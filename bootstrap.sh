#!/bin/bash
#	* bootstrap machine in order to prepare for ansible playbook run 
set -e

# Download and install Command Line Tools if no developer tools exist
#       * previous evaluation didn't work completely, due to gcc binary existing for vanilla os x install
#       * gcc output on vanilla osx box:
#       * 'xcode-select: note: no developer tools were found at '/Applications/Xcode.app', requesting install.
#       * Choose an option in the dialog to download the command line developer tools'
#
# Evaluate 2 conditions
#       * ensure dev tools are installed by checking the output of gcc
#       * check to see if gcc binary even exists ( original logic )
# if either of the conditions are met, install dev tools
if [[ $(/usr/bin/gcc 2>&1) =~ "no developer tools were found" ]] || [[ ! -x /usr/bin/gcc ]]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
fi

# Download and install Homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Info   | Install   | homebrew"
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

# Download and install Ansible
if [[ ! -x /usr/local/bin/ansible ]]; then
    echo "Info   | Install   | Ansible"
    brew update
    brew install python
    pip install ansible==1.9.4
fi

# Download and install Mas for AppStore Automation
if [[ ! -x /usr/local/bin/mas ]]; then
    echo "Info   | Install   | Mas"
    brew install mas
fi

# Download and install Java
if [[ ! -x /usr/bin/java ]]; then
    echo "Info   | Install   | Java"
    brew tap caskroom/cask
    brew cask install java
fi

# Modify the PATH
# This should be subsequently updated in shell settings
export PATH=/usr/local/bin:$PATH

ansible-playbook desktop.yml -K -e "appleid=$APPLE_ID applepass=$APPLE_PASS"
