## personal-dotfiles

my personal linux setup and dotfiles.

## Screenshots

<p align="center">
  <img src="./screenshots/modes.gif">
</p>

## requirements

- Arch Linux (or another Arch-based distro)
- GNU Stow
- Hyprland 0.55+ (Lua configuration)

## installation

> [!NOTE]
> Some configs contain hardcoded paths and assumptions about my setup.
> I recommend copying only the configs you want and adapting them to your own system instead of applying the entire repository.

### clone the repository

```bash
git clone https://github.com/yugg755i/dotfiles.git
cd dotfiles
```

### applying configs

I don't recommend applying the entire repository with `stow */`, especially if you're new to Hyprland.

Instead, copy or stow only the components you want and adapt them to your setup.

For example:

```bash
stow kitty
stow waybar
stow yazi
```

See [`hypr/.config/hypr/binds.lua`](./hypr/.config/hypr/binds.lua) for the complete list.

## shaders

Shader configuration is located in `hypr/shader.lua`.

```text
Alt + C              CRT Mode
SUPER + D            Reading Mode
SUPER + Alt + N      Night Light
SUPER + Alt + S      Disable All Shaders
```

## wallpaper

* https://walle.theblank.club
* https://github.com/dusklinux/images
* [current wallpaper](https://unsplash.com/photos/a-large-body-of-water-surrounded-by-mountains-1yFDsklbtBU)

## credits

* waybar and rofi: https://github.com/martin-djakovic/dotfiles
* Shaders: https://github.com/snes19xx/surface-dots
