;;
(eval-when-compile (require 'cl))


;;;;;;;; Packages Import
(require 'coldnew-macro)
(require 'coldnew-functions)
(require 'coldnew-commands)
(require 'coldnew-variables)
(require 'coldnew-vim)


;;;;;;;; Normal Map
(vim:nmap (kbd "C-x C-b") 'ibuffer)
(vim:nmap (kbd "C-x f") 'anything-find-file)
(vim:nmap (kbd "C-x C-f") 'lusty-file-explorer)
(vim:nmap (kbd "M-x") 'anything-execute-extended-command)
(vim:nmap (kbd "C-M-X") 'smex)
(vim:nmap (kbd "C-c C-e") 'eval-and-replace)
(vim:nmap (kbd "C-x C-s") 'save-buffer-always)
(vim:nmap (kbd "C-=") 'text-scale-increase)
(vim:nmap (kbd "C-+") 'text-scale-increase)
(vim:nmap (kbd "C--") 'text-scale-decrease)
(vim:nmap (kbd "<f4>") 'shell-pop)
(vim:nmap (kbd "C-x M-s") 'egg-status)
(vim:nmap (kbd "C-x M-l") 'egg-log)

;;;;;;;; Insert Map
(vim:imap (kbd "C-x C-b") 'ibuffer)
(vim:imap (kbd "C-x C-f") 'lusty-file-explorer)
(vim:imap (kbd "M-x") 'anything-execute-extended-command)
(vim:imap (kbd "C-c C-e") 'eval-and-replace)
(vim:imap (kbd "C-x C-s") 'save-buffer-always)
(vim:imap (kbd "C-=") 'text-scale-increase)
(vim:imap (kbd "C-+") 'text-scale-increase)
(vim:imap (kbd "C--") 'text-scale-decrease)
(vim:imap (kbd "<f4>") 'shell-pop)
(vim:imap (kbd "C-x M-s") 'egg-status)
(vim:imap (kbd "C-x M-l") 'egg-log)
(vim:imap (kbd "<backspace>") 'hungry-delete-backward)
(vim:imap (kbd "DEL") 'hungry-delete-forward)


;;;;;;;; Visual Map
(vim:vmap (kbd "M-;") 'vim:visual-toggle-comment)

;;;;;;;; Window Map
(vim:wmap (kbd "C-w f") 'fullscreen-window)


(provide 'coldnew-keybinding)
;; coldnew-keybinding.el ends here.
