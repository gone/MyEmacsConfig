;make sure we have access to everything
(add-to-list 'load-path "~/.emacs.d/elpa/")
(require 'package)
(require 'cedet)
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)
(require 'starter-kit-defuns)

;; turn off that annoying start up screen - yes I know what gnu is.
(setq inhibit-startup-echo-area-messagee t)
(setq inhibit-startup-message t)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;set variables
(setq inhibit-startup-echo-area-messagee t)
(setq inhibit-startup-message t)
(setq tramp-default-method "ssh")
(setq auto-mode-alist (cons '("\\.tac$" . python-mode) auto-mode-alist))
(setq display-time-24hr-format t)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(deft-auto-save-interval 0.0)
 '(focus-follows-mouse nil)
 '(nxml-child-indent 4)
 '(nxml-outline-child-indent 4)
 '(py-indent-offset 4)
 '(python-indent 8)
 '(safe-local-variable-values (quote ((test-case-name . slader\.test\.test_common) (test-case-name . "slader.test.test_common") (test-case-name . "slader.test.test_common.py") (test-case-name . solutions\.tests) (folded-file . t) (test-case-name . twisted\.test\.test_abstract) (test-case-name . twisted\.test\.test_process) (test-case-name . twisted\.test\.test_factories) (test-case-name . twisted\.test\.test_newcred) (test-case-name . twisted\.test\.test_defer) (test-case-name . twisted\.test\.test_protocols) (test-case-name . twisted\.test\.test_banana) (test-case-name . twisted\.test\.test_pb) (test-case-name . twisted\.test\.test_reflect) (test-case-name . twisted\.test\.test_persisted) (test-case-name . twisted\.test\.test_jelly))))
 '(slime-complete-symbol-function (quote slime-fuzzy-complete-symbol))
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify)))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

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
(setq-default indent-tabs-mode 'nil)
(setq indent-tabs-mode 'nil)
(setq global-show-trailing-whitespace t)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")
;load
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/elisp")
(load-library "python-mode.el")
(load-library "ansi-color.el")
(load-library "espresso.elc")
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
(load-library "multi-mode.el")
(load-library "twisted.el")
;nxml
;(load "~/.emacs.d/nxhtml/autostart.el")
;(setq mumamo-background-colors nil) 
;(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))


;custom keys
(global-set-key (kbd "M-p") 'align-regexp)
(global-set-key (kbd "C-'") 'other-frame)
(global-set-key (kbd "C-;") 'other-window)
(global-set-key (kbd "s-y") 'clipboard-yank)
(global-set-key (kbd "s-k") 'clipboard-kill-ring-save)
(global-set-key (kbd "<f8>") 'apropos)
(global-set-key (kbd "M-p") 'align-regexp)

(defun back-to-indentation-or-beginning ()
   (interactive)
   (if (= (point) (save-excursion (back-to-indentation) (point)))
       (beginning-of-line)
     (back-to-indentation)))

(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)


;disabled
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


;custom-modes
(setq auto-mode-alist
      (append auto-mode-alist
          '(("\\.[hg]s$"  . haskell-mode)
        ("\\.hi$"     . haskell-mode)
        ("\\.tac$"    . python-mode)
        ("\\.l[hg]s$" . literate-haskell-mode))))
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
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(require 'color-theme)
(color-theme-initialize)
(eval-after-load "color-theme"
     (color-theme-arjen))

;haskel
;; (load "~/.emacs.d/haskell-mode-2.4/haskell-site-file.el")
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (autoload 'haskell-mode "haskell-mode"
;;   "Major mode for editing Haskell scripts." t)
;; (autoload 'literate-haskell-mode "haskell-mode"
;;   "Major mode for editing literate Haskell scripts." t)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

;cheetah templating library
;;(load-library "cheetah-mode.el")

;git support
(add-to-list 'load-path "~/.emacs.d/egg/")
(load-library "egg.elc")


(add-hook 'after-save-hook
    'executable-make-buffer-file-executable-if-script-p)

;(load-library "python-mode.el")
;(load-library "python.el")
(add-hook 'python-mode-hook
          (setq py-smart-indentation nil))

(load-library "ansi-color.el")
(load-library "espresso.elc")
(load-library "js2.elc")
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
(load-library "multi-mode.el")

;python
;(require 'pymacs)
(require 'pythoscope)
(defun twisted-dev-debug ()
  (interactive)
  (twisted-dev-runtests 't))

(require 'twisted-dev)

(add-hook 'python-mode-hook (lambda ()
                  (define-key py-mode-map (kbd "s-u") 'python-send-buffer)
                  (define-key py-mode-map (kbd "<f2>") 'flymake-display-err-menu-for-current-line)
                  (define-key py-mode-map (kbd "<f5>") 'twisted-dev-runtests)
                  (define-key py-mode-map (kbd "<f6>") 'twisted-dev-debug)))


(require 'auto-complete)
(global-auto-complete-mode t)
(define-key
 ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(require 'deft)

(load-library "init_python")
(load-library "init_sproutcore.el")

;processing
;keep these around, but cold storage it - I'm not doing much processing
;(autoload 'processing-mode "processing-mode" "Processing mode" t)
;(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))
;(setq processing-location "~/workspace/processing/processing-1.1/")

;; paredit
(add-to-list 'load-path "~/opt/paredit")
(require 'paredit)
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook           (lambda () (paredit-mode +1)))
;(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
( defun override-slime-repl-bindings-with-paredit ()
   (define-key slime-repl-mode-map
       (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

(require 'eldoc) ; if not already loaded
(eldoc-add-command
 'paredit-backward-delete
 'paredit-close-round)


;clojure-swank
;(add-to-list 'load-path "~/workspace/clojure/swank-clojure/src/emacs")
;(setq swank-clojure-jar-path "~/.clojure/clojure.jar"
;      swank-clojure-extra-classpaths (list
;                                     "~/workspace/clojure/swank-clojure/src/main/clojure"
;                                     "~/.clojure/clojure-contrib-1.2.0-SNAPSHOT.jar"))
;(require 'swank-clojure-autoload)

;slimep
;(add-to-list 'load-path "~/.emacs.d/slime/")
(setq inferior-lisp-program "clj-env-dir")

(defun slime-buffer-name (type)
  (format "*Slime %s*"
          (cond
           ((keywordp type)
            (substring (symbol-name type) 1))
           (t (symbol-name type)))))


;; (setq slime-backend
;;        "~/.emacs.d/slime/swank-loader.lisp")
;;  (load "~/.emacs.d/slime/slime-autoloads.el")
;;  (eval-after-load "slime"
;;    '(progn
;;     (slime-setup '(slime-fancy slime-asdf slime-banner))
;;     (setq slime-complete-symbol*-fancy t)
;;     (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)))
;; (require 'slime)
;; (slime-setup '(slime-repl))
;; (slime-setup)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

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

(setq global-show-trailing-whitespace t)
(setq whitespace-style '(tab-mark))
(whitespace-mode)



(require 'w3m-load)

;(setq slime-path "/usr/share/emacs/site-lisp/slime/")

;; (setq inferior-lisp-program "/usr/bin/sbcl --noinform"
;;       cltl2-url "file:///usr/local/share/doc/cltl/clm/node1.html"
;;       hyperspec-prog (concat slime-path "hyperspec")
;;       hyperspec-path "/usr/local/share/doc/HyperSpec/")

;; (setq lisp-indent-function 'common-lisp-indent-function
;;       ;slime-complete-symbol-function 'slime-fuzzy-complete-symbol
;;       slime-startup-animation nil
;;       common-lisp-hyperspec-root (concat "file://" hyperspec-path)
;;       common-lisp-hyperspec-symbol-table (concat hyperspec-path "Data/Map_Sym.txt")
;;       w3m-default-homepage common-lisp-hyperspec-root
;;       ;browse-url-browser-function 'w3m
;;       w3m-symbol 'w3m-default-symbol
;;       w3m-key-binding 'info
;;       w3m-coding-system 'utf-8
;;       w3m-default-coding-system 'utf-8
;;       w3m-file-coding-system 'utf-8
;;       w3m-file-name-coding-system 'utf-8
;;       w3m-terminal-coding-system 'utf-8)

;; (add-hook 'lisp-mode-hook 'slime)
;; (add-hook 'lisp-mode-hook 'slime-mode)


(setq browse-url-generic-program "google-chrome"
      browse-url-browser-function 
      '(("file:///usr/local/share/doc/." . w3m-browse-url)
        ("." . browse-url-generic)))

(defun browse-django-docs ()
  (interactive)
  (w3m-browse-url "file://home/bbeecher/django/docs/_build/html/index.html"))


(defun delete-horizontal-space-forward () ; adapted from `delete-horizontal-space'
      "*Delete all spaces and tabs after point."
      (interactive "*")
      (delete-region (point) (progn (skip-chars-forward " \t") (point))))



(require 'uniquify)
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
