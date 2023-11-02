echo 'hi bash start'
export OVERLAY_VM_FILES=1
export ENABLE_ACTIONS=1
export CODE_DIR='/Users/gdryke/code'
export WORK_DIR='/Users/gdryke/work'

alias rr='cd $CODE_DIR'
alias myip='curl ipecho.net/plain ; echo'

alias dev-ssh='minikube -p actions-dev ssh'
alias dev-start='vmrun start /Users/gdryke/.minikube/machines/actions-dev/actions-dev.vmx'
alias dev-stop='vmrun stop /Users/gdryke/.minikube/machines/actions-dev/actions-dev.vmx'

#alias bpdev='ssh -A build@gdryke-3b97aa63c.service.bpdev-us-east-1.github.net'
alias bpdev='ssh -A build@gdryke-3bbf1ef29.service.bpdev-us-east-1.github.net'
## GHES Aliases, specifically HA
alias ghes-ha-clean='./chroot-cluster-stop.sh && ./chroot-cluster-reset.sh test/cluster-ha.conf'
export ENABLE_ACTIONS=1
alias all='./chroot-stop.sh && ./chroot-reset.sh && ./chroot-build.sh && ./chroot-start.sh && ./chroot-configure.sh'

# open note setup, uses VSCODE/Drive
alias note='code /Users/gdryke/personal/notes/notes.code-workspace'

alias weather='curl wttr.in'

export HISTSIZE=10000000
export HISTFILESIZE=10000000

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
LBLUE='\033[1;34m'
LGREEN='\033[1;32m'
# all colors
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
NC='\033[0m' # No Color

# Mac only stuff
if [ "Darwin" == "$(uname)" ]
then
    alias ls='ls -G'
fi

tip_file="~/terminal-tips.md"    # doesn't actually work now without ~ expansion...
function echo_tip() {
    tips=$(cat ~/terminal-tips.md | grep '^*')
    tip_count=$(echo "$tips" | wc -l)
    line=$[RANDOM%5+1]
    echo "$tips" | sed -n $line"p"
}

if [ -e ~/terminal-tips.md ]
then
  tip=$(echo_tip)
  echo "Tip of the terminal:"
  echo "*$tip **"
fi

# below is from: http://ezprompt.net/

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function set_actions_docker {
    export DOCKER_TLS_VERIFY=1
    export DOCKER_HOST=tcp://172.16.141.129:2376
    export DOCKER_CERT_PATH=/Users/gdryke/.minikube/certs
}

export PS1="\`parse_git_branch\`[\t] \W \`nonzero_return\`\\$ "

export EDITOR=vim

# az cli Sub stuff
alias set-actions-sub="az account set -s 'PE-Actions-Plaform-Test'"
alias set-ghae-sub="az account set -s 'GHPI Dev 1'"

alias runnertest="ssh -i ~/.ssh/id_runnertest2 -p 122 admin@20.80.144.9"

function checkAzureSupport() {
ticket=$1
ticket='2103260010002042'
# TODO get token from here: cat ~/.azure/accessTokens.json  | jq
# And if it expires, refresh and regrab with `az account list --output none` (I think)
token=$(cat ~/.azure/accessTokens.json  | jq -r 'last(.[] | select(.userId == "grdry@microsoft.com" and .resource == "https://management.core.windows.net/")).accessToken')
auth="Bearer $token"

curl -s "https://management.azure.com/subscriptions/32f750d1-2a53-4792-a857-b5a0ee599f96/providers/Microsoft.Support/supportTickets/$ticket?api-version=2015-03-01" \
  -H 'x-ms-client-session-id: ffdcdc05ff9041218b267bb3c7d0fb2c' \
  -H 'x-ms-command-name: Microsoft_Azure_Support.' \
  -H 'Accept-Language: en' \
  -H "Authorization: $auth" \
  -H 'x-ms-effective-locale: en.en-us' \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'GetOperationType: GetTicketDetailsOnly' \
  -H 'x-ms-client-request-id: ba0d000f-01d5-43ef-b67c-4b8269f13003' \
  -H 'Referer: ' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36' \
  --compressed | jq .properties.supportRequest.status
}

function getShasFromBuild() {
grep 'digest: sha' ~/docs/raw_adn_docker_build.txt | awk -F' ' '{print $2; print $4}'
}

alias gp-off="launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias gp-on="launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias '??'='github-copilot-cli what-the-shell'

function reminder() {
sleep $1 && open raycast://confetti && osascript -e "tell app \"System Events\" to display alert \"$2\""
}

# only works on mac as is
function kusto-link() {
content=$(pbpaste)

link=$(echo "$content" | head -1)
echo $link
echo $link | grep -q "dataexplorer.azure.com"
if [ $? -ne 0 ]; then
    echo "First line does not appear to be a Kusto link, exiting"
    echo '\t'"$link"
    return
fi
echo "dumping formatted query"

body=$(echo "$content" | tail -n +3)
printf '```\n%s\n```\n[link](%s\n)\n' "$body" "$link" | pbcopy
}


echo 'Hi bash end'
