local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ name = "black" },
	{ name = "isort" },
	{ name = "stylua" },
	{ name = "shfmt" },
	{ name = "prettier" , args = {"--tab-width", "4"} },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ name = "flake8" },
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({})
