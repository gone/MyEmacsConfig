(server-start)

(erc :server "irc.freenode.net" :full-name "Ben Beecher")
;; turn off that annoying start up screen - yes I know what gnu is.
(setq inhibit-startup-echo-area-messagee t)
(setq inhibit-startup-message t)
;; turn off that annoying ~ file
(setq make-backup-files nil)
;;change the font to something readable
;;(set-face-font 'default "-outline-Consolas-normal-r-normal-normal-19-14-96-96-c-*-iso8859-1")

(setq tramp-default-method "ssh")

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "/usr/share/emacs22/site-lisp/")
(put 'upcase-region 'disabled nil)


;custom keys
(global-set-key (kbd "M-p") 'align-regexp)
(global-set-key (kbd "C-'") 'other-frame)
(global-set-key (kbd "C-;") 'other-window)
(global-set-key (kbd "s-i") 'clipboard-yank)
(global-set-key (kbd "<f8>") 'apropos)

;custom-modes
(setq auto-mode-alist (cons '("\\.tac$" . python-mode) auto-mode-alist))
(menu-bar-mode nil)
;;line numbers 
(line-number-mode t)
(global-linum-mode t)
(column-number-mode t)
;; show clock in modeline
(display-time)
(setq display-time-24hr-format t)
;; scroll line by line, smoothly
(setq scroll-step 1)
;; don't add newlines to end of buffer when scrolling
(setq next-line-add-newlines nil)
;; make mouse yank at point
(setq mouse-yank-at-point t)
(global-set-key [(shift tab)] 'next-multiframe-window)
;; paren matching
(show-paren-mode t)
(setq show-paren-style 'expression)
;; useful highlights
(setq search-highlight t)
(setq query-replace-highlight t)
;; highlight region, somewhat ugly
(transient-mark-mode nil)

(global-font-lock-mode t)

(defun untab-all ()
  "transmogrify all tabs to spaces"
  (interactive)
  (save-excursion
    (untabify (point-min) (point-max))
    (message "transmogrified")))

;; we don't want no stinkin tabs
;(setq c-basic-offset 4)
;(setq-default indent-tabs-mode t)
;(setq-default default-tab-width 4)

(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; assignField - used at IFS for setting the field variables are pulled from.
(fset 'assignField
   "\C-e = ucase(trim(Fields(\"Field\C-u\C-xq\")))\C-a\C-n")



(load-library "cheetah-mode.el")

;(load-library "python-mode.el")
;(load-library "python.el")
(add-hook 'python-mode-hook
		  (setq py-smart-indentation nil))
(load-library "psvn.el")
(load-library "ansi-color.el")
(load-library "espresso.elc")
(load-library "js2.elc")
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
(load-library "xml-rpc.el")
(load-library "trac-wiki.el")
(load-library "tidy.el")
(load-library "multi-mode.el")
(require 'color-theme)
(eval-after-load "color-theme"
     (color-theme-hober))
(load "~/elisp/haskell-mode-2.4/haskell-site-file.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)


(require 'dired-single)
(defun my-dired-init ())
(add-hook 'dired-mode-hook
	  '(lambda ()
        ;; <add other stuff here>
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

;; Turn on tabs
(set-variable 'py-indent-offset 4)
(setq indent-tabs-mode t)
(setq-default indent-tabs-mode t)
(setq tab-stop-list (list 4 8 12 16 20 24 28 32 36 40 44 48 52 56))

;; Set the tab width
(setq default-tab-width 4)
(setq global-tab-width 4)
(setq c-basic-indent 4)

;(require 'auto-complete)
;(global-auto-complete-mode t)
;(define-key ac-complete-mode-map "\C-n" 'ac-next)
;(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;(require 'yasnippet)
;(yas/initialize)
;(yas/load-directory "~/elisp/snippets")
;(require 'auto-complete-yasnippet)

;(load-library "init_python")
(load-library "pymacs.elc")
(require 'pymacs)


(defun docstrings (&optional buffer)
  "Changes all doc strings in the buffer (default current) into the correct format."
  (interactive)
  (when (not buffer)
	(setq buffer (current-buffer)))
  (save-excursion
	(set-buffer buffer)
	(goto-char (point-min))
	(while (re-search-forward "def .*:
\[^\"]*\"\"\"." 'nil 't)
	  (goto-char (- (point) 1))
	  (newline-and-indent)
	  (re-search-forward "\"\"\"" 'nil 't)
	  (goto-char (- (point) 3))
	  (newline-and-indent))))



(setq global-show-trailing-whitespace t)
(setq whitespace-style '(tab-mark))
(whitespace-mode)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(focus-follows-mouse nil)
 '(nxml-child-indent 4)
 '(nxml-outline-child-indent 4)
 '(py-indent-offset 4)
 '(python-indent 8)
 '(safe-local-variable-values (quote ((folded-file . t) (test-case-name . twisted\.test\.test_abstract) (test-case-name . twisted\.test\.test_process) (test-case-name . twisted\.test\.test_factories) (test-case-name . twisted\.test\.test_newcred) (test-case-name . twisted\.test\.test_defer) (test-case-name . twisted\.test\.test_protocols) (test-case-name . twisted\.test\.test_banana) (test-case-name . twisted\.test\.test_pb) (test-case-name . twisted\.test\.test_reflect) (test-case-name . twisted\.test\.test_persisted) (test-case-name . twisted\.test\.test_jelly)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
;gnus!
(setq gnus-select-method '(nntp "news.giganews.com"))
;(setq gnus-startup-hook  (list (add-to-list 'gnus-secondary-select-methods '(nnimap "gmail"
				   ;; 														(nnimap-address "imap.gmail.com")
				   ;; 														(nnimap-server-port 993)
				   ;; 														(nnimap-stream ssl)))
				   ;; (setq message-send-mail-function 'smtpmail-send-it
				   ;; 		 smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
				   ;; 		 smtpmail-auth-credentails '(("smtp.gmail.com" 587 "benbeecher@gmail.com" nil))
				   ;; 		 smptmail-default-smtp-server "smtp.gmail.com"
				   ;; 		 smtpmail-smtp-server "smtp.gmail.com"
				   ;; 		 smtpmail-smtp-service 587
				   ;; 		 smtpmail-local-domain "newworldrecords.org")))




(load-library "twit.el")