

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
(add-to-list 'load-path "/usr/share/emacs/23.1/site-lisp/")

(put 'upcase-region 'disabled nil)


;custom keys
(global-set-key (kbd "M-p") 'align-regexp)
(global-set-key (kbd "C-'") 'other-frame)
(global-set-key (kbd "C-;") 'other-window)
(global-set-key (kbd "s-i") 'clipboard-yank)
(global-set-key (kbd "s-k") 'clipboard-kill-region)
(global-set-key (kbd "<f8>") 'apropos)



;(load "~/elisp/haskell-mode-2.4/haskell-site-file.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(autoload 'haskell-mode "haskell-mode"
  "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
  "Major mode for editing literate Haskell scripts." t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)



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
 '(py-indent-offset 4 t)
 '(python-indent 8)
 '(safe-local-variable-values (quote ((folded-file . t) (test-case-name . twisted\.test\.test_abstract) (test-case-name . twisted\.test\.test_process) (test-case-name . twisted\.test\.test_factories) (test-case-name . twisted\.test\.test_newcred) (test-case-name . twisted\.test\.test_defer) (test-case-name . twisted\.test\.test_protocols) (test-case-name . twisted\.test\.test_banana) (test-case-name . twisted\.test\.test_pb) (test-case-name . twisted\.test\.test_reflect) (test-case-name . twisted\.test\.test_persisted) (test-case-name . twisted\.test\.test_jelly))))
 '(slime-complete-symbol-function (quote slime-fuzzy-complete-symbol))
 '(tool-bar-mode nil))
;gnus!
;(setq gnus-select-method '(nntp "news.giganews.com"))
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

(require 'color-theme)
(defun my-color-theme ()
  "Color theme by benbeecher, created 2009-09-25."
  (interactive)
  (color-theme-install
   '(my-color-theme
     ((background-color . "black")
      (background-mode . dark)
      (border-color . "white")
      (cursor-color . "yellow")
      (foreground-color . "white")
      (mouse-color . "white"))
     ((apropos-keybinding-face . underline)
      (apropos-label-face italic variable-pitch)
      (apropos-match-face . match)
      (apropos-property-face . bold-italic)
      (apropos-symbol-face . bold)
      (goto-address-mail-face . italic)
      (goto-address-mail-mouse-face . secondary-selection)
      (goto-address-url-face . link)
      (goto-address-url-mouse-face . highlight)
      (list-matching-lines-buffer-name-face . underline)
      (list-matching-lines-face . bold)
      (view-highlight-face . highlight)
      (widget-mouse-face . highlight))
     (default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 121 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
     (CUA-global-mark-face ((t (:background "cyan" :foreground "black"))))
     (CUA-rectangle-face ((t (:background "maroon" :foreground "white"))))
     (CUA-rectangle-noselect-face ((t (:background "dimgray" :foreground "white"))))
     (bold ((t (:bold t :weight bold))))
     (bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
     (border ((t (:background "white"))))
     (buffer-menu-buffer ((t (:bold t :weight bold))))
     (button ((t (:underline t))))
     (clearcase-dired-checkedout-face ((t (:foreground "red"))))
     (comint-highlight-input ((t (:bold t :weight bold))))
     (comint-highlight-prompt ((t (:foreground "cyan"))))
     (completions-common-part ((t (:family "DejaVu Sans Mono" :foundry "unknown" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "white" :background "black" :stipple nil :height 121))))
     (completions-first-difference ((t (:bold t :weight bold))))
     (cursor ((t (:background "yellow"))))
     (escape-glyph ((t (:foreground "cyan"))))
     (file-name-shadow ((t (:foreground "grey70"))))
     (fixed-pitch ((t (:family "courier"))))
     (flash-paren-face-off ((t (nil))))
     (flash-paren-face-on ((t (nil))))
     (flash-paren-face-region ((t (nil))))
     (font-lock-builtin-face ((t (:foreground "LightSteelBlue"))))
     (font-lock-comment-delimiter-face ((t (:foreground "OrangeRed"))))
     (font-lock-comment-face ((t (:foreground "OrangeRed"))))
     (font-lock-constant-face ((t (:foreground "Aquamarine"))))
     (font-lock-doc-face ((t (:foreground "LightSalmon"))))
     (font-lock-function-name-face ((t (:foreground "LightSkyBlue"))))
     (font-lock-keyword-face ((t (:foreground "Cyan"))))
     (font-lock-negation-char-face ((t (nil))))
     (font-lock-preprocessor-face ((t (:foreground "LightSteelBlue"))))
     (font-lock-regexp-grouping-backslash ((t (:bold t :weight bold))))
     (font-lock-regexp-grouping-construct ((t (:bold t :weight bold))))
     (font-lock-string-face ((t (:foreground "LightSalmon"))))
     (font-lock-type-face ((t (:foreground "PaleGreen"))))
     (font-lock-variable-name-face ((t (:foreground "LightGoldenrod"))))
     (font-lock-warning-face ((t (:bold t :foreground "Pink" :weight bold))))
     (fringe ((t (:background "grey10"))))
     (header-line ((t (:background "grey90" :foreground "grey20" :box nil))))
     (help-argument-name ((t (:italic t :slant italic))))
     (highlight ((t (:background "darkolivegreen"))))
     (ibuffer-deletion-face ((t (:foreground "red"))))
     (ibuffer-marked-face ((t (:foreground "green"))))
     (isearch ((t (:background "palevioletred2" :foreground "brown4"))))
     (isearch-fail ((t (:background "red4"))))
     (italic ((t (:italic t :slant italic))))
     (lazy-highlight ((t (:background "paleturquoise4"))))
     (link ((t (:foreground "cyan1" :underline t))))
     (link-visited ((t (:underline t :foreground "violet"))))
     (match ((t (:background "RoyalBlue3"))))
     (menu ((t (nil))))
     (minibuffer-prompt ((t (:foreground "cyan"))))
     (mode-line ((t (:background "darkslateblue" :foreground "yellow" :box (:line-width -1 :style released-button)))))
     (mode-line-buffer-id ((t (:bold t :weight bold))))
     (mode-line-emphasis ((t (:bold t :weight bold))))
     (mode-line-highlight ((t (:box (:line-width 2 :color "grey40" :style released-button)))))
     (mode-line-inactive ((t (:background "grey30" :foreground "grey80" :box (:line-width -1 :color "grey40" :style nil) :weight light))))
     (mouse ((t (:background "white"))))
     (next-error ((t (:background "blue"))))
     (nobreak-space ((t (:foreground "cyan" :underline t))))
     (query-replace ((t (:foreground "brown4" :background "palevioletred2"))))
     (region ((t (:background "blue"))))
     (scroll-bar ((t (nil))))
     (secondary-selection ((t (:background "darkslateblue"))))
     (shadow ((t (:foreground "grey70"))))
     (show-block-face1 ((t (:background "gray10"))))
     (show-block-face2 ((t (:background "gray15"))))
     (show-block-face3 ((t (:background "gray20"))))
     (show-block-face4 ((t (:background "gray25"))))
     (show-block-face5 ((t (:background "gray30"))))
     (show-block-face6 ((t (:background "gray35"))))
     (show-block-face7 ((t (:background "gray40"))))
     (show-block-face8 ((t (:background "gray45"))))
     (show-block-face9 ((t (:background "gray50"))))
     (show-paren-match ((t (:background "turquoise"))))
     (show-paren-mismatch ((t (:background "purple" :foreground "white"))))
     (tool-bar ((t (:background "grey75" :foreground "black" :box (:line-width 1 :style released-button)))))
     (tooltip ((t (:background "lightyellow" :foreground "black"))))
     (trailing-whitespace ((t (:background "red"))))
     (underline ((t (:underline t))))
     (variable-pitch ((t (:family "helv"))))
     (vertical-border ((t (nil))))
     (widget-button ((t (:bold t :weight bold))))
     (widget-button-pressed ((t (:foreground "red"))))
     (widget-documentation ((t (:foreground "lime green"))))
     (widget-field ((t (:background "dim gray"))))
     (widget-inactive ((t (:foreground "light gray"))))
     (widget-single-line-field ((t (:background "dim gray")))))))
(my-color-theme)

;clj
;; (add-to-list 'load-path "~/workspace/clojure/clojure-mode/")
;; (require 'clojure-mode)

;; (add-to-list 'load-path "~/workspace/clojure/swank-clojure/src/emacs/")

;; (setq swank-clojure-jar-path "/usr/share/clojure/clojure.jar"
;; 	  swank-clojure-extra-classpaths (list "~/workspace/clojure/swank-clojure/src/main/clojure/"
;; 									  "/home/benbeecher/workspace/clojure/contrib/clojure-contrib.jar"
;; 									  "~/workspace/clojure/compojure/compojure.jar"
;; 									  ))

;; (require 'swank-clojure-autoload)

;;slime
(require 'w3m-load)
(setq slime-path "/usr/share/emacs/site-lisp/slime/")

(setq inferior-lisp-program "/usr/bin/sbcl --noinform"
	  cltl2-url "file:///usr/local/share/doc/cltl/clm/node1.html"
      hyperspec-prog (concat slime-path "hyperspec")
      hyperspec-path "/usr/local/share/doc/HyperSpec/")

(setq lisp-indent-function 'common-lisp-indent-function
      ;slime-complete-symbol-function 'slime-fuzzy-complete-symbol
      slime-startup-animation nil
      common-lisp-hyperspec-root (concat "file://" hyperspec-path)
      common-lisp-hyperspec-symbol-table (concat hyperspec-path "Data/Map_Sym.txt")
      w3m-default-homepage common-lisp-hyperspec-root
      ;browse-url-browser-function 'w3m
      w3m-symbol 'w3m-default-symbol
      w3m-key-binding 'info
      w3m-coding-system 'utf-8
      w3m-default-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
(require 'slime)
(slime-setup '(slime-repl))
(add-hook 'lisp-mode-hook 'slime)
(add-hook 'lisp-mode-hook 'slime-mode)
(setq browse-url-generic-program "google-chrome"
	  browse-url-browser-function 
	  '(("file:///usr/local/share/doc/." . w3m-browse-url)
	   ("." . browse-url-generic)))
