lvim.keys.insert_mode["<C-s>"] = "<ESC>:w<CR>"
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.normal_mode["<Tab>"] = "<cmd>BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = "<cmd>BufferLineCyclePrev<cr>"

lvim.builtin.which_key.mappings["x"] = { "<cmd>BufferKill<CR>", "Close Buffer" }
lvim.builtin.which_key.mappings["c"] = { "<cmd>cd %:h<CR>", "cd cur" }
lvim.builtin.which_key.mappings["o"] = { "<cmd>SymbolsOutline<CR>", "outline" }
lvim.builtin.which_key.mappings.n = { name = "Notice" }
lvim.builtin.which_key.mappings.r = { name = "SnipRun" }
lvim.builtin.which_key.mappings.T = { name = "Translate" }
lvim.builtin.which_key.mappings.L.c = { name = "LeetCode" }

lvim.builtin.which_key.mappings["s"]["P"] = { "<cmd>Telescope projects<CR>", "projects" }

lvim.builtin.which_key.mappings["l"]["v"] = { ":lua vim.diagnostic.config({ virtual_text = false})<CR>", "close virtual" }

lvim.builtin.which_key.mappings["b"]["o"] = { "<cmd>BufOnly<CR>:e<CR>", "close all buffer but this" }
