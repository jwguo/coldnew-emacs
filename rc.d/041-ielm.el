;;;

(eval-when-compile (require 'cl))


(add-hook 'ielm-mode-hook
	  '(lambda ()
	     (ielm-auto-complete)
	     ))

(defun ielm-auto-complete ()
  "Enables `auto-complete' support in \\[ielm]."
  (setq ac-sources '(ac-source-functions
		     ac-source-variables
		     ac-source-features
		     ac-source-symbols
		     ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-modes 'inferior-emacs-lisp-mode)
  (auto-complete-mode 1))

(provide '041-ielm)
;; 041-ielm.el ends here.