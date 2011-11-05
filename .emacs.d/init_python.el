(require 'auto-complete-yasnippet)

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(eval-after-load "pymacs"
  '(add-to-list 'pymacs-load-path ""))
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-completion
;;;  Integrates:
;;;   1) Rope
;;;   2) Yasnippet
;;;   all with AutoComplete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
      (setq value (cons (format "%s%s" prefix element) value))))))

(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")

(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))

(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))

(add-hook 'python-mode-hook
		  (lambda ()
			(auto-complete-mode 1)
			(set (make-local-variable 'ac-sources)
				 (append ac-sources '(ac-source-rope) '(ac-source-yasnippet)))
			(set (make-local-variable 'ac-find-function) 'ac-python-find)
			(set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
			(set (make-local-variable 'ac-auto-start) nil)))

;;more tab completion stuff
(defun python-tab ()
  ; Try the following:
  ; 1) Do a yasnippet expansion
  ; 2) Do a Rope code completion
  ; 3) Do an indent
  (interactive)
  (if (eql (ac-start) nil)
      (indent-for-tab-command)))

(defadvice ac-start (before advice-turn-on-auto-start activate)
  (set (make-local-variable 'ac-auto-start) t))
(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
  (set (make-local-variable 'ac-auto-start) nil))
;(define-key py-mode-map [tab] 'python-tab)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; End Auto Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto Syntax Error Hightlight
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
					   'flymake-create-temp-inplace))
		   (local-file (file-relative-name
						temp-file
						(file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))
  (defun flymake-html-init ()
	(let* ((temp-file (flymake-init-create-temp-buffer-copy
					   'flymake-create-temp-inplace))
		   (local-file (file-relative-name
						temp-file
						(file-name-directory buffer-file-name))))
	  (list "tidy" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
			   '("\\.py\\'" flymake-pyflakes-init))
  (add-to-list 'flymake-allowed-file-name-masks
			   '("\\.html$\\|\\.ctp" flymake-html-init))
  
  (add-to-list 'flymake-err-line-patterns
			   '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
				 nil 1 2 4)))

(defun show-fly-err-at-point () 
  "If the cursor is sitting on a flymake error, display the 
message in the minibuffer" 
  (interactive) 
  (let ((line-no (line-number-at-pos))) 
    (dolist (elem flymake-err-info) 
      (if (eq (car elem) line-no) 
          (let ((err (car (second elem)))) 
            (message "%s" (fly-pyflake-determine-message err))))))) 

(defun fly-pyflake-determine-message (err) 
  "pyflake is flakey if it has compile problems, this adjusts the 
message to display, so there is one ;)" 
  (cond ((not (or (eq major-mode 'Python) (eq major-mode 'python-mode) t))) 
        ((null (flymake-ler-file err)) 
         ;; normal message do your thing 
         (flymake-ler-text err)) 
        (t ;; could not compile err 
         (format "compile error, problem on line %s" (flymake-ler-line err))))) 

(defadvice flymake-goto-next-error (after display-message activate compile) 
  "Display the error in the mini-buffer rather than having to mouse over it" 
  (show-fly-err-at-point)) 

(defadvice flymake-goto-prev-error (after display-message activate compile) 
  "Display the error in the mini-buffer rather than having to mouse over it" 
  (show-fly-err-at-point)) 

(defadvice flymake-mode (before post-command-stuff activate compile) 
  "Add functionality to the post command hook so that if the 
cursor is sitting on a flymake error the error information is 
displayed in the minibuffer (rather than having to mouse over 
it)" 
  (set (make-local-variable 'post-command-hook) 
       (cons 'show-fly-err-at-point post-command-hook))) 


(add-hook 'find-file-hook 'flymake-find-file-hook)
(provide 'init_python)
