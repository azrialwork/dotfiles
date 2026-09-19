# =============================================================================
# ~/.bashrc — WSL shell configuration (root)
# Theme: Mercury (opencode mercury theme) — truecolor
# =============================================================================

# -----------------------------------------------------------------------------
# Mercury palette (truecolor SGR codes, from opencode mercury theme)
# -----------------------------------------------------------------------------
# Each variable holds the SGR parameter string, e.g. "38;2;141;164;245".
# Use with: \e[<code>m ... \e[0m
MERCURY_INK='38;2;221;221;229'        # default text
MERCURY_PRIMARY='38;2;141;164;245'    # blue — directories, prompt symbol
MERCURY_SUCCESS='38;2;119;197;153'    # green — executables, git branch
MERCURY_WARNING='38;2;252;155;111'    # yellow — archives, line numbers
MERCURY_ERROR='38;2;252;146;180'      # red — errors, setuid
MERCURY_INFO='38;2;119;190;207'       # cyan — symlinks, man underline
MERCURY_PURPLE='38;2;167;182;248'     # purple — sockets
MERCURY_WEAK='38;2;157;157;168'       # muted — separators
MERCURY_NEUTRAL='38;2;23;23;33'       # background #171721 (as foreground code)

# -----------------------------------------------------------------------------
# ls colors
# -----------------------------------------------------------------------------
export LS_COLORS="\
di=${MERCURY_PRIMARY}:\
ln=${MERCURY_INFO}:\
ex=${MERCURY_SUCCESS}:\
fi=${MERCURY_INK}:\
pi=${MERCURY_WARNING}:\
so=${MERCURY_PURPLE}:\
bd=${MERCURY_WARNING}:\
cd=${MERCURY_WARNING}:\
su=${MERCURY_ERROR}:\
sg=${MERCURY_ERROR}:\
tw=${MERCURY_SUCCESS}:\
ow=${MERCURY_SUCCESS}:\
st=${MERCURY_WEAK}:\
or=${MERCURY_ERROR}:\
mi=${MERCURY_WEAK}:\
*.zip=${MERCURY_WARNING}:\
*.tar=${MERCURY_WARNING}:\
*.gz=${MERCURY_WARNING}:\
*.xz=${MERCURY_WARNING}:\
*.7z=${MERCURY_WARNING}:\
*.rar=${MERCURY_WARNING}:\
*.bz2=${MERCURY_WARNING}"
alias ls='ls --color=auto'

# -----------------------------------------------------------------------------
# grep colors
# -----------------------------------------------------------------------------
export GREP_COLORS="\
ms=${MERCURY_PRIMARY}:\
mc=${MERCURY_PRIMARY}:\
sl=:\
cx=:\
fn=${MERCURY_SUCCESS}:\
ln=${MERCURY_WARNING}:\
bn=${MERCURY_WARNING}:\
se=${MERCURY_WEAK}"
alias grep='grep --color=auto'

# -----------------------------------------------------------------------------
# man page colors (LESS_TERMCAP)
# -----------------------------------------------------------------------------
export LESS_TERMCAP_mb=$'\e['${MERCURY_PRIMARY}'m'   # bold
export LESS_TERMCAP_md=$'\e['${MERCURY_PRIMARY}'m'   # bold
export LESS_TERMCAP_me=$'\e[0m'                      # end bold
export LESS_TERMCAP_so=$'\e['${MERCURY_NEUTRAL}';48;2;141;164;245m'  # standout: primary bg, neutral fg
export LESS_TERMCAP_se=$'\e[0m'                      # end standout
export LESS_TERMCAP_us=$'\e['${MERCURY_INFO}'m'      # underline
export LESS_TERMCAP_ue=$'\e[0m'                      # end underline

# -----------------------------------------------------------------------------
# Prompt (PS1)
# -----------------------------------------------------------------------------
__mercury_prompt() {
    local last=$?
    local reset='\[\e[0m\]'
    local primary='\[\e['${MERCURY_PRIMARY}'m\]'
    local success='\[\e['${MERCURY_SUCCESS}'m\]'
    local error='\[\e['${MERCURY_ERROR}'m\]'

    # git branch (if inside a git repo)
    local branch=""
    local b
    b=$(git symbolic-ref --short HEAD 2>/dev/null) || b=$(git rev-parse --short HEAD 2>/dev/null)
    [ -n "$b" ] && branch="${success}(${b})${reset} "

    # exit status of the last command
    local status=""
    [ "$last" -ne 0 ] && status="${error}✗ ${last}${reset} "

    # prompt symbol: $ for regular user, # for root
    local dollar='\$'

    PS1="\[\e]0;\u: \w\a\]${success}\u${reset} ${primary}\w${reset} ${branch}${status}${primary}${dollar}${reset} "
}
PROMPT_COMMAND=__mercury_prompt

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias ll='ls -alF'          # long listing, all files
alias la='ls -A'            # all files except . and ..
alias l='ls -CF'            # compact listing
alias c='clear'
alias ..='cd ..'            # up one level
alias ...='cd ../..'        # up two levels
alias oo='opencode'         # launch opencode
alias oc='cd ~/.config/opencode'
alias r='source ~/.bashrc'  # reload this file