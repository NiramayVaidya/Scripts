mv .zsh_history .zsh_history_bad
strings .zsh_history_bad > .zsh_history
# This command not working via bash script, hence execute it from cmd prompt
# after executing this bash script
# fc -R .zsh_history
