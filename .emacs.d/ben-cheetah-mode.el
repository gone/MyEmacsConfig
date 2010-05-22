(define-derived-mode cheetah-mode html-mode "Cheetah"
  (make-face 'cheetah-variable-face)
  (font-lock-add-keywords
   nil
   '(
     ("\\(#\\(from\\|else\\|include\\|set\\|import\\|for\\|if\\|end\\|block\\)+\\)\\>" 1 font-lock-type-face)
     ("\\(#\\(from\\|for\\|end\\|block\\)\\).*\\<\\(for\\|import\\|if\\|in\\|block\\)\\>" 3 font-lock-type-face)
     ("\\(\\$\\(?:\\sw\\|}\\|{\\|\\s_\\)+\\)" 1 font-lock-variable-name-face))
   )
  (font-lock-mode 1)
  )
(setq auto-mode-alist (cons '( "\\.tmpl\\'" . cheetah-mode ) auto-mode-alist ))

