;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.x

(defun my-c-mode-common-hook ()
;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
(c-set-offset 'substatement-open 0)
;; other customizations can go here

(setq c++-tab-always-indent t)
(setq c-basic-offset 4)                  ;; Default is 2
(setq c-indent-level 4)                  ;; Default is 2

(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
(setq tab-width 4)
(setq indent-tabs-mode t)  ; use spaces only if nil
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(setq ring-bell-function 'ignore)

(setq-default tab-width 4) ; or any other preferred value
(load-theme 'zenburn t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(pdf-tools exec-path-from-shell jupyter org-tempo visual-fill-column visual-fill bash-completion jedi neotree company-math latex-extra latex-math-preview magithub magit importmagic company-shell auctex auctex-latexmk))
 '(xterm-mouse-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'prog-mode-hook 'linum-mode)
;;(setq-default 'truncate-lines t)
(add-hook 'after-init-hook 'global-company-mode)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/"))
(package-initialize)
;;(elpy-enable)

;; make sure use-package is available
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

;; add equation to latex keybinding
(defun insert-equation ()
  (interactive)
  (insert "\\begin{equation*}")
  (insert "\n\n")
  (insert "\\end{equation*}")
  (backward-char 16)
  (insert "  "))

;; add align to latex keybinding
(defun insert-align()
  (interactive)
  (insert "\\begin{align*}")
  (insert "\n\n")
  (insert "\\end{align*}")
  (backward-char 13)
  (insert "  "))

;; add definition
(defun insert-def()
  (interactive)
  (insert "\\begin{definition}[]")
  (insert "\n\n")
  (insert "\\end{definition}")
  (backward-char 19))

;; add example
(defun insert-exp()
  (interactive)
  (insert "\\begin{example}")
  (insert "\n\n")
  (insert "\\end{example}")
  (backward-char 13)
  (insert "  "))

(defun insert-frac()
  (interactive)
  (insert "\\frac{}{}")
  (backward-char 3))

(defun insert-inline-eq()
  (interactive)
  (insert "\\$$")
  (backward-char 1))

;; add equation to latex keybinding
(defun insert-begin ()
  (interactive)
  (insert "\\begin{}")
  (insert "\n\n")
  (insert "\\end{}")
  (backward-char 9))

(use-package tex
  :ensure auctex)
(use-package exec-path-from-shell)
(exec-path-from-shell-initialize)
;;(add-to-list 'TeX-view-program-list
;;			 '("Zathura"
;;			   ("zathura %o"
;;				(mode-io-correlate " --synctex-forward %n:0:%b -x \"emacsclient -socket-name=%sn --no-wait +%{line} %{input}\""))
;;			   "zathura"))
;; (setq TeX-view-program-selection '((output-pdf "Zathura"))
;; 	  TeX-source-correlate-start-server t)
;;(setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view")))
;; Use pdf-tools to open PDF files
(use-package pdf-tools)
(setq TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)) 
        TeX-view-program-selection '((output-pdf "PDF Tools"))  
        TeX-source-correlate-start-server t)
;; (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
;;       TeX-source-correlate-start-server t)

;; ;; Update PDF buffers after successful LaTeX runs
;; (add-hook 'TeX-after-compilation-finished-functions
;;            #'TeX-revert-document-buffer)

;; add ghostscript to path
(setenv "PATH" (concat "/usr/bin/:" (getenv "PATH")))

;; generic latex begin-end
;;(defun lc(a &optional)
;; (interactive)
;;  (insert "\\begin{")
;;  (insert a)
;;  (insert "}")
;;  (insert "\n\n")
;;  (insert "\\end{")
;;  (insert a)
;;  (insert "}")
;;  (backward-char 13)
;;  (insert "  "))

;; I use this a lot in latex
(global-set-key (kbd "M-<f3>") 'insert-begin)
(global-set-key (kbd "M-<f4>") 'insert-frac)
(global-set-key (kbd "M-<f5>") 'insert-def)
(global-set-key (kbd "M-<f6>") 'insert-exp)
(global-set-key (kbd "M-<f7>") 'insert-equation)
(global-set-key (kbd "M-<f8>") 'insert-align)

;; don't ask to save
(setq exec-path (append '("/Library/TeX/texbin") exec-path))
(setq TeX-save-query nil)
(local-set-key [3 3] (quote TeX-command-run-all))

;; load neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq-default neo-show-hidden-files t)

;; magit keybindings
(global-set-key (kbd "C-x g") 'magit-status)

;; more lines in ansi-term
(setq term-buffer-maximum-size 25000)

;; orgmode configurations
(defun org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (setq org-hide-emphasis-markers t)
  (setq org-startup-folded nil))

(use-package org
  :hook (org-mode . org-mode-setup)
  :config
  (setq org-ellipsis " ▼"))
  
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-set-startup-visibility "show2levels")
(setq org-log-done t)

(defvar default-font-size 120)
(defvar default-variable-font-size 120)
(set-face-attribute 'default nil :font "Courier" :height default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Courier" :height default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Trebuchet MS" :height default-variable-font-size :weight 'regular)

;; set the size of the text for different headings
(with-eval-after-load 'org-faces
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)   
                  (org-level-3 . 1.05)   
                  (org-level-4 . 1.0)   
                  (org-level-5 . 1.1)   
                  (org-level-6 . 1.1)   
                  (org-level-7 . 1.1)   
                  (org-level-8 . 1.1)))
	(set-face-attribute (car face) nil :font "Trebuchet MS" :weight 'regular :height (cdr face)))
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch))

;; Ensure that anything that should be fixed-pitch in Org files appears that way
;;(set-face-attribute 'line-number nil :inherit 'fixed-pitch)
;;(set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

;; visual fill to add some pretty padding in org mode
(defun org-mode-visual-fill ()
  (setq visual-fill-column-width 100
		visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :defer t
  :hook (org-mode . org-mode-visual-fill))

;; babel allows us to run the code in #+begin_src ... #+end_src block
(use-package jupyter)

(org-babel-do-load-languages 'org-babel-load-languages
							' ((python . t)
							   (shell . t)
							   (jupyter . t)))
(setq org-babel-python-command "/usr/local/bin/python3")
(setq org-confirm-babel-evaluate nil)

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

