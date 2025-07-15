#
# ~/.bash_profile
#

# Additional $PATH locations

export PATH="$PATH:~/.local/bin"
export NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export ELECTRON_OZONE_PLATFORM_HINT=auto
export PATH="$PATH:/home/$USER/.dotnet/tools"

# Run bashrc

[[ -f ~/.bashrc ]] && . ~/.bashrc
