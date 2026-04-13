return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = {}, -- ← 关键：禁用 markdownlint
      },
    },
  },
}
