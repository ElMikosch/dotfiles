return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        gdscript = {},
        gdshader_lsp = {},
      },
    },
  },
}
