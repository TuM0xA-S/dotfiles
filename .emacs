;; system
(setq gc-cons-threshold (* 100 1024 1024))
(setq read-process-output-max (* 1024 1024))
;; ui stuff
;; (setq inhibit-startup-message t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
;; (tooltip-mode 0)
(setq inhibit-startup-screen t)

;; editor customization

(show-paren-mode)
(setq show-paren-when-point-inside-paren t)
(electric-pair-mode)
;; (setq electric-pair-preserve-balance nil)

;; (setq-default cursor-type 'bar) ;; modern cursor
(setq ring-bell-function 'ignore) ;; no sounds
(delete-selection-mode 1)
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t)
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq highlight-nonselected-windows t)
(setq mark-even-if-inactive nil)
(setq kill-do-not-save-duplicates t)
;; (setq yank-pop-change-selection t)
(setq require-final-newline t)
;; interactive stuff in minibuffer
;; (fido-mode)
;; (savehist-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
;; (global-set-key (kbd "<f10>") 'save-buffer)
(column-number-mode)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(setq tab-always-indent 'complete)

(put 'downcase-region 'disabled nil)

(defun my/open-line-above ()
  "Insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(defun my/open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(global-set-key (kbd "<C-return>") 'my/open-line-below)
(global-set-key (kbd "<C-S-return>") 'my/open-line-above)

(defun my/delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (if (use-region-p)
      (delete-region (region-beginning) (region-end))
    (delete-region (point) (progn (forward-word arg) (point)))))

(defun my/backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (my/delete-word (- arg)))

(global-set-key (kbd "<C-backspace>") 'my/backward-delete-word)
(global-set-key (kbd "<M-backspace>") 'my/backward-delete-word)
(global-set-key (kbd "M-d") 'my/delete-word)

(defun my/kill-ring-save ()
  "This command is similar to `kill-ring-save', except that it copies line when no region"
  (interactive)
  (if (region-active-p)
        (call-interactively #'kill-ring-save)
    (save-excursion
      (kill-ring-save
       (progn (beginning-of-line) (point))
       (progn (end-of-line) (point))))))

(defun my/kill-region-or-line ()
  "This command do `kill-region', and kills line if no region"
  (interactive)
  (if (region-active-p)
        (call-interactively #'kill-region)
    (save-excursion
      (kill-region
       (progn (beginning-of-line) (point))
       (progn (end-of-line) (point))))))

(global-set-key (kbd "M-w") 'my/kill-ring-save)
(global-set-key (kbd "C-w") 'my/kill-region-or-line)

(defun my/smart-line-beginning ()
  "Move point to the beginning of text on the current line; if that is already
the current position of point, then move it to the beginning of the line."
  (interactive)
  (let ((pt (point)))
    (beginning-of-line-text)
    (when (eq pt (point))
      (beginning-of-line))))

(global-set-key (kbd "C-a") 'my/smart-line-beginning)

;; windows
(global-set-key (kbd "<left>") 'windmove-left)
(global-set-key (kbd "<right>") 'windmove-right)
(global-set-key (kbd "<up>") 'windmove-up)
(global-set-key (kbd "<down>") 'windmove-down)

(global-set-key (kbd "<S-left>") 'windmove-swap-states-left)
(global-set-key (kbd "<S-right>") 'windmove-swap-states-right)
(global-set-key (kbd "<S-up>") 'windmove-swap-states-up)
(global-set-key (kbd "<S-down>") 'windmove-swap-states-down)

(global-set-key (kbd "<C-left>") 'windmove-display-left)
(global-set-key (kbd "<C-right>") 'windmove-display-right)
(global-set-key (kbd "<C-up>") 'windmove-display-up)
(global-set-key (kbd "<C-down>") 'windmove-display-down)
(global-set-key (kbd "C-_") 'windmove-display-same-window)

(global-set-key (kbd "<M-left>") 'windmove-delete-left)
(global-set-key (kbd "<M-right>") 'windmove-delete-right)
(global-set-key (kbd "<M-up>") 'windmove-delete-up)
(global-set-key (kbd "<M-down>") 'windmove-delete-down)

;; shell
(setq async-shell-command-display-buffer nil)
(setq shell-command-prompt-show-cwd t)
(setq comint-prompt-read-only t)
(setq-default comint-input-ignoredups t)
;; (set-face-foreground 'comint-highlight-prompt "#729fcf")

;; uncoment if have problems with hardlinks
;; (setq backup-by-copying t)

;;; Lockfiles unfortunately cause more pain than benefit
(setq create-lockfiles nil)

;; calendar
(setq calendar-week-start-day 1)

;; чтобы не срало в этот файл
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file t)

;; backup files in emacs-backup-dir
(setq emacs-backup-dir (concat user-emacs-directory "backup/"))
(setq backup-directory-alist `((".*" . ,emacs-backup-dir)))
;; autosave files in emacs-auto-save-dir
(setq emacs-auto-save-dir (concat user-emacs-directory "auto-save/"))
(make-directory emacs-auto-save-dir t)
(setq auto-save-file-name-transforms `((".*" ,emacs-auto-save-dir t)))

;; packages
;; Setup package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install packages.
;; refresh before if have uninstalled package
(dolist (package '(bash-completion
                   go-mode
                   auto-virtualenv
                   expand-region
                   ;; gruvbox-theme
                   which-key
                   smart-mode-line
                   smart-mode-line-powerline-theme
                   lsp-mode
                   ;; helm
                   ivy
                   lsp-ivy
                   diminish
                   powerline
                   ;; lsp-ui
                   ;; crux
                   backward-forward
                   projectile))
  (unless (package-installed-p package)
    (package-install package)))

(projectile-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(backward-forward-mode t)
(global-set-key (kbd "C-,") 'backward-forward-previous-location)
(global-set-key (kbd "C-.") 'backward-forward-next-location)

(require 'bash-completion)
(bash-completion-setup)

(require 'auto-virtualenv)
(add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'which-key)
(which-key-mode)

;; theme
(setq custom-safe-themes t)
(load-theme 'tango-dark)

(require 'smart-mode-line)
(setq sml/theme 'dark)
(sml/setup)
(setq powerline-display-buffer-size nil)
(setq powerline-display-hud nil)
(powerline-center-theme)

;; how to set font
;; (add-to-list 'default-frame-alist
;;              '(font . "JetBrainsMono Nerd Font 12"))

;; (require 'helm)
;; (helm-mode)
;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)

(require 'ivy)
(ivy-mode)

(require 'lsp-mode)
(add-hook 'go-mode-hook (lambda ()
                          (lsp)
                          (add-hook 'before-save-hook #'lsp-format-buffer nil t)
                          (add-hook 'before-save-hook #'lsp-organize-imports nil t)))

;; (setq lsp-keymap-prefix "C-c l")
;; (add-hook 'lsp-mode-hook 'lsp-enable-which-key-integration)

(setq my/lsp-keymap (make-keymap))
(dolist (bind '(("d" . lsp-find-definition)
                ("r" . lsp-find-references)
                ("i" . lsp-find-implementation)
                ("t" . lsp-find-type-definition)
                ("h" . lsp-describe-thing-at-point)
                ("ar" . lsp-rename)
                ("ao" . lsp-organize-imports)
                ("af" . lsp-format-buffer)))
  (define-key my/lsp-keymap (kbd (car bind)) (cdr bind)))

(define-key lsp-mode-map (kbd "C-c l") my/lsp-keymap)

;; (require 'crux)

(require 'diminish)
(diminish 'ivy-mode)
(eval-after-load "flymake" '(diminish 'flymake-mode "FMK"))
(eval-after-load "lsp-lens" '(diminish 'lsp-lens-mode))
(diminish 'eldoc-mode)
(diminish 'lsp-mode "LSP")
(diminish 'which-key-mode)

;; server mode
(require 'server)
(if (not (server-running-p))
    (server-start)
  (warn "server already running"))


