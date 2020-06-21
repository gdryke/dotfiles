echo 'hi bash start'
export OVERLAY_VM_FILES=1
export ENABLE_ACTIONS=1
export CODE_DIR='/Users/gdryke/code'
export WORK_DIR='/Users/gdryke/work'

alias dev-ssh='minikube -p actions-dev ssh'
alias dev-start='vmrun start /Users/gdryke/.minikube/machines/actions-dev/actions-dev.vmx'
alias dev-stop='vmrun stop /Users/gdryke/.minikube/machines/actions-dev/actions-dev.vmx'
alias rr='cd $CODE_DIR'
alias myip='curl ipecho.net/plain ; echo'
echo 'Hi bash end'
