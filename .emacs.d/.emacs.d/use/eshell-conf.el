;; (defmacro make-my-function (name)
;;   (list 'defun (intern (format "my-%s-function" name)) ()
;;         (list 'interactive)
;;         (list (intern (format "mark-%s" name)))
;;         (list 'do-more-stuff)
;;         (list (intern (format "modify-%s" name)))))

;; (defun my function ()
;;   (interactive)
;;   (message "This is a great function"))

;; (defun insert-text ()
;;   (interactive)
;;   (insert "This is a great function"))

;; (defun j-sout ()
;;   (interactive)
;;   (insert "System.out.println(\"\");")
;;   (backward-char 3)
;;   (xah-fly-insert-mode-activate)
;;   )

;; (defun j-psvm ()
;;   (interactive)
;;   (insert "public static void main(String[] args) {")
;;   (newline)
;;   (c-indent-line-or-region)
;;   (newline)
;;   (insert "}")
;;   (c-indent-line-or-region)
;;   (previous-line)
;;   (c-indent-line-or-region)
;;   (xah-fly-insert-mode-activate)
;;   )

;; (defun p-v-method ()
;;   (interactive)
;;   (insert "private void () {")
;;   (newline)
;;   (c-indent-line-or-region)
;;   (newline)
;;   (insert "}")
;;   (c-indent-line-or-region)
;;   (backward-char 12)
;;   ;; (backward-word)
;;   ;; (backward-word)
;;   (xah-fly-insert-mode-activate)
;;   )

;; (defun lsp-describe-thing-at-point-custom ()
;;   (interactive)
;;   (lsp-describe-thing-at-point)
;;   (other-window)
;;   )
  

;; (defun get-cursor-position ()
;;   (point)
;;   (current-column))

;; (defun go-to-line (line)
;;   (interactive)
;;   ;; (goto-char line)
;;   (goto-line line)  
;;   )

;; (go-to-line 30)

;; (defun check-strings (word)
;;   (if (string= "abc" word)
;;       (message "true")
;;     )
;;   )

;; (check-strings "abc")

;; (check-strings "abcdo")

;; (defun find-word-in-line (word)
  ;; (setq i 0)
  ;; (while (/= i 10)
    ;; (+ i 1)
  ;; (if (string= "abcdeeju" word)
      ;; i
    ;; )
    ;; )
  ;; )
;; 
;; (find-word-in-line "a")

;; (point)

;; (region-beginning)

;; (goto-char 2)

;; (line-beginning-position)

;; (line-end-position)

;; (beginning-of-line)

;; (line-number-at-pos)   

;; (current-line)

;; (count-lines)

;; (current-column)

;; (thing-at-point)

;; (search-forward "for")

;; (current-line)
;; (xah-copy-line-or-region)
;; (set-mark-command)

(defun copy-from-cursor-to-beginning-of-line ()
  (interactive)
  ;; (set-mark-command)
  (cua-set-mark)
  (beginning-of-line)
  (xah-copy-line-or-region)
  (cua-cancel)
  (end-of-line)
  ;; (kill-ring-save)
  (insert "cd ")
  (yank)
  (execute-kbd-macro (kbd "<return>"))  
  ;; (newline)
  ;; (exchange-point-and-mark)
  )

;; (defun get-current-line ()
;;   (interactive) 
;;   (setq my-line
;; 	(buffer-substring-no-properties
;; 	 (line-beginning-position)
;; 	 (line-end-position)
;; 	 )
;; 	)
;;   (message my-line)
;;   )

;; command-log-mode
;; clm/open-command-log-buffer


   
