### BEGIN

# Set up the prompt
autoload -Uz promptinit
autoload -U colors && colors 
#promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Дополнение файла истории 
setopt  APPEND_HISTORY

# Игнорировать лишние пробелы 
setopt  HIST_IGNORE_SPACE

# Use modern completion system
autoload -Uz compinit
compinit

# correct 
#setopt CORRECT_ALL 
#SPROMPT="Correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort) "

# disable beeps 
unsetopt beep

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
export LS_COLORS='no=00;37:fi=00;37:di=01;36:ln=04;36:pi=33:so=01;35:do=01;35:bd=33;01:cd=33;01:or=31;01:su=37:sg=30:tw=30:ow=34:st=37:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.btm=01;31:*.sh=01;31:*.run=01;31:*.tar=33:*.tgz=33:*.arj=33:*.taz=33:*.lzh=33:*.zip=33:*.z=33:*.Z=33:*.gz=33:*.bz2=33:*.deb=33:*.rpm=33:*.jar=33:*.rar=33:*.jpg=32:*.jpeg=32:*.gif=32:*.bmp=32:*.pbm=32:*.pgm=32:*.ppm=32:*.tga=32:*.xbm=32:*.xpm=32:*.tif=32:*.tiff=32:*.png=32:*.mov=34:*.mpg=34:*.mpeg=34:*.avi=34:*.fli=34:*.flv=34:*.3gp=34:*.mp4=34:*.divx=34:*.gl=32:*.dl=32:*.xcf=32:*.xwd=32:*.flac=35:*.mp3=35:*.mpc=35:*.ogg=35:*.wav=35:*.m3u=35:';
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#===========================================#
# PageUp PageDown
# bindkeys 
bindkey '^[[A' up-line-or-search # up arrow for back-history-search 
bindkey '^[[B' down-line-or-search # down arrow for fwd-history-search 
bindkey '\e[1~' beginning-of-line # home 
bindkey '\e[2~' overwrite-mode # insert 
bindkey '\e[3~' delete-char # del 
bindkey '\e[4~' end-of-line # end 
bindkey '\e[5~' up-line-or-history # page-up 
bindkey '\e[6~' down-line-or-history # page-down
#===========================================#

# загружаем список цветов 
autoload colors && colors

# Установка атрибутов доступа для вновь создаваемых файлов 
umask 022

# создать директорию и перейти в нее 
mcd(){ mkdir $1; cd $1 }

#если текущая директория пустая, то удалить ее и перейти в родительскую директорию 
rcd(){ local P="`pwd`"; cd .. && rmdir "$P" || cd "$P"; }

# быстрое переименование 
name() {
	name=$1
	vared -c -p 'rename to: ' name
	command mv $1 $name
}

# распаковка архива 
ex () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)	tar xjf $1		 	;;
			*.tar.gz)	tar xzf $1			;;
			*.bz2)		bunzip2 $1			;;
			*.rar)		unrar x $1			;;
			*.gz)			gunzip $1			;;
			*.tar)		tar xf $1			;;
			*.tbz2)		tar xjf $1			;;
			*.tgz)		tar xzf $1			;;
			*.zip)		unzip $1				;;
			*.Z)			uncompress $1		;;
			*.7z)			7z x $1				;;
			*)				echo "я не в курсе как распаковать '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

arh () { 
	if [ $1 ]; then 
		case $1 in 
			tar.bz2)	tar -cjvf $2.tar.bz2 $2 ;; 
			tar.gz)	tar -czvf $2.tar.bz2 $2 ;; 
			tar.xz)	tar -cf - $2 | xz -9 -c - > $2.tar.xz ;; 
			bz2)		bzip $2 ;; 
			gz)		gzip -c -9 -n $2 > $2.gz ;; 
			tar)		tar cpvf $2.tar $2 ;; 
			tbz)		tar cjvf $2.tar.bz2 $2 ;; 
			tgz)		tar czvf $2.tar.gz $2 ;; 
			zip)		zip -r $2.zip $2 ;; 
			7z)		7z a $2.7z $2 ;; 
			*help)	echo "Usage: pack TYPE FILES" ;; 
			*)			echo "'$1' cannot be packed via pack()" ;; 
		esac 
	else 
		echo "'$1' is not a valid file" 

	fi 
}

# mp3 в нормальную кодировку 
mp32utf() { find -iname '*.mp3' -print0 | xargs -0 mid3iconv -eCP1251 --remove-v1 }

