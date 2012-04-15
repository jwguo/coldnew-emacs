
(eval-when-compile (require 'cl))

;;;;;;;; Packages Import
(require 'coldnew-macro)
(require 'coldnew-functions)
(require 'coldnew-commands)
(require 'coldnew-variables)
(require 'coldnew-evil)

;;;;;;;; *scratch*
;;
;; if *scratch* buffer does not exist,creat it automatically.
(run-with-idle-timer 1 t
		     '(lambda () (get-buffer-create "*scratch*")))

;;;;;;;; Uniquify
;; The library uniquify overrides Emacs' default mechanism for
;; making buffer names unique (using suffixes like <2>, <3> etc.)
;; with a more sensible behaviour which use parts of the file names
;; to make the buffer names distinguishable.
;;
(when (require* 'uniquify)
  (setq uniquify-buffer-name-style 'reverse)
  (setq uniquify-separator "/")
  ;; rename after killing uniquified
  (setq uniquify-after-kill-buffer-p t)
  ;; don't muck with special buffers
  (setq uniquify-ignore-buffers-re "^\\*"))

;;;;;;;; Ibuffer
;; Ibuffer is an advanced replacement for BufferMenu, which lets you operate
;; on buffers much in the same manner as Dired. The most important Ibuffer
;; features are highlighting and various alternate layouts.
;;
(when (require* 'ibuffer)
  (require 'ibuf-ext)
  ;; Settings
  (setq ibuffer-always-compile-formats         t )
  (setq ibuffer-default-shrink-to-minimum-size t )
  (setq ibuffer-expert                         t )
  (setq ibuffer-show-empty-filter-groups     nil )
  (setq ibuffer-use-other-window             nil )
  (setq ibuffer-always-show-last-buffer      nil )

  ;; Keybindings
  (when (featurep 'evil)
    ;; Normal map
    (evil-define-key 'normal ibuffer-mode-map (kbd "d") 'ibuffer-do-delete)
    (evil-define-key 'normal ibuffer-mode-map (kbd "s") 'ibuffer-do-sort-by-size)
    (evil-define-key 'normal ibuffer-mode-map (kbd "RET") 'ibuffer-visit-buffer)
    (evil-define-key 'normal ibuffer-mode-map (kbd "D") 'ibuffer-mark-for-delete)
    (evil-define-key 'normal ibuffer-mode-map (kbd "u") 'ibuffer-unmark-all)
    (evil-define-key 'normal ibuffer-mode-map (kbd "x") 'ibuffer-do-kill-on-deletion-marks)
    ;; Insert map
    ;; (evil-define-key 'insert ibuffer-mode-map (kbd "d") 'ibuffer-mark-for-delete)
    ;; (evil-define-key 'insert ibuffer-mode-map (kbd "u") 'ibuffer-unmark-all)
    ;; (evil-define-key 'insert ibuffer-mode-map (kbd "x") 'ibuffer-do-kill-on-deletion-marks)
    ;; (evil-define-key 'insert ibuffer-mode-map (kbd "RET") 'ibuffer-visit-buffer)
    )

;;;;;; Hooks
  (add-hook 'ibuffer-mode-hook
	    '(lambda ()
	       (hl-line-mode)		; Enable highlight-line
	       (ibuffer-switch-to-saved-filter-groups "default")
	       (ibuffer-do-sort-by-filename/process)
	       ))

;;;;;; Buffer lists
  (setq ibuffer-saved-filter-groups
	'(("default"
	   ("*Buffer*" (or
			(name . "^TAGS\\(<[0-9]+>\\)?$")
			(name . "^\\**Loading Config Log\\*$")
			(name . "^\\**Loading Library Log\\*$")
			(name . "^\\*Anything Log\\*$")
			(name . "^\\*Backtrace\\*$")
			(name . "^\\*Buffer List\\*$")
			(name . "^\\*CEDET Global\\*$")
			(name . "^\\*Compile-Log\\*$")
			(name . "^\\*Completions\\*$")
			(name . "^\\*EGG:*")
			(name . "^\\*Kill Ring\\*$")
			(name . "^\\*Occur\\*$")
			(name . "^\\*Process List\\*$")
			(name . "^\\*Shell Command Output\\*")
			(name . "^\\*Warnings\\*$")
			(name . "^\\*anything for\\*$")
			(name . "^\\*anything*")
			(name . "^\\*compilation\\*$")
			(name . "^\\*el-get*")
			(name . "^\\*grep\\*$")
			(name . "^\\*gud\\*$")
			(name . "^\\*ielm\\*")
			(name . "^\\*im.bitlbee.org\\*$")
			(name . "^\\*irc*")
			(name . "^\\*scratch\\*$")
			(name . "^\\*tramp")
			(name . "^\\*wclock\\*$")
			(name . "^ipa*")
			(name . "^loaddefs.el$")
			(name . "^\\*Messages\\*$")
			(name . "^\\*WoMan-Log\\*$")
			))
	   ("Version Control" (or (mode . svn-status-mode)
				  (mode . svn-log-edit-mode)
				  (name . "^\\*svn*\\*")
				  (name . "^\\*vc*\\*$")
				  (name . "^\\*Annotate")
				  (name . "^\\*git-*")
				  (name . "^\\*cvs*")
				  (name . "^\\*vc-*")
				  (mode . egg-status-buffer-mode)
				  (mode . egg-log-buffer-mode)
				  (mode . egg-commit-buffer-mode)))
	   ("Help" (or (mode . woman-mode)
		       (mode . man-mode)
		       (mode . info-mode)
		       (mode . help-mode)
		       (name . "\\*Help\\*$")
		       (name . "\\*info\\*$")))
	   ("Dired" (or (mode . dired-mode)
			(mode . nav-mode)))
	   ("IRC"   (or (mode . erc-mode)
			(mode . rcirc-mode)))
	   ("Terminal" (or (mode . eshell-mode)
			   (mode . term-mode)
			   (mode . inferior-python-mode)
			   (mode . comint-mode)
			   (name . "\\*scheme\\*$")))
	   ("Config" (name . "*.conf$"))
	   ("Text" (or (mode . text-mode)
		       (name . "*.txt$")))
	   ("w3m"   (or (mode . w3m-mode)
			(name . "^\\*w3m*")))
	   ("Org"   (mode . org-mode))
	   ("LaTEX" (or (mode . latex-mode)
			(name . "*.tex$")))
	   ("Verilog" (mode . verilog-mode))
	   ("Web Develop" (or (mode . html-mode)
			      (mode . css-mode)))
	   ("Shell Script" (or (mode . shell-script-mode)
			       (mode . shell-mode)
			       (mode . sh-mode)
			       (mode . ruby-mode)))
	   ("Perl"  (or (mode . cperl-mode)
			(mode . perl-mode)))
	   ("Python" (or (mode . python-mode)
			 (mode . ipython-mode)))
	   ("Octave" (or (mode . octave-mode)
			 (mode . inferior-octave-mode)))
	   ("Scala" (or (mode . scala-mode)
			(name . "\\*inferior-scala\\*$")))
	   ("Diff" (mode . diff-mode))
	   ("C++ . C#" (or (mode . c++-mode)
			   (mode . csharpmode)))
	   ("C"          (mode . c-mode))
	   ("Object-C"   (mode . objc-mode))
	   ("Snippet" (or (mode . snippet-mode)
			  (name . "*.yas$")))
	   ("newLisp"  (mode . newlisp-mode))
	   ("Common Lisp"   (mode . slime-mode))
	   ("Scheme"  (or (mode . scheme-mode)
			  (mode . gambit-mode)))
	   ("Clojure" (or (mode . clojure-mode)
			  (name . "\\*slime-repl clojure\\*")))
	   ("Emacs recipes" (name . "*.rcp$"))
	   ("Emacs" (or (mode . emacs-lisp-mode)
			(mode . lisp-interaction-mode)
			))
	   )))

  ;; Following buffer will not show in iBuffer
  (setq ibuffer-never-show-predicates
	(list
	 "^\\*Buffer List\\*$"
	 "^\\*CEDET Global\\*$"
	 "^\\*MiniBuf-*"
	 "^\\*Egg:Select Action\\*$"
	 "^\\*Ido Completions\\*$"
	 "^\\*SPEEDBAR\\*$"
	 "^\\*nav\\*$"
	 "^\\*swank\\*$"
	 "^\\*slime-events\\*$"
	 "^\\*RE-Builder\\*$"
	 "^\\*anything\\*$"
	 "^\\*anything complete\\*$"
	 "^\\*pomodoro\\*$"
	 "^\\*Project Buffers\\*$"
	 "^eproject$"
	 ;; "^"
	 "^\\*.*\\(-preprocessed\\)\\>\\*"
	 "^\\*ORG.*\\*"
	 "^\\*ac-mode-*"
	 ".loaddefs.el$"
	 "^loaddefs.el$"
	 ))

  ;;;; Advice
  ;; Reverse group list
  (defadvice ibuffer-generate-filter-groups (after reverse-ibuffer-groups () activate)
    (setq ad-return-value (nreverse ad-return-value)))

  ;; Switching to ibuffer puts the cursor on the most recent buffer
  (defadvice ibuffer (around ibuffer-point-to-most-recent activate)
    "Open ibuffer with cursor pointed to most recent buffer name"
    (let ((recent-buffer-name (buffer-name)))
      ad-do-it
      (ibuffer-jump-to-buffer recent-buffer-name)))

  ;; Kill ibuffer after quit
  (defadvice ibuffer-quit (after kill-ibuffer activate)
    "Kill the ibuffer buffer on exit."
    (kill-buffer "*Ibuffer*"))

  ;; Use human readable Size column instead of original one
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000) (format "%7.3fK" (/ (buffer-size) 1000.0)))
     ((> (buffer-size) 1000000) (format "%7.3fM" (/ (buffer-size) 1000000.0)))
     (t (format "%8dB" (buffer-size)))))

  ;; integrate ibuffer with git
  (when (require* 'ibuffer-git)
    (setq ibuffer-formats
	  '((mark modified read-only git-status-mini " "
		  (name 23 23 :left :elide)
		  " "
		  (size-h 9 -1 :right)
		  "  "
		  (mode 16 16 :left :elide)
		  " "
		  (git-status 8 8 :left)
		  "    "
		  ;; (eproject 16 16 :left :elide)
		  ;; "      "
		  filename-and-process))))
  )

;;;;;;;; tempbuf
;; a minor mode that enables buffers to get automatically deleted in the
;; background when it can be deduced that they are no longer of any use.
;; It could be common for example to apply this mode to dired-mode buffers
;; or read-only buffers visiting files, relieving you from having to delete
;; each of them manually when the buffer list grows too large.
;;
(when (require* 'tempbuf)
  ;; Take following mode as temp buffer
  (let ((tempbuf-mode-list
	 '(custom-mode
	   w3-mode
	   w3m-mode
	   Man-mode
	   woman-mode
	   help-mode
	   view-mode
	   dired-mode
	   )))
    (dolist (tempbuf-hook tempbuf-mode-list)
	    (add-hook (intern (concat (symbol-name tempbuf-hook) "-hook")) 'turn-on-tempbuf-mode))))

;;;;;;;; midnight
;; Midnight mode is a package that comes with Emacs for running configured
;; actions at every `midnight.
;;
(when (require* 'midnight)

  (defvar clean-buffer-delay-time (* 8 3600)
    "Every delay time will clean buffer.")

  ;; ;; Every day clean the buffer
  ;; (setq clean-buffer-list-delay-general 1)

  ;; Clean the buffer-list every 8hr
  (setq clean-buffer-list-delay-special clean-buffer-delay-time)

  ;; Kill anything, clean-buffer-list is very intelligent
  ;; at not killing unsaved buffer.
  (setq clean-buffer-list-kill-regexps '("^.*$"))

  ;; After clean-buffer-delay-time, clean the buffer.
  (run-at-time t clean-buffer-delay-time 'clean-buffer-list)


  ;; keep these buffer untouched prevent append multiple times
  (defvar clean-buffer-list-kill-never-buffer-names-init
    clean-buffer-list-kill-never-buffer-names
    "Init value for clean-buffer-list-kill-never-buffer-names")

  ;; append to *-init instead of itself
  (setq clean-buffer-list-kill-never-buffer-names
	(append
	 '("*Messages*" "*cmd*" "*scratch*" "*w3m*" "*w3m-cache*" "*Inferior Octave*")
	 clean-buffer-list-kill-never-buffer-names-init))

  ;; Prevent to kill buffers if match rules.
  (defvar clean-buffer-list-kill-never-regexps-init
    clean-buffer-list-kill-never-regexps
    "Init value for clean-buffer-list-kill-never-regexps")

  ;; append to *-init instead of itself
  (setq clean-buffer-list-kill-never-regexps
	(append
	 '("^\\*EMMS Playlist\\*.*$"
	   ".*irc\\.freenode\\.net.*"
	   ".*irc\\.debian\\.org.*"
	   ".*im\\.bitlbee\\.org.*"
	   "^\\*ansi-term*"
	   "^\\*terminal*"
	   "^\\*Inferior*"
	   )
	 clean-buffer-list-kill-never-regexps-init))

  )


(provide 'coldnew-buffer)
;; coldnew-buffer.el ends here.
