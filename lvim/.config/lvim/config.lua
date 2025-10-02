-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

if vim.loop.os_uname().sysname == "Windows_NT" then
  -- Enable powershell as your default shell
  vim.opt.shell = "pwsh.exe"
  vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.cmd [[
            let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
            let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
            set shellquote= shellxquote=
      ]]

  -- Set a compatible clipboard manager
  vim.g.clipboard = {
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
  }
else
  vim.g.clipboard = {
    name = "xclip",
    copy = {
      ["+"] = "xclip -selection clipboard",
      ["*"] = "xclip -selection primary",
    },
    paste = {
      ["+"] = "xclip -selection clipboard -o",
      ["*"] = "xclip -selection primary -o",
    },
    cache_enabled = 0,
  }
  vim.o.shell = "/bin/zsh"
end

vim.opt.conceallevel = 1
lvim.builtin.treesitter.ensure_installed = {
  "markdown", "markdown_inline", "regex", "comment", "yaml", "latex", "html"
}
lvim.builtin.treesitter.highlight.disable = { "css", "latex", "markdown", "cls" }
require("lvim.lsp.manager").setup("marksman")

lvim.plugins = {
  { "Mofiqul/dracula.nvim" },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end
  },
  {
    "jalvesaq/zotcite",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    config = function ()
        require("zotcite").setup({
            -- your options here (see doc/zotcite.txt)
        })
    end
  },
  { "jalvesaq/cmp-zotcite",
    ft={"pandoc", "markdown", "rmd", "quarto"},
  },
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },
  {
    "hisbaan/dataview.nvim",
    -- configuration here, see below for full configuration options
    opts = {
        vault_dir = "~/Documents/Notes/",
        buffer_type = "float", -- float | split | vsplit | tab
    },
    ft = {"markdown"},
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "zotero")
end
lvim.builtin.cmp.on_config_done = function(cmp)
  pcall(cmp.sources, { name = "cmp_zotcite" })
end

lvim.colorscheme = "dracula"
