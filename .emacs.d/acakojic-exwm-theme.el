(deftheme acakojic-exwm
  "Created 2020-04-16.")

(custom-theme-set-variables
 'acakojic-exwm
 '(ansi-color-faces-vector [default default default italic underline success warning error])
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(cua-mode t)
 '(custom-safe-themes '("55c2069e99ea18e4751bd5331b245a2752a808e91e09ccec16eb25dadbe06354" "450f3382907de50be905ae8a242ecede05ea9b858a8ed3cc8d1fbdf2d57090af" "1068ae7acf99967cc322831589497fee6fb430490147ca12ca7dd3e38d9b552a" "e9740103f6ae2cbc97fef889b85b1c51b4d4a2d95c2b398b57a1842d14d96304" default))
 '(package-selected-packages '(exwm treemacs-magit magit xah-elisp-mode command-log-mode dracula-theme twilight-theme zerodark-theme zweilight-theme swiper dap-mode lsp-ui company-lsp hydra yasnippet projectile xah-fly-keys which-key try use-package gnu-elpa-keyring-update lsp-java lsp-mode))
 '(column-number-mode t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-theme-set-faces
 'acakojic-exwm
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 128 :width normal))))
 '(mode-line ((t (:background "#99ff99" :foreground "#2e3436" :box (:line-width -1 :style released-button))))))

(provide-theme 'acakojic-exwm)
