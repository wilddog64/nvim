require("CopilotChat").setup {
  -- See Configuration section for options
  mappings = {
    submit_prompt = {
      normal = '<Leader>s',
      insert = '<C-s>'
    }
  },
  selection = function(source)
    return select.visual(source) or select.buffer(source)
  end
}
