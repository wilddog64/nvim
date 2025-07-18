# Neovim & Vim Configuration with `redact.nvim`

This repository includes:

* **Neovim configs** (`init.lua`, `nvim_minimum.lua`)
* **Vim configs** (`vimrc`, `vimrc_minimal`)
* A **utility plugin** `redact.nvim` for sanitizing sensitive data before sharing or copying.

---

## 📁 Repository Structure

```
.
├── init.lua               # Main Neovim configuration
├── nvim_minimum.lua       # Minimal Neovim config for LSP/Mason testing
├── vimrc                  # Primary Vim configuration
├── vimrc_minimal          # Minimal Vim config for quick testing
└── lua/
    ├── redact.lua         # redact.nvim: buffer sanitizer plugin
    └── usr/modules/       # Auxiliary Lua modules
        ├── init.lua               # Module initializer exporting enable functions
        ├── lua_dir.lua            # Navigate to Lua config directories via keymap
        ├── visual_sign.lua        # Show visual block indicators via sign column
        ├── look_non_whitespace.lua# Insert nearest non-whitespace character
        ├── preserve_state.lua     # Preserve search and cursor state across commands
        ├── remove_last_path.lua   # Command‑line helper to remove last path segment
        └── redact.lua             # Internal redactor implementation (optional override)
```

---

## 🔧 Neovim Configuration

### `init.lua`

* Modular Lua setup using `require`
* Plugin management via `packer.nvim`
* LSP (`lspconfig`), Mason, Treesitter, Telescope, and more
* Editor settings & custom key mappings

### `nvim_minimum.lua`

* Lightweight config to validate LSP and Mason
* Basic options: line numbers, indent settings, leader-key mapping

---

## 🔧 Vim Configuration

### `vimrc`

* Settings for terminal Vim: `filetype`, `syntax`, `mouse`, indent
* Plugin definitions and key mappings

### `vimrc_minimal`

* Minimal subset of `vimrc` to test core behavior

---

## 🛠 Utility Plugin: `redact.nvim`

Located at `lua/redact.lua`, this Neovim module lets you sanitize buffer content safely.

### Commands

* `:RedactBuffer` — sanitize entire buffer in place
* `:RedactSelection` — sanitize visual selection
* `:RedactCopy` — sanitize and copy to clipboard
* `:RedactPreview` — preview sanitized content in a split

### Default Key Mappings

| Command          | Mapping      |
| ---------------- | ------------ |
| Redact Buffer    | `<leader>rb` |
| Redact Selection | `<leader>rs` |
| Redact & Copy    | `<leader>rc` |
| Redact Preview   | `<leader>rp` |

### Built-in Patterns

* **URIs**: HTTP(s), JDBC, Redis, FTP, and any `scheme://…`
* **Hosts**: `host:`, `externalHost:` (case-insensitive)
* **Private IPs**: `10.x.x.x`, `192.168.x.x`, `172.16–31.x.x`
* **Internal domains**: `*.internal`, `*.cluster.local`
* **Secrets**: bearer tokens, `password:`, email addresses
* **Config keys**: `tenantId`, `repository`, `dbUsername`, `spring.datasource.username`
* **JDBC Params**: `databaseName=…`

### Customization

Override patterns or keymaps in your Neovim config:

```lua
require('redact').enable_keymap({
  patterns = {
    -- extend or override default patterns
  },
  mappings = {
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
2. **Copy** configs to your home directory:

   * Neovim: `init.lua` → `~/.config/nvim/init.lua`
   * Neovim minimal (optional): `nvim_minimum.lua` → `~/.config/nvim/init.lua`
   * Vim: `vimrc` → `~/.vimrc`
   * Vim minimal (optional): `vimrc_minimal` → `~/.vimrc`
3. **Place** `lua/redact.lua` under `~/.config/nvim/lua/`
4. **Enable** the plugin in your Neovim config by adding:

   ```lua
   require('redact').enable_keymap()
   ```
5. **Restart** Neovim.

---

## 📝 Notes

* Use **minimal configs** for isolating and debugging LSP/Mason issues.
* `redact.nvim` helps maintain privacy when sharing logs, YAML, or code.

Happy coding! 🚀
