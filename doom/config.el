;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq display-line-numbers-type t)

(setq eglot-code-action-indications '(mode-line))

;; disable the buffer on the bottom. To see pres: C-h
(setopt eldoc-display-functions '(eldoc-display-in-buffer))

(after! evil-escape
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.3))  ;; example setting timeout to 0.3 seconds

(map! :n
      "C-h" #'evil-window-left
      "C-j" #'evil-window-down
      "C-k" #'evil-window-up
      "C-l" #'evil-window-right)


(after! which-key
  (setq which-key-idle-delay 0.3))  ;; Adjust 0.3 to a delay (in seconds) that suits you

(setq doom-theme 'doom-one
      doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14 :weight 'regular)
      doom-modeline-major-mode-color-icon t
      doom-modeline-project-detection 'auto)

(use-package! corfu
  :init
  (global-corfu-mode)       ;; Enable Corfu completion globally
  :custom
  (corfu-auto t)            ;; Enable automatic popup
  (corfu-auto-delay 0.1)    ;; Small delay before popup appears
  (corfu-auto-prefix 1))    ;; Popup after typing 1 character


(use-package! flymake
  :custom
  (flymake-no-changes-timeout 4))


(use-package! orderless
  :custom
  (completion-styles '(orderless partial-completion basic))
  (completion-category-defaults nil)
  (completion-category-overrides nil))

;; Disable eglot in Emacs Lisp buffers (to avoid "Couldn't guess..." prompt)
;; (add-hook 'emacs-lisp-mode-hook (lambda () (eglot-ensure -1)))

;; Enable eglot in these programming modes:
(use-package! eglot
  :hook ((js-mode . eglot-ensure)
         (rjsx-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (python-mode . eglot-ensure)
         (php-mode . eglot-ensure)
         (ruby-mode . eglot-ensure)
         (enh-ruby-mode . eglot-ensure)))

(use-package! dirvish
  :init
  (dirvish-override-dired-mode)

  :config
  (dirvish-peek-mode) ; Preview files in minibuffer
  (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
  (when (eq system-type 'darwin)
    (setq insert-directory-program "/opt/homebrew/bin/gls"))

  :custom
  (dirvish-mode-line-format
   '(:left (sort symlink) :right (omit yank index)))
  (dirvish-mode-line-height 10)
  (dirvish-attributes
   '(nerd-icons file-time file-size collapse subtree-state vc-state git-msg))
  (dirvish-subtree-state-style 'nerd)
  (delete-by-moving-to-trash t)
  (dirvish-path-separators (list
                            (format "  %s " (nerd-icons-codicon "nf-cod-home"))
                            (format "  %s " (nerd-icons-codicon "nf-cod-root_folder"))
                            (format " %s " (nerd-icons-faicon "nf-fa-angle_right"))))
  (dired-listing-switches
   "-l --almost-all --human-readable --group-directories-first --no-group")
  )

;; -----------------------------------------------------------------------------

(after! eglot
  ;; (eglot-booster-mode) need to install with cargo emacs-lsp-booster
  (setq eglot-project-root-functions
        '(eglot-locate-project)))  ; Use eglot's default method, ignore Projectile


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

;; Keybinding to list diagnostics
(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c d") #'eglot-diagnostics))

;; Enable flymake diagnostic indicators (already enabled if using eglot)
(setq flymake-no-changes-timeout 3)  ; show diagnostics quickly

;; Avoid line jumping due to scrolling
;; (setq scroll-conservatively 101)

;; ;; Disable automatic eldoc popup in eglot buffers
;; (add-hook 'eglot-managed-mode-hook
;;           (lambda ()
;;             (eldoc-mode -1)))

;; ;; Bind a key to show hover docs manually
;; (with-eval-after-load 'eglot
;;   (define-key eglot-mode-map (kbd "C-c h") #'eglot-hover))

;; (custom-set-faces
;;  '(eglot-highlight-symbol-face ((t (:underline t :weight normal)))))


;; Optional: Customize flymake display to use fringes or underlines
;; (customize-face 'flymake-error :underline '(:style wave :color "Red"))
;; (customize-face 'flymake-warning :underline '(:style wave :color "Orange"))

(when (eq system-type 'darwin)
  (let ((gls (executable-find "gls")))
    (when gls
      (setq insert-directory-program gls)
      (setq dired-use-ls-dired t))))
