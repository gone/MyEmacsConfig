(defvar packages '(android-mode anything anything-config anything-el-swank-fuzzy
         anything-ipython archives auto-complete auto-indent-mode autopair
         clojure-mode clojurescript-mode clojure-test-mode closure-lint-mode
         coffee-mode color-theme color-theme-blackboard
         color-theme-solarized color-theme-zenburn django-theme durendal
         ecb eieio elein elisp-cache elisp-slime-nav find-file-in-project findr
         flymake-coffee flymake-cursor flymake-jslint flymake-jslint
         flymake-jslint flymake-sass geben gist go-mode go-mode haml-mode
         handlebars-mode html-script-src idle-highlight-mode ido-ubiquitous
         inflections inf-ruby  javascript js-comint json jump magit
         magithub magit-simple-keys markdown-mode nose org org-magit paredit
         pony-mode pyflakes pylint python-pylint rainbow-delimiters rinari
         ruby-compilation ruby-mode  sass-mode scss-mode slime slime-clj
         slime-repl slime-ritz smex swank-clojure virtualenv yaml-mode
         yas-jit yasnippet yasnippet-bundle))


(dolist (p packages)
    (when (not (package-installed-p p))
      (package-install p)))
