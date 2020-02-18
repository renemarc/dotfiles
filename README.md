<h1 align="center">
  <a name="top" title="dotfiles">~/.&nbsp;📂</a><br/>Cross-platform, cross-shell dotfiles<br/> <sup><sub>powered by  <a href="https://www.chezmoi.io/">chezmoi</a> 🏠</sub></sup>
</h1>

Universal command set and colourful shell configurations for Bash, Zsh and Powershell, compatible with macOS, Windows and (partially) Linux, all managed easily using [chezmoi](https://github.com/twpayne/chezmoi).

<div align="center">
    <p><strong>Be sure to <a href="#" title="star">⭐️</a> or <a href="#" title="fork">🔱</a> this repo if you find it useful! 😃</strong></p>
</div>

## Project goals ⚽

- Unified set of aliases and commands.
- Familiar feel and creature comforts across environments.
- Cross-platform file management toolset.
- Easy access to common paths.
- Shortcuts to popular cross-platform apps.
- System-agnostic `update` and `dotfiles` install commands.
- A pretty interface! 💃

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Supported toolset 🛠️

Use either one or many of these, the config files will be in place and ready to provide a familiar interface.

### 🐚 Shells

- [Bash](https://www.gnu.org/software/bash/) <sub><sup><b title="Linux">🐧</b></sup></sub><b title="macOS"></b>, enhanced with [Bash-It](https://github.com/Bash-it/bash-it).
- [PowerShell 5.1+](https://github.com/PowerShell/PowerShell) <sub><sup><b title="Linux">🐧</b></sup></sub><b title="macOS"></b><b title="Windows">⊞</b>, enhanced with [Oh-My-Posh](https://github.com/JanDeDobbeleer/oh-my-posh), [Terminal Icons](https://github.com/devblackops/Terminal-Icons), [WSL Interopt](https://github.com/mikebattista/PowerShell-WSL-Interop), and others.
- [Z shell](http://zsh.sourceforge.net/) <sub><sup><b title="Linux">🐧</b></sup></sub><b title="macOS"></b>, enhanced with [Oh-My-Zsh](https://ohmyz.sh/), [Powerlevel10K](https://github.com/romkatv/powerlevel10k), and others.

### 💻 Terminals

- [Hyper](https://hyper.is/) <sub><sup><b title="Linux">🐧</b></sup></sub><b title="macOS"></b><b title="Windows">⊞</b>
- [iTerm2](https://iterm2.com/) <b title="macOS"></b>
- [macOS Terminal](https://support.apple.com/en-ca/guide/terminal/welcome/mac) <b title="macOS"></b>
- [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal-preview/9n0dx20hk701) <b title="Windows">⊞</b>

### 📦 Package managers

- [Homebrew](https://brew.sh/) <b title="macOS"></b>
- [Scoop](https://scoop.sh/) <b title="Windows">⊞</b>

### 💾 Universal apps <sup><sub><b title="Linux">🐧</b></sub></sup><b title="macOS"></b><b title="Windows">⊞</b>

- [chezmoi](https://www.chezmoi.io/) dotfiles manager.
- [Git](https://git-scm.com/) version-control system.
- [GNU Wget](https://www.gnu.org/software/wget/) HTTP/FTP file downloader.
- [OpenSSH](https://www.openssh.com/) secure networking utilities.
- [Ripgrep](https://github.com/BurntSushi/ripgrep) fast-search tool.
- [SQLite3](https://www.sqlite.org/cli.html) database client.
- [Starship 🚀](https://starship.rs) cross-shell prompt.
- [tmux](https://github.com/tmux/tmux/wiki) terminal multiplexer, enhanced with [Oh-My-Tmux](https://github.com/gpakosz/.tmux).

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Cross-shell compatibility matrix 🏁

These are unified CLI commands available amongst different shells on all platforms. While some of their outputs may differ in style between different environments, their usage and behaviours remain universal.

Additional aliases are provided by [Bash-It](https://github.com/Bash-it/bash-it/tree/master/aliases/available), [Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet) and [Powershell](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_aliases), and are listed by using the command `alias`.

System-specific aliases are marked with <b title="macOS"></b>, <b title="Windows">⊞</b>, or <sub><sup><b title="Linux">🐧</b></sup></sub>.

### 🧭 Easier navigation

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅ | `~`      | Navigates to user home directory.
| ✅   | ✅         | ✅ | `cd-`    | Navigates to last used directory.
| ✅   | ✅         | ✅ | `..`<br>`cd..` | Navigates up a directory.
| ✅   | ✅         | ✅ | `...`    | Navigates up two directories.
| ✅   | ✅         | ✅ | `....`   | Navigates up three directories.
| ✅   | ✅         | ✅ | `.....`  | Navigates up four directories.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🗂️ Directory browsing

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `l`     | Lists visible files in long format.
| ✅   | ✅         | ✅  | `ll`    | Lists all files in long format, excluding `.` and `..`.
| ✅   | ✅         | ✅  | `lsd`    | Lists only directories in long format.
| ✅   | ✅         | ✅  | `lsh`   | Lists only hidden files in long format.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🗄️ File management

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `cpv`   | Copies a file securely.
| ✅   | ✅         | ✅  | `fd`    | Finds directories.
| ✅   | ✅         | ✅  | `ff`    | Finds files.
| ❌   | ✅         | ❌  | `mirror` | Mirrors directories.
| ✅   | ✅         | ✅  | `rg`    | Searches recursively with [ripgrep](https://github.com/BurntSushi/ripgrep).

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 💡 General aliases

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `alias` | Lists aliases.
| ✅   | ✅         | ✅  | `c`     | Clears the console screen.
| ✅   | ❌         | ✅  | `extract`<br>`x` | Extracts common file formats.<br>_Usage: `extract solarized.zip`_
| ✅   | ✅         | ✅  | `h`     | Displays/Searches global history.<br>_Usage: `h`_<br>_Usage: `h cd`_
| ✅   | ✅         | ⚠️  | `hs`    | Displays/Searches session history.<br>_Usage: `hs`_<br>_Usage: `hs cd`_
| ✅   | ✅         | ✅  | `mkcd`<br>`take` | Creates directory and change to it.<br>_Usage: `mkcd foldername`_
| ✅   | ❌         | ✅  | `reload` | Reloads the shell.
| ✅   | ✅         | ✅  | `repeat`<br>`r` | Repeats a command `x` times.<br>_Usage: `repeat 5 echo hello`_.
| ✅   | ❌         | ✅  | `resource` | Reloads configuration.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🕙 Time

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `now`<br>`unow` | Gets local/UTC date and time in [ISO 8601](https://xkcd.com/1179/) format `YYYY-MM-DDThh:mm:ss`.
| ✅   | ✅         | ✅  | `nowdate`<br>`unowdate` | Gets local/UTC date in `YYYY-MM-DD` format.
| ✅   | ✅         | ✅  | `nowtime`<br>`unowtime` | Gets local/UTC time in `hh:mm:ss` format.
| ✅   | ✅         | ✅  | `timestamp` | Gets Unix time stamp.
| ✅   | ✅         | ✅  | `week`  | Gets week number in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Week_dates) format `YYYY-Www`.
| ✅   | ✅         | ✅  | `weekday` | Gets weekday number.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🌐 Networking

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `fastping` | Pings hostname(s) 30 times in quick succession.
| ✅   | ✅         | ✅  | `flushdns` | Flushes the DNS cache.
| ✅   | ✅         | ✅  | `ips`   | Gets all IP addresses.
| ✅   | ✅         | ✅  | `localip` | Gets local IP address.
| ✅   | ✅         | ✅  | `publicip` | Gets external IP address.
| ✅   | ✅         | ✅  | `GET`<br>`HEAD`<br>`POST`<br>`PUT`<br>`DELETE`<br>`TRACE`<br>`OPTIONS` | Sends HTTP requests.<br>_Usage: `GET https://example.com`_

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### ⚡ Power management

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `hibernate` | Hibernates the system.
| ✅   | ✅         | ✅  | `lock`  | Locks the session.
| ✅   | ✅         | ✅  | `poweroff` | Shuts down the system.
| ✅   | ✅         | ✅  | `reboot` | Restarts the system.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🤓 Sysadmin

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `mnt`   | Lists drive mounts.
| ✅   | ✅         | ✅  | `path`  | Prints each `$PATH` entry on a separate line.
| ✅   | ✅         | ✅  | `sysinfo` | Displays information about the system.<br><strong><sup>Uses either [Winfetch](https://github.com/lptstr/winfetch), [Neofetch](https://github.com/dylanaraps/neofetch), or [Screenfetch](https://github.com/KittyKatt/screenFetch).</sup></strong>
| ✅   | ✅         | ✅  | `top`   | Monitors processes and system resources.<br><strong><sup>Uses either [atop](https://linux.die.net/man/1/atop), [htop](https://hisham.hm/htop/), [ntop](https://github.com/Nuke928/NTop) <b title="windows">⊞</b>, or native.</sup></strong>
| ✅   | ✅         | ✅  | `update` | Keeps all apps and packages up to date.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🖥️ Applications

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `browse` | Opens file/URL in default browser.<br>_Usage: `browse https://example.com`_
| ✅   | ✅         | ✅  | `chrome` | Opens file/URL in [Chrome](https://www.google.com/chrome/).
| ✅   | ✅         | ✅  | `edge` | Opens file/URL in [Microsoft Edge](https://www.microsoft.com/en-us/edge).
| ✅   | ✅         | ✅  | `firefox` | Opens file/URL in [Firefox](https://www.mozilla.org/en-CA/firefox/).
| ❔   | ✅         | ❔  | `iexplore` | Opens file/URL in [Internet Explorer](https://www.microsoft.com/ie). <b title="Windows">⊞</b>
| ✅   | ✅         | ✅  | `opera` | Opens file/URL in [Opera](https://www.opera.com/).
| ✅   | ✅         | ✅  | `safari` | Opens file/URL in [Safari](https://www.apple.com/ca/safari/). <b title="macOS"></b>
| ✅   | ✅         | ✅  | `ss`    | Enters the [Starship 🚀](https://starship.rs) cross-shell prompt.
| ✅   | ✅         | ✅  | `subl`<br>`st`  | Opens in [Sublime Text](https://www.sublimetext.com/).

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 👩‍💻 Development

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `dk`    | 🐳 Alias for [`docker`](https://www.docker.com/).
| ✅   | ✅         | ✅  | `dco`   | 🐳 Alias for [`docker-compose`](https://docs.docker.com/compose/).
| ✅   | ✅         | ✅  | `g`     | :octocat: Alias for [`git`](https://git-scm.com/).
| ✅   | ✅         | ✅  | `va`    | 🐍 Activates Python [virtual environment `venv`](https://docs.python.org/3/tutorial/venv.html).
| ✅   | ✅         | ✅  | `ve`    | 🐍 Creates Python [virtual environment `venv`](https://docs.python.org/3/tutorial/venv.html).

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

###  macOS

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `hidedesktop`<br>`showdesktop` | Toggles display of desktop icons.
| ✅   | ✅         | ✅  | `hidefiles`<br>`showfiles` | Toggles hidden files display in [Finder](https://support.apple.com/en-ca/HT201732).
| ✅   | ✅         | ✅  | `spotoff`<br>`spoton` | Toggles [Spotlight](https://support.apple.com/en-ca/HT204014).

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### ⊞ Windows

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ❔   | ✅         | ❔  | `hidefiles`<br>`showfiles` | Toggles hidden files display in [File Explorer](https://support.microsoft.com/en-ca/help/4026617/windows-10-windows-explorer-has-a-new-name).

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 📁 Common paths

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `dls`   | Navigates to `~/Downloads`.
| ✅   | ✅         | ✅  | `docs`  | Navigates to `~/Documents`.
| ✅   | ✅         | ✅  | `dt`    | Navigates to `~/Desktop`.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 📁 Configuration paths

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `chezmoiconf` | Navigates to [Chezmoi](https://www.chezmoi.io/)'s local configuration repo.
| ✅   | ✅         | ✅  | `powershellconf` | Navigates to [Powershell](https://github.com/PowerShell/PowerShell)'s profile location.
| ✅   | ✅         | ✅  | `sublimeconf` | Navigates to [Sublime Text](https://www.sublimetext.com/)'s local configuration repo.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 📁 Custom paths

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `archives` | Navigates to `~/Archives`.
| ✅   | ✅         | ✅  | `repos` | Navigates to `~/Code`.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🌱 Varia

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `cb`    | 📋 Copies contents to the clipboard.
| ✅   | ✅         | ✅  | `cbpaste` | 📋 Pastes the contents of the clipboard.
| ✅   | ✅         | ✅  | `md5sum` | #️⃣ Calculates MD5 hashes.
| ✅   | ✅         | ✅  | `sha1sum`  | #️⃣ Calculates SHA1 hashes.
| ✅   | ✅         | ✅  | `sha256sum` | #️⃣ Calculates SHA256 hashes.
| ✅   | ✅         | ✅  | `forecast` | 🌤️ Displays [detailed weather and forecast](https://wttr.in/?n).
| ✅   | ✅         | ✅  | `weather` | 🌤️ Displays [current weather](https://wttr.in/?format=%l:+(%C)+%c++%t+[%h,+%w]).

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Inspirations 💡

- [Digital Ocean: What are your favorite bash aliases?](https://www.digitalocean.com/community/questions/what-are-your-favorite-bash-aliases)
- [GitHub: dotfiles](http://dotfiles.github.io/)
- [GitHub: Jay Harris' Windows dotfiles](https://github.com/jayharris/dotfiles-windows)
- [GitHub: Jan Moesen's dotfiles](https://github.com/janmoesen/tilde)
- [GitHub: Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
- [nixCraft: 30 Handy Bash Shell Aliases For Linux / Unix / Mac OS X](https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html)

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

<p align="center"><strong>Don't forget to <a href="#" title="star">⭐️</a> or <a href="#" title="fork">🔱</a> this repo! 😃<br/><sub>Assembled with <b title="love">❤️</b> in Montréal.</sub></strong></p>
