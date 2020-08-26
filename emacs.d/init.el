;; パッケージ管理(package.el)の設定
;;



(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
(package-initialize)

(require 'cl)
(defvar installing-package-list
  '(
    init-loader
    undo-tree
    yafolding
    volatile-highlights
    whitespace
    rainbow-delimiters
    yatex
    python-mode
    atom-dark-theme
    mozc
;;    blank-mode
;;    hlinum
;;    popup
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))

;; cf: https://qiita.com/sambatriste/items/aee6e1d91099f533499d
(setq custom-file (locate-user-emacs-file "custom.el"))


;;
;; init-loader
;;
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
;;(require 'init-loader)
;;(setq init-loader-show-log-after-init 'error-only)
(init-loader-load "~/.emacs.d/configs")


;; 左に行ラインを表示
(global-linum-mode t)
;;タブの無効化
(setq-default indent-tabs-mode nil)
;;タブ幅を2に
(setq-default tab-width 2)
(setq default-tab-width 2)
(setq tab-stop-list '(2 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                      64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))




;; 日本語フォントを設定
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Noto Sans CJK JP" :size 12))

;; フォントの横幅を調整
(add-to-list 'face-font-rescale-alist '(".*Noto.*" . 1.2))

;; 日本語ディレクトリの設定
(set-default-coding-systems 'utf-8)