#конвертируем всякую дурь 
mpg2flv()	{ ffmpeg -i $1 -ar 22050 -ab 32 -f flv -s 320x240 `echo $1 | awk -F . '{print $1}'`.flv }
flv2xvid()	{ mencoder "$1" -vf scale=320:240  -ovc xvid -xvidencopts bitrate=250:autoaspect -vf pp=lb -oac mp3lame  -lameopts fast:preset=standard -o  "./basename $1.avi" }
flv2divx()	{ mencoder "$1" --vf scale=320:240  -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=250:mbd=2:v4mv:autoaspect -vf pp=lb -oac mp3lame  -lameopts fast:preset=standard -o  "./basename $1.avi" }

# top по имени процесса, правда только по полному 
pidtop() {htop -p `pidof $@ | tr ' ' ','`}

# мой айпишник 
myip() {lynx --source http://www.formyip.com/ |grep The | awk {'print $5'}}

# великий рандом для перемешивания строк в файле 
rand() { awk '{print rand()"\t"$0}'|sort|awk -F'\t' '{print $2}'}

# копипаст в консоли 
ccopy(){ cp $1 /tmp/ccopy.$1; }
alias cpaste="ls /tmp/ccopy.* | sed 's|/tmp/ccopy.||' | xargs -I % mv /tmp/ccopy.% ./%"

#поставить на запуск
xxx(){chmod +x $1 && ./$1}

#перейти в папку с выыодом
ccd() { cd $1  && ls -S --sort=extension  --color=auto}

#поиск в history
h() { grc cat ~/.zsh_history | grep $1 }

#===========================================#
#оформим подсветку в grep 
export GREP_COLOR="1;33"

alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'

alias reload='source ~/.zshrc && clear'
# переименование-перемещение c пogтвepжgeнueм без коррекции 
alias mv='nocorrect mv -i'
# рекурсивное копирование с подтверждением без коррекции 
alias cp='nocorrect cp -iR'
# удаление с подтверждением без коррекции 
alias rm='nocorrect rm -i'
# принудимтельное удаление без коррекции 
alias rmf='nocorrect rm -f'
# принудительное рекурсивное удаление без коррекции 
alias rmrf='nocorrect rm -fR'
# создание каталогов без коррекции 
alias mkdir='nocorrect mkdir'
# показ файлов в цвете 
alias ls='ls -S --sort=extension  --color=auto '
alias ll='ls -a -S --sort=extension --color=auto '
# создаем пароль из 6символов 
alias mkpass="head -c6 /dev/urandom | xxd -ps"

[[ -f /usr/bin/grc ]] && {
	alias ping="grc --colour=auto ping"
	alias traceroute="grc --colour=auto traceroute"
	alias make="grc --colour=auto make"
	alias diff="grc --colour=auto diff"
	alias cvs="grc --colour=auto cvs"
	alias netstat="grc --colour=auto netstat"
	alias logc="grc cat"
	alias logt="grc tail"
	alias logh="grc head"
	alias mount="grc mount"
	alias lll='grc ls -agh --sort=extension --time-style="+| %l:%M %d %b |"'
	alias	ps='grc ps'
}

#alias -s {avi,mpeg,mpg,mov,m2v,flv}=mplayer
#alias -s {zip,fb2}=fbless
#alias -s txt=$PAGER
#alias -s py=python3
#alias -s {ogg,mp3,wav,wma}=mplayer
#alias -s {xls,doc,,rtf,ppt,odt,sxw}=soffice
#alias -s {png,gif,jpg,jpeg}=feh
#alias -s {pdf,djvu}=evince

# глобальные алиасы 
alias -g H="| head"
alias -g T="| tail"
alias -g G="| grep"
alias -g L="| less"
alias -g M="| most"
alias -g B="&|"
alias -g HL="--help"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

#конвертим вывод в utf8, а то достало 
alias -g KU="| iconv -c -f koi8r -t utf8"
alias -g CU="| iconv -c -f cp1251 -t utf8"

#ну и обратно тоже 
alias -g UK="| iconv -c -f utf8 -t koi8r"
alias -g UC="| iconv -c -f utf8 -t cp1251"

alias apts='sudo aptitude search'
alias apti='sudo aptitude install'

alias gayscrotum='scrot -u poop.png && convert poop.png -set filename:magic '\''%wx%h_%b-%k_%i'\'' \( +clone -background black -shadow 100x4+0+0 \) +swap -background none -layers merge +repage '\''%[filename:magic]'\'' ; pngnq *_poop.png && rm *poop.png'

#===========================================#

CURRENT_BG='%{green}%'
SEGMENT_SEPARATOR=''

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$user"
  fi
#    prompt_segment black default "%(!.%{%F{yellow}%}.)$user|%m"
}

prompt_dir() {
  prompt_segment blue black '%~'
}

prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙ "

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

build_prompt() {
	RETVAL=$?
	prompt_status
	prompt_context
	prompt_dir
  prompt_end 
}

setopt PROMPT_SUBST
PROMPT='%{%f%b%k%}$(build_prompt) '

### END
