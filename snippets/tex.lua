-- lua/snippets/tex.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local extras = require("luasnip.extras")
local rep = extras.rep
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix

local function has_vimtex_fun(name)
  return vim.fn.exists("*" .. name) == 1
end

local function in_math()
  return has_vimtex_fun("vimtex#syntax#in_mathzone") and vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local function in_comment()
  return has_vimtex_fun("vimtex#syntax#in_comment") and vim.fn["vimtex#syntax#in_comment"]() == 1
end

local function math()
  return in_math() and not in_comment()
end

local function text()
  return not in_math() and not in_comment()
end

return {
  -- beg -> begin/end
  s(
    {
      trig = "beg",
      name = "begin/end",
      wordTrig = true,
      snippetType = "autosnippet",
      condition = text,
    },
    fmta(
      [[
\begin{<>}
  <>
\end{<>}
]],
      { i(1), i(0), rep(1) }
    )
  ),

  -- mk -> inline math
  s({
    trig = "mk",
    name = "inline math",
    wordTrig = true,
    snippetType = "autosnippet",
    condition = text,
  }, fmta("$<>$<>", { i(1), i(0) })),

  -- dm -> display math
  s(
    {
      trig = "dm",
      name = "display math",
      wordTrig = true,
      snippetType = "autosnippet",
      condition = text,
    },
    fmta(
      [[
\[
  <>
.\]
<>
]],
      { i(1), i(0) }
    )
  ),

  -- a1 -> a_1
  s(
    {
      trig = "([A-Za-z])(%d)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = math,
    },
    f(function(_, snip)
      return snip.captures[1] .. "_" .. snip.captures[2]
    end, {})
  ),

  -- a_12 -> a_{12}
  s(
    {
      trig = "([A-Za-z])_(%d%d)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = math,
    },
    f(function(_, snip)
      return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
    end, {})
  ),

  -- superscripts
  s({
    trig = "sr",
    name = "^2",
    wordTrig = true,
    snippetType = "autosnippet",
    condition = math,
  }, t("^2")),

  s({
    trig = "cb",
    name = "^3",
    wordTrig = true,
    snippetType = "autosnippet",
    condition = math,
  }, t("^3")),

  s({
    trig = "compl",
    name = "complement",
    wordTrig = true,
    snippetType = "autosnippet",
    condition = math,
  }, t("^{c}")),

  s({
    trig = "td",
    name = "superscript",
    wordTrig = true,
    snippetType = "autosnippet",
    condition = math,
  }, fmta("^{<>}<>", { i(1), i(0) })),

  -- 普通前缀 bar / hat
  s({
    trig = "bar",
    name = "overline",
    priority = 10,
    wordTrig = true,
    snippetType = "autosnippet",
    condition = math,
  }, fmta("\\overline{<>}<>", { i(1), i(0) })),

  s({
    trig = "hat",
    name = "hat",
    priority = 10,
    wordTrig = true,
    snippetType = "autosnippet",
    condition = math,
  }, fmta("\\hat{<>}<>", { i(1), i(0) })),

  -- postfix: zbar -> \overline{z}, phat -> \hat{p}
  postfix({
    trig = "bar",
    name = "overline postfix",
    priority = 100,
    snippetType = "autosnippet",
    condition = math,
  }, {
    f(function(_, parent)
      return "\\overline{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
    end, {}),
  }),

  postfix({
    trig = "hat",
    name = "hat postfix",
    priority = 100,
    snippetType = "autosnippet",
    condition = math,
  }, {
    f(function(_, parent)
      return "\\hat{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
    end, {}),
  }),
}
