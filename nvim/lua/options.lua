-- :help options

local opt = vim.opt

-- preferences for :find
-- set path+=**

opt.wildmenu = true
opt.wildmode = { "longest", "list", "full" }
opt.number = true				-- set numbered lines
opt.relativenumber = true			-- set relative numbered lines
opt.clipboard = "unnamedplus"

