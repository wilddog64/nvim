local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  completion = {
    autocomplete = false
  },
}

-- setup keys to trigger auto complete and snippets
_G.vimrc = _G.vimrc or {}
_G.vimrc.cmp = _G.vimrc.cmp or {}
_G.vimrc.cmp.lsp = function()
  cmp.complete({
    completion = {
      autocomplete = false
    },
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Annon"](args.body)
      end,
    },
    cmp.setup {
       snippet = {
          expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end
       },
       -- ... Your other configuration ...
       mapping = {
          ["<Tab>"] = cmp.mapping({
             c = function()
                if cmp.visible() then
                   cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                   cmp.complete()
                end
             end,
             i = function(fallback)
                if cmp.visible() then
                   cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                   vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                else
                   fallback()
                end
             end,
             s = function(fallback)
                if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                   vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                else
                   fallback()
                end
             end
          }),
          ["<S-Tab>"] = cmp.mapping({
             c = function()
                if cmp.visible() then
                   cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                   cmp.complete()
                end
             end,
             i = function(fallback)
                if cmp.visible() then
                   cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                   return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                else
                   fallback()
                end
             end,
             s = function(fallback)
                if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                   return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                else
                   fallback()
                end
             end
          }),
          ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
          ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
          ['<C-n>'] = cmp.mapping({
             c = function()
                if cmp.visible() then
                   cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                   vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                end
             end,
             i = function(fallback)
                if cmp.visible() then
                   cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                   fallback()
                end
             end
          }),
          ['<C-p>'] = cmp.mapping({
             c = function()
                if cmp.visible() then
                   cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                   vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                end
             end,
             i = function(fallback)
                if cmp.visible() then
                   cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                   fallback()
                end
             end
          }),
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
          ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
          ['<CR>'] = cmp.mapping({
             i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
             c = function(fallback)
                if cmp.visible() then
                   cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                   fallback()
                end
             end
          }),
          -- ... Your other configuration ...
       },
       -- ... Your other configuration ...
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
      { name = "buffer" },
      { name = 'spell' },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    experimental = {
      ghost_text = false,
      native_menu = false,
    },
  })
end
_G.vimrc.cmp.snippet = function()
  cmp.complete({
    config = {
      sources = {
        { name = 'vsnip' }
      }
    }
  })
end

vim.cmd([[
  inoremap <C-x><C-o> <Cmd>lua vimrc.cmp.lsp()<CR>
  inoremap <C-x><C-s> <Cmd>lua vimrc.cmp.snippet()<CR>
]])
