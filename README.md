# deprecated!
I've since moved to NixOS. New config available [here](https://github.com/n3oney/nixus).

# neoney's dotfiles

- how 2 use?

There's a `dotter` file in the root directory. That's a binary, execute it.
To deploy the files to all the right directories, run `./dotter deploy`.

Before that though, you must create a `.dotter/local.toml` file.
This file doesn't get synced to Git, and you must specify what packages you want (for example:
`packages = ["hyprland", "hyprpaper", "alacritty", "neovim", "eww"]`)

and you can also override any variables:

```
[variables]
main_monitor = "DP-1"
term_font_size = 10.5
main_width = 2560
main_height = 1440
```

To see what's available, check the `.dotter/global.toml` file.
