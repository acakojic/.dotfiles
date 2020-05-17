;;; xah-elisp-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "xah-elisp-mode" "xah-elisp-mode.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from xah-elisp-mode.el

(autoload 'xah-elisp-mode "xah-elisp-mode" "\
A major mode for emacs lisp.

Most useful command is `xah-elisp-complete-or-indent'.

Press TAB before word to pretty format current lisp expression tree.
Press TAB after word to complete.
Press SPACE to expand function name to template.

I also recommend the following setup:
 URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
 URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
 URL `http://ergoemacs.org/emacs/elisp_insert_brackets_by_pair.html'
 URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'

home page:
URL `http://ergoemacs.org/emacs/xah-elisp-mode.html'

\\{xah-elisp-mode-map}

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "xah-elisp-mode" '("xah-elisp-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; xah-elisp-mode-autoloads.el ends here
