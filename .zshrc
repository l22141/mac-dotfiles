# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/mac/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="avit"
#ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions kubectl)


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/mac/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/mac/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/mac/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/mac/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# homebrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
export HOMEBREW_BREW_GIT_REMOTE=https://mirrors.ustc.edu.cn/brew.git
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_NO_AUTO_UPDATE=1

#curl
export http_proxy=http://127.0.0.1:56722
export https_proxy=http://127.0.0.1:56722

# gcc alias
alias gcc=/usr/local/Cellar/gcc/14.2.0_1/bin/gcc-14
alias g++=/usr/local/Cellar/gcc/14.2.0_1/bin/g++-14

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
# export ALL_PROXY=127.0.0.1:63690

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# alias nvim=~/.local/nvim-macos-x86_64/bin/nvim
alias lsd=~/.local/lsd-v1.2.0/lsd
# alias procs=~/.local/bin/procs

export JAVA_TOOL_OPTIONS="-Duser.language=en -Duser.country=US"

alias hg="kitten hyperlinked-grep"
alias gdt="git difftool --no-symlinks --dir-diff"

alias kq="kitten choose-files"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/Users/mac/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/mac/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# export PATH=`echo $PATH|sed -e "s!:$HOME/bin!!g" -e 's!:/usr/local/bin!!g'`:$HOME/bin:/usr/local/bin
export PATH=~/.local/bin:$PATH
export VISUAL=nvim
export EDITOR=nvim

source /Users/mac/.config/broot/launcher/bash/br

alias ranger="source ranger ranger"
# function ranger {
#     local IFS=$'\t\n'
#     local tempfile="$(mktemp -t tmp.XXXXXX)"
#     local ranger_cmd=(
#         command
#         ranger
#         --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
#     )
#
#     ${ranger_cmd[@]} "$@"
#     if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
#         cd -- "$(cat "$tempfile")" || return
#     fi
#     command rm -f -- "$tempfile" 2>/dev/null
# }
function tree {
     br -c :pt "$@"
}
# deep fuzzy cd
function dcd {
	br --only-folders --cmd "$1;:cd"
}

export PYTHONSTARTUP="$HOME/.pythonrc"
alias cpy14="mamba activate py314"
export CONDA_PREFIX="/Users/mac/miniforge3/"

# git alias ref from zsh git plugins
# display all commit history with more useful info than gloga
alias gloda='glod --all'
# delete all local branches which deleted in remote repo.
# note: the hacks '"'"' which input ' in apostrophe string
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -d'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -D'

# set cmd+; as autosuggestions-execute
# Note: cat <input key> shows the code for <input key>
if [[ "$TERM" == *kitty ]]
then
    # use cmd+; as trigger for some tools which needs ; in the command line
    # e.g. jq
    bindkey '^[[59;9u' autosuggest-execute
else
    # nvim terminal can't support cmd+;, so use ; as the trigger
    # maybe alt+; is better, but it's more difficult to input than ;
    bindkey ';' autosuggest-execute
fi
cpy14
# alias wget="/opt/local/bin/wget"
alias config='/usr/bin/git --git-dir=/Users/mac/.cfg/ --work-tree=/Users/mac'
