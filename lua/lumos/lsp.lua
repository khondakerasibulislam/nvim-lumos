local M = {}

function M.setup()
  -- Check if lspconfig is available
  local ok, lspconfig = pcall(require, 'lspconfig')
  if not ok then
    return
  end

  local configs_ok, configs = pcall(require, 'lspconfig.configs')
  if not configs_ok then
    return
  end

  -- Register LUMOS LSP server
  if not configs.lumos then
    configs.lumos = {
      default_config = {
        cmd = {'lumos-lsp'},
        filetypes = {'lumos'},
        root_dir = lspconfig.util.root_pattern('.git', 'Cargo.toml'),
        settings = {},
      },
    }
  end

  -- Setup LSP
  lspconfig.lumos.setup({
    on_attach = function(client, bufnr)
      -- Enable completion
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Keybindings
      local opts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end,
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  })
end

return M
