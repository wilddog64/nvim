# Neovim & Vim Configuration with `redact.nvim`

This repository includes:
- **Neovim configs** (`init.lua`, `nvim_minimum.lua`)
- **Vim configs** (`vimrc`, `vimrc_minimal`)
- A **utility plugin** `redact.nvim` for sanitizing sensitive data before sharing or copying.

---

## 📁 Repository Structure

```
.
├── init.lua            # Full-featured Neovim setup
├── nvim_minimum.lua    # Minimal Neovim config for LSP/Mason testing
├── vimrc               # Complete Vim configuration
├── vimrc_minimal       # Minimal Vim for quick tests
└── lua/
    └── redact.lua      # redact.nvim: buffer sanitizer plugin
```

### Neovim Configuration
- **`init.lua`**
  - Modular Lua setup using `require`
  - Plugin management via `packer.nvim`
  - LSP (`lspconfig`), Mason, Treesitter, Telescope, and more
  - Editor settings & custom key mappings
- **`nvim_minimum.lua`**
  - Lightweight config to validate LSP and Mason installation
  - Basic options: line numbers, indent settings, leader-key mapping

### Vim Configuration
- **`vimrc`**
  - Settings for terminal Vim: `filetype`, `syntax`, `mouse`, indent
  - Plugin definitions and key mappings
- **`vimrc_minimal`**
  - Minimal subset of `vimrc` to test core behavior

### Utility Plugin: `redact.nvim`
Located at `lua/redact.lua`, this module lets you sanitize buffer content before copy or share.

- **Commands**:
  - `:RedactBuffer` — sanitize entire buffer in place
  - `:RedactSelection` — sanitize visual selection
  - `:RedactCopy` — sanitize and copy to clipboard
  - `:RedactPreview` — preview sanitized content in a split
- **Default Key Mappings**:
  - `<leader>rb` — Redact Buffer
  - `<leader>rs` — Redact Selection
  - `<leader>rc` — Redact & Copy
  - `<leader>rp` — Redact Preview
- **Built-in Patterns**:
  - **URIs**: HTTP(s), JDBC, Redis, FTP, etc.
  - **Hosts**: `host:`, `externalHost:` (case-insensitive)
  - **Private IPs**: `10.x.x.x`, `192.168.x.x`, `172.16–31.x.x`
  - **Internal domains**: `*.internal`, `*.cluster.local`
  - **Secrets**: bearer tokens, `password:`, email addresses
  - **Config keys**: `tenantId`, `repository`, `dbUsername`, `spring.datasource.username`
  - **JDBC Params**: `databaseName=...`
- **Customization**:
  ```lua
  require('redact').enable_keymap({
    patterns = { -- override or extend patterns
      -- e.g. custom key patterns
    },
    mappings = { -- override default keybindings
      buffer    = '<leader>ab',
      selection = '<leader>as',
      copy      = '<leader>ac',
      preview   = '<leader>ap',
    }
  })
  ```

---

## ⚙️ Installation & Setup

1. **Clone** this repository:
   ```bash
   git clone <repo-url>
   ```
2. **Copy files**:
   - Neovim: `init.lua` → `~/.config/nvim/init.lua`
   - Neovim minimal: `nvim_minimum.lua` → `~/.config/nvim/init.lua` (for testing)
   - Vim: `vimrc` → `~/.vimrc`
   - Vim minimal: `vimrc_minimal` → `~/.vimrc`
3. **Place** `lua/redact.lua` under `~/.config/nvim/lua/`
4. **Enable** the plugin in your Neovim config:
   ```lua
   -- at top of init.lua
   require('redact').enable_keymap()
   ```
5. **Restart** Neovim.

---

## 📝 Notes

- Use **minimal configs** (`nvim_minimum.lua` or `vimrc_minimal`) to isolate and debug LSP/Mason setup.
- `redact.nvim` is indispensable when pasting logs, YAML, or code into AI tools or public forums.

---

Happy coding! 🚀
