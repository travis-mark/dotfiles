;; Third-party packages
;; Source: https://ianyepan.github.io/posts/setting-up-use-package/
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
;;https://www.emacswiki.org/emacs/AutoSave
(defun save-all ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'save-all)

;; Company
(use-package company :ensure t
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (setq company-idle-delay 0)))

;; Ido
;; https://www.emacswiki.org/emacs/InteractivelyDoThings
(unless (or (fboundp 'helm-mode) (fboundp 'ivy-mode))
    (ido-mode t)
    (setq ido-enable-flex-matching t))

;; Eshell fix path
;; https://www.emacswiki.org/emacs/ExecPath
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell. This is particularly useful under Mac OS X and macOS, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "$SHELL --login -c 'echo $PATH'"
						    ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(set-exec-path-from-shell-PATH)

;; Configs
(global-display-line-numbers-mode 1) 
(load-theme 'tango-dark t)
(save-place-mode 1)
(show-paren-mode 1)
(setq-default c-basic-offset 2)
(setq inhibit-startup-message t
      vc-follow-symlinks nil
      visible-bell nil)

;; Keybindings
(if (recentf-mode 1) (bind-key "C-x r" 'recentf-open-files))
(use-package magit :ensure t :init (progn (bind-key "C-x g" 'magit-status)))
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x x") 'execute-extended-command)
(global-set-key (kbd "C-x C-x") 'execute-extended-command)
;; (global-set-key (kbd "C-x C-x") 'exchange-point-and-mark) ;; TODO: Find another keybind?
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)


