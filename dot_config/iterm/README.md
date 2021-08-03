# ~/.config/iterm/
## iTerm2 macOS Terminal Emulator preferences file

To keep any modifications done inside [iTerm2](https://iterm2.com/) in sync with this repo, the [`symlink_com.googlecode.iterm2.plist.tmpl`](./symlink_com.googlecode.iterm2.plist.tmpl) is parsed and turned into a symbolic link pointing to [`com.googlecode.iterm2.plist`](./com.googlecode.iterm2.plist) when running `chezmoi apply`. The actual plist file is not copied over to the user home directory.

[See details about chezmoi symlinks.](https://www.chezmoi.io/docs/how-to/)

The linked file [`com.googlecode.iterm2.plist`](./com.googlecode.iterm2.plist) is loaded by iTerm2 when the **Load preferences from a custom folder or URL** setting is enabled in **iTerm2 → General → Preferences**.

[See explainations on Stratus3D.](http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/)
