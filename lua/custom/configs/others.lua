local M = {}

M.noice = {
	lsp = {
		progress = {
			enabled = true,
		},
		signature = {
			enabled = false,
		},
	},
	presets = {
		bottom_search = false,
		-- command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = true,
	},
	messages = {
		enabled = true,
		view = "notify",
		view_error = "notify",
		view_warn = "notify",
		view_history = "messages",
		view_search = "virtualtext",
	},
	health = {
		checker = false,
	},
}

M.signature = {
	floating_window = false,
}

M.flash = {
	highlight = {
		backdrop = false,
	},

	modes = {
		search = {
			enabled = false,
		},
		char = {
			highlight = { backdrop = false },
		},
	},
}

M.tabout = {
	tabkey = "", -- key to trigger tabout, set to an empty string to disable
	backwards_tabkey = "", -- key to trigger backwards tabout, set to an empty string to disable
	act_as_tab = true, -- shift content if tab out is not possible
	act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
	enable_backwards = true,
	completion = true, -- if the tabkey is used in a completion pum
	tabouts = {
		{ open = "'", close = "'" },
		{ open = '"', close = '"' },
		{ open = "`", close = "`" },
		{ open = "(", close = ")" },
		{ open = "[", close = "]" },
		{ open = "{", close = "}" },
	},
	ignore_beginning = true, -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content
	exclude = {}, -- tabout will ignore these filetypes}
}

M.ufo = {
	-- Fold options
	fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = (" ↙ %d "):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0

		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end

		-- Second line
		local lines = vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, false)
		local secondLine = nil
		if #lines == 1 then
			secondLine = lines[1]
		elseif #lines > 1 then
			secondLine = lines[2]
		end
		if secondLine ~= nil then
			table.insert(newVirtText, { secondLine, "AdCustomFold" })
		end

		table.insert(newVirtText, { suffix, "MoreMsg" })

		return newVirtText
	end,
}

local icons = lvim.icons.kind
M.outline = {
	autofold_depth = 1,
	symbols = {
		File = { icon = icons.File, hl = "@text.uri" },
		Module = { icon = icons.Module, hl = "@namespace" },
		Namespace = { icon = icons.Namespace, hl = "@namespace" },
		Package = { icon = icons.Package, hl = "@namespace" },
		Class = { icon = icons.Class, hl = "@type" },
		Method = { icon = icons.Method, hl = "@method" },
		Property = { icon = icons.Property, hl = "@method" },
		Field = { icon = icons.Field, hl = "@field" },
		Constructor = { icon = icons.Constructor, hl = "@constructor" },
		Enum = { icon = icons.Enum, hl = "@type" },
		Interface = { icon = icons.Interface, hl = "@type" },
		Function = { icon = icons.Function, hl = "@function" },
		Variable = { icon = icons.Variable, hl = "@constant" },
		Constant = { icon = icons.Constant, hl = "@constant" },
		String = { icon = icons.String, hl = "@string" },
		Number = { icon = icons.Number, hl = "@number" },
		Boolean = { icon = icons.Boolean, hl = "@boolean" },
		Array = { icon = icons.Array, hl = "@constant" },
		Object = { icon = icons.Object, hl = "@type" },
		Key = { icon = icons.Key, hl = "@type" },
		Null = { icon = icons.Null, hl = "@type" },
		EnumMember = { icon = icons.EnumMember, hl = "@field" },
		Struct = { icon = icons.Struct, hl = "@type" },
		Event = { icon = icons.Event, hl = "@type" },
		Operator = { icon = icons.Operator, hl = "@operator" },
		TypeParameter = { icon = icons.TypeParameter, hl = "@parameter" },
		Component = { icon = "󰡀", hl = "@function" },
		Fragment = { icon = "", hl = "@constant" },
	},
}

M.scroll = {
	mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "zt", "zb" },
	hide_cursor = true, -- Hide cursor while scrolling
	stop_eof = true, -- Stop at <EOF> when scrolling downwards
	use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
	respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	easing_function = nil, -- Default easing function
	pre_hook = nil, -- Function to run before the scrolling animation starts
	post_hook = nil, -- Function to run after the scrolling animation ends
}
return M
