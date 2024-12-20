# Vim and Neovim Configuration

This repository contains my personal configurations for Vim and Neovim. These configurations have been carefully tailored to meet my needs, emphasizing efficiency, minimalism, and clarity.

## Structure

### Neovim Configuration

- **File**: `init.lua`
- **Description**: The main configuration file for Neovim. It organizes the settings, plugins, and custom modules into a modular structure for easy maintenance and scalability.

#### Key Highlights:
1. **Plugin Management**:
   - Utilizes `packer.nvim` for managing plugins.
   - Includes essential plugins like `nvim-lspconfig`, `nvim-treesitter`, and `fzf.nvim`.

2. **Modules**:
   - Settings are modularized into Lua files under `usr/` for clarity.
   - Example modules:
     - `usr.lsp`: Language server configurations.
     - `usr.cmp`: Completion setup.

3. **Customization**:
   - Lazy-loaded plugins for faster startup.
   - Leader key: `;`

4. **Path Management**:
   - Backup, undo, and shada paths are dynamically set based on Neovim's standard paths.

### Vim Configuration

- **File**: `vimrc`
- **Description**: The main configuration file for Vim. Focused on providing a robust yet straightforward setup, suitable for use on servers and environments without Neovim.

#### Key Highlights:
1. **Plugin Management**:
   - Uses `vim-plug` for managing plugins.
   - Essential plugins like `ale`, `fzf.vim`, and `vim-go`.

2. **General Settings**:
   - Custom key mappings and leader key: `;`.
   - Syntax highlighting and file type detection.

3. **Server Compatibility**:
   - Minimal reliance on external dependencies, ensuring compatibility on servers.

4. **Session Management**:
   - Configured for easy session management and restoration.

## Philosophy

I prioritize configurations that:
- Are easy to understand and maintain.
- Do not rely on features or plugins I do not fully understand.
- Provide a balance between modern features and minimalism.

## Installation

1. Clone the repository to your configuration directory:
   ```bash
   git clone <repository-url> ~/.config/nvim
