vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.lumos",
  callback = function()
    vim.bo.filetype = "lumos"
  end,
})
