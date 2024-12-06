local sing_define = vim.fn.sign_define

 sing_define("DiagnosticSignError",
	{text = " ", texthl = "DiagnosticSignError"})
sing_define("DiagnosticSignWarn",
	{text = " ", texthl = "DiagnosticSignWarn"})
sing_define("DiagnosticSignInfo",
	{text = " ", texthl = "DiagnosticSignInfo"})
sing_define("DiagnosticSignHint",
	{text = "󰌵", texthl = "DiagnosticSignHint"})
