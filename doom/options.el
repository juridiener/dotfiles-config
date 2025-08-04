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


;; ====== Commands that need to be run
;; M-x nerd-icons-install-fonts


(setq org-directory "~/org/")



;; Debug
(setq debug-on-error t)
(setq display-line-numbers-type t)

;; Evil Escape Settings
(after! evil-escape
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.3))

;; Eglot Settings
(setq eglot-code-action-indications '(mode-line))
(setq lsp-log-io t)

;; Disable eldoc buffer at bottom
(setopt eldoc-display-functions '(eldoc-display-in-buffer))

;; Theme and Font
(setq doom-theme 'base16-rose-pine)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14 :weight 'regular))
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-project-detection 'auto)

;; Fringe Icons
(setq doom-themes-treemacs-enable-variable-pitch nil)
(setq flymake-fringe-indicator-position 'right-fringe)

;; Which Key Delay
(after! which-key
  (setq which-key-idle-delay 0.3))

;; Nerd Icons Configuration
(setq nerd-icons-font-family "JetBrainsMono Nerd Font")

;; Set fringe font explicitly
(set-face-attribute 'fringe nil :font "JetBrainsMono Nerd Font")
