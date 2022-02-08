
* * *

# Shell Integration

iTerm2 may be integrated with the unix shell so that it can keep track of your command history, current working directory, host name, and more—even over ssh. This enables several useful features.

### How To Enable Shell Integration

The easiest way to install shell integration is to select the _iTerm2>Install Shell Integration_ menu item. It will download and run a shell script as described below. You should do this on every host you ssh to as well as your local machine. The following shells are supported: tcsh, zsh, bash, and fish 2.3 or later. Contributions for other shells are most welcome.

When you select the _iTerm2>Install Shell Integration_ menu item, it types this for you:

curl -L https://iterm2.com/misc/install\_shell\_integration.sh | bash

Don't care for piping curl to bash? Do it by hand. This is also what you must do if you use a shell that isn't your login shell. Select your shell to see the appropriate instructions:

 |  |  | 

curl -L https://iterm2.com/shell\_integration/bash \\
-o ~/.iterm2\_shell\_integration.bash
Next, you need to load the script at login time. You need to add the following command to ~/.bash\_profile or ~/.profile. If you already have .profile then add it there, otherwise add it to .bash\_profile. Put it at the end because other scripts may overwrite the settings it needs, such as \`PROMPT\_COMMAND\`.
source ~/.iterm2\_shell\_integration.bash

Don't want to or can't install a login script? See the workaround at the end of this document using triggers.

### Features

Shell Integration enables numerous features:

#### Marks

These are saved locations in history. They make it easy to navigate to previous shell prompts or other locations of interest.

#### Alert when current command finishes running.

iTerm2 will present a modal alert when a long-running command finishes, if you ask it to.

#### View information about commands.

You can see the return status code, working directory, running time, and more for shell commands entered at the prompt in the past.

#### Download files from remote hosts with a click.

You can right click on a filename (e.g., in the output of _ls_) to download it.

#### Drag-drop files to upload with scp.

Hold down option and drag-drop a file from Finder into iTerm2 to upload it.

#### View command history.

It can be seen and searched in the toolbelt or quickly accessed in a popup window.

#### Easy access to recently and frequently used directories.

iTerm2 remembers the directories you use, sorting them by "frecency" and giving you access to them in the toolbelt and in a popup window.

#### Assign profiles to hostnames, usernames, or username+hostname combinations.

Sessions will automatically switch profiles as you log in and out according to rules you define.

#### Ensures the command prompt always starts at the left column, even when the last command didn't end in a newline.

Each of these features are described in more detail below.

### How it works

Shell Integration works by configuring your shell on each host you log into to send special escape codes that convey the following information:

*   Where the command prompt begins and ends.
*   Where a command entered at the command prompt ends and its output begins.
*   The return code of the last-run command.
*   Your username.
*   The current host name.
*   The current directory.

### How to use it

#### Marks

When shell integration is enabled, iTerm2 automatically adds a mark at each command prompt. Marks are indicated visually by a small blue triangle in the left margin.

![[8知识管理/InBox/evernote/参考/_resources/Shell_Integration_-_Documentation_-_iTerm2_-_macOS_Terminal_Replacement.resources/unknown_filename.3.png]]

You can navigate marks with Cmd-Shift-Up and Down-arrow keys.

If you have a multi-line prompt and would like to customize the mark's location, add this to your PS1 at the location where the mark should appear:

For zsh:

%{$(iterm2\_prompt\_mark)%}

For bash:

\\\[$(iterm2\_prompt\_mark)\\\]

Fish users can place this line somewhere in their fish\_prompt function:

iterm2\_prompt\_mark

This feature is not supported in tcsh.

For zsh and bash users: if you are unable to modify PS1 directly (for example, if you use a zsh theme that wants to control PS1), you must take an extra step. Add `export ITERM2_SQUELCH_MARK=1` before the shell integration script is sourced. Add the `iterm2_prompt_mark` as directed above to your prompt through those means available to you.

#### Alert on next mark

iTerm2 can show an alert box when a mark appears. This is useful when you start a long-running command. Select _Edit>Marks and Annotations>Alert on next mark_ (Cmd-Opt-A) after starting a command, and you can go do something else in another window or tab. When the command prompt returns, a modal alert will appear, calling attention to the finished job.

![[8知识管理/InBox/evernote/参考/_resources/Shell_Integration_-_Documentation_-_iTerm2_-_macOS_Terminal_Replacement.resources/unknown_filename.4.png]]

#### Command status

The mark on a command line will turn red if a command fails. You can right click the mark to view its return code.

![[8知识管理/InBox/evernote/参考/_resources/Shell_Integration_-_Documentation_-_iTerm2_-_macOS_Terminal_Replacement.resources/unknown_filename.png]]

#### Download with scp

You can right-click on a filename (e.g., in the output of _ls_) and select _Download with scp from_ hostname\*\*, and iTerm2 will download the file for you.

![[unknown_filename.5.png]]

A new menu bar item will be added called _Downloads_ that lets you view downloaded files and track their progress.

![[8知识管理/InBox/evernote/参考/_resources/Shell_Integration_-_Documentation_-_iTerm2_-_macOS_Terminal_Replacement.resources/unknown_filename.1.png]]

#### Upload with scp

If you drop a file (e.g., from Finder) into iTerm2 while holding the option key, iTerm2 will offer to upload the file via scp to the remote host into the directory you were in on the line you dropped the file on. A new menu bar item will be added called _Uploads_ that lets you view uploaded files and track their progress.

#### Command history

With shell integration, iTerm2 can track your command history. The command history is stored separately for each username+hostname combination. There are four places where this is exposed in the UI:

##### Command history popup

You can view and search the command history with _Session>Open Command History..._ (Shift-Cmd-;).

##### Autocomplete

Commands in command history are also added to Autocomplete (Cmd-;). If _Preferences>General>Save copy/paste history and command history to disk_ is enabled, then command history will be preserved across runs of iTerm2 (up to 200 commands per user/hostname).

##### Toolbelt

A command history tool may be added to the toolbelt by selecting _Toolbelt>Command History_.

![[8知识管理/InBox/evernote/参考/_resources/Shell_Integration_-_Documentation_-_iTerm2_-_macOS_Terminal_Replacement.resources/unknown_filename.2.png]]

Bold commands are from the current session. Clicking on one will scroll to reveal it. Double-clicking enters the command for you. Option-double-clicking will output a "cd" command to go to the directory you were in when it was last run.

##### Command Completion

iTerm2 will present command completion suggestions automatically when _View>Auto Command Completion_ is selected.

#### Recent Directories

With shell integration, iTerm2 will remember which directories you have used recently. The list of preferred directories is stored separately for each username+hostname combination. It is sorted by "frecency" (frequency and recency of use). There are two places it is exposed in the UI:

##### Recent Directories popup

You can view and search your recently and frequently used directories in _Session>Open Recent Directories..._ (Cmd-Opt-/).

##### Toolbelt

A _Recent Directories_ tool may be added to the toolbelt by selecting _Toolbelt>Recent Directories_. ![[unknown_filename.6.png]]

Double-clicking a directory will type its path for you into the current terminal. Option-double-click will enter a "cd" command for you. You can also right-click on a directory to toggle its "starred" status. A starred directory will always appear at the bottom of the list so it is easy to find.

#### Automatic Profile Switching

Please see the documentation at [Automatic Profile Switching](https://iterm2.com/automatic-profile-switching.html).

#### Shell Integration for root

If you'd like to be able to use shell integration as root, you have two options. The first option, presuming you use bash, is to become root with `sudo -s` (which loads your `.bashrc` as root) and add this to your `.bashrc`:

test $(whoami) == root && source "${HOME}/.iterm2\_shell\_integration.bash"

The alternative is to use Triggers to emulate shell integration as described in the following section.

#### Triggers

For some users, installing a login script on every host they connect to is not an option. To be sure, modifying root's login script is usually a bad idea. In these cases you can get the benefits of shell integration by defining triggers. The following triggers are of interest:

*   Report User & Host
*   Report Directory
*   Prompt Detected

Use these triggers to tell iTerm2 your current username, hostname, and directory. Suppose you have a shell prompt that looks like this:

george@example.com:/home/george%

It exposes the username, hostname, and working directory. We can harvest those with a regular expression. First, define a trigger with this regex:

^(\\w+)@(\[\\w.\]+):.+%

It captures the username and hostname from the example prompt above. Select the action "Report User & Host". Set the trigger's parameter to:

\\1@\\2

Then create another trigger with the action _Report Directory_. This regular expression will extract the directory from the example prompt:

^\\w+@\[\\w.\]+:(\[^%\]+)%

Set this trigger's parameter to

\\1

Make sure both triggers have their _Instant_ checkbox enabled so they'll take effect before a newline is received.

Finally, add a regular expression that matches the start of your prompt and give the "Prompt Detected" action. This causes a "mark" to be added, which is a blue triangle visible to the left of this line. You can navigate from mark to mark with Cmd-Shift-Up/Down Arrow.

You may specify a user name or host name alone to _Report Host & User_. If you give just a user name then the previous host name will be preserved; if you give just a host name then the previous user name will be preserved. To change the user name only, give a parameter like `user@`. To change the host name only, give a parameter like `example.com`.

### Limitations

Shell Integration does not work with tmux or screen.

#### A Note on SCP

iTerm2 can do uploads and downloads with scp as described above. There are a few things you should know.

iTerm2 links in libssh2, and does not shell out to scp. It respects /etc/known\_hosts and ~/.ssh/known\_hosts, and will update the latter file appropriately. Host fingerprints are verified. Password, keyboard-interactive, and public-key authentication are supported. Private keys by default come from ~/.ssh/id\_rsa, id\_dsa, or id\_ecdsa, and may be encrypted with an optional passphrase.

iTerm2 respects ssh\_config files, but only a subset of the commands are understood:

*   Host
*   HostName
*   User
*   Port
*   IdentityFile

Settings pulled from ssh\_config override the hostname and user name provided by shell integration. The shell integration-provided host name is used as the text against which _Host_ patterns are matched.

The following files are parsed as ssh\_config files, in order of priority:

*   ~/Library/Application Support/iTerm/ssh\_config
*   ~/.ssh/config
*   /etc/ssh\_config

The scp code is relatively new. If you are in a high-security environment, please keep this in mind.

    Created at: 2019-08-27T10:28:14+08:00
    Updated at: 2019-08-27T10:28:14+08:00

