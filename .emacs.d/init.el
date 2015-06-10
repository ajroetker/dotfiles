;; fix the PATH variable
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "TERM=vt100 $SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(defvar my-packages '(evil
                      evil-leader
                      better-defaults
                      flx-ido
                      rust-mode
                      puppet-mode
                      ido-ubiquitous
                      helm
                      helm-projectile
                      projectile
                      paredit
                      rainbow-delimiters
                      color-theme
                      auto-complete
                      clojure-mode
                      cider
                      ac-cider))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(require 'flx-ido)
(require 'ido-ubiquitous)
(require 'icomplete)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(ido-ubiquitous-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(require 'projectile)
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)
(helm-projectile-on)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'paredit-mode)
(load-theme 'tango-dark t)
(require 'evil-leader)
(evil-leader/set-leader ",")
(evil-leader/set-key
  ")" 'paredit-forward-slurp-sexp
  "}" 'paredit-forward-barf-sexp
  "(" 'paredit-backward-slurp-sexp
  "{" 'paredit-backward-barf-sexp
  "W" 'paredit-wrap-round
  "w[" 'paredit-wrap-square
  "w{" 'paredit-wrap-curly
  "S" 'paredit-splice-sexp
  "e" 'projectile-find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer)
(global-evil-leader-mode)
(require 'evil)
(evil-mode 1)

;; http://stackoverflow.com/questions/10569165/how-to-map-jj-to-esc-in-emacs-evil-mode
(define-key evil-insert-state-map "j" #'cofi/maybe-exit)

(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "j")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
               nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?j))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                          (list evt))))))))


;; http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files 
;; make all backup files go into a directory
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/autosaves")))

;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(require 'auto-complete-config)
(ac-config-default)

(require 'cider)
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround) 
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

(add-hook 'cider-repl-mode-hook #'paredit-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
