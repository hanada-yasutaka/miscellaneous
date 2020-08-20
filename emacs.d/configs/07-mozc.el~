; mozcの設定
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
; 全角半角キーで on/off
(global-set-key [zenkaku-hankaku] 'toggle-input-method)
; 変換キーでon
(global-set-key [henkan]
		(lambda () (interactive)
		  (when (null current-input-method) (toggle-input-method))))
; カタカナひらがな/ローマ字キーでon
(global-set-key [hiragana-katakana]
		(lambda () (interactive)
		  (when (null current-input-method) (toggle-input-method))))

; 無変換キーでon
(global-set-key [muhenkan]
		(lambda () (interactive)
		  (inactivate-input-method)))
; 全角半角キーと無変換キーのキーイベントを横取りする
(defadvice mozc-handle-event (around intercept-keys (event))
  "Intercept keys muhenkan and zenkaku-hankaku, before passing keys
to mozc-server (which the function mozc-handle-event does), to
properly disable mozc-mode."
  (if (member event (list 'zenkaku-hankaku 'muhenkan))
      (progn
	(mozc-clean-up-session)
	(toggle-input-method))
    (progn ;(message "%s" event) ;debug
      ad-do-it)))
(ad-activate 'mozc-handle-event)
