# Tye's .Dotfiles

Personal Configuration Files

## TODO

---

## TyeBased16

  TODO: Base16 Builder

    @import url("https://tyecon.github.io/.dotfiles/TyeBased16/TyeBased16.css");
---

## BetterDiscord

  > Remove Existing Folder

    Windows:
    cmd /c mklink /J %APPDATA%\BetterDiscord .\BetterDiscord

    Unix:
    ln -s {BetterDiscord Path} ~/.dotfiles/BetterDiscord
---

## Firefox

### Download

> <https://www.mozilla.org/en-US/firefox/all/#product-desktop-nightly>

    Windows:
    choco install firefox-nightly

    Unix:
    apt-get install firefox-nightly

### Addons

 > <https://addons.mozilla.org/en-US/firefox/collections/17709165/Tye-s-Addons/>

### userChrome

> about:config > Set the option toolkit.legacyUserProfileCustomizations.stylesheets to True

> about:profiles > Open Folder > \chrome\ > Remove userChrome.css > Copy that path for Link Command

    Windows:
    cmd /c mklink /H {FIREFOX-CSS-PATH} .\Firefox\userChrome.css

    Example:
    cmd /c mklink /H C:\Users\Tyecon\AppData\Roaming\mozilla\firefox\profiles\bwulq044.default-release\chrome\userChrome.css C:\Users\Tyecon\Documents\.dotfiles\Firefox\userChrome.css

    Unix:
    ln {FIREFOX-CSS-PATH} ~/.dotfiles/Firefox/userChrome.css

### TreeStyleTabs

> about:addons > Tree Style Tabs > Options > Advanced > Load From File > treestyletab.css

### Tridactyl

TODO: tridactylrc

---

## Editors

### VSCode

TODO: Sync Share

### Vim

TODO: .vimrc

### Emacs

TODO: .emacs.d

---

## Shell

> <https://guinuxbr.com/en/posts/zsh+oh-my-zsh+starship/>

### tmux

### zsh

### p10k

### starship
