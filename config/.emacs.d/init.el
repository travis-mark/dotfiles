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
;; Source: https://systemcrafters.net/emacs-from-scratch/the-best-default-settings/#automatically-revert-buffers-for-changed-files
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; AutoSave
;; Source: https://www.emacswiki.org/emacs/AutoSave
(defun save-all ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'save-all)

;; C
(setq-default c-basic-offset 2)

;; Completion
;; Derived from https://martinsosic.com/development/emacs/2017/12/09/emacs-cpp-ide.html
(use-package company :ensure t
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
;;    (global-set-key (kbd "M-/") 'company-complete-common-or-cycle) 
    (setq company-idle-delay 0)))

;; Line numbers
(global-display-line-numbers-mode 1) 

;; LSP
;; Ref: https://ianyepan.github.io/posts/emacs-ide/
;; (use-package lsp-mode
;;   :hook ((c++-mode python-mode java-mode js-mode) . lsp-deferred)
;;   :commands lsp)

;; (use-package lsp-ui
;;   :commands lsp-ui-mode)

;; Recent files
;; Derived from https://systemcrafters.net/emacs-from-scratch/the-best-default-settings/#remembering-recently-edited-files
(if (recentf-mode 1)
    (bind-key "C-x r" 'recentf-open-files))

;; Source Control
(use-package magit :ensure t
  :init
  (progn
    (bind-key "C-x g" 'magit-status)))

;; Startup
(setq inhibit-startup-message t
      visible-bell nil)

;; Theme
(load-theme 'tango-dark t)
