local cmp = require('cmp')

local lspkind = require('lspkind')
lspkind.init()

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},

	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<c-y>'] = cmp.mapping.confirm({ select = true }, { 'i', 'c' }),
	},

	sources = cmp.config.sources{
		{ name = 'nvim_lua' },
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'ultisnips' },
		{ name = 'buffer', keyword_length = 5 },
	},

	formatting = {
		format = lspkind.cmp_format {
			with_text = true,
			menu = {
				buffer = '[buf]',
				nvim_lsp = '[lsp]',
				nvim_lua = '[api]',
				path = '[path]',
				ultisnips = '[snip]',
			},
		},
	},

	experimental = {
		native_menu = false,
		ghost_text = false,
	},
})


-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline', keyword_length = 3, }
	})
})

-- nvim-cmp highlight groups.
vim.cmd [[
	highlight! CmpItemAbbrMatch gui=bold guibg=NONE guifg=#A3BE8C
	highlight! CmpItemAbbrMatchFuzzy gui=bold guibg=NONE guifg=#A3BE8C
	highlight! CmpItemAbbrDeprecated gui=italic guibg=NONE guifg=#BF616A

	highlight! CmpItemKindDefault guibg=NONE guifg=#B48EAD
	highlight! CmpItemKindVariable guibg=NONE guifg=#88C0D0
	highlight! CmpItemKindInterface guibg=NONE guifg=#88C0D0
	highlight! CmpItemKindText guibg=NONE guifg=#88C0D0
	highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
	highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
	highlight! CmpItemKindKeyword guibg=NONE guifg=#EBCB8B
	highlight! CmpItemKindProperty guibg=NONE guifg=#EBCB8B
	highlight! CmpItemKindUnit guibg=NONE guifg=#EBCB8B

	highlight! CmpItemMenu guibg=NONE guifg=#E5E9F0
]]
