;;; pylint-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "pylint" "pylint.el" (21640 39717 398519 965000))
;;; Generated autoloads from pylint.el

(autoload 'pylint "pylint" "\
Run PYLINT, and collect output in a buffer, much like `compile'.

While pylint runs asynchronously, you can use \\[next-error] (M-x next-error),
or \\<pylint-mode-map>\\[compile-goto-error] in the grep output buffer, to go to the lines where pylint found matches.

\\{pylint-mode-map}

\(fn)" t nil)

(autoload 'pylint-add-key-bindings "pylint" "\


\(fn)" nil nil)

(autoload 'pylint-add-menu-items "pylint" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("pylint-pkg.el") (21640 39717 414707 719000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; pylint-autoloads.el ends here
