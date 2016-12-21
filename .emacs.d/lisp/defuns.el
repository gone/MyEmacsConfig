(provide 'defuns)

(defun back-to-indentation-or-beginning ()
   (interactive)
   (if (= (point) (save-excursion (back-to-indentation) (point)))
       (beginning-of-line)
     (back-to-indentation)))


(defun setup-window-system-frame-colours (&rest frame)
  (if window-system
      (let ((f (if (car frame)
		   (car frame)
		 (selected-frame))))
	(progn
      (set-frame-font 	  (set-face-attribute 'default nil :font  "-zevv-peep-medium-r-normal--20-175-75-75-c-100-iso8859-1"))
      (load-theme 'zenburn t)

      ))))



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


(defun delete-horizontal-space-forward () ; adapted from `delete-horizontal-space'
      "*Delete all spaces and tabs after point."
      (interactive "*")
      (delete-region (point) (progn (skip-chars-forward " \t") (point))))


(defun run-python2 ()
  "run a python2 interp"
  (run-python "python2"))


 ;; Helper for compilation. Close the compilation window if
  ;; there was no error at all.
(defun compilation-exit-autoclose (status code msg)
    ;; If M-x compile exists with a 0
    (when (and (eq status 'exit) (zerop code))
      ;; then bury the *compilation* buffer, so that C-x b doesn't go there
      (bury-buffer)
      ;; and delete the *compilation* window
      (delete-window (get-buffer-window (get-buffer "*compilation*"))))
    ;; Always return the anticipated result of compilation-exit-message-function
    (cons msg code))
  ;; Specify my function (maybe I should have done a lambda function)


(defun tag-word-or-region (tag)
    "Surround current word or region with a given tag."
    (interactive "sEnter tag (without <>): ")
    (let (pos1 pos2 bds start-tag end-tag)
        (setq start-tag (concat "<" tag ">"))
        (setq end-tag (concat "</" tag ">"))
        (if (and transient-mark-mode mark-active)
            (progn
                (goto-char (region-end))
                (insert end-tag)
                (goto-char (region-beginning))
                (insert start-tag))
            (progn
                (setq bds (bounds-of-thing-at-point 'symbol))
                (goto-char (cdr bds))
                (insert end-tag)
                 (goto-char (car bds))
                 (insert start-tag)))))



(defun flymake-jade-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                 'flymake-create-temp-intemp))
     (local-file (file-relative-name
                  temp-file
                  (file-name-directory buffer-file-name)))
     (arglist (list local-file)))
    (list "jade" arglist)))


(defun tag-word-or-region (tag)
    "Surround current word or region with a given tag."
    (interactive "sEnter tag (without <>): ")
    (let (pos1 pos2 bds start-tag end-tag)
        (setq start-tag (concat "<" tag ">"))
        (setq end-tag (concat "</" tag ">"))
        (if (and transient-mark-mode mark-active)
            (progn
                (goto-char (region-end))
                (insert end-tag)
                (goto-char (region-beginning))
                (insert start-tag))
            (progn
                (setq bds (bounds-of-thing-at-point 'symbol))
                (goto-char (cdr bds))
                (insert end-tag)
                 (goto-char (car bds))
                 (insert start-tag)))))
