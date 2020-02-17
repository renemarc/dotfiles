# ~/.config/iterm/
## iTerm2 preferences file

The file [`../../com.googlecode.iterm2.plist`](../../com.googlecode.iterm2.plist) is loaded by [iTerm2](https://iterm2.com/) when the **Load preferences from a custom folder or URL** setting is enabled in **iTerm2 → General → Preferences**.

[See explainations on Status3D.](http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/)

To keep any modifications done inside iTerm in sync with this repo, the above [`./symlink_com.googlecode.iterm2.plist.tmpl`](./symlink_com.googlecode.iterm2.plist.tmpl) is parsed and turned into a symlink when running `chezmoi apply`. 

[See details about chezmoi symlinks.](https://www.chezmoi.io/docs/how-to/)
