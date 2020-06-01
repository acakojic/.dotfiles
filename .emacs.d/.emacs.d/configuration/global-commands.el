(add-hook 'exwm-mode-hook #'xah-fly-keys-off)

(defun exwm--define-keys (@keymap-name @key-cmd-alist)
  "Map `define-key' over a alist @key-cmd-alist.
Example usage:
;; (xah-fly--define-keys
;;  (define-prefix-command 'xah-fly-dot-keymap)
;;  '(
;;    (\"h\" . highlight-symbol-at-point)
;;    (\".\" . isearch-forward-symbol-at-point)
;;    (\"1\" . hi-lock-find-patterns)
;;    (\"w\" . isearch-forward-word)))
Version 2019-02-12"
  (interactive)
  (mapc
   (lambda ($pair)
     (define-key @keymap-name (kbd (xah-fly--key-char (car $pair))) (cdr $pair)))
   @key-cmd-alist))

(defun change-modeline-color-on-input-mode-change ()
  (let ((specs (cl-case exwm--input-mode
                 (line-mode
		  (progn
                    '((:background "#99ff99") mode-line)
		    ;; (message "init.el - 411 - change-modeline-color-on-input-mode-change")
		    ;; (message "%s" major-mode)
		    )
		  )
		  
                 (char-mode
                  '((:background "#8080ff") mode-line)))))
    (make-local-variable 'face-remapping-alist)
    (setf (alist-get 'mode-line face-remapping-alist) specs)))

(add-hook 'exwm-input--input-mode-change-hook
          'change-modeline-color-on-input-mode-change)


;; (defun change-color-line-mode () ;;da li vratiti?
;;   (interactive)
;;   (call-interactively #'exwm-reset)
;;   ;; (message "change-color-line-mode")
;;   (set-face-background 'mode-line "#99ff99")
;;   ;; (face-remap-add-relative
;;   ;; 		   'mode-line '((:background "#99ff99") mode-line))
;;   )


;; Global keybindings can be defined with `exwm-input-global-keys'.
;; Here are a few examples:
(setq exwm-input-global-keys
      `(
	;; (kbd "SPC" #'exwm-reset)
	;; ([?\s-home] . exwm-reset)
	;; ([?\s-x] . kill-region)
	;; ([?\s-c] . kill-ring-save)
	;; ([?\s-v] . yank)
        ;; Bind "s-r" to exit char-mode and fullscreen mode.
        ;; ([?\s-r] . exwm-reset)
	([s-home] . exwm-reset) ;;ovo radi
	;; ([s-home] . change-color-line-mode)
	;; ([s-home] . [s-pause])
	;; ([home] . [s-home])
	([pause] . [s-home])
	;; ([home] . exwm-reset)
	;; ([?\s-l] . exwm-reset)
	;; ([?\s-c] . exwm-input-release-keyboard)
	;; ([t] . exwm-input-release-keyboard)
        ;; Bind "s-w" to switch workspace interactively.
        ([?\s-w] . exwm-workspace-switch)
        ;; Bind "s-0" to "s-9" to switch to a workspace by its index.
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))
        ;; Bind "s-&" to launch applications ('M-&' also works if the output
        ;; buffer does not bother you).
        ([?\s-&] . (lambda (command)
		     (interactive (list (read-shell-command "$ ")))
		     (start-process-shell-command command nil command)))
        ;; Bind "s-<f2>" to "slock", a simple X display locker.
        ([s-f2] . (lambda ()
		    (interactive)
		    (start-process "" nil "/usr/bin/slock")))))


;; To add a key binding only available in line-mode, simply define it in
;; `exwm-mode-map'.  The following example shortens 'C-c q' to 'C-q'.
(define-key exwm-mode-map [?\C-q] #'exwm-input-send-next-key)
(define-key exwm-mode-map (kbd "SPC") #'xah-fly-leader-key-map)
;; (define-key exwm-mode-map (kbd "t") #'exwm-input-release-keyboard)
;; (define-key exwm-mode-map [?\s-t] #'exwm-input-release-keyboard)
;; (defun change-color-char-mode () ;;da li vratiti?
;;   (interactive)
;;   (call-interactively #'exwm-input-release-keyboard)
;;   (set-face-background 'mode-line "#8080ff")
;;   ;; (message "change-color-char-mode")
;;   ;; (face-remap-add-relative
;;   ;; 		   'mode-line '((:background "#8080ff") mode-line))
;;   )
;; (define-key exwm-mode-map (kbd "t") #'change-color-char-mode)
(define-key exwm-mode-map (kbd "t") #'exwm-input-release-keyboard)
(define-key exwm-mode-map (kbd "a") #'execute-extended-command)
(define-key exwm-mode-map (kbd "b") #'switch-to-buffer)

(add-hook 'exwm-manage-finish-hook
          (lambda ()
	    (message exwm-class-name)
	    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
;; up
(defun key-up ()
  (interactive)
  ;; (cond
  ;;  ((string= exwm-class-name "Firefox")
  ;;   (exwm-input--fake-key 'up))
  ;;  ((string= exwm-class-name "Firefox-esr")
  ;;   (exwm-input--fake-key 'up))
  ;;  ((string= exwm-class-name "jetbrains-studio")
  ;;   (exwm-input--fake-key 'up))
  ;;  ((string= exwm-class-name "NetBeans IDE 8.2")
  ;;   (exwm-input--fake-key 'up))
  ;;  ((string= exwm-class-name "oracle-ide-osgi-boot-OracleIdeLauncher")
  ;;   (exwm-input--fake-key 'down))
  ;;  )
  (if is-mark-on
      (progn
	(message "S-up")
	(exwm-input--fake-key 'S-up))
    (progn
      (message "up")
      (exwm-input--fake-key 'up)
      )
    )
  )
(define-key exwm-mode-map (kbd "u") #'key-up)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
;; down
(defun key-down ()
  (interactive)
  (if is-mark-on
      (progn
	(message "S-down")
	(exwm-input--fake-key 'S-down))
    (progn
      (message "down")
      (exwm-input--fake-key 'down)
      )
    )
  )
(define-key exwm-mode-map (kbd "e") #'key-down)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
;; left
(defun key-left ()
  (interactive)
  (if is-mark-on
      (progn
	(message "S-left")
	(exwm-input--fake-key 'S-left))
    (progn
      (message "left")
      (exwm-input--fake-key 'left)
      )
    )
  )
(define-key exwm-mode-map (kbd "n") #'key-left)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
;; right
(defun key-right ()
  (interactive)
  (if is-mark-on
      (progn
	(message "S-right")
	(exwm-input--fake-key 'S-right))
    (progn
      (message "right")
      ;; (if xah-fly-keys-off
      ;; 	   (message "xah-fly-keys-are-off"))
      (exwm-input--fake-key 'right)
      )
    )
  )
(define-key exwm-mode-map (kbd "i") #'key-right)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
;; left word
(defun key-left-word ()
  (interactive)
  ;; (cond
  ;;  ((string= exwm-class-name "Firefox")
  ;;   (exwm-input--fake-key 'C-left))
  ;;  ((string= exwm-class-name "Firefox-esr")
  ;;   (exwm-input--fake-key 'C-left))
  ;;  ((string= exwm-class-name "jetbrains-studio")
  ;;   (exwm-input--fake-key 'C-left))
  ;;  ((string= exwm-class-name "NetBeans IDE 8.2")
  ;;   (exwm-input--fake-key 'C-left))
  ;;  ((= (length exwm-class-name) 0)
  ;;   (exwm-input--fake-key 'C-left))
  ;;  )
  (if is-mark-on
      (progn
	(message "C-S-left")
	(exwm-input--fake-key 'C-S-left))
    (progn
      (message "C-left")
      (exwm-input--fake-key 'C-left)
      )
    )
  )
(define-key exwm-mode-map (kbd "l") #'key-left-word)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
;; right word
(defun key-right-word ()
  (interactive)
  ;; (execute-kbd-macro (kbd "C-<right>"))
  ;; (cond
   ;; ((string= exwm-class-name "Firefox")
   ;;  (exwm-input--fake-key 'C-left))
   ;; ((string= exwm-class-name "Firefox-esr")
   ;;  (exwm-input--fake-key 'C-right))
   ;; ((string= exwm-class-name "jetbrains-studio")
   ;;  (exwm-input--fake-key 'C-right))
   ;; ((string= exwm-class-name "NetBeans IDE 8.2")
   ;;  (exwm-input--fake-key 'C-right))
   ;; ((= (length exwm-class-name) 0)
   ;;  (exwm-input--fake-key 'C-right))
  ;; )
  (if is-mark-on
      (progn
	(message "C-S-right")
	(exwm-input--fake-key 'C-S-right))
    (progn
      (message "C-right")
      (exwm-input--fake-key 'C-right)
      )
    )
  )
(define-key exwm-mode-map (kbd "y") #'key-right-word)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-home ()
  (interactive)
  ;; (cond
  ;;  ((string= exwm-class-name "Firefox")
  ;;   (exwm-input--fake-key 'home))
  ;;  ((string= exwm-class-name "Firefox-esr")
  ;;   (exwm-input--fake-key 'home))
  ;;  ((string= exwm-class-name "jetbrains-studio")
  ;;   (exwm-input--fake-key 'home))
  ;;  ((string= exwm-class-name "NetBeans IDE 8.2")
  ;;   (exwm-input--fake-key 'home))
  ;;  ((= (length exwm-class-name) 0)
  ;;   (exwm-input--fake-key 'home))
  ;;  )
  ;; )
  (if is-mark-on
      (progn
	(message "S-home")
	(exwm-input--fake-key 'S-home))
    (progn
      (message "home")
      (exwm-input--fake-key 'home)
      )
    )
  )
(define-key exwm-mode-map (kbd "h") #'key-home)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-end ()
  (interactive)
  (if is-mark-on
      (progn
	(message "S-end")
	(exwm-input--fake-key 'S-end))
    (progn
      (message "end")
      (exwm-input--fake-key 'end)
      )
    )
  )
(define-key exwm-mode-map (kbd "o") #'key-end)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-page-up ()
  (interactive)
  (if is-mark-on
      (progn
	(message "S-prior")
	(exwm-input--fake-key 'S-prior))
    (progn
      (message "prior")
      (exwm-input--fake-key 'prior)
      )
    )
  )
(define-key exwm-mode-map (kbd ",") #'key-page-up)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-page-down ()
  (interactive)
  (if is-mark-on
      (progn
	(message "S-next")
	(exwm-input--fake-key 'S-next))
    (progn
      (message "next")
      (exwm-input--fake-key 'next)
      )
    )
  )
(define-key exwm-mode-map (kbd ".") #'key-page-down)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-go-to-next-highlighted-element-usage ()
  (interactive)
      (exwm-input--fake-key 'M-next)
  )
(define-key exwm-mode-map (kbd "Y") #'key-go-to-next-highlighted-element-usage)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-go-to-previous-highlighted-element-usage ()
  (interactive)
      (exwm-input--fake-key 'M-prior)
  )
(define-key exwm-mode-map (kbd "L") #'key-go-to-previous-highlighted-element-usage)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-scroll-up ()
  (interactive)
      (exwm-input--fake-key 'C-up)
  )
(define-key exwm-mode-map (kbd "U") #'key-scroll-up)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-scroll-down ()
  (interactive)
      (exwm-input--fake-key 'C-down)
  )
(define-key exwm-mode-map (kbd "E") #'key-scroll-down)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-select-next-tab ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    (exwm-input--fake-key 'C-next))
   ((string= exwm-class-name "Firefox-esr")
    (exwm-input--fake-key 'C-next))
   ((string= exwm-class-name "jetbrains-studio")
    (exwm-input--fake-key 'M-right))
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (exwm-input--fake-key 'M-right))
   ((= (length exwm-class-name) 0)
    (exwm-input--fake-key 'C-next))
   )
  ;; (exwm-input--fake-key 'M-right)
  )
(define-key exwm-mode-map (kbd "O") #'key-select-next-tab)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-select-previous-tab ()
  (interactive)
  ;; (cond
   ;; ((string= exwm-class-name "Firefox")
   ;;  (exwm-input--fake-key 'C-left))
   ;; ((string= exwm-class-name "Firefox-esr")
   ;;  (exwm-input--fake-key 'C-right))
   ;; ((string= exwm-class-name "jetbrains-studio")
   ;;  (exwm-input--fake-key 'C-right))
   ;; ((string= exwm-class-name "NetBeans IDE 8.2")
   ;;  (exwm-input--fake-key 'C-right))
   ;; ((= (length exwm-class-name) 0)
   ;;  (exwm-input--fake-key 'C-right))
  ;; )
      (exwm-input--fake-key 'M-left)
  )
(define-key exwm-mode-map (kbd "H") #'key-select-previous-tab)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-move-caret-to-code-block-start ()
  (interactive)
  ;; (cond
  ;;  ((string= exwm-class-name "Firefox")
  ;;   (exwm-input--fake-key 'end))
  ;;  ((string= exwm-class-name "Firefox-esr")
  ;;   (exwm-input--fake-key 'end))
  ;;  ((string= exwm-class-name "jetbrains-studio")
  ;;   (exwm-input--fake-key 'end))
  ;;  ((string= exwm-class-name "NetBeans IDE 8.2")
  ;;   (exwm-input--fake-key 'end))
  ;;  ((= (length exwm-class-name) 0)
  ;;   (exwm-input--fake-key 'end))
  ;;  )
  ;; )
  (if is-mark-on
      (progn
	(exwm-input--fake-key 'C-S-\[)
	(message "C-S-[")
	)
    (progn
      (message "C-[")
      (exwm-input--fake-key 'C-\[ )
      )
    )
  )  
(define-key exwm-mode-map (kbd "(") #'key-move-caret-to-code-block-start)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-move-caret-to-code-block-end ()
  (interactive)
  ;; (cond
  ;;  ((string= exwm-class-name "Firefox")
  ;;   (exwm-input--fake-key 'end))
  ;;  ((string= exwm-class-name "Firefox-esr")
  ;;   (exwm-input--fake-key 'end))
  ;;  ((string= exwm-class-name "jetbrains-studio")
  ;;   (exwm-input--fake-key 'end))
  ;;  ((string= exwm-class-name "NetBeans IDE 8.2")
  ;;   (exwm-input--fake-key 'end))
  ;;  ((= (length exwm-class-name) 0)
  ;;   (exwm-input--fake-key 'end))
  ;;  )
  ;; )
  (if is-mark-on
      (progn
	(exwm-input--fake-key 'C-S-\] )
	(message "C-S-]")
	)
    (progn
      (message "C-]")
      (exwm-input--fake-key 'C-\] )
      )
    )
  )  
(define-key exwm-mode-map (kbd ")") #'key-move-caret-to-code-block-end)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-minibuffer-keyboard-quit ()
  (interactive)
  (minibuffer-keyboard-quit)
  )
(define-key exwm-mode-map (kbd "g") #'key-minibuffer-keyboard-quit)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
;; delete
(defun key-delete ()
  (interactive)
  (exwm-input--fake-key 'delete)
  )
(define-key exwm-mode-map (kbd "5") #'key-delete)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
;; delete
(defun key-backspace ()
  (interactive)
  (exwm-input--fake-key 'backspace)
  )
(define-key exwm-mode-map (kbd "s") #'key-backspace)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-backspace-word ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    (exwm-input--fake-key 'C-backspace))
   ((string= exwm-class-name "Firefox-esr")
    (exwm-input--fake-key 'C-backspace))
   ((string= exwm-class-name "jetbrains-studio")
    (exwm-input--fake-key 'C-backspace))
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (exwm-input--fake-key 'C-backspace))
   ((= (length exwm-class-name) 0)
    (exwm-input--fake-key 'C-backspace))
   )
  )
(define-key exwm-mode-map (kbd "f") #'key-backspace-word)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-delete-word ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    (exwm-input--fake-key 'C-delete))
   ((string= exwm-class-name "Firefox-esr")
    (exwm-input--fake-key 'C-delete))
   ((string= exwm-class-name "jetbrains-studio")
    (exwm-input--fake-key 'C-delete))
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (exwm-input--fake-key 'C-delete))
   ((= (length exwm-class-name) 0)
    (exwm-input--fake-key 'C-delete))
   )
  )
(define-key exwm-mode-map (kbd "p") #'key-delete-word)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-undo-text ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    (exwm-input--fake-key 'C-z))
   ((string= exwm-class-name "Firefox-esr")
    (exwm-input--fake-key 'C-z))
   ((string= exwm-class-name "jetbrains-studio")
    (exwm-input--fake-key 'C-z))
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (exwm-input--fake-key 'C-z))
   ((= (length exwm-class-name) 0)
    (exwm-input--fake-key 'C-z))
   )
  )
(define-key exwm-mode-map (kbd "j") #'key-undo-text)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-cut-line ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    (exwm-input--fake-key 'C-x))
   ((string= exwm-class-name "Firefox-esr")
    (exwm-input--fake-key 'C-x))
   ((string= exwm-class-name "jetbrains-studio")
    (progn 
      (exwm-input--fake-key 'C-x)
      (if is-mark-on
	  (setq is-mark-on nil)
	)
      )
    )
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (progn 
      (exwm-input--fake-key 'C-x)
      (if is-mark-on
	  (setq is-mark-on nil)
	)
      )
    )
   ((= (length exwm-class-name) 0)
    (progn 
      (exwm-input--fake-key 'C-x)
      (if is-mark-on
	  (setq is-mark-on nil)
	)
      )
    )
   )
  )
(define-key exwm-mode-map (kbd "x") #'key-cut-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-copy-line ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    (exwm-input--fake-key 'C-c))
   ((string= exwm-class-name "Firefox-esr")
    (exwm-input--fake-key 'C-c))
   ((string= exwm-class-name "jetbrains-studio")
    (progn 
      (exwm-input--fake-key 'C-c)
      (if is-mark-on
	  (setq is-mark-on nil)
	)
      )
    )
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (progn 
      (exwm-input--fake-key 'C-c)
      (if is-mark-on
	  (setq is-mark-on nil)
	)
      )
    )
   ((= (length exwm-class-name) 0)
    (progn 
      (exwm-input--fake-key 'C-c)
      (if is-mark-on
	  (setq is-mark-on nil)
	)
      )
    )
   )
  )
(define-key exwm-mode-map (kbd "c") #'key-copy-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-paste-line ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    (exwm-input--fake-key 'C-v))
   ((string= exwm-class-name "Firefox-esr")
    (exwm-input--fake-key 'C-v))
   ((string= exwm-class-name "jetbrains-studio")
    (exwm-input--fake-key 'C-v))
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (exwm-input--fake-key 'C-v))
   ((= (length exwm-class-name) 0)
    (exwm-input--fake-key 'C-v))
   )
  )
(define-key exwm-mode-map (kbd "v") #'key-paste-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-search-text ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    ;; (exwm-input--fake-key 'C-v)
    )
   ((string= exwm-class-name "Firefox-esr")
    ;; (exwm-input--fake-key 'C-v)
    )
   ((string= exwm-class-name "jetbrains-studio")
    (exwm-input--fake-key 'C-f))
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (exwm-input--fake-key 'C-f))
   ((= (length exwm-class-name) 0)
    (exwm-input--fake-key 'C-f))
   )
  )
(define-key exwm-mode-map (kbd "k") #'key-search-text)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-enter-bellow ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    ;; (exwm-input--fake-key 'C-v)
    )
   ((string= exwm-class-name "Firefox-esr")
    ;; (exwm-input--fake-key 'C-v)
    )
   ((string= exwm-class-name "jetbrains-studio")
    (exwm-input--fake-key 'C-return)
    )
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (exwm-input--fake-key 'C-return)
    )
   ((= (length exwm-class-name) 0)
    ;; (exwm-input--fake-key 'C-f)
    )
   )
  )
(define-key exwm-mode-map (kbd "r") #'key-enter-bellow)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-comment-line ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    (exwm-input--fake-key 'C-/))
   ((string= exwm-class-name "Firefox-esr")
    (exwm-input--fake-key 'C-/))
   ((string= exwm-class-name "jetbrains-studio")
    (exwm-input--fake-key 'C-/))
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (exwm-input--fake-key 'C-/))
   ((= (length exwm-class-name) 0)
    (exwm-input--fake-key 'C-/))
   )
  )
(define-key exwm-mode-map (kbd "z") #'key-comment-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
;; (setq is-mark-on nil)
(setq is-mark-on nil)

(defun key-mark-region ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    )
   ;; (global-set-key (kbd "M-SPC") (lambda() (interactive) (push-mark nil nil 1))))
   ;; (exwm-input--fake-key 'S-))
   ((string= exwm-class-name "Firefox-esr")
    ;; (exwm-input--fake-key 'C-f))
    (if is-mark-on
	(progn
	  (message "false")
	  (setq is-mark-on nil))
      (progn
	(message "true")
	(setq is-mark-on t)
	)
      )
    )
   ((string= exwm-class-name "jetbrains-studio")
    (if is-mark-on
	(progn
	  (message "mark-region-false")
	  (setq is-mark-on nil))
      (progn
	(message "mark-region-true")
	(setq is-mark-on t)
	)
      )
    )
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (if is-mark-on
	(progn
	  (message "mark-region-false")
	  (setq is-mark-on nil))
      (progn
	(message "mark-region-true")
	(setq is-mark-on t)
	)
      )
    )
   ((= (length exwm-class-name) 0)
    ;; (exwm-input--fake-key 'C-f))
    )
   )
  )
(define-key exwm-mode-map (kbd "m") #'key-mark-region)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-android-studio-next-highlighted-error ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'f2)
    )
  )
(define-key exwm-mode-map (kbd "'") #'key-android-studio-next-highlighted-error)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-android-studio-previous-highlighted-error ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'S-f2)
    )
  )
(define-key exwm-mode-map (kbd "\"") #'key-android-studio-previous-highlighted-error)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-match-brace ()
  (interactive)
  (cond
   ((string= exwm-class-name "Firefox")
    ;; (exwm-input--fake-key 'C-S-m)
    )
   ((string= exwm-class-name "Firefox-esr")
    ;; (exwm-input--fake-key 'C-S-m)
    )
   ((string= exwm-class-name "jetbrains-studio")
    (exwm-input--fake-key 'C-S-m)
    )
   ((string= exwm-class-name "NetBeans IDE 8.2")
    ;; (exwm-input--fake-key 'C-})
    (if is-mark-on
	(progn
	  (exwm-input--fake-key 'C-S-\] )
	  (message "C-S-]")
	  )
      (progn
	(message "C-]")
	(exwm-input--fake-key 'C-\] )
	)
      )
    )
   ((= (length exwm-class-name) 0)
    (exwm-input--fake-key 'C-S-m))
   )
  )
(define-key exwm-mode-map (kbd "-") #'key-match-brace)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<


;; (if is-mark-on
;;       (progn
;; 	(message "S-prior")
;; 	(exwm-input--fake-key 'S-prior))
;;     (progn
;;       (message "prior")
;;       (exwm-input--fake-key 'prior)
;;       )
;;     )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-show-project-files ()
  (interactive)
  (cond
   ;; ((string= exwm-class-name "Firefox")
    ;; (exwm-input--fake-key 'C-f))
   ;; ((string= exwm-class-name "Firefox-esr")
    ;; (exwm-input--fake-key 'C-f))
   ((string= exwm-class-name "jetbrains-studio")
    (exwm-input--fake-key 'M-1))
   ((string= exwm-class-name "NetBeans IDE 8.2")
    (exwm-input--fake-key 'M-1))
   ((= (length exwm-class-name) 0)
    ;; (exwm-input--fake-key ?\M-v\S-c))
   (exwm-input--fake-key ?\M-v c)) ;; aca ovde sam stao
   )
  )
  ;; (when (and exwm-class-name
  ;;            (string= exwm-class-name "jetbrains-studio"))
  ;;   (exwm-input--fake-key 'M-1)
  ;;   )
  ;; )
;; (define-key exwm-mode-map (kbd "1") #'key-android-studio-project-files)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-show-favorites ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'M-2)
    )
  )
;; (define-key exwm-mode-map (kbd "2") #'key-android-studio-favorites)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-show-search-result ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'M-3)
    )
  )
;; (define-key exwm-mode-map (kbd "3") #'key-android-studio-search-result)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-show-device-file-explorer ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'M-4)
    )
  )
;; (define-key exwm-mode-map (kbd "4") #'key-android-studio-device-file-explorer)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-show-inspection-result ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'M-5)
    )
  )
;; (define-key exwm-mode-map (kbd "5") #'key-android-studio-inspection-result)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-show-logcat ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'M-6)
    )
  )
;; (define-key exwm-mode-map (kbd "6") #'key-android-studio-logcat)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-show-structure ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'M-7)
    )
  )
;; (define-key exwm-mode-map (kbd "7") #'key-android-studio-structure)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-show-version-control ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'M-9)
    )
  )
;; (define-key exwm-mode-map (kbd "9") #'key-android-studio-version-control)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-show-editor ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'escape)
    )
  )
(define-key exwm-mode-map (kbd "0") #'key-show-editor)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-remove-others-and-show-only-editor ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (progn
      (exwm-input--fake-key 'M-1)
      (exwm-input--fake-key 'S-escape)
      (exwm-input--fake-key 'M-4)
      (exwm-input--fake-key 'S-escape)
      (exwm-input--fake-key 'escape)
      )
    )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-save-buffer ()
  (interactive)
  ;; (when (and exwm-class-name
  ;;            (string= exwm-class-name "jetbrains-studio"))
  ;;   (exwm-input--fake-key 'C-s)
  ;;   (message "save buffer")g
  ;;   )
  (exwm-input--fake-key 'C-s)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-select-previous-tab ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'M-left)
    (message "save buffer")
    )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(defun key-select-next-tab ()
  (interactive)
  (when (and exwm-class-name
             (string= exwm-class-name "jetbrains-studio"))
    (exwm-input--fake-key 'M-right)
    (message "save buffer")
    )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
(exwm--define-keys
 (define-prefix-command 'exwm-leader-key-map)
 '(
   ("x" . switch-to-buffer)
   ("h" . windmove-left)
   ("t" . windmove-down)
   ("n" . windmove-right)
   ("c" . windmove-up)

   ("," . xah-fly-window-keymap)
   
   ("g" . key-select-previous-tab)
   ("r" . key-select-next-tab)

   ("e" . key-save-buffer)
   ("d" . previous-buffer)
   ("s" . next-buffer)

   ("1" . key-show-project-files)
   ("2" . key-show-favorites)
   ("3" . key-show-search-result)
   ("4" . key-show-device-file-explorer)
   ("5" . key-show-inspection-result)
   ("6" . key-show-logcat)
   ("7" . key-show-structure)
   ;; ("8" . key-show-
   ("9" . key-show-version-control)
   ("0" . key-remove-others-and-show-only-editor)
   )
 )

(define-key exwm-mode-map (kbd "SPC") 'exwm-leader-key-map)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<
