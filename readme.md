# mac-dotfiles
Shell configurations for macOS

## setup
1. Clone this repository into HOME directory.
```bash
git clone git@github.com:tomon9086/mac-dotfiles.git ~/.dotfiles
```

2. Link `.zshrc`
```console
ln ~/.dotfiles/.zshrc ~/.zshrc
```

3. Link `.gitignore_global`
```console
mkdir -p ~/.config/git
ln ~/.dotfiles/.gitignore_global ~/.config/git/ignore
```

## commandline tools
### required
- [zplug](https://github.com/zplug/zplug)
- [fzy](https://github.com/jhawthorn/fzy)
  - to support `enhancd`

### optional
- [custom-commands](https://github.com/tomon9086/custom-commands)
- [gibo](https://github.com/simonwhitaker/gibo)
