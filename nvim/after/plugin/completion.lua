-- set completeopt=menuone,noinsert,noselect
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-e>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
    -- from @tjdevries
    ["<c-y>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(
        _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    }
    -- ['<CR>'] = cmp.mapping.confirm({
    --   behavior = cmp.ConfirmBehavior.Insert,
    --   select = true
    -- }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 3 },
  },
  formatting = {
    format = lspkind.cmp_format {
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        luasnip = "[snip]"
        },
      with_text = true
    }
  },
  experimental = {
    native_menu = false,
    ghost_text = false
  }
}


vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]
