# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/container_user/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/container_user/conda/etc/profile.d/conda.sh" ]; then
        . "/home/container_user/conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/container_user/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

