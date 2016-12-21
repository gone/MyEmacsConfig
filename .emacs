;;load packages

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "/usr/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)
(require 'use-package)

;; display
;;TODO: figure out how to keep this and keep new ediff windows small
;; (setq initial-frame-alist (quote ((fullscreen . maximized))))
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(set-face-attribute 'default nil :height 100)
(load-theme 'zenburn t)
(scroll-bar-mode -1)
(tool-bar-mode 0)
(blink-cursor-mode 0)
; fix for autocomplete
(set-cursor-color "white")
;;;function setup
(menu-bar-mode -1)
;;line numbers
(line-number-mode t)
(global-linum-mode t)
(column-number-mode t)
;; paren matching
(show-paren-mode t)
;; useful highlights
(transient-mark-mode nil)
(global-font-lock-mode t)
(whitespace-mode)
(defalias 'yes-or-no-p 'y-or-n-p)
;;;Variables
(setq ring-bell-function 'ignore)
(setq inhibit-startup-echo-area-messagee t
      explicit-shell-file-name "/bin/zsh"
      inhibit-startup-message t
      display-time-24hr-format t
      scroll-step 1
      x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      next-line-add-newlines nil
      search-highlight t
      indent-tabs-mode nil
      global-show-trailing-whitespace t
      query-replace-highlight t
      c-basic-offset 4
      default-tab-width 4
      global-hl-line-mode 1
      browse-url-generic-program "google-chrome-unstable"
      show-paren-style 'expression
      temporary-file-directory "~/.emacs.d/private/tmp/"
      compilation-exit-message-function 'compilation-exit-autoclose
      global-show-trailing-whitespace t
      whitespace-style '(tab-mark)
      color-theme-is-global t
      create-lockfiles nil
      frame-title-format "%b (%f)"
      url-cookie-file "~/emacs.d/private/url/cookies"
      )
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(idle-highlight-mode t)
(setq-default indent-tabs-mode nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(focus-follows-mouse nil)
 '(magit-push-arguments nil)
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "SOMEDAY(s)" "WAITING(w)" "DONE(d)"))))
 '(package-check-signature nil)
 '(package-selected-packages
   (quote
    (babel-repl yaml-mode flymake-yaml pytest web-mode handlebars-mode ztree magit-gitflow magit rainbow-delimiters sunrise-commander sunrise-x-loop sunrise-x-mirror sunrise-x-modeline sunrise-x-tree dired+ zenburn-theme virtualenvwrapper use-package pyvirtualenv pyvenv pallet ido-ubiquitous idle-highlight-mode idle-highlight)))
 '(py-indent-offset 4)
 '(py-python-command "ipython")
 '(python-indent 4)
 '(python-indent-offset 4)
 '(safe-local-variable-values
   (quote
    ((test-case-name . slader\.test\.test_common)
     (test-case-name . "slader.test.test_common")
     (test-case-name . "slader.test.test_common.py")
     (test-case-name . solutions\.tests)
     (folded-file . t)
     (test-case-name . twisted\.test\.test_abstract)
     (test-case-name . twisted\.test\.test_process)
     (test-case-name . twisted\.test\.test_factories)
     (test-case-name . twisted\.test\.test_newcred)
     (test-case-name . twisted\.test\.test_defer)
     (test-case-name . twisted\.test\.test_protocols)
     (test-case-name . twisted\.test\.test_banana)
     (test-case-name . twisted\.test\.test_pb)
     (test-case-name . twisted\.test\.test_reflect)
     (test-case-name . twisted\.test\.test_persisted)
     (test-case-name . twisted\.test\.test_jelly))))
 '(scss-compile-at-save nil)
 '(slime-complete-symbol-function (quote slime-fuzzy-complete-symbol))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify)))

