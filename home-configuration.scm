(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (gnu packages)
             (guix gexp))

(home-environment
 (packages (map specification->package
                (list
                 "cmake"
                 "curl"
                 "emacs"
                 "fd"
                 "fzf"
                 "git"
                 "gnupg"
                 "htop"
                 "perl"
                 "pinentry-tty"
                 "neovim"
                 "openssl"
                 "ripgrep"
                 "sqlite"
                 "tmux"
                 )))
 (services
  (list
   (service home-bash-service-type
            (home-bash-configuration
             (aliases
              '(("ll" . "ls -l")
                ("e" . "emacsclient -nw")
                ("vim" . "nvim")
                ("vi" . "nvim")))
             (bashrc
              (list
               (local-file "config/bashrc")
               (local-file "config/gpg.sh")
               (local-file "config/fzf/fzf.bash")))
             (guix-defaults? #t)))
   (simple-service 'env-vars
                   home-environment-variables-service-type
                   `(("XDG_RUNTIME_DIR" . "$HOME/tmp")
                     ("PATH" . "$PATH:$HOME/bin")
                     ("HISTFILE" . "$XDG_CACHE_HOME/.bash_history")))

   (simple-service 'docker-env-vars
                   home-environment-variables-service-type
                   `(("DOCKER_BUILDKIT" . "0")
                     ("COMPOSE_DOCKER_CLI_BUILD" . "0")))

   (simple-service 'go-env-vars
                   home-environment-variables-service-type
                   `(("GO111MODULE" . "on")
                     ("GOFLAGS=-mod" . "vendor")
                     ("GOPRIVATE" . "*.internal.digitalocean.com,github.com/digitalocean")))

   (simple-service 'fzf-env-vars
                   home-environment-variables-service-type
                   `(("FZF_COMPLETION_TRIGGER" . "~~")
                     ("FZF_COMPLETION_OPTS" . "--border")))

   (simple-service 'tmux-conf
                   home-files-service-type
                   (list `("tmux.conf",
                           (local-file "config/tmux.conf"))))

   (simple-service 'git-conf
                   home-files-service-type
                   (list `("gitconfig",
                           (local-file "config/gitconfig"))))

   (simple-service 'fzf-conf
                   home-files-service-type
                   (list `("fzf/fzf.bash",
                           (local-file "config/fzf/fzf.bash"))
                         `("fzf/config.bash",
                           (local-file "config/fzf/config.bash"))
                         `("fzf/key-bindings.bash",
                           (local-file "config/fzf/key-bindings.bash"))
                         `("fzf/completion.bash",
                           (local-file "config/fzf/completion.bash"))))
   )))
