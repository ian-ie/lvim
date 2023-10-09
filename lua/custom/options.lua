vim.api.nvim_create_autocmd({ "InsertLeave", "CursorMoved" }, {
	pattern = "*",
	command = "normal! zz",
})

vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.cursorline = true
vim.opt.fileencodings = "utf-8,gb2312,gbk"


if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font Mono,等距更纱黑体 SC:h11"
	vim.g.neovide_remember_window_size = false
	vim.g.neovide_transparency = 0.95
	vim.g.neovide_cursor_vfx_mode = "wireframe"
else
	lvim.transparent_window = true
end
