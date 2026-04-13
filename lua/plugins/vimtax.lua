-- lua/plugins/vimtex.lua
return {
  {
    "lervag/vimtex",
    init = function()
      vim.g.tex_flavor = "latex"

      -- PDF viewer: Skim
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1

      -- 不要老弹 quickfix
      vim.g.vimtex_quickfix_mode = 0

      -- 文章里用的是旧的 g:tex_conceal；在当前 VimTeX 里用这个
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        texTabularChar = 1,
        spacing = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 0,
        styles = 1,
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "plaintex", "bib" },
        callback = function()
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = "nc"
        end,
      })

      -- 如果你的 LaTeX 模板统一走 xelatex，可打开这段
      -- vim.g.vimtex_compiler_latexmk = {
      --   options = {
      --     "-xelatex",
      --     "-synctex=1",
      --     "-interaction=nonstopmode",
      --     "-file-line-error",
      --   },
      -- }
    end,
  },
}
