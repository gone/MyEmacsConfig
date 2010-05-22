(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;set variables
(setq inhibit-startup-echo-area-messagee t)
(setq inhibit-startup-message t)
(setq tramp-default-method "ssh")
(setq auto-mode-alist (cons '("\\.tac$" . python-mode) auto-mode-alist))
(setq display-time-24hr-format t)
;; scroll line by line, smoothly
(setq scroll-step 1)
;; don't add newlines to end of buffer when scrolling
(setq next-line-add-newlines nil)
;; make mouse yank at point
(setq mouse-yank-at-point t)
(setq search-highlight t)
(setq query-replace-highlight t)
(setq c-basic-offset 4)
(setq-default default-tab-width 4)
(setq global-show-trailing-whitespace t)
(setq browse-url-browser-function 'browse-url-generic
	  browse-url-generic-program "google-chrome")
;load
(add-to-list 'load-path "~/.emacs.d")
(load-library "python-mode.el")
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
(load-library "twisted.el")
(load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/ecb")

;custom keys
(global-set-key (kbd "M-p") 'align-regexp)
(global-set-key (kbd "C-'") 'other-frame)
(global-set-key (kbd "C-;") 'other-window)
(global-set-key (kbd "s-y") 'clipboard-yank)
(global-set-key (kbd "s-k") 'clipboard-kill-ring-save)
(global-set-key (kbd "<f8>") 'apropos)
(global-set-key (kbd "s-m") 'clean-sql)

;disabled
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;custom-modes
(menu-bar-mode nil)
;;line numbers 
(line-number-mode t)
(global-linum-mode t)
(column-number-mode t)
;; show clock in modeline
(display-time)
;; paren matching
(show-paren-mode t)
(setq show-paren-style 'expression)
;; useful highlights
(transient-mark-mode nil)
(global-font-lock-mode t)


;font
(set-face-attribute 'default nil :font  "-zevv-peep-normal-normal-normal-*-16-*-*-*-c-80-iso10646-1")

;color;
(require 'color-theme)
(color-theme-initialize)
(eval-after-load "color-theme"
     (color-theme-arjen))

;haskel
(load "~/.emacs.d/haskell-mode-2.4/haskell-site-file.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;python
(require 'pymacs)
(require 'pythoscope)
(defun twisted-dev-debug ()
  (interactive)
  (twisted-dev-runtests 't))

(add-hook 'python-mode-hook (lambda ()
			      (define-key py-mode-map (kbd "s-u") 'python-send-buffer)
			      (require 'twisted-dev)
			      (define-key py-mode-map (kbd "<f5>") 'twisted-dev-runtests)
				  (define-key py-mode-map (kbd "<f6>") 'twisted-dev-debug)))

(require 'auto-complete)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
(require 'auto-complete-yasnippet)

(load-library "init_python")


;processing
;keep these around, but cold storage it - I'm not doing much processing
;(autoload 'processing-mode "processing-mode" "Processing mode" t)
;(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))
;(setq processing-location "~/workspace/processing/processing-1.1/")



;clojure
;(add-to-list 'load-path "~/workspace/clojure/clojure-mode")
;(require 'clojure-mode)
;clojure-swank
;(add-to-list 'load-path "~/workspace/clojure/swank-clojure/src/emacs")
;(setq swank-clojure-jar-path "~/.clojure/clojure.jar"
;      swank-clojure-extra-classpaths (list
;									  "~/workspace/clojure/swank-clojure/src/main/clojure"
;									  "~/.clojure/clojure-contrib-1.2.0-SNAPSHOT.jar"))
;(require 'swank-clojure-autoload)

;slimep
(add-to-list 'load-path "~/.emacs.d/slime/")
(setq inferior-lisp-program "sbcl")
(setq slime-backend
      "/home/bbeecher/.emacs.d/slime/swank-loader.lisp")
(load "/home/bbeecher/.emacs.d/slime/slime-autoloads")
(eval-after-load "slime"
  '(progn
    (slime-setup '(slime-fancy slime-asdf slime-banner))
    (setq slime-complete-symbol*-fancy t)
    (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)))
(require 'slime)
(slime-setup '(slime-repl))
(slime-setup)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

;dired-single
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

;functions
(defun untab-all ()
  "transmogrify all tabs to spaces"
  (interactive)
  (save-excursion
    (untabify (point-min) (point-max))
    (message "transmogrified")))

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

(defun clean-sql (start stop)
  "cleans a region of text stolen from a console - replaing \t and \n"
  (interactive "r")
  (defun replace (from to)
	(goto-char start)
	(while (search-forward from stop t)
	  (replace-match to nil t)))
  (save-excursion 
	(replace "\\n" "\n")
	(replace "\\t" "\t")))
			   

(defun blankit ()
  (interactive "")
  "prints ', blank=True' - using this for the cph project since every freaking field needs it"
  (insert ", blank=True"))
; this should really check to see if the last char was (, and if so omit the ","
; also should check to see if we have a ) at the end, and add it if not
