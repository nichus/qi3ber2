# qi3ber2.zsh-theme
# screenshot: none

function load_average {
  if [ -f '/proc/loadavg' ]; then
    LA=`cut -d\  -f1 < /proc/loadavg`
  else
    if [ -f '/bin/uptime' ]; then
      UPTIME='/bin/uptime'
    elif [ -f '/usr/bsd/uptime' ]; then
      UPTIME='/usr/bsd/uptime'
    else
      UPTIME='/usr/ucb/uptime'
    fi
    LA=${${UPTIME[(w)-3]}%,}
  fi
  printf "%05.2f\n" ${LA}
}
_fishy_collapsed_wd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
}
function {
  local lc bc hc nc ec pc
  local ul ur mi ml mr ll lr vl

  ul="┌"
  ur="┐"
  mi="─"
  ml="┤"
  mr="├"
  ll="└"
  lr="┘"
  vl="│"

  if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
    lc="%{%F{166}%}"
    uc="%{%F{33}%}"
    bc="%{%F{245}%}"
    hc="%{%F{33}%}"
    pc="%{%F{white}%}"
    nc="%{%f%}"
    ec="%{%F{red}%}"

    ZSH_THEME_GIT_PROMPT_PREFIX=""
    ZSH_THEME_GIT_PROMPT_SUFFIX=" $lc$vl$nc"

    ZSH_THEME_GIT_PROMPT_BEHIND=" %{$fg[red]%}⪕"
    ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg[yellow]%}⪖"
    ZSH_THEME_GIT_PROMPT_DIVERGED=" %{$fg[red]%}⫨"
    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

    RPROMPT='$(vi_mode_prompt_info)$(git_prompt_status)%{$reset_color%}'
  else
    ZSH_THEME_GIT_PROMPT_PREFIX=""
    ZSH_THEME_GIT_PROMPT_SUFFIX=" $vl"

    ZSH_THEME_GIT_PROMPT_BEHIND=" ⪕"
    ZSH_THEME_GIT_PROMPT_AHEAD=" ⪖"
    ZSH_THEME_GIT_PROMPT_DIVERGED=" ⫨"
    ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
    ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"

    RPROMPT='$(vi_mode_prompt_info)$(git_prompt_status)'
  fi
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  local return_status="%(?.   .$ec%3<<000%?$bc)"

  PROMPT="$lc$ul$ml$nc $hc%m$nc:$bc%y$ec♥$bc"'$(load_average)'" $lc$mr$ml$nc $pc"'$(_fishy_collapsed_wd)'"$nc $lc$vl$nc "'$(git_prompt_info)'$'\n'"$lc$ll$ml$nc $bc%D{%m/%d %H:%M} %! ${return_status} $lc$vl$nc %(!.#.$) "
  PS2=$' %_${lc}>${nc} '
}
