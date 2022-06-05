local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

treesitter.setup {
  ensure_installed = {"css", "html", "javascript", "json", "json5", "lua", "php", "python", "ruby", "scheme", "scss", "tsx", "typescript", "vim", "vue", "yaml" }, -- A list of parser names, or "all"
  sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing (for "all")
  highlight = {
    enable = true, -- `false` will disable the whole extension
    disable = { "" }, -- list of language that will be disabled

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
