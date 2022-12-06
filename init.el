(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
)

(defun require-or-install (package)
  (unless (package-installed-p package)
    (refresh-and-package-install package))
)

(defvar done-package-refresh-contentsp nil)

(defun refresh-and-package-install (package)
  (unless done-package-refresh-contentsp
    (setq done-package-refresh-contentsp t)
    (package-refresh-contents))
    (package-install package))

(progn
  (require-or-install 'nyan-mode)
  (nyan-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary nil)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("org" . "https://orgmode.org/elpa/")))
 '(package-selected-packages
   '(seeing-is-believing smartrep ein smex smooth-scroll smooth-scrool all-the-icons-icon-for-dir-with-chevron
                         (neotree all-the-icons-icon-for-dir-with-chevron all-the-icon-for-file)        
                         (neotree all-the-icons-icon-for-dir-with-chevron all-the-icon-for-file)        
                         neotree rainbow-delimiters ace-window helm-config helm doom-modeline which-key 
doom-themes fontawesome nyan-mode zoom)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(progn
  (require-or-install 'multi-vterm)
  (use-package multi-vterm :ensure t)
  (global-set-key (kbd "C-c v") 'multi-vterm))

(progn
  (require-or-install 'use-package)
)

(set-face-attribute 'default nil :font "FiraCode Nerd Font Bold" :height 100)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

  (progn
    (require-or-install 'doom-modeline)
  )


  (progn
    (require-or-install 'which-key)
  )

  (use-package which-key
    :diminish which-key-mode
    :hook (after-init . which-key-mode))

(progn
  (require-or-install 'helm)
)

(progn
  (helm-mode 1)
(setq recentf-max-saved-items 2000)
(setq recentf-auto-cleanup 'never)
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
(setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))

(recentf-mode 1)
(bind-key "C-c r " 'helm-recentf)
)

(progn
  (require-or-install 'fzf)
)

(use-package fzf
  :bind(("C-c f" . fzf))
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/grep-command "grep -nrH"
        fzf/position-bottom t
        fzf/window-height 15)
  )

(progn
  (require-or-install 'windresize)
)

(bind-key "C-c w" 'windresize)

(progn
  (toggle-scroll-bar -1)
  (setq inhibit-startup-message t)
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode -1)
  (add-to-list 'default-frame-alist '(drag-internal-border . 1))
  (add-to-list 'default-frame-alist '(internal-border-width . 5))
  (setq display-time-string-forms '((format "%s %s %s" dayname monthname day)
                                  (format "  %s:%s" 24-hours minutes))
      frame-title-format '(" - " display-time-string " - "))

(display-time)
)

(progn
  (require-or-install 'ace-window)
  )

(bind-key "C-x o" 'ace-window)

(progn
  (require-or-install 'zoom)
  )

(progn
  (require-or-install 'rainbow-delimiters)
 (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)
)

(progn
  (require-or-install 'neotree)
)

(progn
(use-package neotree
  :init
  (setq-default neo-keymap-style 'concise)
  :config
  (setq neo-smart-open t)
  (setq neo-create-file-auto-open t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (bind-key "C-c t" 'neotree-toggle)
  (bind-key "RET" 'neotree-enter-hide neotree-mode-map)
  (bind-key "a" 'neotree-hidden-file-toggle neotree-mode-map)
  (bind-key "<left>" 'neotree-select-up-node neotree-mode-map)
  (bind-key "<right>" 'neotree-change-root neotree-mode-map))


;; Change neotree's font size

;; Tips from https://github.com/jaypei/emacs-neotree/issues/218
(defun neotree-text-scale ()
  "Text scale for neotree."
  (interactive)
  (text-scale-adjust 0)
  (text-scale-decrease 1)
  (message nil))
  (add-hook 'neo-after-create-hook
      (lambda (_)
        (call-interactively 'neotree-text-scale)))
;; neotree enter hide
;; Tips from https://github.com/jaypei/emacs-neotree/issues/77
(defun neo-open-file-hide (full-path &optional arg)
  "Open file and hiding neotree.
The description of FULL-PATH & ARG is in `neotree-enter'."
  (neo-global--select-mru-window arg)
  (find-file full-path)
  (neotree-hide))

(defun neotree-enter-hide (&optional arg)
  "Neo-open-file-hide if file, Neo-open-dir if dir.
The description of ARG is in `neo-buffer--execute'."
  (interactive "P")
  (neo-buffer--execute arg 'neo-open-file-hide 'neo-open-dir))
)

(progn
  (require-or-install 'smex)
  (smex-initialize)
  (global-set-key (kbd "C-c s") 'smex)
  (global-set-key (kbd "C-c m") 'smex-major-mode-commands)
  ;; This is your old M-x.
  )


(progn
  (require-or-install 'smartrep)
  )

(progn
  (eval-when-compile
  (require 'ein)
  (require 'ein-notebook)
  (require 'ein-notebooklist)
  (require 'ein-markdown-mode)
  (require 'smartrep))

;; (add-hook 'ein:notebook-mode-hook 'electric-pair-mode) ;; お好みで
;; (add-hook 'ein:notebook-mode-hook 'undo-tree-mode) ;; お好みで

;; undoを有効化 (customizeから設定しておいたほうが良さげ)
(setq ein:worksheet-enable-undo t)

;; 画像をインライン表示 (customizeから設定しておいたほうが良さげ)
(setq ein:output-area-inlined-images t)

;; markdownパーサー
;; M-x ein:markdown →HTMLに翻訳した結果を*markdown-output*バッファに出力
(require 'ein-markdown-mode)

;; pandocと markdownコマンドは入れておく
;; brew install pandoc
;; brew install markdown
(setq ein:markdown-command "pandoc --metadata pagetitle=\"markdown preview\" -f markdown -c ~/.pandoc/github-markdown.css -s --self-contained --mathjax=https://raw.githubusercontent.com/ustasb/dotfiles/b54b8f502eb94d6146c2a02bfc62ebda72b91035/pandoc/mathjax.js")

;; markdownをhtmlに出力してブラウザでプレビュー
(defun ein:markdown-preview ()
  (interactive)
  (ein:markdown-standalone)
  (browse-url-of-buffer ein:markdown-output-buffer-name))

;; smartrepを入れておく。
;; C-c C-n C-n C-n ... で下のセルに連続で移動、
;; その途中でC-p C-p C-pで上のセルに連続で移動など
;; セル間の移動がスムーズになってとても便利
(declare-function smartrep-define-key "smartrep")
(with-eval-after-load "ein-notebook"
  (smartrep-define-key ein:notebook-mode-map "C-c"
    '(("C-n" . 'ein:worksheet-goto-next-input-km)
      ("C-p" . 'ein:worksheet-goto-prev-input-km))))
)
