print("THIS IS COPILOT CHAT TEST")

describe("copilot chat history", function()
  print("Inside describe block")
  local test_history_file = "/tmp/test_chat_history.json"
  local ch

  it("should load the module", function()
    print("Testing module load")
    ch = require("usr.copilot-chat-history")
    assert(ch ~= nil, "Module should load")
  end)
end)

