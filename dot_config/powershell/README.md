# PowerShell Core (Windows)

## Prettify the prompt

Let's make the prompt pretty and Git-oriented with [Oh-My-Posh](https://github.com/JanDeDobbeleer/oh-my-posh) and [Posh-Git](https://github.com/dahlbyk/posh-git):

```sh
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
```

[See this article](https://www.hanselman.com/blog/HowToMakeAPrettyPromptInWindowsTerminalWithPowerlineNerdFontsCascadiaCodeWSLAndOhmyposh.aspx) for more info.
