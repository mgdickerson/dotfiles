return {
  -- Whichkey
  {
    "folke/which-key.nvim",
    -- This is lvim specific magic for filling Whichkey:
    -- config = function()
    --   require("lvim.core.which-key").setup()
    -- end,
    cmd = "WhichKey",
    event = "VeryLazy",
    -- enabled = lvim.builtin.which_key.active,

    keys = {
      {
        "<leader>/",
        "<Plug>(comment_toggle_linewise_current)",
        "Comment toggle current line",
        mode = "n",
      },
      {
        "<leader>/",
        "<Plug>(comment_toggle_linewise_visual)",
        "Comment toggle visual selection",
        mode = "v",
      }
    },
    vkeys = {

    },
  },

}
