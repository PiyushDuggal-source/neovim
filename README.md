# A Basic Stable IDE config for Neovim

```sh
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout release-0.8
make CMAKE_BUILD_TYPE=Release
sudo make install
```

## ⚠️ ⚠️  Run these commands first ⚠️ ⚠️

#### For Ubuntu

```sh
sudo apt update && sudo apt upgrade && sudo apt install git ripgrep xsel wl-clipboard cargo clang-format python3-pip npm
sudo npm install -g neovim && sudo pip install black pynvim && sudo cargo install stylua
```

##### For lazygit (Ubuntu)
```sh
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```


##### For lazygit (Fedora)
```sh
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit
```

##### Nodejs for specific distros

- [Here](https://github.com/nodesource/distributions)


Make sure to remove or move your current `nvim` directories: ```~/.config/nvim``` ```~/.local/share/nvim```

```sh
git clone https://github.com/PiyushDuggal-source/neovim ~/.config/nvim
```


Run `nvim` and wait for the plugins to be installed

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

## Get health

Open `nvim` and enter the following:

```
:checkhealth
```

check the report and download required packages.

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

---

**NOTE** make sure you have [node](https://nodejs.org/en/) installed, I recommend a node manager like [fnm](https://github.com/Schniz/fnm).

## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Configuration

### LSP

To add a new LSP

First Enter:

```
:LspInstallInfo
```

and press `i` on the Language Server you wish to install

Next you will need to add the server to this list: [servers](https://github.com/LunarVim/nvim-basic-ide/blob/8b9ec3bffe8c8577042baf07c75408532a733fea/lua/user/lsp/lsp-installer.lua#L6)

### Formatters and linters

Make sure the formatter or linter is installed and add it to this setup function: [null-ls](https://github.com/LunarVim/nvim-basic-ide/blob/8b9ec3bffe8c8577042baf07c75408532a733fea/lua/user/lsp/null-ls.lua#L13)

## Plugins

- [packer](https://github.com/wbthomason/packer.nvim)
- [plenary](https://github.com/nvim-lua/plenary.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [vim-bbye](https://github.com/moll/vim-bbye)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- [project.nvim](https://github.com/ahmedkhalf/project.nvim)
- [impatient.nvim](https://github.com/lewis6991/impatient.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [alpha-nvim](https://github.com/goolord/alpha-nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [darkplus.nvim](https://github.com/LunarVim/darkplus.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- [vim-illuminate](https://github.com/RRethy/vim-illuminate)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [DAPInstall.nvim](https://github.com/ravenxrz/DAPInstall.nvim)
- etc.

---

> If debugging is the process of removing bug, then programming must be the process of putting them in.

\- Edsger W. Dijkstra
