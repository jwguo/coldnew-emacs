;;

(eval-when-compile (require 'cl))

;;;; Coding-Style Setting
(add-hook 'c-mode-hook
	  '(lambda ()
	     (c-set-style "linux")                ; C 語言風格為 linux
	     (setq c-basic-offset             8 ) ; 縮排設定
	     (setq tab-width                  4 ) ; TAB 寬度為4個空格
	     (setq indent-tabs-mode         nil ) ; 禁止在縮排中插入制表符
	     (setq c-max-one-liner-length   100 ) ; 最大格數為 100 格
	     (setq compilation-window-height 10 ) ; 編譯結果視窗高度
	     ;;(substatement-open   .   0)
	     ))

;;;; Keybindings
(add-hook 'c-mode-hook
	  '(lambda ()
	     (vim:local-nmap (kbd ",o") 'ff-find-other-file)
	     (vim:local-nmap (kbd ",h") 'ff-find-related-file)
	     ;; Insert yasnippet
	     (vim:local-imap (kbd "M-i") 'c-mode:insert-inc-or-if) ; insert "#include <>" or "if () {...}"
	     (vim:local-imap (kbd "M-d") 'c-mode:insert-do-while)  ; insert "do {...} while()"
	     (vim:local-imap (kbd "M-m") 'c-mode:insert-main-function) ; insert "int main () {...}"
	     ))

;;;; Hooks
(add-hook 'c-mode-hook
	  '(lambda ()
	     ;; Use my define programming-common environment
	     (programming-common-hook)
	     ;; Use my define cc-mode common environment
	     (cc-mode-common-hook)

	     ;; Enable C-Eldoc
	     (c-turn-on-eldoc-mode)
	     ))

;;;; Auto-Mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))

;;;; Extra Coding Style setting
;; Enlightenment(EFL 、) Coding Style
(c-add-style
 "enlightenment"
 '("gnu"
   (indent-tabs-mode . nil)
   (tab-width . 8)
   (c-offsets-alist.
    ((defun-block-intro . 3)
     (statement-block-intro . 3)
     (case-label . 1)
     (statement-case-intro . 3)
     (inclass . 3)
     ))))

;;;; Functions

;; insert yasnippet
(defcmd c-mode:insert-inc-or-if ()
  "If at the start of line. add `inc' and expand it,
else add `if' and expand it."
  (let* ((current (point))
	 (begin (line-beginning-position)))
    (if (eq current begin)
	(insert "inc")
      (insert "if"))
    (yas/expand)))

(defcmd c-mode:insert-do-while ()
  "insert do{...} while()."
  (insert "do")
  (yas/expand))

(defcmd c-mode:insert-main-function ()
  "insert main()."
  (let* ((current (point))
	 (begin (line-beginning-position)))
    (if (equal current begin)
	(insert "main"))
    (yas/expand)))

(provide 'lang-c)
;; lang-c.el ends here.