local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt", "goimports" },
    sql = {},
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "sql" then
      return nil  -- explicitly skip SQL
    end
    return {
      timeout_ms = 500,
      lsp_fallback = true,
    }
  end,
}

return options
