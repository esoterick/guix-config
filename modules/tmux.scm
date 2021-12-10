(define-module (home modules tmux))

(define-public tmux-config
  (list
    (simple-service 'tmux-config
                   home-files-service-type
		   `((".tmux.conf",
		      (local-file "../files/tmux.conf")))
                   )))
