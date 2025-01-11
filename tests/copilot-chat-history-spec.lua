-- tests/copilot-chat-history-spec.lua

print("THIS IS COPILOT CHAT TEST")

describe("copilot chat history", function()
  print("Inside describe block")
  local chat_history = require("usr.copilot-chat-history")
  local test_history_file = vim.fn.stdpath("data") .. "/copilot-chat-history.json"

  -- Mock data
  local mock_history = {
    {
      role = "user",
      content = "test message"
    },
    {
      role = "assistant",
      content = "test response"
    }
  }

  before_each(function()
    print("Setting up test...")
    package.loaded["copilot.chat"] = {
      get_chat_history = function() return mock_history end,
      set_chat_history = function(history) mock_history = history end
    }
  end)

  after_each(function()
    if vim.fn.filereadable(test_history_file) == 1 then
      vim.fn.delete(test_history_file)
    end
  end)

  it("should save chat history to file", function()
    print("Running save test")
    chat_history.save_chat_history()
    assert(vim.fn.filereadable(test_history_file) == 1)
    local json = vim.fn.readfile(test_history_file)[1]
    local saved_history = vim.fn.json_decode(json)
    assert.are.same(mock_history, saved_history)
  end)

  it("should restore chat history from file", function()
    print("Running restore test")
    local test_history = {
      { role = "user", content = "new test" }
    }
    local json = vim.fn.json_encode(test_history)
    vim.fn.writefile({json}, test_history_file)

    chat_history.restore_chat_history()

    assert.are.same(test_history, mock_history)
  end)
end)

