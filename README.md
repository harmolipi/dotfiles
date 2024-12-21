# Harmolipi's dotfiles

My Neovim config now uses Astronvim. In addition to it, I'm using:

- Tmux
- Neovim
- Lazygit
- Zsh

## Setup

### Ansible

Install programs with:

```bash
ansible-playbook --ask-become-pass dotfiles.yml
```

### Stow

These dotfiles are now set up to be used with
[Stow](https://www.gnu.org/software/stow/). After installing the necessary
programs, symlink the configs to the proper locations with:

```bash
stow configs
```

## Story

I recently started learning to use Neovim and gradually crafting my
configuration, so I'm saving/publishing my settings here as I go. My settings
are largely based on the setup of Takuya Matsuyama
([devaslife on YouTube](https://www.youtube.com/c/devaslife)), who has inspired
me to go down this wonderful rabbit hole.

This is very much a work in progress and I really don't know what I'm doing, so
beware of copying my configuration! Better yet,
[take a look at Takuya's](https://github.com/craftzdog/dotfiles-public).

## Helpful notes

Just some things, mostly for myself, to remember:

- Directory structure info: `:h 'runtimepath'`
