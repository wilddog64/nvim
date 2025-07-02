M = {}

local visual_sign_group = vim.api.nvim_create_augroup("VisualSignShow", { clear = true })

-- Define the sign
vim.fn.sign_define("VisualSign", { text = ">", texthl = "Visual" })

local sign_ids = {}

local function hide_visual_block()
  for _, id in ipairs(sign_ids) do
    vim.fn.sign_unplace("", { buffer = vim.fn.bufnr("%"), id = id })
  end
  sign_ids = {}
end

local function show_visual_block()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  for lnum = start_line, end_line do
    local id = vim.fn.sign_place(0, "", "VisualSign", vim.fn.bufnr("%"), { lnum = lnum })
    table.insert(sign_ids, id)
  end
end

function M.enable_keymap()
  vim.api.nvim_create_autocmd("InsertLeave", {
    group = visual_sign_group,
    once = true,
    callback = hide_visual_block,
  })

  vim.api.nvim_create_autocmd("ModeChanged", {
    group = visual_sign_group,
    pattern = "[\\x16]*:i",
    callback = show_visual_block,
  })
end

return M
