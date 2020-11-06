# Shell scripts
This is a collection of useful shell scripts for an OSX/\*NIX environment.

## Info
### extract
Extract multiple file archive types.
### get-java-version
Returns a minimal Java version number (1.8 -> 8, 11 -> 11, etc)
### gi
Generate a .gitignore file, using [gitignore.io](https://www.gitignore.io/)
### git-recreate-branch
Delete and recreate a branch in git.
### incognito
Start a bash session without a loaded profile .
### my-ip
Print my IP address.
### notif
Display a notification in OSX.
### phone-battery
Print the connected Android phone's battery level using ADB.
### pull-all
Pull changes from multiple repositories.
### ql
Open a file in Quicklook mode (OSX only).
### serve
Start a python server from the specified repository.
### set-title
Set the terminal's window title.
### weather
Fetch the weather for a specified location, using [wttr.in](http://wttr.in).

## Dependencies
 - .profile
   - [homebrew](https://brew.sh/) with [bash completion](https://github.com/scop/bash-completion) (not needed if \_\_git\_ps1 is installed)
 - phone-battery
   - [ADB](https://developer.android.com/studio/command-line/adb.html)
