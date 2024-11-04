local statuscol = require "statuscol"
local builtin = require "statuscol.builtin"
statuscol.setup {
  relculright = true,
  segments = {
    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
    {
      sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, wrap = true, auto = true },
      click = "v:lua.ScSa",
    },
    {
      sign = { namespace = { "diagnostic/signs" }, maxwidth = 1 },
      click = "v:lua.ScSa",
    },
    {
      sign = { namespace = { "gitsigns" }, maxwidth = 1, auto = true },
      click = "v:lua.ScSa",
    },
    { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
  },
  clickmod = "c", -- modifier used for certain actions in the builtin clickhandlers:
  clickhandlers = { -- builtin click handlers
    Lnum = builtin.lnum_click,
    FoldClose = builtin.foldclose_click,
    FoldOpen = builtin.foldopen_click,
    FoldOther = builtin.foldother_click,
    DapBreakpointRejected = builtin.toggle_breakpoint,
    DapBreakpoint = builtin.toggle_breakpoint,
    DapBreakpointCondition = builtin.toggle_breakpoint,
    ["diagnostic/signs"] = builtin.diagnostic_click,
    gitsigns = builtin.gitsigns_click,
  },
}
