; -*- mode: Emacs-Lisp; eval: (auto-fill-mode 1);-*-
;(setq debug-on-error t)

;;;;;;;;;;;;;;;;;;;;;;
;; Conventions
;; one ; for lines just commented out
;; two ; for actual comments and such.
;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;
;;
;; General Preferences
;; 
;;;;;;;;;;;;;;;;;;;;;;

;; Put the time on the window
(display-time)

;; enable visual feedback on selections
(setq-default transient-mark-mode t)

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)
;; insert newline at the end of the file if needed
(setq require-final-newline t)

;; prevent strange things from happening with symlinks or hardlinks
;; Version control

(setq version-control t)
(setq backup-by-copying t)
(setq backup-by-copying-when-linked t)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\^?" 'backward-delete-char-untabify) ; fix backspace
(global-set-key "\^H" 'backward-delete-char-untabify) ; 
(global-set-key [backspace] 'delete-backward-char)
(global-set-key [delete] 'delete-char)
(global-set-key [f2]  'enlarge-window)
(global-set-key [f3]  'shrink-window)
(global-set-key [kp-delete] 'delete-char)
(defun back-window ()
  (interactive)
  (other-window -1))
(global-set-key (kbd "C-x O") 'back-window)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-interval 30)
 '(display-time-mode t)
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(mail-user-agent 'gnus-user-agent)
 '(package-selected-packages
   '(ox-minutes ox-hugo ox-asciidoc json-mode adoc-mode babel babel-repl csv-mode dash easy-hugo f jinja2-mode markdown-changelog markdown-mode markdown-mode+ markdown-toc markdownfmt toc-org yaml-mode))
 '(perl-tab-to-comment t)
 '(warning-suppress-types '((comp))))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ansible)
(use-package ansible-doc)
(use-package ansible-vault)
(use-package babel)
(use-package babel-repl)
(use-package csv-mode)
(use-package dash)
(use-package f)
(use-package jinja2-mode)
(use-package json-mode)
(use-package lua-mode)
(use-package markdown-mode)
(use-package markdown-toc)
(use-package markdownfmt)
(use-package ox-asciidoc)
(use-package ox-gfm)
(use-package ox-hugo)
(use-package ox-minutes)
(use-package toc-org)
(use-package yaml-mode)

(when window-system
  ;; enable wheelmouse support by default
  (mwheel-install)
  ;; use extended compound-text coding for X clipboard
  (set-selection-coding-system 'compound-text-with-extensions)
  (add-to-list 'default-frame-alist '(foreground-color . "white"))
  (add-to-list 'default-frame-alist '(background-color . "black"))
  (add-to-list 'default-frame-alist '(cursor-color . "coral")))

;;; Minimal Unbreak Emacs
; Waste of display space if you can't click on it
(if (not window-system) (menu-bar-mode nil))

; Linux mode for C
(setq c-default-style
      '((c-mode . "linux") (other . "gnu"))
      c-basic-offset 4
      )

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
    '(lambda ()
       (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

; Setup ansible
(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(setq org-agenda-files (list "~/org-files/work.org"
                             "~/org-files/home.org"))
(setq org-log-done t)
(add-hook 'org-mode-hook '(lambda () (setq fill-column 72)))
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(require 'ox-hugo)

; The default for "uniquifying" buffer names sucks
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Default Mode

(setq-default default-major-mode 'text-mode)
(setq text-mode-hook '(lambda () "Smooges defaults for text mode."
			; (turn-on-auto-fill)
			(setq fill-column 72)
))

(setq user-mail-address "smooge@fedoraproject.org")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Droid Sans Mono" :foundry "unknown" :slant normal :weight normal :height 143 :width normal))))
 '(markdown-code-face ((t (:inherit fixed-pitch :background "blue")))))

