(add-to-list 'load-path "~/.emacs.d/mu4e")
(require 'org-mu4e)
(require 'mu4e)
(setq mu4e-get-mail-command "offlineimap")
(setq message-kill-buffer-on-exit t)

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; don't prompt for applying of marks, just apply
(setq mu4e-headers-leave-behavior 'apply)

;; Try to display images in mu4e
(setq
 mu4e-view-show-images t
 mu4e-view-image-max-width 800)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(setq mu4e-confirm-quit nil
      mu4e-headers-date-format "%d/%b/%Y %H:%M" ; date format
      mu4e-html2text-command "html2text -utf8 -width 72")

;; Start mu4e in fullscreen, immediately ping for new mail
(defun mu4e-up-to-date-status ()
  (interactive)
  (window-configuration-to-register :mu4e-fullscreen)
  (mu4e)
  (mu4e-update-mail-show-window)
  (delete-other-windows))

;; Restore previous window configuration
(defun mu4e-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :mu4e-fullscreen))

(define-key mu4e-main-mode-map (kbd "q") 'mu4e-quit-session)
(define-key mu4e-headers-mode-map (kbd "M-u") 'mu4e-update-mail-show-window)

;; default
(setq mu4e-maildir "~/Maildir")
(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/[Gmail].Sent Mail"   . ?s)
         ("/[Gmail].Trash"       . ?t)
         ("/[Gmail].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
(setq
 user-mail-address "adamja1@gmail.com"
 user-full-name  "Adam Awan"
 message-signature
 (concat
  "Adam Awan | Tree.io\n"
  "\n"))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)

;; don't keep message buffers around
    (setq message-kill-buffer-on-exit t)
 
    ;; show images
    (setq mu4e-show-images t)
 
    ;; use imagemagick, if available
    (when (fboundp 'imagemagick-register-types)
      (imagemagick-register-types))
 
    ;;; message view action
    (defun mu4e-msgv-action-view-in-browser (msg)
      "View the body of the message in a web browser."
      (interactive)
      (let ((html (mu4e-msg-field (mu4e-message-at-point t) :body-html))
            (tmpfile (format "%s/%d.html" temporary-file-directory (random))))
        (unless html (error "No html part for this message"))
        (with-temp-file tmpfile
          (insert
           "<html>"
           "<head><meta http-equiv=\"content-type\""
           "content=\"text/html;charset=UTF-8\">"
           html))
        (browse-url (concat "file://" tmpfile))))
 
    (add-to-list 'mu4e-view-actions
                 '("View in browser" . mu4e-msgv-action-view-in-browser) t)
 
    ;; convert org mode to HTML automatically
    (setq org-mu4e-convert-to-html t)
 
    ;; need this to convert some e-mails properly
    (setq mu4e-html2text-command "html2text -utf8 -width 72")

;;; evil-mode mu4e

(eval-after-load 'mu4e
  '(progn
     ;; use the standard bindings as a base
     (evil-make-overriding-map mu4e-view-mode-map 'normal t)
     (evil-make-overriding-map mu4e-main-mode-map 'normal t)
     (evil-make-overriding-map mu4e-headers-mode-map 'normal t)
     
     (evil-add-hjkl-bindings mu4e-view-mode-map 'normal
       "g" 'mu4e~headers-jump-to-maildir
       "u" 'mu4e-update-index
       "j" 'evil-next-line
       "C" 'mu4e-compose-new
       "o" 'mu4e-view-message
       "Q" 'mu4e-raw-view-quit-buffer)
     
     ;; (evil-add-hjkl-bindings mu4e-view-raw-mode-map 'normal
     ;; "J" 'mu4e-jump-to-maildir
     ;; "j" 'evil-next-line
     ;; "C" 'mu4e-compose-new
     ;; "q" 'mu4e-raw-view-quit-buffer)
     
     (evil-add-hjkl-bindings mu4e-headers-mode-map 'normal
       "g" 'mu4e~headers-jump-to-maildir
       "u" 'mu4e-update-index
       "j" 'evil-next-line
       "C" 'mu4e-compose-new
       "o" 'mu4e-view-message
       )
     
     (evil-add-hjkl-bindings mu4e-main-mode-map 'normal
       "g" 'mu4e~headers-jump-to-maildir
       "u" 'mu4e-update-index
       "j" 'evil-next-line
       "RET" 'mu4e-view-message)
     ))

 
(defalias 'org-mail 'org-mu4e-compose-org-mode)

(provide 'setup-mu4e)
