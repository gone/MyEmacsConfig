;;; starter-kit-js-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "starter-kit-js" "starter-kit-js.el" (20119
;;;;;;  21610))
;;; Generated autoloads from starter-kit-js.el

(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

(eval-after-load 'js '(progn (define-key js-mode-map "{" 'paredit-open-curly) (define-key js-mode-map "}" 'paredit-close-curly-and-newline) (add-hook 'js-mode-hook 'esk-paredit-nonlisp) (setq js-indent-level 2) (define-key js-mode-map (kbd ",") 'self-insert-command) ))

;;;***

;;;### (autoloads nil nil ("starter-kit-js-pkg.el") (20119 21610
;;;;;;  471027))

;;;***

(provide 'starter-kit-js-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; starter-kit-js-autoloads.el ends here