;;;Hooks
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'change-major-mode-hook 'linum-delete-overlays nil t)
(add-hook 'after-save-hook
    'executable-make-buffer-file-executable-if-script-p)


(random t) ;; Seed the random-number generator

;;;File Extensions
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . rst-mode))
(add-to-list 'auto-mode-alist '("\\.rst\\'" . rst-mode))
(add-to-list 'auto-mode-alist '("\\.rest\\'" . rst-mode))


;;configure emacs
(add-to-list 'load-path "~/.emacs.d/lisp")

;;;Load third party libs
(load-library "twisted.el")
(load-library "init_python")
(load-library "init_javascript")
;(load-library "init_clojure")


(use-package whitespace)
(use-package ffap)
(use-package editorconfig)
(use-package pymacs)
;(use-package dired-single)
(use-package rainbow-delimiters)
(use-package twisted-dev)
(use-package eldoc)
(use-package defuns)
(use-package yasnippet)
(use-package init_ispell)

(use-package spaceline-config
  :config
  (spaceline-emacs-theme))

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))


(use-package web-mode
  :config
  (setq web-mode-markup-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("django"  . "\\.html")))
  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (local-set-key (kbd "RET") 'newline-and-indent))
  (add-hook 'web-mode-hook  'my-web-mode-hook))


(use-package flycheck
  :config
  (setq flycheck-display-errors-delay .2)
  (flycheck-define-checker scss
    "A SCSS syntax checker using the SCSS compiler.
See URL `http://sass-lang.com'."
    :command ("scss-lint" source)
    :error-patterns
    ((error line-start (file-name) ":" line " [E] Syntax error: " (message))
     (warning line-start (file-name) ":" line " [W] " (message)))
    :modes scss-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(setq diredp-hide-details-initially-flag nil)
(require 'dired+)
(toggle-diredp-find-file-reuse-dir 1)

;; (add-hook 'dired-mode-hook
;;       '(lambda ()
;;         (define-key dired-mode-map [return] 'dired-single-buffer)
;;         (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
;;         (define-key dired-mode-map "^"
;;         (function
;;          (lambda nil (interactive) (dired-single-buffer ".."))))))

;;;Custom Keys
(use-package bind-key
  :config
  (bind-key (kbd "C-x C-SPC") 'pop-to-mark-command)
  (bind-key "M-p" 'align-regexp)
  (bind-key "C-'" 'other-frame)
  (bind-key "C-;" 'other-window)
  (bind-key "<f8>" 'apropos)
  (bind-key "C-a" 'back-to-indentation-or-beginning)
  (bind-key "M-<left>" 'buf-move-left)
  (bind-key "M-<right>" 'buf-move-right)
  (bind-key "M-<up>" 'buf-move-up)
  (bind-key "M-<down>" 'buf-move-down)
  (bind-key "C-x RET" 'eshell)
  (bind-key "\C-cl" 'org-store-link)
  (bind-key "\C-ca" 'org-agenda)
  (bind-key "C-+" 'text-scale-increase)
  (bind-key "C--" 'text-scale-decrease)
  (bind-key "C-s" 'isearch-forward-regexp)
  (bind-key "\C-r" 'isearch-backward-regexp)
  (bind-key "M-%" 'query-replace-regexp)
  (bind-key "C-M-s" 'isearch-forward)
  (bind-key "C-M-r" 'isearch-backward)
  (bind-key "C-M-%" 'query-replace)
  (bind-key "C-x C-i" 'imenu)
  (bind-key "C-c y" 'bury-buffer)
  (bind-key "C-c m" 'revert-buffer)
  (bind-key "C-x C-o" (lambda () (interactive) (other-window 2)))
  (bind-key "C-c q" 'join-line)
  (bind-key "M-/" 'hippie-expand)
  (bind-key "C-x C-b" 'ibuffer)
  (bind-key "C-c g" 'magit-status))

;;smex
(use-package smex
  :config
  (setq smex-save-file "~/.emacs.d/private/.smex-items")
  (bind-key "M-x" (lambda ()
                    (interactive)
                    (or (boundp 'smex-cache)
                        (smex-initialize))
                    (global-set-key [(meta x)] 'smex)
                    (smex)))
  (bind-key [(shift meta x)] (lambda ()
                      (interactive)
                      (or (boundp 'smex-cache)
                          (smex-initialize))
                      (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                      (smex-major-mode-commands)))

  (defadvice smex (around space-inserts-hyphen activate compile)
    (let ((ido-cannot-complete-command
           `(lambda ()
              (interactive)
              (if (string= " " (this-command-keys))
                  (insert ?-)
                (funcall ,ido-cannot-complete-command)))))
      ad-do-it))

  (defun smex-update-after-load (unused)
    (when (boundp 'smex-cache)
      (smex-update)))
  (add-hook 'after-load-functions 'smex-update-after-load))



