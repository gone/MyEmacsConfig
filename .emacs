;;;Packages
(require 'cask "/usr/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)
(require 'use-package)
(setq initial-frame-alist (quote ((fullscreen . maximized))))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(load-theme 'zenburn t)
(add-to-list 'load-path "~/.emacs.d/lisp")

(make-directory "~/.emacs.d/private/autosaves/" t)
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs.d/private/autosaves/" t)))


(use-package recentf
  :config
  (setq recentf-save-file "~/.emacs.d/private/recentf")
  (recentf-mode 1)
  (setq recentf-max-menu-items 25))


;;;Load third party libs
(load-library "twisted.el")
(load-library "init_python")
(load-library "init_javascript")
;(load-library "init_clojure")

(use-package ffap)
(use-package editorconfig)
(use-package pymacs)
(use-package dired-single)
(use-package spaceline-config
  :config
  (spaceline-emacs-theme))



(use-package backup
  :config
  (make-directory "~/.emacs.d/private/backups/" t)
  (setq backup-directory-alist (quote ((".*" . "~/.emacs.d/private/backups/")))))

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

(use-package ido
  :config
  (setq ido-save-directory-list-file "~/.emacs.d/private/ido.last")
  (ido-mode t)
  (setq ido-everywhere t)
  (ido-ubiquitous-mode 1)
  (setq ido-create-new-buffer 'always)
  (setq ido-enable-flex-matching t))

(use-package rainbow-delimiters)
(use-package twisted-dev)
;(use-package auto-complete)
(use-package eldoc)
(use-package defuns)


(use-package yasnippet)
(use-package init_ispell)

(use-package web-mode
  :config
  (setq web-mode-markup-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
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



(use-package flycheck)
(use-package saveplace
  :config
  (setq save-place-file "~/.emacs.d/private/places")
  (setq-default save-place t))

;(set-face-attribute 'default nil :font "DejaVesu Sans Mono-11")
;(set-frame-font "DejaVu Sans Mono-10" t t)

;(helm-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode 0)
(blink-cursor-mode 0)

(defalias 'yes-or-no-p 'y-or-n-p)

;;;Variables
(setq ring-bell-function 'ignore)
(setq inhibit-startup-echo-area-messagee t
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
      flycheck-display-errors-delay .3
      browse-url-generic-program "google-chrome-unstable"
      tramp-default-method "ssh"
      show-paren-style 'expression
      temporary-file-directory "~/.emacs.d/private/tmp/"
      compilation-exit-message-function 'compilation-exit-autoclose
      global-show-trailing-whitespace t
      whitespace-style '(tab-mark)
      color-theme-is-global t
      create-lockfiles nil
      frame-title-format "%b (%f)"
      )

(setq-default indent-tabs-mode nil)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(focus-follows-mouse nil)
 '(package-check-signature nil)
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


;;;Tramp
(use-package tramp
  :config
  (setenv "SHELL" "/bin/bash"))

;;;Hooks
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'scss-mode-hook #'rainbow-delimiters-mode)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'change-major-mode-hook 'linum-delete-overlays nil t)
(add-hook 'after-save-hook
    'executable-make-buffer-file-executable-if-script-p)

(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

(add-hook 'python-mode-hook (lambda ()
                              (setq py-smart-indentation nil)
                              (define-key python-mode-map (kbd "s-u") 'python-send-buffer)
                              (define-key python-mode-map (kbd "<f5>") 'twisted-dev-runtests)
                              (define-key python-mode-map (kbd "<f6>") 'twisted-dev-debug)))

(add-hook 'html-mode-hook (lambda ()
                            (define-key html-mode-map (kbd "\C-xt") 'tag-word-or-region)))
(add-hook 'dired-mode-hook
      '(lambda ()
        (define-key dired-mode-map [return] 'dired-single-buffer)
        (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
        (define-key dired-mode-map "^"
        (function
         (lambda nil (interactive) (dired-single-buffer "..")))))

      ;; if dired's already loaded, then the keymap will be bound
      (if (boundp 'dired-mode-map)
        ;; we're good to go; just add our bindings
        (my-dired-init)
        ;; it's not loaded yet, so add our bindings to the load-hook
        (add-hook 'dired-load-hook 'my-dired-init)))


(random t) ;; Seed the random-number generator

;;;File Extensions
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.tac$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . rst-mode))
(add-to-list 'auto-mode-alist '("\\.rst\\'" . rst-mode))
(add-to-list 'auto-mode-alist '("\\.rest\\'" . rst-mode))



;;;Custom Keys


(global-set-key (kbd "C-x C-SPC") 'pop-to-mark-command)
(global-set-key (kbd "M-p") 'align-regexp)
(global-set-key (kbd "C-'") 'other-frame)
(global-set-key (kbd "C-;") 'other-windowes)
(global-set-key (kbd "<f8>") 'apropos)
(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)
(global-set-key (kbd "M-<left>") 'buf-move-left)
(global-set-key (kbd "M-<right>") 'buf-move-right)
(global-set-key (kbd "M-<up>") 'buf-move-up)
(global-set-key (kbd "M-<down>") 'buf-move-down)
(global-set-key (kbd "C-x RET") 'eshell)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-M-%") 'query-replace)
(global-set-key (kbd "C-x C-i") 'imenu)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c m") 'revert-buffer)
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two
(global-set-key (kbd "C-c q") 'join-line)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;;magit
(global-set-key (kbd "C-c g") 'magit-status)


;;smex
(use-package smex)
(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
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
    (add-hook 'after-load-functions 'smex-update-after-load)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)




; fix for autocomplete
(set-cursor-color "white")
;;;function setup
(menu-bar-mode -1)
;;line numbers
(line-number-mode t)
(global-linum-mode t)
(column-number-mode t)
;; show clock in modeline
(display-time)
;; paren matching
(show-paren-mode t)
;; useful highlights
(transient-mark-mode nil)
(global-font-lock-mode t)
(whitespace-mode)

;;;font and theme
;(set-face-attribute 'default nil :font "DejaVu Sans Mono-11")




;;;auto complete
;(global-auto-complete-mode t)
;; (define-key
;;   ac-complete-mode-map "\C-n" 'ac-next)
;; (define-key ac-complete-mode-map "\C-p" 'ac-previous)




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


(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

(eval-after-load 'grep
  '(when (boundp 'grep-find-ignored-files)
     (add-to-list 'grep-find-ignored-files "*.class")))

;; Cosmetics

(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

;; (eval-after-load 'magit
;;   '(progn
;;      (set-face-foreground 'magit-diff-added "green4")
;;      (set-face-foreground 'magit-diff-del "red3")))

(idle-highlight-mode t)


(use-package vlf-setup)
(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)
(setq explicit-shell-file-name "/bin/zsh")

(flycheck-define-checker scss
  "A SCSS syntax checker using the SCSS compiler.
See URL `http://sass-lang.com'."
  :command ("scss-lint" source)
  :error-patterns
  ((error line-start (file-name) ":" line " [E] Syntax error: " (message))
   (warning line-start (file-name) ":" line " [W] " (message)))
   :modes scss-mode)


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


(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
