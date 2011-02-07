;;
(eval-when-compile (require 'cl))
(eval-after-load 'rcirc '(load "~/.emacs.d/.authinfo")) ; Password Settings in it

;;;;;; Persional Info
(setq rcirc-default-nick "coldnew")
(setq rcirc-default-user-name "coldnew")
(setq rcirc-default-full-name "Yen-Chin,Lee")

;;;;;; Settings
;; for debugging.
(setq rcirc-debug-flag t)
;; Include date in time stamp.
(setq rcirc-time-format "%Y-%m-%d %H:%M ")
;; Enable Logging rcirc
(setq rcirc-log-flag t)
;; Put logs in this directory
(setq rcirc-log-directory "~/.emacs.d/var/log/rcirc/")
;;
(setq rcirc-notify-open t)
;;
(setq rcirc-notify-timeout 1)
;;
(setq rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY" "MODE"))
;; Prompt Settings
(setq rcirc-prompt ">> ")
;; Do not show on modline
(setq rcirc-track-minor-mode nil)

;; Join these channels at startup.
(setq rcirc-server-alist
      '(
	("irc.freenode.net" :channels  ("#emacs" "#lisp" "##linux"	; english channel
					"#tossug" "#gentoo-tw" "#python.tw" "#ubuntu-tw"))
	("irc.debian.org" :channels ("#dot"))
	))

;;;;;; Hooks
(add-hook 'rcirc-mode-hook
	  '(lambda ()
	     ;; Keep input line at bottom.
	     (set (make-local-variable 'scroll-conservatively) 8192)
	     ;; Use Omit-mode
	     (rcirc-omit-mode)
	     ))

;; (add-hook 'rcirc-print-hooks
;;	  '(lambda ()
;;	     ;; Writing Log in ~/.emacs.d/var/log/rcirc/
;;	     (rcirc-write-log)
;;	     ))

;;;;;; Keybindings
(add-hook 'rcirc-mode-hook
	  '(lambda ()
	     ;; Insert map
	     (vim:local-imap (kbd "RET") 'rcirc-send-input)
	     ))



;;;;;; RCIRC Commands
(defun-rcirc-command all (input)
  "Run the arguments as a command for all connections.
   Example use: /all away food or /all quit zzzz."
  (interactive "s")
  (let ((buffers (mapcar 'process-buffer (rcirc-process-list))))
    (dolist (buf buffers)
      (with-current-buffer buf
	(goto-char (point-max))
	(insert "/" input)
	(rcirc-send-input)))))


;;;;;; Other Settings

;;;; Don't print /away messages.
(defun rcirc-handler-301 (process cmd sender args)
  "/away message handler.")


;;;;;; Functions


(provide '035-rcirc)
;; 035-rcirc.el ends here.