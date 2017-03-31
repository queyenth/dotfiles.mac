source "${HOME}/zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save"

  zgen oh-my-zsh

  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/git-extras
  zgen oh-my-zsh plugins/mercurial
  zgen oh-my-zsh plugins/bower
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/brew
  zgen oh-my-zsh plugins/osx
  zgen oh-my-zsh plugins/composer
  zgen oh-my-zsh plugins/common-aliases
  zgen oh-my-zsh plugins/docker

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-completions src
  zgen load supercrabtree/k

  zgen load denysdovhan/spaceship-zsh-theme spaceship

  zgen save
fi

streaming() {
     INRES="1920x1080" # input resolution
     OUTRES="1920x1080" # output resolution
     FPS="25" # target FPS
     GOP="50" # i-frame interval, should be double of FPS, 
     GOPMIN="25" # min i-frame interval, should be equal to fps, 
     THREADS="2" # max 6
     CBR="1000k" # constant bitrate (should be between 1000k - 3000k)
     QUALITY="ultrafast"  # one of the many FFMPEG preset
     AUDIO_RATE="44100"
     STREAM_KEY="$1" # use the terminal command Streaming streamkeyhere to stream your video to twitch or justin
     SERVER="live-fra" # twitch server in frankfurt, see http://bashtech.net/twitch/ingest.php for list
     
     ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f alsa -i pulse -f flv -ac 2 -ar $AUDIO_RATE \
       -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p\
       -s $OUTRES -preset $QUALITY -tune film -acodec libmp3lame -threads $THREADS -strict normal \
       -bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"
}

alias rec="ffmpeg -f x11grab -video_size 1920x1080 -i :0 -f alsa -i default -c:v ffvhuff -c:a flac $1"
alias enc_to_webm="ffmpeg -i $1 -acodec libvorbis -aq 7 -ac 2 -qmax 30 -threads 2 $2"
alias grep="grep --color=auto --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn"
alias docker-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1"
alias tg='ntfy -b telegram done'
alias dk='docker'
alias dkc='docker-compose'
alias dkm='docker-machine'
alias dki='eval $(docker-machine env bibika)'
alias ls="gls --color=auto --group-directories-first"
alias date="gdate"
alias br="brew"
alias bru="brew update && brew upgrade && brew cleanup"
alias brc="brew cask"

export GREP_OPTIONS=""
export EDITOR="vim"
export HOMEBREW_GITHUB_API_TOKEN=''
export PATH=$PATH:~/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
