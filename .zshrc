# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

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


. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

export NODE_OPTIONS=--max_old_space_size=4096
export DEVEXPRESS_NUGET_API_KEY=JtJD8Qs2QxHCfuImqyaDo36bhLNpikjK7lxXZECKAsUYjocP13

#################### MY SHITS
vpnopen(){
    openvpn3 session-start --config ~/profile-554.ovpn;
}
drun(){
  sudo docker-compose run --rm -v ~/.ssh:/root/.ssh:ro $*
}
dcud(){
  sudo docker-compose up -d $*
}
dbash(){
  sudo docker exec -ti $* bash
}
dlogs(){
  sudo docker logs -f $*
}
alias dps="sudo docker ps --format '{{.ID}} {{.Names}}'"
alias dps="sudo docker ps --format '{{.ID}} {{.Names}}'"
alias ctdev="sudo docker-compose exec casetracking bash"
alias ctspec="sudo docker-compose exec -e RAILS_ENV=test casetracking bundle exec rspec"
ct-pods(){
  kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' --namespace casetracking | grep -xE 'casetracking-\w+-\w+'
}
ct-pod(){
  kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' --namespace casetracking | grep -xE 'casetracking-\w+-\w+' | head -1
}
spody-pod(){
  kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' --namespace casetracking | grep -xE 'ct-spody-\w+-\w+' | head -1
}
share-pod(){
  kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' --namespace casetracking | grep -xE 'ct-shared-data-api-\w+-\w+' | head -1
}
auto-worker-exec-flows-pod(){
  kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' --namespace casetracking | grep -xE 'ct-automations-worker-execute-flows-\w+-\w+' | head -1
}
ct-auto-worker(){
  kubectl exec -ti $(auto-worker-exec-flows-pod) --namespace casetracking -- /bin/sh
}
ctprod(){
  kubectl exec -ti $(ct-pod) --namespace casetracking -- /bin/sh
}
spodyprod(){
  kubectl exec -ti $(spody-pod) --namespace casetracking -- /bin/sh
}
shareprod(){
  kubectl exec -ti $(share-pod) --namespace casetracking -- /bin/sh
}
note() {
  now=$(date +'%Y-%m-%d')
  filename=~/daily-notes/$now-$1.note
  if [ -z "$1" ]
  then
    filename=~/daily-notes/$now-root.note
  elif [ "$1" = "-l" ]
  then
    ls ~/daily-notes/$now*.note | awk -F/ '{print $NF}' | sed -e "s/$now-//" -e "s/\.note$//"
    return
  elif [ "$1" = "-f" ]
  then
    filename=~/daily-notes/$now-$2.note
    echo $filename
    return
  elif [ "$1" = "-lo" ]
  then
    ls ~/daily-notes/*.note | awk -F/ '{print $NF}' | sed -e "s/*-*-*-//" -e "s/\.note$//"
    return
  fi
  vim -c "autocmd TextChanged,TextChangedI * silent write | set autoread | set noswapfile | set nobackup" $filename
}

note-resurrect(){
  if [ "$1" = "-l" ]
  then
    ls ~/daily-notes/*.note | awk -F/ '{print $NF}' | sed -e "s/*-*-*-//" -e "s/\.note$//"
    return
  fi
  result=$(echo "$1" | sed 's/[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}-//')
  cp ~/daily-notes/$1.note $(note -f $result)
  note $result
}


_note-resurrect_complete()
{
    local cur_word prev_word type_list

    # COMP_WORDS is an array of words in the current command line.
    # COMP_CWORD is the index of the current word (the one the cursor is
    # in). So COMP_WORDS[COMP_CWORD] is the current word; we also record
    # the previous word here, although this specific script doesn't
    # use it yet.
    cur_word="${COMP_WORDS[COMP_CWORD]}"
    prev_word="${COMP_WORDS[COMP_CWORD-1]}"

    # Ask ytmdl to generate a list of types it supports
    type_list=`note-resurrect -l`

    # Only perform completion if the current word starts with a dash ('-'),
    # meaning that the user is trying to complete an option.
    if [[ ${cur_word} == -* ]] ; then
        # COMPREPLY is the array of possible completions, generated with
        # the compgen builtin.
        COMPREPLY=( $(compgen -W "${type_list}" -- ${cur_word}) )
    else
        COMPREPLY=( "${type_list}" )
    fi
    return 0
}
_note_complete()
{
    local cur_word prev_word type_list

    # COMP_WORDS is an array of words in the current command line.
    # COMP_CWORD is the index of the current word (the one the cursor is
    # in). So COMP_WORDS[COMP_CWORD] is the current word; we also record
    # the previous word here, although this specific script doesn't
    # use it yet.
    cur_word="${COMP_WORDS[COMP_CWORD]}"
    prev_word="${COMP_WORDS[COMP_CWORD-1]}"

    # Ask ytmdl to generate a list of types it supports
    type_list=`note -l`

    # Only perform completion if the current word starts with a dash ('-'),
    # meaning that the user is trying to complete an option.
    if [[ ${cur_word} == -* ]] ; then
        # COMPREPLY is the array of possible completions, generated with
        # the compgen builtin.
        COMPREPLY=( $(compgen -W "${type_list}" -- ${cur_word}) )
    else
        COMPREPLY=( "${type_list}" )
    fi
    return 0
}

# Register _ytmdl_complete to provide completion for the following commands
complete -F _note_complete note
complete -F _note-resurrect_complete note-resurrect

##########################

export PATH="$HOME/.local/bin:$PATH"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

