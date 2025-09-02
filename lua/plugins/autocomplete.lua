return {
  {
    'williamboman/mason.nvim',
    build = ":MasonUpdate",
    config = function()
      require('mason').setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },

    config = function()
      require('mason-lspconfig').setup({
        automatic_installation = true,
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({
              capabilities = require('cmp_nvim_lsp').default_capabilities(),
              settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  diagnostics = { globals = { 'vim' } },
                },
              },
            })
          end,
        },
      })
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      cmp.event:on(
	      'confirm_done',
	      cmp_autopairs.on_confirm_done()
      )
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end,
  },
  {
	  'windwp/nvim-autopairs',
	  config = function()
		  require('nvim-autopairs').setup()
	  end
  },
  {
	  'windwp/nvim-ts-autotag',
	  ft = { 'html', 'javascriptreact', 'typescriptreact', 'xml' },
	  config = function()
		  require('nvim-ts-autotag').setup()
	  end,
	  dependencies = {
		  'nvim-treesitter/nvim-treesitter'
	  }
  }
}

