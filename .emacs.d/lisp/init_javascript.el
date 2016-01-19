(defun annotate-debugger ()
  (interactive)
  (highlight-lines-matching-regexp "debugger"))

(add-hook 'js-mode-hook 'annotate-debugger)


(defun javascript-add-breakpoint ()
  (interactive)
  (newline-and-indent)
  (insert "debugger; // jshint ignore:line")
  (highlight-lines-matching-regexp "^[ 	]*debugger"))

(add-hook 'js-mode-hook
	  (lambda ()
	    (define-key js-mode-map (kbd "C-c C-t") 'javascript-add-breakpoint)
      ))
