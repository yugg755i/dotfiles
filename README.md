## personal-dotfiles

my personal linux setup and dotfiles.

## preview

![modes](./preview/modes.gif)

## components

* **os** → Arch Linux
* **wm** → Hyprland
* **terminal** → Kitty
* **shell** → Fish
* **bar** → Waybar
* **launcher** → Rofi
* **notifications** → SwayNC
* **osd** → SwayOSD
* **editor** → Neovim / VSCode
* **file manager** → Yazi + Nautilus
* **music** → MPD + rmpc
* **pdf viewer** → Zathura
* **colors** → Matugen
* **wallpaper** → awww
* **theming** → GTK + Kvantum
* **utilities** → btop, Fastfetch

## features

* dynamic color theming using matugen
* multiple environment modes with matching wallpapers and ambience
* rofi-based wallpaper picker
* lyrics integration through lrclib
* media controls and notifications via swaync
* power profiles for different usage scenarios

## structure

```text
dotfiles/
├── btop
├── fastfetch
├── fish
├── gtk-3.0
├── gtk-4.0
├── hypr
├── kitty
├── matugen
├── micro
├── mpd
├── rmpc
├── rofi
├── scripts
├── swaync
├── swayosd
├── waybar
├── yazi
└── zathura
```

## installation

### clone the repository

```bash
git clone https://github.com/yugg755i/dotfiles.git
cd dotfiles
```

### install dependencies

```bash
sudo pacman -S hyprland kitty fish rofi waybar swaync swayosd yazi micro fastfetch btop mpd rmpc zathura stow python
```

aur packages:

* `matugen`
* `awww`
* `rofi-wayland`
* nerd fonts (`ttf-jetbrains-mono-nerd`)

### apply dotfiles using stow

```bash
stow */
```

## wallpaper sources

* https://walle.theblank.club
* https://github.com/dusklinux/images

## credits

* waybar and rofi inspiration — https://github.com/martin-djakovic/dotfiles

## notes

these dotfiles are built around my personal workflow and are shared as-is. some adjustments may be needed depending on your setup.

## reuse

feel free to borrow, copy, or steal whatever you find useful.
