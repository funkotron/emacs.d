(menu-bar-mode -1)
(tool-bar-mode -1)

(add-to-list 'load-path "~/.emacs.d/")

;; Load secrets
(require 'setup-secrets)

(package-initialize)

;; Require Org-Babel Clojure
(require 'ob-clojure)
(require 'ob-python)

;; (find-file "~/Dropbox/org/index.org")
;; (desktop-save-mode 1)

;; Automatically reload file if changed on disk
(global-auto-revert-mode t)

;; Add etc folder to load path for miscellaneous packages
(add-to-list 'load-path "~/.emacs.d/etc")

;;Add MELPA
(require 'package)
(add-to-list 'package-archives
'("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; ========== Support Wheel Mouse Scrolling ==========

(mouse-wheel-mode t)

;; ===== Turn on Auto Fill mode automatically in all modes =====

;; Auto-fill-mode the the automatic wrapping of lines and insertion of
;; newlines when the cursor goes over the column limit.

;; This should actually turn on auto-fill-mode by default in all major
;; modes. The other way to do this is to turn on the fill for specific modes
;; via hooks.

;; (setq auto-fill-mode 1)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
;;Turn off flyspell mode for org-mode
;; (add-hook 'org-mode-hook (setq flyspell-mode nil))
(eval-after-load "flyspell"
  '(defun flyspell-mode (&optional arg)))

(add-hook 'org-mode-hook 'org-display-inline-images)
;; Orgmode Screenshots Insertion
(defun my-screenshot ()
"Take a screenshot into a unique-named file in the current buffer file 
directory and insert a link to this file."

(interactive)
(setq file-base
      (make-temp-name
       (file-name-directory (buffer-file-name))
       ))
(setq filename
      (concat
       file-base ".png"))
(setq thumbnail
      (concat
       file-base "-thumb.png"))

(call-process "scrot" nil nil nil "-s" "-t" "30" filename)
(insert (concat "[[" thumbnail "]] \n"))
(insert (concat "[[" filename "][" filename "]]"))
(org-display-inline-images))

;; Set org mode shortcuts
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Powerline
(add-to-list 'load-path "~/.emacs.d/emacs-powerline")
(require 'powerline)

;; First define a variable which will store the previous column position
(defvar previous-column nil "Save the column position")

(global-set-key [f10] 'save-buffers-kill-emacs)

 ;; ===== Make Text mode the default mode for new buffers =====

;; (setq default-major-mode 'org-mode)

 ;; ===== Turn off tab character =====

;;
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.

;;
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally
;;

(setq-default indent-tabs-mode nil)

;; Smart tabs
;; (require 'smart-tabs-mode)
;; (smart-tabs-insinuate 'python)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("5bff694d9bd3791807c205d8adf96817ee1e572654f6ddc5e1e58b0488369f9d" "06f5145c01ec774a0abb49eeffa3980743ce2f997112b537effeb188b7c51caf" "88d556f828e4ec17ac074077ef9dcaa36a59dccbaa6f2de553d6528b4df79cbd" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "4c9ba94db23a0a3dea88ee80f41d9478c151b07cb6640b33bfc38be7c2415cc4" "24cb1b9c182198f52df7cebf378ee9ecca93a2daeb9a90049a2f1f556119c742" "3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "75d4ccc5e912b93f722e57cca3ca1a15e079032cd69fd9bc67268b4c85639663" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "ea0c5df0f067d2e3c0f048c1f8795af7b873f5014837feb0a7c8317f34417b04" "1f3304214265481c56341bcee387ef1abb684e4efbccebca0e120be7b1a13589" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(global-hl-line-mode nil)
 '(org-agenda-files (quote ("~/Dropbox/org/index.org")))
 '(org-capture-templates (quote (("w" "indextemplate" entry (file+headline "~/Dropbox/org/index.org" "Notes") "* %^{Title}

  Source: %u, %c

  %i"))) t)
 '(org-src-fontify-natively t)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#ffffff"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync)

;; on to the visual settings
(setq inhibit-splash-screen t)		; no splash screen, thanks
;;(column-number-mode 1)			; column numbers in the mode line

(tool-bar-mode -1)			; no tool bar with icons
(scroll-bar-mode -1)			; no scroll bars
;; (unless (string-match "apple-darwin" system-configuration)
  ;; on mac, there's always a menu bar drown, don't have it empty
  ;;(menu-bar-mode -1))

;; choose your own fonts, in a system dependant way
(if (string-match "apple-darwin" system-configuration)
    (set-face-font 'default "PragmataPro-13")
  (set-face-font 'default  "PragmataPro-12"))

;; (global-linum-mode 1)			; add line numbers on the left

;; avoid compiz manager rendering bugs
(add-to-list 'default-frame-alist '(alpha . 100))

;; copy/paste with C-c and C-v and C-x, check out C-RET too
;; (cua-mode)

;; Comment out lines using M-; fix for when there's nothing selected
;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
      If no region is selected and current line is not blank and we are not at the end of the line,
      then comment current line.
      Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key (kbd "C-;") 'comment-dwim-line)

;; under mac, have Command as Meta and keep Option for localized input
(when (string-match "apple-darwin" system-configuration)
  (setq mac-allow-anti-aliasing t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none))

;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

; winner-mode provides C-<left> to get back to previous window layout
;; (winner-mode 1)

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

;; M-x shell is a nice shell interface to use, let's make it colorful.  If
;; you need a terminal emulator rather than just a shell, consider M-x term
;; instead.
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; If you do use M-x term, you will notice there's line mode that acts like
;; emacs buffers, and there's the default char mode that will send your
;; input char-by-char, so that curses application see each of your key
;; strokes.
;;
;; The default way to toggle between them is C-c C-j and C-c C-k, let's
;; better use just one key to do the same.
(require 'term)
(define-key term-raw-map  (kbd "C-'") 'term-line-mode)
(define-key term-mode-map (kbd "C-'") 'term-char-mode)

;; Have C-y act as usual in term-mode, to avoid C-' C-y C-'
;; Well the real default would be C-c C-j C-y C-c C-k.
(define-key term-raw-map  (kbd "C-y") 'term-paste)

;; use ido for minibuffer completion
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)

;; default key to switch buffer is C-x b, but that's not easy enough
;;
;; when you do that, to kill emacs either close its frame from the window
;; manager or do M-x kill-emacs.  Don't need a nice shortcut for a once a
;; week (or day) action.
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-c") 'ido-switch-buffer)
(global-set-key (kbd "C-x B") 'ibuffer)

;; C-x C-j opens dired with the cursor right on the file you're editing
(require 'dired-x)

;; Stop cursor flashing
(blink-cursor-mode 0)

(global-set-key (kbd "C-<RET>") 'org-insert-heading-respect-content)

;; Org-sync
;;(add-to-list 'load-path "~/.emacs.d/org-sync")
;;(add-to-list 'load-path "~/.emacs.d/org-element")
;;(mapc 'load
;;            '("org-element" "os" "os-bb" "os-github" "os-rmine"))

;;(setq os-github-auth (cons "funkotron" "pass"))
;;

(require 'package)
(add-to-list 'package-archives
    '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; -*- emacs-lisp -*-
(unless package-archive-contents    ;; Refresh the packages descriptions
  (package-refresh-contents))
(setq package-load-list '(all))     ;; List of packages to load
(unless (package-installed-p 'org)  ;; Make sure the Org package is
  (package-install 'org))           ;; installed, install it if not

(package-initialize)

(defvar my-packages '(
                      starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      multiple-cursors
                      ace-jump-mode
                      key-chord
                      clojure-mode
                      clojure-test-mode
                      nrepl
                      ac-nrepl
                      nrepl-ritz
                      rainbow-delimiters
                      noctilux-theme
                      subatomic-enhanced-theme
                      color-theme-solarized
                      dash
                      s
                      multi-term
                      simple-httpd
                      elpy
                      htmlize
                      ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq auto-mode-alist (cons '("\\.cljs" . clojure-mode) auto-mode-alist))

;; Emacs-Pastebin
(add-to-list 'load-path "~/.emacs.d/emacs-pastebin")
(require 'pastebin)
(pastebin-login)

;; Light Table litable-mode
(add-to-list 'load-path "~/.emacs.d/litable")
(require 'litable)

;; Undo-Tree
(add-to-list 'load-path "~/.emacs.d/undo-tree")
(require 'undo-tree)

;; Evil Vim mode
(el-get 'evil)
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(setq evil-default-cursor t)
(setq evil-replace-state-cursor '("red" box))

;;Exit insert mode by pressing j and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

(require 'nrepl)
;; Configure nrepl.el
(setq nrepl-hide-special-buffers t)
(setq nrepl-popup-stacktraces-in-repl nil)
(setq nrepl-history-file "~/.emacs.d/nrepl-history")
(setq nrepl-popup-stacktraces nil)
 
;; Some default eldoc facilities
(add-hook 'nrepl-connected-hook
(defun pnh-clojure-mode-eldoc-hook ()
 (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
)(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)(nrepl-enable-on-existing-clojure-buffers))
 
;; nrepl hooks
(define-key global-map (kbd "C-c C-z") '(add-to-list 'same-window-buffer-names "*nrepl*"))
(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'nrepl-mode-hook 'subword-mode)
 
;; Auto completion config
(require 'auto-complete-config)
(ac-config-default)

;; Auto completion for NREPL
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; Use AC-Nrepl in place of el-doc
(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)

;; nrepl-inspect
;; (add-to-list 'load-path "~/.emacs.d/nrepl-inspect")
;; (require 'nrepl-inspect)
;; (define-key nrepl-mode-map (kbd "C-c C-/") 'nrepl-inspect)


;; nrepl-ritz
(require 'nrepl-ritz) ;; after (require 'nrepl)
(add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)
(defun my-nrepl-mode-setup ()
  (require 'nrepl-ritz))
 
;; ;; Ritz middleware
(define-key nrepl-interaction-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
(define-key nrepl-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
(define-key nrepl-interaction-mode-map (kbd "C-c C-a") 'nrepl-apropos)
(define-key nrepl-mode-map (kbd "C-c C-a") 'nrepl-apropos)


;; Shortcut for switching windows
(global-set-key "\M-`" 'next-multiframe-window)


(add-to-list 'load-path "~/.emacs.d/framemove")
(require 'framemove)
(framemove-default-keybindings) ;; default prefix is Meta

(add-to-list 'load-path "~/.emacs.d/rainbow-delimiters")
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; Projectile
(require 'projectile)
(projectile-global-mode)


;; (add-to-list 'default-frame-alist '(cursor-color . "palegoldenrod"))
;; (setq default-frame-alist
;;   '((cursor-color . "palegoldenrod")))


(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
                 (cons 'height (/ (x-display-pixel-height)
                             (frame-char-height)))))))


;; Full screen utility functions
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))
  (set-frame-size-according-to-resolution))

;; Make full screen on startup
;; (run-with-idle-timer 0.1 nil 'toggle-fullscreen)

(require 'maxframe)
(defvar my-fullscreen-p t "Check if fullscreen is on or off")

;; Maximize window
(defun my-toggle-maximize ()
  (interactive)
  (setq my-fullscreen-p (not my-fullscreen-p))
  (if my-fullscreen-p
	  (restore-frame)
	(maximize-frame)))

;;Full Screen
(global-set-key (kbd "M-0") 'toggle-fullscreen)


;; Correcting the shell PATH
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell 
      (replace-regexp-in-string "[[:space:]\n]*$" "" 
        (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when (equal system-type 'darwin) (set-exec-path-from-shell-PATH))

;; Remove the starter-kit hl-line mode hook
(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)
(global-hl-line-mode -1)
(hl-line-mode -1)

;;========================================
;; start the emacsserver that listens to emacsclient
(server-start)

;; Add org-protocol to capture data from firefox
(add-to-list 'load-path "/usr/share/emacs/24.2/lisp/org/org-protocol")
(require 'org-protocol)

(setq org-capture-templates
      (quote
       (("w"
         "indextemplate"
         entry
         (file+headline "~/Dropbox/org/index.org" "Notes")
         "* %^{Title}\n\n  Source: %u, %c\n\n  %i"
         :empty-lines 1)
        ;; ... more templates here ...
        )))

;; Set wrap commands like M-( which wraps brackets for squareones and
;; quotes
(global-set-key (kbd "M-[") 'insert-pair)
;; (global-set-key (kbd "M-{") 'insert-pair)
(global-set-key (kbd "M-\"") 'insert-pair)
(global-set-key (kbd "M-\"") 'insert-pair)

(setq org-startup-indented 1)
(global-visual-line-mode t)

;; MU4E Mail Client
(require 'setup-mu4e)

;; Colortheme.el

;; (add-to-list 'load-path " /usr/share/emacs24/site-lisp/emacs-goodies-el/color-theme.el")
;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)
;;      (color-theme-hober)))


;; (add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")

;; (load-theme 'subatomic-enhanced t)
(load-theme 'solarized-dark t)

;; SHELL
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
       ;; foreground color (yellow)
(global-set-key (kbd "C-c t") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term) ;; create a new one

;; disable evil mode for terminals
(add-hook 'term-mode-hook                                 
          (lambda ()
            (turn-off-evil-mode)
            (setq evil-local-mode nil)
            (setq evil-mode nil)
            ))


;; change mode-line color by evil state
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
    (lambda ()
      (let ((color (cond ((minibufferp) default-color)
                         ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                         ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                         ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                         (t default-color))))
        (set-face-background 'mode-line (car color))
        (set-face-foreground 'mode-line (cdr color))))))

;;Projectile
(global-set-key "\C-xo" 'projectile-find-file)


;; Narrow to function
(defun clone-buffer-and-narrow-to-function ()
  (interactive)
  (clone-indirect-buffer-other-window (which-function) 'pop-to-buffer)
  (mark-defun) ; works not only in emacs-lisp, but C++, Python, ...
  (narrow-to-region (mark) (point))
  (pop-mark)
  (other-window 1))
(define-key global-map (kbd "C-x 4 n") 'clone-buffer-and-narrow-to-function) ; or whatever key you prefer

;; Elpy Python toolkit
(package-initialize)
(elpy-enable)

;; (setq flymake-warning-re "^W[0-9]") 
;; (setq python-check-command "flake8")

(defadvice flymake-parse-line (after elpy-flymake-parse-line (line)
                                     activate compile)
  "Advise flymake-parse-line to understand pep8/flake8 warnings"
  ;; pep8 says "W291 trailing whitespace" for warnings
  (let ((err-file (flymake-ler-file ad-return-value))
        (err-text (flymake-ler-text ad-return-value)))
    (if (and (string-match "\.py" err-file)
             (string-match "^W[0-9]" err-text))
        (setq ad-return-value
              (flymake-ler-make-ler err-file
                                    (flymake-ler-line ad-return-value)
                                    "w"
                                    err-text
                                    (flymake-ler-full-file ad-return-value))))))

(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 4)
        (setq python-indent 4)))
