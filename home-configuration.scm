;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

;;              (bash-profile '("\
;; export HISTFILE=$XDG_CACHE_HOME/.bash_history"))))

(define-module (home environment)
	       #:use-module (gnu home)
	       #:use-module (gnu home services shells)
	       #:use-module (gnu packages)
	       #:use-module (gnu services)
	       #:use-module (guix gexp))
;; personal modules
;;  #:use-module (home modules tmux))

(home-environment
  (packages
    (map specification->package
	 (list
	   "fish"
	   "guile"
	   "emacs-no-x"
	   "neovim"
	   "git"
	   "tmux"
	   "curl"
	   "fzf"
	   "ripgrep"
	   "fd"
	   "bat"
	   "nss-certs")))
  (services
    (list
      (service
	home-bash-service-type
	(home-bash-configuration
	  (aliases
	    '(("grep='grep --color" . "auto")
	      ("ll" . "ls -l")
	      ("ls='ls -p --color" . "auto")))
	  (bashrc
	    (list
	      (local-file
		"/home/rlambert/src/guix-config/.bashrc"
		"bashrc")))
	  (bash-profile
	    (list
	      (local-file
		"/home/rlambert/src/guix-config/.bash_profile"
		"bash_profile")))))
      (service
	home-fish-service-type
	(home-fish-configuration
	  (aliases
	    '(("grep" ."grep --color auto")
	      ("ll" ."ls -l")
	      ("robert" ."echo 'helllooooo'")))
	  (environment-variables
	    '(("XDG_RUNTIME_DIR" . "$HOME/tmp")
	      ("SSL_CERT_DIR" . "$HOME/.guix-profile/etc/ssl/certs")
	      ("SSL_CERT_FILE" . "$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt")
	      ("GIT_SSL_CAINFO" . "$SSL_CERT_FILE")
	      ("FZF_DEFAULT_COMMAND" . "fd --type f")
	      ("FZF_CTRL_T_COMMAND". "$FZF_DEFAULT_COMMAND")
	      ("CURL_CA_BUNDLE" . "$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt")))
	  (config
	    (list
	      (local-file
		"config.fish"))
	    ))
	))))
