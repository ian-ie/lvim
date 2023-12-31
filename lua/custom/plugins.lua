local others = require("custom.configs.others")

lvim.plugins = {
	{ "spin6lock/vim_sproto", ft = "sproto" },
	{
		"glepnir/template.nvim",
		cmd = { "Template", "TemProject" },
		config = function()
			require("template").setup({
				temp_dir = "~/.config/lvim/template",
			})
		end,
	},
	{
		"folke/zen-mode.nvim",
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "toggle zen mode" } },
	},
	-- 输入法切换
	{
		"keaising/im-select.nvim",
		config = function()
			require("im_select").setup({
				-- IM will be set to `default_im_select` in `normal` mode
				-- For Windows/WSL, default: "1033", aka: English US Keyboard
				-- For macOS, default: "com.apple.keylayout.ABC", aka: US
				-- For Linux, default:
				--               "keyboard-us" for Fcitx5
				--               "1" for Fcitx
				--               "xkb:us::eng" for ibus
				-- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
				default_im_select = "1033",

				-- Can be binary's name or binary's full path,
				-- e.g. 'im-select' or '/usr/local/bin/im-select'
				-- For Windows/WSL, default: "im-select.exe"
				-- For macOS, default: "im-select"
				-- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
				default_command = "im-select.exe",

				-- Restore the default input method state when the following events are triggered
				set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

				-- Restore the previous used input method state when the following events
				-- are triggered, if you don't want to restore previous used im in Insert mode,
				-- e.g. deprecated `disable_auto_restore = 1`, just let it empty
				-- as `set_previous_events = {}`
				set_previous_events = { "InsertEnter" },

				-- Show notification about how to install executable binary when binary missed
				keep_quiet_on_no_binary = false,

				-- Async run `default_command` to switch IM or not
				async_switch_im = true,
			})
		end,
	},
	-- 符号对齐
	{
		"junegunn/vim-easy-align",
		keys = {
			{ "ga", "<plug>(EasyAlign)", desc = "align", mode = "x" },
			{ "ga", "<plug>(EasyAlign)", desc = "align", mode = "n" },
		},
		config = function()
			vim.cmd([[
                let g:easy_align_delimiters = {
                    \ 'l': { 'pattern': '--\+', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] }
                    \ }
                ]])
		end,
	},
	-- increment
	{
		"monaqa/dial.nvim",
		keys = {
			{ "<C-a>", "<Plug>(dial-increment)", desc = "dial-increment" },
			{ "<C-x>", "<Plug>(dial-decrement)", desc = "dial-decrement" },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
					augend.constant.alias.bool, -- boolean value (true <-> false)
					augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
					augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
				},
			})
		end,
	},
	-- 居中
	{
		"arnamak/stay-centered.nvim",
		config = function()
			require("stay-centered").setup()
		end,
	},
	-- 快捷jj
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"metakirby5/codi.vim",
		keys = { { "<leader>lc", "<cmd>CodiSelect<cr>", desc = "select codi" } },
	},
	-- 高亮todo
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	--显示颜色
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			require("colorizer").setup()
		end,
	},
	--quickfix增强
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			require("bqf").setup()
		end,
	},
	-- 自动关闭搜索高亮
	{ "romainl/vim-cool" },
	-- 搜索替换
	{
		"roobert/search-replace.nvim",
		config = function()
			require("search-replace").setup({
				-- optionally override defaults
				default_replace_single_buffer_options = "gcI",
				default_replace_multi_buffer_options = "egcI",
			})
		end,
		keys = {
			-- stylua: ignore
			{ "<leader>rS", "<CMD>SearchReplaceSingleBufferSelections<CR>", desc = "[s]elction list" },
			{ "<leader>ro", "<CMD>SearchReplaceSingleBuffeoOpen<CR>", desc = "[o]pen" },
			{ "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", desc = "[w]ord" },
			{ "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", desc = "[W]ORD" },
			{ "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", desc = "[e]xpr" },
			{ "<leader>rF", "<CMD>SearchReplaceSingleBufferCFile<CR>", desc = "[f]ile" },
			{ "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", mode = "v" },
			{ "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", mode = "v" },
			{ "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", mode = "v" },
		},
	},
	{
		"nvim-pack/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
		keys = {
            -- stylua: ignore start
			{ "<leader>so", "<cmd>lua require('spectre').open()<CR>", desc = "Open Spectre" },
			{ "<leader>sw", "<Esc><cmd>lua require('spectre').open_visual({select_word=true})<CR>", desc = "Search Current Word", },
			{ "<leader>sp", "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", desc = "Search On Current File", },
			{ "<leader>sw", "<cmd>lua require('spectre').open_visual()<CR>", desc = "Search Current Word", mode = "v", },
			-- stylua: ignore end
		},
	},
	-- tabnien
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = "hrsh7th/nvim-cmp",
	},
	--[[ {
		"codota/tabnine-nvim",
		build = "./dl_binaries.sh",
		config = function()
			require("tabnine").setup({
				disable_auto_comment = false,
				accept_keymap = "<C-Tab>",
				dismiss_keymap = "<C-]>",
				debounce_ms = 800,
				suggestion_color = { gui = "#808080", cterm = 244 },
				exclude_filetypes = { "TelescopePrompt", "NvimTree" },
				log_file_path = "~/script/", -- absolute path to Tabnine log file,
			})
		end,
	}, ]]

	-- 参数提示
	{
		"ray-x/lsp_signature.nvim",
		event = { "BufRead", "BufNew" },
		config = function()
			require("lsp_signature").setup(others.signature)
		end,
	},
	-- 符号信息
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		config = function()
			require("symbols-outline").setup(others.outline)
		end,
	},
	--置灰未使用变量
	{
		"zbirenbaum/neodim",
		event = "LspAttach",
		config = function()
			require("neodim").setup({
				alpha = 0.75,
				blend_color = "#000000",
				update_in_insert = {
					enable = true,
					delay = 100,
				},
				hide = {
					virtual_text = true,
					signs = false,
					underline = false,
				},
			})
		end,
	},
	-- 诊断合集
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		keys = {
			{ "<leader>tt", "<cmd>TroubleToggle<cr>", desc = "trouble" },
			{ "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "workspace" },
			{ "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "document" },
			{ "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>", desc = "references" },
		},
	},
	--窗口预览goto
	{
		"rmagatti/goto-preview",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("goto-preview").setup({
				default_mappings = true,
				post_open_hook = function(_, win)
					-- Close the current preview window with <Esc>
					vim.keymap.set("n", "<Esc>", function()
						vim.api.nvim_win_close(win, true)
					end, { buffer = true })
					vim.keymap.set("n", "q", function()
						vim.api.nvim_win_close(win, true)
					end, { buffer = true })
				end,
			})
		end,
	},
	--恢复上次浏览
	{
		"ethanholz/nvim-lastplace",
		lazy = false,
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			})
		end,
	},

	--nvimapi补全
	{ "folke/neodev.nvim" },

	-- 会话
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "folds" } },
	},
	-- 翻译
	{
		"voldikss/vim-translator",
		cmd = "TranslateW",
		keys = {
			{ "gt", "<cmd>TranslateW<cr>", desc = "to cn", mode = { "n", "v" } },
			{ "gC", "<cmd>TranslateW --target_lang=en<cr>", desc = "to en", mode = { "v", "n" } },
		},
	},
	-- 行跳转
	{
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
	},

	-- 代码片段运行
	{
		"michaelb/sniprun",
		build = "bash ./install.sh",
		cmd = "SnipRun",
		keys = {
			{ "<leader>rf", "<cmd>%SnipRun<cr>", desc = "run file" },
			{ "<leader>rs", "<Plug>SnipRun", desc = "run snip" },
			{ "<leader>rc", "<Plug>SnipClose", desc = "close" },
			{ "<leader>rr", "<Plug>SnipReset", desc = "reset" },
			{ "<leader>r", "<Plug>SnipRun", desc = "run", mode = "v" },
		},
	},
	-- 多光标
	{
		"mg979/vim-visual-multi",
		event = "VeryLazy",
		branch = "master",
		enable = false,
		init = function()
			vim.g.VM_maps = {
				["Find Under"] = "<C-n>",
				-- ["Find Subword Under"] = "<C-u>",
				-- ["Select All"] = "<C-a>",
				-- ["Select h"] = "<C-h>",
				-- ["Select l"] = "<C-l>",
				["Add Cursor Up"] = "<C-k>",
				["Add Cursor Down"] = "<C-j>",
				["Add Cursor At Pos"] = "<C-c>",
				-- ["Add Cursor At Word"] = "<C-w>",
				["Remove Region"] = "q",
			}
		end,
	},

	-- 快速移动
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = others.flash,
		keys = {
			-- stylua: ignore start
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
			{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash Treesitter Search", },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search", },
			-- stylua: ignore end
		},
	},

	-- 加("")
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- %增强
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	-- 彩虹括号
	{
		"HiPhish/nvim-ts-rainbow2",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	-- 智能v
	{
		"RRethy/nvim-treesitter-textsubjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				textsubjects = {
					enable = true,
					prev_selection = ",",
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = "textsubjects-container-inner",
					},
				},
			})
		end,
	},
	-- ts对象增强
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	-- v增强
	{
		"chrisgrieser/nvim-various-textobjs",
		opts = { useDefaultKeymaps = true, disabledKeymaps = { "L" } },
	},
	-- 跳出tab
	{
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
		},
		opts = others.tabout,
	},
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({
				default_mappings = true,
				-- which builtin marks to show. default {}
				builtin_marks = { ".", "<", ">", "^" },
				-- whether movements cycle back to the beginning/end of buffer. default true
				cyclic = true,
				-- whether the shada file is updated after modifying uppercase marks. default false
				force_write_shada = false,
				-- how often (in ms) to redraw signs/recompute mark positions.
				-- higher values will have better performance but may cause visual lag,
				-- while lower values may cause performance penalties. default 150.
				refresh_interval = 250,
				-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
				-- marks, and bookmarks.
				-- can be either a table with all/none of the keys, or a single number, in which case
				-- the priority applies to all marks.
				-- default 10.
				sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
				-- disables mark tracking for specific filetypes. default {}
				excluded_filetypes = {},
				-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
				-- sign/virttext. Bookmarks can be used to group together positions and quickly move
				-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
				-- default virt_text is "".
				bookmark_0 = {
					sign = "⚑",
					virt_text = "hello world",
					-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
					-- defaults to false.
					annotate = false,
				},
				mappings = {},
			})
		end,
	},
	--折叠
	{
		"kevinhwang91/nvim-ufo",
		event = "BufRead",
		dependencies = {
			{ "kevinhwang91/promise-async" },
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						-- foldfunc = "builtin",
						-- setopt = true,
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},

		config = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.api.nvim_command("highlight AdCustomFold guifg=#6699CC")
			require("ufo").setup(others.ufo)
		end,
		keys = {
			-- stylua: ignore start
			{ "zR", function() require("ufo").openAllFolds() end, desc = "open all folds", },
			{ "zM", function() require("ufo").closeAllFolds() end, desc = "colse all folds", },
			{ "Z", function() local winid = require("ufo").peekFoldedLinesUnderCursor() if not winid then vim.lsp.buf.hover() end end, desc = "preview fold", },
			{ "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "open same level fold", },
			{ "zm", function() require("ufo").closeFoldsWith() end, desc = "close same level fold", },
			-- stylua: ignore end
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup({
						background_colour = "#000000",
					})
				end,
			},
			{ "MunifTanjim/nui.nvim" },
		},

		opts = others.noice,
		keys = {
			{ "<leader>ns", "<cmd>Notifications<cr>", desc = "show notifications" },
			{ "<leader>nt", "<cmd>Noice telescope<cr>", desc = "show notice in telescope" },
			{ "<leader>nm", "<cmd>messages<cr>", desc = "show message" },
			{ "<leader>nd", "<cmd>NoiceDisable<cr>", desc = "NoiceDisable" },
			{ "<leader>ne", "<cmd>NoiceEnable<cr>", desc = "NoiceEnable" },
		},
	},
	-- 加速j k
	{
		"rainbowhxch/accelerated-jk.nvim",
		config = function()
			require("neoscroll").setup(others.scroll)
		end,
		keys = {
			{ "j", "<Plug>(accelerated_jk_gj)", mode = "n" },
			{ "k", "<Plug>(accelerated_jk_gk)", mode = "n" },
		},
	},
	-- 平滑滚动
	{
		"karb94/neoscroll.nvim",
		event = "BufRead",
		config = function()
			require("neoscroll").setup(others.scroll)
		end,
	},
	-- 更好的ui
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	-- 缩进线
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup()
		end,
	},
	-- theme
	{ "olimorris/onedarkpro.nvim" },
	{ "catppuccin/nvim", name = "catppuccin", pririty = 1000, opts = others.catppuccin },
}
