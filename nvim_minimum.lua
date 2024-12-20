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
