return {
  "chrisgrieser/nvim-spider",
  opts = {
    skipInsignificantPunctuation = false,
    consistentOperatorPending = true,
  },
  keys = {
    {
      "gw",
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to end of word",
    },
    {
      "ge",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to start of next word",
    },
    {
      "gb",
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to start of previous word",
    },
  },
}
