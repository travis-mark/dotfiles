;; Third-party packages
;; https://ianyepan.github.io/posts/setting-up-use-package/
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org"   . "https://orgmode.org/elpa/"))
(setq package-enable-at-startup nil)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

;; Auto-Reload on file / folder change
;; https://systemcrafters.net/emacs-from-scratch/the-best-default-settings/#automatically-revert-buffers-for-changed-files
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; AutoSave
;; https://www.emacswiki.org/emacs/AutoSave
(defun save-all ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'save-all)

;; Backups
(setq backup-by-copying t)
(unless backup-directory-alist
  (setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))))

;; Company
(use-package company :ensure t
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (setq company-idle-delay 0)))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))

(use-package swiper
  :ensure t)

(use-package counsel
  :ensure t)

;; Configs
;; `C-h f` (describe-function) and
;; `C-h o` (describe-symbol) to see what these do
(global-display-line-numbers-mode 1) 
(load-theme 'tango-dark t)
(save-place-mode 1)
(savehist-mode 1)
(show-paren-mode 1)
(setq-default c-basic-offset 2
	      indent-tabs-mode nil)
(setq apropos-do-all t
      custom-file (expand-file-name "custom.el" user-emacs-directory)
      ediff-window-setup-function 'ediff-setup-windows-plain
      inhibit-startup-message t
      load-prefer-newer t
      require-final-newline t
      save-interprogram-paste-before-kill t
      vc-follow-symlinks nil
      visible-bell nil)

;; Eshell fix path
;; https://www.emacswiki.org/emacs/ExecPath
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to
match that used by the user's shell. This is particularly useful
under Mac OS X and macOS, where GUI apps are not started from a
shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "$SHELL --login -c 'echo $PATH'"
						    ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(set-exec-path-from-shell-PATH)

;; Flyspell
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))

;; File

;; Ido
;; https://www.emacswiki.org/emacs/InteractivelyDoThings
(unless (or (fboundp 'helm-mode) (fboundp 'ivy-mode))
  (ido-mode t)
  (setq ido-enable-flex-matching t))

;; Keybindings
(if (recentf-mode 1) (bind-key "C-x r" 'recentf-open-files))
(use-package magit :ensure t :init (progn (bind-key "C-x g" 'magit-status)))
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Org mode
(require 'org)
(global-set-key (kbd "C-x a") 'org-agenda)

;; Projectile
(use-package projectile
  :init
  (progn
    (projectile-mode +1)
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))


;; Python
(setq python-indent-offset 4)

;; Uniquify (fix duplicate buffer names)
;; https://www.emacswiki.org/emacs/uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

