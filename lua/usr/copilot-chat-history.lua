local M = {}

local history_file = vim.fn.stdpath("data") .. "/copilot-chat-history.json"

function M.set_history_file(file)
    history_file = file
end

function M.get_history_file()
    return history_file
end

function M.save_chat_history()
    local ok, chat = pcall(require, "CopilotChat")
    if not ok then
        vim.notify("Copilot chat not available", vim.log.levels.ERROR)
        return
    end

    local history = chat.get_chat_history()
    if history then
        local json = vim.fn.json_encode(history)
        vim.fn.writefile({json}, history_file)
        vim.notify("Copilot chat history saved")
    end
end

function M.restore_chat_history()
    local ok, chat = pcall(require, "CopilotChat")
    if not ok then return end

    if vim.fn.filereadable(history_file) == 1 then
        local json = vim.fn.readfile(history_file)[1]
        local history = vim.fn.json_decode(json)
        if history then
            chat.set_chat_history(history)
            return history
        end
    end
end

return M

