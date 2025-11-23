local M = {}

function M.setup(opts)
  opts = opts or {}

  -- Setup LSP
  require('lumos.lsp').setup()

  -- Setup Tree-sitter if available
  local ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
  if ok then
    ts_configs.setup({
      ensure_installed = { 'lumos' },
      highlight = { enable = true },
    })
  end
end

return M
