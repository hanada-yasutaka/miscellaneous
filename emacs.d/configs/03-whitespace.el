(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         spaces         ; スペース
                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
      '(
        (space-mark ?\u3000 [?\u2423])
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
        ))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))

(global-whitespace-mode 1)

;;(defvar my/bg-color "#fff")
(set-face-attribute 'whitespace-trailing nil
                     :underline t)
(set-face-attribute 'whitespace-tab nil
                     :underline t)
(set-face-attribute 'whitespace-space nil
                     :weight 'bold)
;; (set-face-attribute 'whitespace-empty nil
;;                     :background my/bg-color)

;; markdown-modeなどでauto-cleanupを無効にする
(add-hook 'markdown-mode-hook
          '(lambda ()
             (set (make-local-variable 'whitespace-action) nil)))
