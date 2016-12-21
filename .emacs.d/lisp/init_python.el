;;; package --- Summary
;;; Commentary:

;;; Code:
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)

(use-package virtualenv)

;; (eval-after-load "pymacs"
;;   '(add-to-list 'pymacs-load-path ""))

;; (setq ropemacs-enable-shortcuts 'nil)
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)

(require 'pytest)
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key "\C-ca" 'pytest-all)
            (local-set-key "\C-cm" 'pytest-module)
            (local-set-key "\C-c." 'pytest-one)
            (local-set-key "\C-cd" 'pytest-directory)
            (local-set-key "\C-cpa" 'pytest-pdb-all)
            (local-set-key "\C-cpm" 'pytest-pdb-module)
            (local-set-key "\C-cp." 'pytest-pdb-one)))


(use-package virtualenvwrapper
  :init
  (venv-initialize-interactive-shells) ;; if you want interactive shell support
  (venv-initialize-eshell) ;; if you want eshell support
  (setq venv-location "~/.virtualenvs/")
  (add-hook 'venv-postactivate-hook (lambda ()
                                      (setenv "DJANGO_SETTINGS_MODULE" (concat venv-current-name venv-current-name ".settings.local"))))
  (setq eshell-prompt-function
        (lambda ()
          (concat "(" venv-current-name ") " (eshell/pwd) " $ "))))



(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))

(add-hook 'python-mode-hook 'annotate-pdb)


(defun python-add-breakpoint ()
  (interactive)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ 	]*import ipdb; ipdb.set_trace()"))

(add-hook 'python-mode-hook
	  (lambda ()
	    (define-key python-mode-map (kbd "C-c C-t") 'python-add-breakpoint)
      ))


;(autoload 'jedi:setup "jedi" nil t)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:setup-keys t)
;; (setq jedi:complete-on-dot t)

(setq python-command "ipython"
      py-python-command-args '("--pylab"))

(provide 'init_python)
;;; init_python.el ends here
