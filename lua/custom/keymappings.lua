local function setn(key, cmd, opt)
	vim.keymap.set("n", key, cmd, opt)
end

local function setv(key, cmd, opt)
	vim.keymap.set("x", key, cmd, opt)
	vim.keymap.set("o", key, cmd, opt)
end

local function seti(key, cmd, opt)
	vim.keymap.set("i", key, cmd, opt)
end

local function setwk(key, cmd, desc, vmod)
	local wk = lvim.builtin.which_key
	local map = vmod and wk.vmappings or wk.mappings
	map[key] = { cmd, desc }
end

local function setwksn(key, name, vmod)
	local wk = lvim.builtin.which_key
	local map = vmod and wk.vmappings or wk.mappings
	local rk = map[key]
	if rk then
		rk.name = name
	else
		rk = { name = name }
		map[key] = rk
	end
end

local function setwks(root, arr, vmod)
	local wk = lvim.builtin.which_key
	local map = vmod and wk.vmappings or wk.mappings
	local rk = map[root]

	if not arr then
		return
	end

	for _, _tab in ipairs(arr) do
		local sk = _tab[1]
		local cmd = _tab[2]
		local desc = _tab[3]
		rk[sk] = { cmd, desc }
	end
end

-- persistence
setwksn("S", "Session")
setwks("S", {
	{ "s", "<cmd>lua require('persistence').load()<cr>", "Restore Cur Dir Session" },
	{ "l", "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	{ "d", "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
})

seti("<C-s>", "<ESC><cmd>w<cr>")

setn("H", "^")
setn("L", "$")
setn("go", "%")
setn("yaa", "<cmd>%y+<cr>", { desc = "copy all" })
setn("<C-s>", "<cmd>w<cr>")
setn("<A-j>", "<cmd>m +1<cr>")
setn("<A-k>", "<cmd>m -2<cr>")
setn("<A-h>", "xhP")
setn("<A-l>", "xp")
setn("<Tab>", "<cmd>BufferLineCycleNext<cr>")
setn("<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")

setv("L", "$")
setv("H", "^")
setv("<A-j>", "<cmd>m +1<cr>")
setv("<A-k>", "<cmd>m -2<cr>")

setwk("o", "<cmd>SymbolsOutline<cr>", "SymbolsOutline")
setwk("x", "<cmd>BufferKill<CR>", "Close Buffer")
setwk("c", "<cmd>cd %:h<CR>", "Cd Cur")
setwk("w", "<cmd>Telescope live_grep<cr>", "Search Text")

setwksn("n", "Notice")
setwksn("r", "SnipRun")
setwksn("t", "Trouble")
setwks("s", { { "P", "<cmd>Telescope projects<cr>", "projects" } })
setwks("b", { { "f", ":BufferLinePick<cr>", "pick buffer" } })
setwks("l", {
	{ "vo", ":lua vim.diagnostic.config({ virtual_text = true})<CR>", "open virtual" },
	{ "vc", ":lua vim.diagnostic.config({ virtual_text = false})<CR>", "close virtual" },
})

lvim.lsp.buffer_mappings.normal_mode["[e"] = {
	function()
		return vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end,
	"Goto Prev Error",
}

lvim.lsp.buffer_mappings.normal_mode["]e"] = {
	function()
		return vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end,
	"Goto Next Error",
}

lvim.lsp.buffer_mappings.normal_mode["gd"] = {
	function()
		return require("trouble").open("lsp_definitions")
	end,
	"Goto definitions",
}

lvim.lsp.buffer_mappings.normal_mode["gr"] = {
	function()
		return require("trouble").open("lsp_references")
	end,
	"Goto references",
}

lvim.builtin.which_key.mappings.s.p = nil
lvim.builtin.which_key.mappings.Q = { "<cmd>qall<cr>", "Quit All" }
lvim.builtin.which_key.mappings.a = { "ggVG", "Select All" }
