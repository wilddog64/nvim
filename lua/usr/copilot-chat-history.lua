-- In copilot-chat-history.lua
local M = {}

local ok, CopilotChat = pcall('require', 'CopilotChat')
if not ok then
  return
end

function M.save_chat_history(name, path)
  if not name then
    name = 'chat-history'
  end
  if not path then
    path = vim.fn.stdpath("data") .. "/copilot-chat"
  end
  -- Use the default save location from your configuration
  CopilotChat.save("chat-history", path)
end

function M.load_chat_history(name, path)
  if not name then
    name = 'chat-history'
  end
  if not path then
    path = vim.fn.stdpath("data") .. "/copilot-chat"
  end
  return CopilotChat.load("chat-history", path)
end

return M

