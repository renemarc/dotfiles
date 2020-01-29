# Cross-platform, cross-shell dotfiles

Universal command set and colourful shell configurations for Bash, Zsh and Powershell, compatible with macOS, Windows and (partially) Linux, and managed using [chezmoi](https://www.chezmoi.io/).

> One config set to rule them all!

## Supported toolset

Use either one of these or many, the config files will be in place and ready to provide a familiar interface.

### Shells

- Bash (extended with [Bash-It](https://github.com/Bash-it/bash-it)) on macOS.
- [PowerShell 5+](https://github.com/PowerShell/PowerShell) (extended with [Oh-My-Posh](https://github.com/JanDeDobbeleer/oh-my-posh), [WSL Interopt](https://github.com/mikebattista/PowerShell-WSL-Interop) and others) on macOS/Windows.
- Zsh (extended with [Oh-My-Zsh](https://ohmyz.sh/), [Powerlevel10K](https://github.com/romkatv/powerlevel10k) and others) on macOS.

### Terminals

- [Hyper](https://hyper.is/)
-  [iTerm](https://iterm2.com/)
-  [macOS Terminal](https://support.apple.com/en-ca/guide/terminal/welcome/mac)
- ⊞ [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal-preview/9n0dx20hk701?activetab=pivot:overviewtab)

### Package managers

-  [Homebrew](https://brew.sh/)
- ⊞ [Scoop](https://scoop.sh/)

## Cross-shell compatibility matrix

These are unified CLI commands available amongst different shells on all platforms. While some of their outputs may differ in style between different environments, their usage and behaviours remain universal.

Additional aliases are provided by Bash-It, Oh-My-Zsh and Powershell, and are listed by using the command `alias`.

### Easier navigation

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅ | `~`      | Go to user home directory.
| ✅   | ⚠️         | ✅ | `cd-`    | Go to last used directory.
| ✅   | ✅         | ✅ | `..`<br>`cd..` | Go up a directory.
| ✅   | ✅         | ✅ | `...`    | Go up two directories.
| ✅   | ✅         | ✅ | `....`   | Go up three directories.
| ✅   | ✅         | ✅ | `.....`  | Go up four directories.


### Directory browsing

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `l`     | List visible files in long format.
| ✅   | ✅         | ✅  | `ll`    | List all files in long format, excluding `.` and `..`.
| ✅   | ✅         | ✅  | `lsd`    | List only directories in long format.
| ✅   | ✅         | ✅  | `lsh`   | List only hidden files in long format.


### File management

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `cpv`   | Copy a file securely.
| ✅   | ✅         | ✅  | `fd`    | Find directory.
| ✅   | ✅         | ✅  | `ff`    | Find file.
| ❌   | ✅         | ❌  | `mirror` | Mirror directories.


### General aliases

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ❌         | ✅  | `alias` | List aliases.
| ✅   | ✅         | ✅  | `c`     | Clear screen.
| ✅   | ✅         | ✅  | `h`     | Display/Search global history.<br>_Usage: `h`_<br>_Usage: `h cd`_
| ✅   | ✅         | ❌  | `hs`    | Display/Search session history.<br>_Usage: `hs`_<br>_Usage: `hs cd`_
| ✅   | ❌         | ❔  | `reload` | Reload the shell.
| ✅   | ❌         | ❔  | `resource` | Reload configuration.


### General commands

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ❌         | ❔  | `extract`<br>`x` | Extract common file formats.
| ✅   | ✅         | ✅  | `mkcd`<br>`take` | Create directory and change to it.
| ✅   | ✅         | ✅  | `repeat`<br>`r` | Repeat a command `x` times.<br>_Usage: `repeat 5 echo hello`_.


### Time

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `now`<br>`unow` | Display local/UTC date and time in [ISO 8601](https://xkcd.com/1179/) format `YYYY-MM-DDThh:mm:ss`.
| ✅   | ✅         | ✅  | `nowdate`<br>`unowdate` | Display local/UTC date in `YYYY-MM-DD` format.
| ✅   | ✅         | ✅  | `nowtime`<br>`unowtime` | Display local/UTC time in `hh:mm:ss` format.
| ✅   | ✅         | ✅  | `timestamp` | Display Unix time stamp.
| ✅   | ✅         | ✅  | `week`  | Display week number in [ISO 9601](https://en.wikipedia.org/wiki/ISO_8601#Week_dates) format `YYYY-Www`.
| ✅   | ✅         | ✅  | `weekday` | Display weekday number.


### Networking

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ❌         | ❌  | `fastping` | Ping 100 times without waiting 1 second between ECHO_REQUEST packets.
| ✅   | ✅         | ✅  | `flushdns` | Flush the DNS cache.
| ❌   | ❌         | ❌  | `ifactive` | Show active network interfaces.
| ✅   | ✅         | ✅  | `ip`    | Get external IP address.
| ✅   | ✅         | ✅  | `ips`   | Get all IP addresses.
| ✅   | ✅         | ✅  | `localip` | Get local IP address.
| ✅   | ✅         | ✅  | `GET`<br>`HEAD`<br>`POST`<br>`PUT`<br>`DELETE`<br>`TRACE`<br>`OPTIONS` | Send HTTP requests.<br>_Usage: `GET http://example.com`_


### Power management

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `hibernate` | Go to sleep.
| ✅   | ✅         | ✅  | `lock`  | Lock the session.
| ✅   | ✅         | ✅  | `poweroff` | Shut down the system.
| ✅   | ✅         | ✅  | `reboot` | Restart the system.


### Sysadmin

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `mnt`   | List drive mounts.
| ✅   | ✅         | ✅  | `path`  | Print each `$PATH` entry on a separate line.
| ✅   | ✅         | ❔  | `update` | Keep all apps and packages up to date.


### Applications

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `browse` | Open file/URL in default browser.<br>_Usage: `open http://example.com`_
| ✅   | ✅         | ✅  | `chrome` | Open file/URL in [Chrome](https://www.google.com/chrome/).
| ✅   | ✅         | ✅  | `edge` | Open file/URL in [Microsoft Edge](https://www.microsoft.com/en-us/edge).
| ✅   | ✅         | ✅  | `firefox` | Open file/URL in [Firefox](https://www.mozilla.org/en-CA/firefox/).
| ❔   | ✅         | ❔  | `iexplore` | Open file/URL in [Internet Explorer](https://www.microsoft.com/ie). ⊞
| ✅   | ✅         | ✅  | `opera` | Open file/URL in [Opera](https://www.opera.com/).
| ✅   | ✅         | ✅  | `safari` | Open file/URL in [Safari](https://www.apple.com/ca/safari/). 
| ✅   | ✅         | ⚠️  | `ss`    | Enter the [Starship 🚀](https://starship.rs) cross-shell prompt.
| ⚠️   | ✅         | ⚠️  | `subl`<br>`st`  | Open in [Sublime Text](https://www.sublimetext.com/).


### Development

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `dk`    | 🐳 Alias for [`docker`](https://www.docker.com/).
| ✅   | ✅         | ✅  | `dco`   | 🐳 Alias for [`docker-compose`](https://docs.docker.com/compose/).
| ✅   | ✅         | ✅  | `g`     | :octocat: Alias for [`git`](https://git-scm.com/).
| ✅   | ✅         | ✅  | `va`    | 🐍 Python: activate [virtual environment venv](https://docs.python.org/3/tutorial/venv.html).
| ✅   | ✅         | ✅  | `ve`    | 🐍 Python: create [virtual environment venv](https://docs.python.org/3/tutorial/venv.html).


###  macOS

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `hidedesktop`<br>`showdesktop` | Toggle display of desktop icons.
| ✅   | ✅         | ✅  | `hidefiles`<br>`showfiles` | Toggle hidden files display in [Finder](https://support.apple.com/en-ca/HT201732).
| ✅   | ✅         | ✅  | `spotoff`<br>`spoton` | Toggle [Spotlight](https://support.apple.com/en-ca/HT204014).

### ⊞ Windows

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ❔   | ✅         | ❔  | `hidefiles`<br>`showfiles` | Toggle hidden files display in [File Explorer](https://support.microsoft.com/en-ca/help/4026617/windows-10-windows-explorer-has-a-new-name).


### Common paths

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `dl`    | Go to `~/Downloads`.
| ✅   | ✅         | ✅  | `docs`  | Go to `~/Documents`.
| ✅   | ✅         | ✅  | `dt`    | Go to `~/Desktop`.


### Configuration paths

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `chezmoiconf` | Go to [Chezmoi](https://www.chezmoi.io/)'s local configuration repo.
| ✅   | ✅         | ✅  | `sublimeconf` | Go to [Sublime Text](https://www.sublimetext.com/)'s local configuration repo.


### Custom paths

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `archives` | Go to `~/Archives`.
| ✅   | ✅         | ✅  | `repos` | Go to `~/Code`.


### Varia

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ❔   | ❌         | ❔  | `hd`    | Canonical hex dump.
| ✅   | ❌         | ✅  | `md5sum` | Calculate 128-bit MD5 sum hashes.
| ✅   | ❌         | ✅  | `sha`   | Calculate SHA sum hashes.
| ✅   | ❌         | ✅  | `sha1`  | Calculate SHA1 hashes.
| ✅   | ❌         | ✅  | `sha1sum` | Calculate SHA1 sum hashes.
| ❔   | ❌         | ❔  | `mergepdf` | Merge PDF files, preserving hyperlinks.


## Inspirations

- [Digital Ocean: What are your favorite bash aliases?](https://www.digitalocean.com/community/questions/what-are-your-favorite-bash-aliases)
- [GitHub: Jay Harris' Windows dotfiles](https://github.com/jayharris/dotfiles-windows)
- [GitHub: Jan Moesen's dotfiles](https://github.com/janmoesen/tilde)
- [GitHub: Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
- [nixCraft: 30 Handy Bash Shell Aliases For Linux / Unix / Mac OS X](https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html)
