;; Theme & font
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/gruber-darker-theme/")
(load-theme 'gruber-darker t)
(set-face-attribute 'default nil :font "Iosevka-18")

;; Basic UI tweaks
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(electric-pair-mode 1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(setq select-enable-clipboard t
      select-enable-primary t)
(setq-default truncate-lines nil)
(setq-default abbrev-mode nil)

;; Package setup
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (pkg '(company lsp-mode lsp-ui flycheck))
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; Make Flycheck error underlines thicker and brighter
(with-eval-after-load 'flycheck
  (set-face-attribute 'flycheck-error nil
                      :underline '(:style wave :color "#ff4444" :thickness 5))
  (set-face-attribute 'flycheck-warning nil
                      :underline '(:style wave :color "#ffcc00" :thickness 5))
  (set-face-attribute 'flycheck-info nil
                      :underline '(:style wave :color "#33ccff" :thickness 5)))


;; Company (autocomplete)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; LSP (language server for C/C++)
(require 'lsp-mode)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)
;;(require 'lsp-ui)
;;(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(setq lsp-clients-clangd-executable "/usr/bin/clangd")

;; Flycheck (inline error checking)
(require 'flycheck)
(global-flycheck-mode)

;; Load simp-c by tsoding
;;(add-to-list 'load-path "~/.emacs.d/simpc-mode")
;;(require 'simpc-mode)

(defun my-c-style-setup ()
  "Use 4-space indentation and disable auto-reindent in C mode."
  (c-set-style "linux")
  (setq c-basic-offset 4)
  (setq indent-tabs-mode nil)
  (when (boundp 'electric-indent-mode)
    (electric-indent-local-mode -1))
  (local-set-key (kbd "RET") (lambda ()
                               (interactive)
                               (newline)
                               (indent-for-tab-command))))
(add-hook 'c-mode-common-hook 'my-c-style-setup)

(message "Minimal C development setup loaded successfully.")
