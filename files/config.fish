set -x XDG_RUNTIME_DIR $HOME/tmp
set -x fish_user_paths $HOME/bin $fish_user_paths
starship init fish | source
