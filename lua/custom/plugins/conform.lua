return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        go = { 'gofmt' },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
    }
  end,
}
