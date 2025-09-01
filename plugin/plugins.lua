-- guess-indent.nvim
require('guess-indent').setup {}

-- mini.clue
local miniclue = require 'mini.clue'
local function insert_cursor_object_clues()
  local describe = function(prefix)
    local make_clue = function(key, desc) return { mode = 'c', keys = prefix .. key, desc = desc } end
    return {
      make_clue("<C-f>", "Filename under cursor"),
      make_clue("<C-p>", "Filename under cursor, expanded with 'path'"),
      make_clue("<C-w>", "Word under cursor"),
      make_clue("<C-a>", "WORD under cursor"),
      make_clue("<C-l>", "Line under cursor"),
    }
  end

  return {
    describe("<C-r>"),
    describe("<C-r><C-r>"),
    describe("<C-r><C-o>"),
  }
end
miniclue.setup {
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
    insert_cursor_object_clues(),
  },

  window = {
    delay = 0,
    config = {
      width = "auto"
    },
  }
}
