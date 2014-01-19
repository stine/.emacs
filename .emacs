;; ---------------------------------------------------
;; Applied Minds specific config
;; ---------------------------------------------------

;; Create custom style for C and C++ derived from BSD.
(c-add-style "AMI"
	     '("BSD"
	       (indent-tabs-mode . t)
	       (c-basic-offset . 4)
	       (tab-width . 4)))
(add-hook 'c-mode-hook (lambda() (c-set-style "AMI")))
(add-hook 'c++-mode-hook (lambda() (c-set-style "AMI")))

;; Require and load whitespace minor mode when editing c++ or c
(require 'whitespace)
(setq whitespace-style (quote (spaces tabs space-mark tab-mark)))
(add-hook 'c-mode-hook 'whitespace-mode)
(add-hook 'c++-mode-hook 'whitespace-mode)

;; ---------------------------------------------------
;; General editor config
;; ---------------------------------------------------

;; Get rid of all tool bars.
(tool-bar-mode -1)
(menu-bar-mode 0)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; Load Aspell.
(setq ispell-program-name "aspell")
(require 'aspell)
(setq text-mode-hook '(lambda() (flyspell-mode t) ))

;; Ensure emacsclient loads .emacs file.
(add-hook 'before-make-frame-hook #'(lambda() (load-file "~/.emacs")))

;; Enable global auto revert mode.
(global-auto-revert-mode t)

;; Reuse frames for buffers, if they already exist.
(setq-default display-buffer-reuse-frames t)

;; Enable syntax highlighting and set editor colors.
(global-font-lock-mode t)
(set-background-color "Black")
(set-foreground-color "White")
(set-cursor-color "Red")

;; Activate the dynamic completion of buffer names, mini-buffer
(iswitchb-mode 1)
(icomplete-mode 1)

;; Show current column number on the mode line.
(setq column-number-mode t)

;; Put all emacs droppings in a folder.
(setq backup-directory-alist
`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
`((".*" ,temporary-file-directory t)))

;; Delete files by moving them to trash.
(setq delete-by-moving-to-trash t)

;; Enable save space.
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

;; Auto-scroll the compilation window
(setq compilation-scroll-output 1)

;; Close the compilation window if there was no error at all.
(setq compilation-exit-message-function
      (lambda (status code msg)
	;; If M-x compile exists with a 0
	(when (and (eq status 'exit) (zerop code))
	  ;; then bury the *compilation* buffer, so that C-x b doesn't go there
  	  (bury-buffer "*compilation*")
	  ;; and delete the compilation window
	  (delete-window (get-buffer-window (get-buffer "*compilation*"))))
	;; Always return the anticipated result of compilation-exit-message-function
  	(cons msg code)))

;; ---------------------------------------------------
;; Custom functions
;; ---------------------------------------------------


;; ---------------------------------------------------
;; Custom keybindings
;; ---------------------------------------------------

;; Create keybindings.
(add-hook 'c-mode-common-hook (lambda() (define-key c-mode-base-map (kbd "C-c C-j") 'compile)))
(add-hook 'c-mode-common-hook (lambda() (define-key c-mode-base-map (kbd "C-c C-k") 'recompile)))
(add-hook 'c-mode-common-hook (lambda() (define-key c-mode-base-map (kbd "C-c C-l") 'gdb)))

;; ---------------------------------------------------
;; Options menu created config
;; ---------------------------------------------------

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
