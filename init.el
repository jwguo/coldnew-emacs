;;; init.el --- configuration entry point.
(eval-when-compile (require 'cl))

(message "\nEmacs is powering up... Be patient, Master %s!\n" (getenv "USER"))

(defvar emacs-dir
  (file-name-directory
   (or (buffer-file-name (current-buffer)) "~/.emacs.d/"))
  "This the top dir we use in config files. If emacs is read
from user's ~/.emacs.d/init.el use ~/.emacs.d/ as the top dir.")

;; Add directories to emacs's `load-path' recursively.
;; if path does not exist, create directory.
(let* ((lisp-dir '("lisp/" "themes/" "local-lisp/")))
  (dolist (lisp-path lisp-dir)
    (if (not (file-exists-p lisp-path)) (make-directory (concat emacs-dir lisp-path) t))
    (let* ((load-dir (concat emacs-dir lisp-path))
           (default-directory load-dir))
      (setq load-path
            (append
             (let ((load-path (copy-sequence load-path)))
	       (append
		(copy-sequence (normal-top-level-add-to-load-path '(".")))
		(normal-top-level-add-subdirs-to-load-path)))
             load-path
             )))))

;; define a reload command
(defun reload-emacs ()
  "reload my emacs settings"
  (interactive)
  (load-file (concat emacs-dir "init.el")) (desktop-revert) (delete-other-windows))

;; Load up org-mode and org-babel
(require 'org)

;; Load config.org from emacs-dir
(org-babel-load-file (expand-file-name "config.org" emacs-dir))

;; Done and done!!
(message "\nEmacs is ready to serve you, Master %s!\n" (getenv "USER"))

;;; init.el ends here.
