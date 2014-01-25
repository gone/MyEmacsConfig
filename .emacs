;;;Packages

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/elpa/")
(package-initialize)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

;;;Load third party libs
(load-library "twisted.el")
(load-library "init_python")
;(require 'flymake-node-jshint)
(require 'buffer-move)
(require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-shortcuts 'nil)


(require 'pythoscope)
(require 'twisted-dev)
(require 'auto-complete)
(require 'eldoc)
(require 'dired-single)
(require 'server)
(require 'defuns)
(require 'uniquify)
(require 'yaml-mode)
(require 'tidy)
(require 'yasnippet)
(require 'init_ispell)
(require 'web-mode)
(require 'rainbow-delimiters)
(require 'flycheck)
(require 'saveplace)
(require 'helm-config)
(require 'ido)

(autoload 'tidy-buffer "tidy" "Run Tidy HTML parser on current buffer" t)
(autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
(autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
(autoload 'tidy-build-menu  "tidy" "Install an options menu for HTML Tidy." t)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)

;;;Client setup
;;client color and font setup
(defadvice server-create-window-system-frame
  (after set-window-system-frame-colours ())
  "Set custom frame colours when creating the first frame on a display"
  (message "Running after frame-initialize")
  ;(set-face-attribute 'default nil :font  "-zevv-peep-normal-normal-normal-*-16-*-*-*-c-80-iso10646-1")
  (load-theme 'zenburn t)
  (setup-window-system-frame-colours))
(ad-activate 'server-create-window-system-frame)
(add-hook 'after-make-frame-functions 'setup-window-system-frame-colours t)


(setq-default save-place t)

(helm-mode 1)
(ido-mode t)
(scroll-bar-mode 0)
(tool-bar-mode 0)


(defalias 'yes-or-no-p 'y-or-n-p)

;;;Variables
(setq inhibit-startup-echo-area-messagee t
      inhibit-startup-message t
      display-time-24hr-format t
      scroll-step 1
      x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      save-place-file (concat user-emacs-directory "places")
      next-line-add-newlines nil
      search-highlight t
      indent-tabs-mode nil
      global-show-trailing-whitespace t
      query-replace-highlight t
      c-basic-offset 4
      default-tab-width 4
      flycheck-display-errors-delay .3
      browse-url-generic-program "google-chrome"
      tramp-default-method "ssh"
      show-paren-style 'expression
      temporary-file-directory "~/.emacs.d/tmp/"
      compilation-exit-message-function 'compilation-exit-autoclose
      global-show-trailing-whitespace t
      whitespace-style '(tab-mark)
      color-theme-is-global t

      browse-url-browser-function '(("file:///usr/local/share/doc/." . w3m-browse-url)
                                    ("." . browse-url-generic))
      package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/"))
      )





(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(focus-follows-mouse nil)
 '(py-indent-offset 4)
 '(py-python-command "ipython")
 '(python-indent 4)
 '(safe-local-variable-values (quote ((test-case-name . slader\.test\.test_common) (test-case-name . "slader.test.test_common") (test-case-name . "slader.test.test_common.py") (test-case-name . solutions\.tests) (folded-file . t) (test-case-name . twisted\.test\.test_abstract) (test-case-name . twisted\.test\.test_process) (test-case-name . twisted\.test\.test_factories) (test-case-name . twisted\.test\.test_newcred) (test-case-name . twisted\.test\.test_defer) (test-case-name . twisted\.test\.test_protocols) (test-case-name . twisted\.test\.test_banana) (test-case-name . twisted\.test\.test_pb) (test-case-name . twisted\.test\.test_reflect) (test-case-name . twisted\.test\.test_persisted) (test-case-name . twisted\.test\.test_jelly))))
 '(scss-compile-at-save nil)
 '(slime-complete-symbol-function (quote slime-fuzzy-complete-symbol))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify)))


;;;Tramp
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;;;Hooks
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;(add-hook 'after-change-major-mode-hook 'linum-on)
(add-hook 'change-major-mode-hook 'linum-delete-overlays nil t)
(add-hook 'after-save-hook
    'executable-make-buffer-file-executable-if-script-p)

(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

(add-hook 'python-mode-hook (lambda ()
                              (setq py-smart-indentation nil)
                              (define-key python-mode-map (kbd "s-u") 'python-send-buffer)
                              (define-key python-mode-map (kbd "\C-ch") 'pylookup-lookup)
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

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-use-clojure-font-lock t)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(random t) ;; Seed the random-number generator

;;;File Extensions
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.tac$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs$" . handlebars-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
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
(require 'smex)
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

;;;disabled
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(require 'ffap)
(defvar ffap-c-commment-regexp "^/\\*+"
  "matches an opening c-style comment, like \"/***\".")

(defadvice ffap-file-at-point (after avoid-c-comments activate)
  "don't return paths like \"/******\" unless they actually exist.

this fixes the bug where ido would try to suggest a c-style
comment as a filename."
  (ignore-errors
    (when (and ad-return-value
               (string-match-p ffap-c-commment-regexp
                               ad-return-value)
               (not (ffap-file-exists-string ad-return-value)))
      (setq ad-return-value nil))))


; fix for autocomplete
(set-cursor-color "white")
;;;function setup
(menu-bar-mode nil)
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
(set-face-attribute 'default nil :font  "-zevv-peep-normal-normal-normal-*-16-*-*-*-c-80-iso10646-1")
(load-theme 'zenburn t)


;;;auto complete
(global-auto-complete-mode t)
(define-key
  ac-complete-mode-map "\c-n" 'ac-next)
(define-key ac-complete-mode-map "\c-p" 'ac-previous)


;; (require 'sws-mode)
;; (require 'jade-mode)
;; (add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))



;; hippie expand: at times perhaps too hip
(eval-after-load 'hippie-exp
  '(progn
     (dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially))
       (delete f hippie-expand-try-functions-list))

     ;; add this back in at the end of the list.
     (add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t)))




(eval-after-load 'grep
  '(when (boundp 'grep-find-ignored-files)
     (add-to-list 'grep-find-ignored-files "*.class")))

;; Cosmetics

(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green4")
     (set-face-foreground 'magit-diff-del "red3")))

(idle-highlight-mode t)
;;;  .emacs ends here
