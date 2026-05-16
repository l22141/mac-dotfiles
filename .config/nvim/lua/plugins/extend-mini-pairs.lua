return {
  "nvim-mini/mini.pairs",
  opts = {
    mappings = {
      ['"'] = { action = "closeopen", pair = '""', neigh_pattern = '[^\\"].', register = { cr = false } },
      ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
    },
  },
}
