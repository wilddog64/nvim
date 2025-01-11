local M = {}

local chat_history_file = vim.fn.stdpath("data") .. "/copilot-chat-history.json"

function M.save_chat_history()
  local ok, chat = pcall(require, "copilot.chat")
  if not ok then return end

  local history = chat.get_chat_history()
  if history then
    local json = vim.fn.json_encode(history)
    vim.fn.writefile({json}, chat_history_file)
  end
end

function M.restore_chat_history()
  local ok, chat = pcall(require, "copilot.chat")
  if not ok then return end

  if vim.fn.filereadable(chat_history_file) == 1 then
    local json = vim.fn.readfile(chat_history_file)[1]
    local history = vim.fn.json_decode(json)
    if history then
      chat.set_chat_history(history)
    end
  end
end

function M.setup()
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = M.save_chat_history
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = M.restore_chat_history
  })
end

return M
