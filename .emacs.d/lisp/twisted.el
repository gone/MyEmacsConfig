(provide 'twisted-dev)

(defun better-pdb (&optional command-line)
  (interactive)
  (let ((result (if command-line
					(pdb command-line)
				  (call-interactively 'pdb command-line))))
	(gud-def gud-break "break %d%f:%l"     "\C-b" "Set breakpoint at current line.")
    (gud-def gud-remove "clear %d%f:%l"     "\C-d" "Remove breakpoint at current line")
	result))

(defun pyflakes-this-file ()
  (interactive)
  (compile (format "pyflakes %s" (buffer-file-name))))

(defvar test-case-name nil "name of current test case")
(make-variable-buffer-local 'test-case-name)

(defvar twisted-dev-scratch-directory "~/Scratch/Test")

(defvar twisted-dev-directory "~/workspace/python/twisted/trunk")


(defmacro with-cd (dirname &rest code)
  `(let ((old-dirname default-directory)
		 (start-buffer (current-buffer)))
	 (cd ,dirname)
	 (unwind-protect (progn ,@code)

	   (let ((end-buffer (current-buffer)))
		 (set-buffer start-buffer)
		 (cd ,default-directory)
		 (set-buffer end-buffer)))))

(defun show-test-case-name ()
  (interactive)
  (message (format "%s" test-case-name)))

(defun twisted-dev-runtests (&optional debug)
  (interactive)
  (with-cd twisted-dev-scratch-directory
		   (hack-local-variables)
		   (let* ((bfn (buffer-file-name))
				  (shell-script-name (format "%s/trialscript" twisted-dev-scratch-directory))
				  (full-trial-command-line (format "trial --rterrors --reporter=bwverbose --tbformat=emacs %s --testmodule=%s" (if debug "--debug" "") bfn)))
			 (if bfn
				 (funcall (if debug 'better-pdb 'compile)
						  (progn (shell-command 
								  (format "mkdir -p %s; echo '%s/bin/%s' > %s"
								  twisted-dev-scratch-directory
								  twisted-dev-directory
								  full-trial-command-line
								  shell-script-name))
								 (format "sh %s" shell-script-name)))
			   full-command-line))))
				  
				  
  
