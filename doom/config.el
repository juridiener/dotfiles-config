;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here! Remember: do NOT edit files in
;; the Doom Emacs directory directly. Instead, use `doom sync' to commit
;; changes.

;;; Commentary:
;; This is the main configuration file for Doom Emacs.

;;; Code:

;; Load your other config files
(load! "options.el")
(load! "keymaps.el")

;; Configure Flymake to use Nerd Icons
(after! flymake
  (setq flymake-error-bitmap '(nerd-icons-octicon "nf-oct-x" :face flymake-error)
        flymake-warning-bitmap '(nerd-icons-octicon "nf-oct-alert" :face flymake-warning)
        flymake-note-bitmap '(nerd-icons-octicon "nf-oct-info" :face flymake-note))
  ;; Show errors only when cursor is on the line
  (setq flymake-show-diagnostics-at-end-of-line nil)
  (setq flymake-suppress-zero-counters t))

;; Configure Eldoc to show errors at point
(after! eldoc
  ;; Only add flymake-eldoc-function if it exists
  (when (fboundp 'flymake-eldoc-function)
    (add-to-list 'eldoc-documentation-functions #'flymake-eldoc-function))
  (setq eldoc-echo-area-use-multiline-p t)
  (setq eldoc-idle-delay 0.2))

;; Function to show errors in a copyable buffer
(defun my/show-errors-in-buffer ()
  "Show Flymake diagnostics in a buffer that can be copied."
  (interactive)
  (let ((diagnostics (flymake-diagnostics)))
    (if diagnostics
        (with-current-buffer (get-buffer-create "*Flymake Errors*")
          (setq buffer-read-only nil)
          (erase-buffer)
          (insert "File:Line:Column: Type: Message\n")
          (insert "---------------------------\n")
          (dolist (diag diagnostics)
            (insert (format "%s:%d:%d: %s: %s\n"
                            (flymake-diagnostic-buffer diag)
                            (flymake-diagnostic-beg diag)
                            (flymake-diagnostic-end diag)
                            (flymake-diagnostic-type diag)
                            (flymake-diagnostic-text diag))))
          (setq buffer-read-only t)
          (goto-char (point-min))
          ;; Add local keymap to close buffer with ESC or q
          (use-local-map (make-sparse-keymap))
          (local-set-key (kbd "ESC") #'my/close-error-buffer)
          (local-set-key (kbd "q") #'my/close-error-buffer)
          (display-buffer (current-buffer)))
      (message "No errors found"))))

;; Function to close the error buffer
(defun my/close-error-buffer ()
  "Close the *Flymake Errors* buffer if it exists."
  (interactive)
  (let ((buffer (get-buffer "*Flymake Errors*")))
    (when buffer
      (quit-window nil (get-buffer-window buffer)))))

;; Function to handle ESC key globally
(defun my/handle-esc-key ()
  "Handle ESC key: close error buffer if visible, otherwise do normal ESC behavior."
  (interactive)
  (if (get-buffer-window "*Flymake Errors*")
      (my/close-error-buffer)
    ;; If error buffer is not visible, do normal ESC behavior
    (let ((last-command-event ?\e))
      (call-interactively 'evil-force-normal-state))))

;; Global key binding for ESC to close error buffer
(define-key evil-normal-state-map [escape] #'my/handle-esc-key)
(define-key evil-insert-state-map [escape] #'my/handle-esc-key)
(define-key evil-visual-state-map [escape] #'my/handle-esc-key)
(define-key evil-motion-state-map [escape] #'my/handle-esc-key)

;; Show error at point with a short delay
(defun my/show-error-at-point ()
  "Show error message at point in the echo area."
  (let ((diag (if (fboundp 'flymake-diagnostic-at-point)
                  (flymake-diagnostic-at-point)
                ;; Fallback for older Emacs versions
                (let ((diags (flymake-diagnostics)))
                  (seq-find (lambda (d)
                              (let ((beg (flymake-diagnostic-beg d))
                                    (end (flymake-diagnostic-end d)))
                                (and (<= beg (point)) (>= end (point)))))
                            diags)))))
    (when diag
      (message "%s" (flymake-diagnostic-text diag)))))

;; Add to post-command hook to check for errors at point
(add-hook 'post-command-hook
          (lambda ()
            (when (and (bound-and-true-p flymake-mode)
                       (if (fboundp 'flymake-diagnostic-at-point)
                           (flymake-diagnostic-at-point)
                         ;; Fallback check
                         (let ((diags (flymake-diagnostics)))
                           (seq-find (lambda (d)
                                       (let ((beg (flymake-diagnostic-beg d))
                                             (end (flymake-diagnostic-end d)))
                                         (and (<= beg (point)) (>= end (point)))))
                                     diags)))))
            (run-at-time 0.5 nil #'my/show-error-at-point)))

;; Enable eglot in these programming modes:
(use-package! eglot
  :hook ((js-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (python-mode . eglot-ensure)
         (php-mode . eglot-ensure)
         (ruby-mode . eglot-ensure)
         (enh-ruby-mode . eglot-ensure)))

;; Add rjsx-mode separately to avoid syntax error
(after! rjsx-mode
  (add-hook 'rjsx-mode-hook #'eglot-ensure))

;; Dirvish configuration
(use-package! dirvish
  :init
  (dirvish-override-dired-mode)
  :config
  (dirvish-peek-mode)
  (dirvish-side-follow-mode)
  (when (eq system-type 'darwin)
    (setq insert-directory-program "/opt/homebrew/bin/gls"))
  :custom
  (dirvish-mode-line-format '(:left (sort symlink) :right (omit yank index)))
  (dirvish-mode-line-height 10)
  (dirvish-attributes '(nerd-icons file-time file-size collapse subtree-state vc-state git-msg))
  (dirvish-subtree-state-style 'nerd)
  (delete-by-moving-to-trash t)
  (dirvish-path-separators (list
                            (format "  %s " (nerd-icons-codicon "nf-cod-home"))
                            (format "  %s " (nerd-icons-codicon "nf-cod-root_folder"))
                            (format " %s " (nerd-icons-faicon "nf-fa-angle_right"))))
  (dired-listing-switches
   "-l --almost-all --human-readable --group-directories-first --no-group"))

;; Tree-sitter configuration
(after! treesit
  (setq treesit-font-lock-level 4)
  (setq treesit-language-source-alist
        '((bash "https://github.com/tree-sitter/tree-sitter-bash")
          (astro "https://github.com/mauzybwy/tree-sitter-astro" "emacs")
          (cmake "https://github.com/uyha/tree-sitter-cmake")
          (css "https://github.com/tree-sitter/tree-sitter-css")
          (elisp "https://github.com/Wilfred/tree-sitter-elisp")
          (go "https://github.com/tree-sitter/tree-sitter-go")
          (html "https://github.com/tree-sitter/tree-sitter-html")
          (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
          (json "https://github.com/tree-sitter/tree-sitter-json")
          (jq "https://github.com/nverno/tree-sitter-jq")
          (make "https://github.com/alemuller/tree-sitter-make")
          (markdown "https://github.com/ikatyang/tree-sitter-markdown")
          (c-sharp "https://github.com/tree-sitter/tree-sitter-c-sharp")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (nix "https://github.com/nix-community/tree-sitter-nix")
          (ruby "https://github.com/tree-sitter/tree-sitter-ruby")
          (toml "https://github.com/tree-sitter/tree-sitter-toml")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src")
          (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src")
          (heex "https://github.com/phoenixframework/tree-sitter-heex")
          (elixir "https://github.com/elixir-lang/tree-sitter-elixir")
          (yaml "https://github.com/ikatyang/tree-sitter-yaml"))))

;; macOS specific settings
(when (eq system-type 'darwin)
  (let ((gls (executable-find "gls")))
    (when gls
      (setq insert-directory-program gls)
      (setq dired-use-ls-dired t))))

;; Centaur-tabs configuration
(after! centaur-tabs
  (setq centaur-tabs-set-icons t)
  (centaur-tabs-mode t))

;; Ensure Nerd Icons fonts are installed
(when (display-graphic-p)
  (unless (find-font (font-spec :name "Symbols Nerd Font"))
    (message "Installing Nerd Icons fonts...")
    (nerd-icons-install-fonts t)))

;;; config.el ends here
