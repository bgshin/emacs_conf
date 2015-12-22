(blink-cursor-mode t) 

;; recentf stuff
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


(require 'ido)
(ido-mode t) 
(global-auto-revert-mode 1)
