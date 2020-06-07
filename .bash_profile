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

## GHES Aliases, specifically HA
alias ghes-ha-clean='/chroot-cluster-stop.sh && ./chroot-cluster-reset.sh test/cluster-ha.conf'

export HISTSIZE=10000000
export HISTFILESIZE=10000000

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

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

export PS1="\`parse_git_branch\`[\t] \W \`nonzero_return\`\\$ "

echo 'Hi bash end'
