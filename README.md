# Neovim and Vim Configuration

This repository contains my custom configuration files for Neovim (`init.lua`) and Vim (`vimrc`). The configurations are tailored to improve productivity and maintain consistency between the two editors.

---

## File Structure

### Neovim Configuration
- **`init.lua`**: The primary configuration file for Neovim.
  - Modular structure for better organization and maintainability.
  - Includes settings for plugins, LSP configurations, and key mappings.
- **`nvim_minimum.lua`**: A minimal `init.lua` configuration designed to test basic LSP and Mason functionality.

### Vim Configuration
- **`vimrc`**: The main configuration file for Vim.
  - Covers settings, plugins, and key mappings.
  - Ensures compatibility with terminal-based Vim.
- **`vimrc_minimal`**: A minimal `vimrc` configuration for testing purposes.

---

## Features

### Neovim (`init.lua`)
- Organized structure using Lua `require` statements.
- Plugin management with `packer.nvim`.
- LSP (Language Server Protocol) setup for multiple languages.
- Custom key mappings for navigation and functionality.
- Compatibility settings for smooth operation.

### Vim (`vimrc`)
- Comprehensive settings for terminal-based Vim.
- Plugin configurations to enhance development workflow.
- Key mappings tailored for efficiency.
- Compatibility checks for various environments (e.g., fish shell).

---

## Minimal Configurations

### Neovim Minimal Configuration (`nvim_minimum.lua`)

```lua
-- Minimal init.lua to test LSP and Mason

-- Safely require 'lspconfig' and 'mason' to avoid errors
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  print("lspconfig not installed!")
  return
end

-- Add Mason's binary path to $PATH if Mason is installed
local mason_path = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_path .. ":" .. vim.env.PATH

-- Set up lua-language-server (lua_ls)
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT", -- Use LuaJIT for Neovim
      },
      diagnostics = {
        globals = { "vim" }, -- Suppress "undefined global 'vim'" warning
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime
        checkThirdParty = false, -- Avoid third-party prompts
      },
      telemetry = { enable = false }, -- Disable telemetry
    },
  },
  on_init = function(client)
    print("lua-language-server initialized!")
  end,
})

-- Set up basic options for testing
vim.opt.number = true -- Show line numbers
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.mouse = "a"

-- Map <leader>q to quit Neovim quickly
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })

-- Print a message to confirm init.lua is loaded
print("Minimal init.lua loaded!")
```

### Vim Minimal Configuration (`vimrc_minimal`)

```vim
" Minimal vimrc configuration
set nocompatible  " Disable compatibility with old-school Vi
filetype plugin indent on  " Enable file type detection
syntax on  " Enable syntax highlighting

" Basic settings
set number          " Show line numbers
set shiftwidth=2    " Number of spaces for each indentation step
set tabstop=2       " Number of spaces per tab
set expandtab       " Use spaces instead of tabs
set mouse=a         " Enable mouse support

" Key mappings
let mapleader = ";"
nnoremap <leader>q :q<CR> " Quit Vim quickly

" Print a message to confirm vimrc is loaded
echo "Minimal vimrc loaded!"
```

---

## Usage

1. Clone this repository to your local machine.
2. Copy the desired configuration files to their respective locations:
   - For Neovim: `~/.config/nvim/init.lua` or `nvim_minimum.lua`.
   - For Vim: `~/.vimrc` or `vimrc_minimal`.
3. Install the necessary plugins using your preferred plugin manager.

---

## Notes
- The minimal configurations are intended for testing and debugging purposes.
- Modular configurations in `init.lua` and `vimrc` ensure maintainability and scalability.

---

Happy coding!

[LICENSE](LICENSE) | [CONTACT](LICENSE)
