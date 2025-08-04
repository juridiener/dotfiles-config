
(map! :n
      "C-h" #'evil-window-left
      "C-j" #'evil-window-down
      "C-k" #'evil-window-up
      "C-l" #'evil-window-right)


(map! :leader
      "e" #'treemacs)



;; Make H and L switch buffer tabs (like Vim's bufferline)
(map! :n "H" #'centaur-tabs-backward)
(map! :n "L" #'centaur-tabs-forward)

;; Use [B and ]B to move current tab/buffer left or right in centaur-tabs
(map! :n "[ B" #'centaur-tabs-move-current-tab-to-left)
(map! :n "] B" #'centaur-tabs-move-current-tab-to-right)

;; Error handling key bindings
;; (map! :leader
;;       :desc "Show errors in buffer" "e e" #'my/show-errors-in-buffer)

;; Error handling key bindings
(map! :desc "Show errors in buffer" "C-c e" #'my/show-errors-in-buffer)


;; Key bindings for error navigation
(map! :n "]e" #'flymake-goto-next-error
      :n "[e" #'flymake-goto-prev-error)
