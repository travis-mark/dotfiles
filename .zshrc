# Reload script
alias reload='source ~/.zshrc'

# General / Addons
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # FZF Completions
eval "$(starship init zsh)" # Starship Command Prompt
PATH=$PATH:${HOME}/bin # Scripts
GH='/Volumes/Code/travis-mark.github.com'
PD='/Volumes/Code/penndotvso.visualstudio.com'

# Projects
alias dot='cd ${GH}/dotfiles'
alias fcevl='cd ${PD}/Mobile-BOMO/FacilityEvals'
alias fcweb='cd ${PD}/Mobile-BOMO/FacilityEvalsWeb'
alias pduf='cd ${PD}/Mobile-PODS/PDUnifiedFramework'

# Functions 
source /Volumes/Code/travis-mark.github.com/dotfiles/functions/code.zsh 
source /Volumes/Code/travis-mark.github.com/dotfiles/functions/image-size.zsh 
source /Volumes/Code/travis-mark.github.com/dotfiles/functions/ip.zsh 
source /Volumes/Code/travis-mark.github.com/dotfiles/functions/xc.zsh 
source /Volumes/Code/travis-mark.github.com/dotfiles/functions/xman.zsh 
