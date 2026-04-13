return {
  {
    "gaoDean/autolist.nvim",
    ft = { "markdown", "text", "tex", "plaintex", "norg" },
    config = function()
      require("autolist").setup()

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "text", "tex", "plaintex", "norg" },
        callback = function(args)
          local opts = { buffer = args.buf }

          vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<CR>", opts)
          vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<CR>", opts)
          vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<CR>", opts)

          -- 可选：列表缩进
          vim.keymap.set("i", "<Tab>", "<cmd>AutolistTab<CR>", opts)
          vim.keymap.set("i", "<S-Tab>", "<cmd>AutolistShiftTab<CR>", opts)

          -- 可选：切换 checkbox
          vim.keymap.set("n", "<leader>mx", "<cmd>AutolistToggleCheckbox<CR>", opts)
        end,
      })
    end,
  },
}
