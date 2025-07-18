local lua_dir = require('usr.modules.lua_dir')
local preserve_state = require('usr.modules.preserve_state')
local look_non_whitespace = require('usr.modules.look_non_whitespace')
local visual_sign = require('usr.modules.visual_sign')
local remove_last_path = require('usr.modules.remove_last_path')
local redact = require('usr.modules.redact')

return {
  enable_lua_dir_keymap = lua_dir.enable_keymap,
  preserve_state = preserve_state.preserve_state,
  enable_look_nonwhitespace_keymap = look_non_whitespace.enable_keymap,
  enable_visual_sign_keymap = visual_sign.enable_keymap,
  enable_last_path_keymap = remove_last_path.enable_keymap,
  enable_redact_keymap = redact.enable_keymap,
}

