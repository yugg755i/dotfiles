# minimal cozy setup

A cozy earthy Hyprland setup focused on muted colors, soft transparency, and a calm desktop experience.

Built to feel minimal, warm, distraction-free, and actually usable for daily work.

---

## Preview

![rice](https://github.com/yugg755i/dotfiles/blob/main/desktop.png?raw=true)

---

## Components

- **OS** → Arch Linux  
- **WM** → Hyprland  
- **Terminal** → Kitty  
- **Shell** → Fish  
- **Bar** → Waybar  
- **Launcher** → Rofi  
- **Notifications** → SwayNC  
- **OSD** → SwayOSD  
- **Editor** → Micro  
- **File Manager** → Yazi  
- **Music** → MPD + rmpc  
- **PDF Viewer** → Zathura  
- **Colors** → Matugen  
- **Theming** → GTK + Kvantum  
- **Utilities** → btop, Fastfetch

---

## Features

- Dynamic colors generated with Matugen
- Lightweight and fast
- Terminal-focused workflow
- Minimal UI with low visual clutter

---

## Structure

```bash
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

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/yugg755i/dotfiles.git
cd dotfiles
```

---

### 2. Install dependencies

```bash
sudo pacman -S hyprland kitty fish rofi waybar swaync swayosd yazi micro fastfetch btop mpd zathura stow
```

You may also need:
- Kvantum
- Matugen
- Nerd Fonts
- GTK themes/icons

---

### 3. Apply dotfiles using GNU Stow

```bash
stow */
```

---

## Wallpaper

Current wallpaper:

https://raw.githubusercontent.com/dusklinux/images/main/dark/0067.jpg

---

## Extra

- https://walle.theblank.club
- https://github.com/dusklinux/images

---

## Credits

- waybar and rofi - https://github.com/martin-djakovic/dotfiles

---

## Notes

These dotfiles are built around my personal workflow, so some adjustments may be needed depending on your setup.

---
