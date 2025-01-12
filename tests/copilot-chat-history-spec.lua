describe("copilot chat history", function()
    local ch = require("usr.copilot-chat-history")
    local test_path = "/tmp/copilot-test"

    -- Basic functionality tests
    describe("chat history operations", function()
        before_each(function()
            print("Setting up test...")
            vim.fn.mkdir(test_path, "p")
        end)

        after_each(function()
            os.remove(test_path .. "/chat-history.json")
            vim.fn.delete(test_path, "rf")
        end)

        it("should save chat history to file", function()
            print("Testing save functionality")
            ch.save_chat_history()
            local f = io.open(test_path .. '/chat-history.json', 'r')
            assert.is_not_nil(f)
            if f then
                f:close()
            end
        end)

        it("should restore chat history from file", function()
            print("Testing restore functionality")
            ch.save_chat_history()
            local history = ch.load_chat_history()
            assert.is_not_nil(history)
            assert.truthy(type(history) == "table")
        end)
    end)

    -- Keymap tests in separate describe block
    describe("keymaps", function()
        -- Keymap tests here...
    end)
end)