;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; hippie expand: at times perhaps too hip
(eval-after-load 'hippie-exp
  '(progn
     (dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially))
       (delete f hippie-expand-try-functions-list))

     ;; add this back in at the end of the list.
     (add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t)))



;; Cosmetics
;; (eval-after-load 'diff-mode
;;   '(progn
;;      (set-face-foreground 'diff-added "green4")
;;      (set-face-foreground 'diff-removed "red3")))

;; (eval-after-load 'magit
;;   '(progn
;;      (set-face-foreground 'magit-diff-added "green4")
;;      (set-face-foreground 'magit-diff-del "red3")))


(use-package vlf-setup)

(defadvice save-buffer (around save-buffer-as-root-around activate)
  "Use sudo to save the current buffer."
  (interactive "p")
  (if (and (buffer-file-name) (not (file-writable-p (buffer-file-name))))
      (let ((buffer-file-name (format "/sudo::%s" buffer-file-name)))
    ad-do-it)
    ad-do-it))

(use-package ag
  :commands ag
  :init
  (setq ag-reuse-window 't)
  (setq compilation-scroll-output 'first-error)
  :config
  (add-hook 'ag-search-finished-hook (lambda () (pop-to-buffer next-error-last-buffer))))

(use-package magit-gitflow
  :init
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))


;(autoload 'whitespace-mode           "whitespace" "Toggle whitespace visualization."        t)


(make-directory "~/.emacs.d/private/tmp/" t)

(use-package recentf
  :init
  (setq recentf-save-file "~/.emacs.d/private/recentf")
  (recentf-mode 1)
  (setq recentf-max-menu-items 25))

(use-package pcache
  :init
  (make-directory "~/.emacs.d/private/var/pcache/" t)
  (setq pcache-directory "~/.emacs.d/private/var/pcache/"))

(use-package auto-save
  :demand t
  :init
  (make-directory "~/.emacs.d/private/autosaves/" t)
  (setq auto-save-list-file-prefix
        "/.emacs.d/private/autosaves/")
  (setq auto-save-file-name-transforms
        `((".*" ,"~/.emacs.d/private/autosaves/" t))))

(use-package backup
  :demand t
  :init
  (make-directory "~/.emacs.d/private/backups/" t)
  (setq backup-directory-alist (quote ((".*" . "~/.emacs.d/private/backups/")))))


(use-package ido
  :init
  (setq ido-save-directory-list-file "~/.emacs.d/private/ido.last")
  :config
  (setq ido-save-directory-list-file "~/.emacs.d/private/ido.last")
  (ido-mode t)
  (setq ido-everywhere t)
  (ido-ubiquitous-mode 1)
  (setq ido-create-new-buffer 'always)
  (setq ido-enable-flex-matching t))

(use-package saveplace
  :init
  (setq save-place-file "~/.emacs.d/private/places")
  (setq-default save-place t))

(use-package tramp
  :init
  (setq tramp-default-method "ssh")
  (setq tramp-persistency-file-name "~/.emacs.d/private/tramp")
  (setenv "SHELL" "/bin/bash"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(find-file "~/org/todo.org")
(provide '.emacs)
;;; .emacs ends here
