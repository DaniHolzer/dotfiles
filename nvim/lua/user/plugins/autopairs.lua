-- ~/.config/nvim/lua/user/plugins/autopairs.lua

-- https://github.com/windwp/nvim-autopairs



------------------------------------------------------------------------------
-- Autopairs Plugin
------------------------------------------------------------------------------

-- Import Autopairs with a protected call, so it don't error out on first use:
local autopairs_status_ok, autopairs = pcall(require, 'nvim-autopairs')
if not autopairs_status_ok then
  return
end

-- Import CMP with a protected call, so it don't error out on first use:
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

-- Insert ( after select function, method or action:
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on({
  'confirm_done',
  cmp_autopairs.on_confirm_done({
    map_char = { tex = '' },
  }),
})


------------------------------------------------------------
-- Appearance

autopairs.setup {
  check_ts  = true,
  ts_config = {
    lua = {
      'string',
      'source',
    },
    javascript = {
      'string'         ,
      'template_string',
    },
    java = false,
  },
  disable_filetype = {
    'TelescopePrompt',
    'spectre_panel'  ,
  },
  fast_wrap = {
    map   = '<M-e>',
    chars = {
      '{',
      '[',
      '(',
      '"',
      "'",
    },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    -- Offset from pattern match:
    offset = 0,
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'PmenuSel',
    highlight_grey = 'LineNr',
  },
}
