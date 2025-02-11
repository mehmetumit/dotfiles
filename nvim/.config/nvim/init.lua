-- vim.opt.keymap = 'ş['
-- vim.keymap.set({ 'n', 'v' }, 'ş', '[', { silent = true })


-- Make sure to set `mapleader` before lazy so your mappings are correct
-- Comma location in US keyboard
-- vim.g.mapleader = 'ö'
vim.g.mapleader = ','
vim.g.maplocalleader = ' '
local signs = {
  Error = "❌",
  Warn = "⚠️",
  Hint = "💡",
  Info = "",
}
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- 'Wansmer/langmapper.nvim',
  --   lazy = false,
  --   priority = 1, -- High priority is needed if you will use `autoremap()`
  --   config = function()
  --     require('langmapper').setup({--[[ your config ]]})
  --   end,
  -- Surround
  'tpope/vim-surround',
  -- Session managment
  'tpope/vim-obsession',
  -- vim wiki
  'vimwiki/vimwiki',
  -- HTML plugin
  -- 'mattn/emmet-vim',
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  {
    -- Analyze troubles
    'folke/trouble.nvim',
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    -- Copilot
    -- 'github/copilot.vim'
  },
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status progress updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim lua configuration easier
      'folke/neodev.nvim',
      {
        -- For formatters and linters
        -- 'nvimtools/none-ls.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
          -- "nvimtools/none-ls-extras.nvim",
          'nvim-lua/plenary.nvim'
        },
      },
      -- 'mfussenegger/nvim-jdtls'

    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'windwp/nvim-autopairs',
      -- Snippets
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
  },
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    opts = {}
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      -- current_line_blame_formatter = '<author>, <author_time:%R> - <abbrev_sha> - <summary>',
    },
  },
  {
    -- Theme
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      -- sections = {
      --   lualine_a = {
      --     cond=""
      --   }
      -- }
    },
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {}
    -- opts = {
    --   char = '┊',
    --   show_trailing_blankline_indent = false,
    -- },
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    -- Native fzf implementation in c. Need to load like down below
    -- Enable telescope fzf native, if installed
    -- pcall(require('telescope').load_extension, 'fzf')
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    --    config = function()
    --      require("nvim-tree").setup {
    --      }
    --      end,
  },
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
  }
}, {})

-- [[Configure theme ]]
require('onedark').setup({ style = 'cool' })
require('onedark').load()
-- [[ Setting options ]]
-- See `:help vim.o`

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
-- default split positions
vim.o.splitbelow = true
vim.o.splitright = true
-- Make tab chracter as 4 spaces wide
vim.o.tabstop = 4
vim.opt.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.cursorline = true
-- vim.opt.guicursor = ""


vim.opt.wrap = true
-- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.rnu = true
-- vim.o.list = true
-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Update time
vim.o.updatetime = 300
-- vim.o.timeout = true
-- vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- set termguicolors to enable highlight groups
vim.o.termguicolors = true
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python3_host_prog='/bin/python3.9'
-- [[ Keymaps ]]

-- Copy paste magics
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- Asynchronously Format current buffer
vim.keymap.set('n', '<leader>fp', ":Format<CR>")
-- Add normal save
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>');
-- Disable page scrolling
vim.keymap.set('n', '<C-f>', '<Nop>');
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- For turkish keyboard
vim.keymap.set({ 'n', 'v' }, 'ı', 'i');
vim.keymap.set({ 'n', 'v' }, '<C-ı>', '<C-i>');

-- Replace all is aliased to S
vim.keymap.set('n', 'S', ':%s//g<Left><Left>');
--- Quickly switch between tabs
vim.keymap.set('n', 'H', 'gT');
vim.keymap.set('n', 'L', 'gt');
--- Open new empty tab
vim.keymap.set('n', 'tn', ':tabnew<CR>');
-- Searching
-- vim.keymap.set({ 'n', 'v' }, '/', '/\v');

--- Split navigation remap
vim.keymap.set({ 'n', 'v' }, '<C-h>', '<C-w>h');
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<C-w>j');
vim.keymap.set({ 'n', 'v' }, '<C-k>', '<C-w>k');
vim.keymap.set({ 'n', 'v' }, '<C-l>', '<C-w>l');
--- Remove all trailing whitespace by pressing F5
-- vim.keymap.set('n',  '<F5>', ':let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>');
--- Neovim powered terminal keybindings
vim.keymap.set({ 'n', 'v' }, '<leader>t', ':term<CR>');
vim.keymap.set({ 'n', 'v' }, '<leader>T', ':vert :term<CR>');
-- Open shell
vim.keymap.set({ 'n', 'v' }, '<leader>CS', ':shell<CR>');
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<leader>l', ':Lazy<CR>')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Null-ls ]]

local null_ls = require('null-ls');
null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.trail_space.with({
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    null_ls.builtins.formatting.trim_newlines,
    -- null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.formatting.prettierd.with({
    --       condition = function(utils)
    --         return utils.has_file({ ".prettierrc.json" })
    --       end,
    --     }),
    null_ls.builtins.diagnostics.eslint_d.with({
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.vacuum.with({
      diagnostic_config = {
        -- see :help vim.diagnostic.config()
        underline = false,
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        severity_sort = true,

      },
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    null_ls.builtins.completion.luasnip,
  }

}

-- [[ Configure indent-blankline ]]
require('ibl').setup({
  indent = { char = '┊', },
  whitespace = {
    remove_blankline_trail = false,
  },
  -- scope = { enabled = false },
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    layout_config = {
      -- prompt_position = 'top'
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

local builtin = require('telescope.builtin')
-- Enable telescope fzf native, if installed
-- pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>fl', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  -- builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    -- winblend = 10,
    -- previewer = false,
    -- layout_config = {width = 0.6, height = 0.6}
  -- })
  builtin.live_grep({search_dirs={vim.fn.expand("%:p")}})
end, { desc = '[F]ind [L]ine in current buffer' })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = '[F]ind [C]ommands' })
vim.keymap.set('n', '<leader>fhc', builtin.command_history, { desc = '[F]ind in Command [H]istory' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles using .gitignore' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffer' })
vim.keymap.set('n', '<leader>fa', builtin.live_grep, { desc = '[F]ind [A]ll Using Grep' })
vim.keymap.set('n', '<leader>fD', builtin.diagnostics, { desc = '[F]ind All [D]iagnostics' })
vim.keymap.set('n', '<leader>fd', function() builtin.diagnostics({ bufnr = 0 }) end,
  { desc = '[F]ind [D]iagnostics In Current Buffer' })

-- [[ Configure NvimTree ]]
--Toggle tree
vim.keymap.set('n', '<C-t>', '<cmd>NvimTreeToggle<CR>');
local function tree_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.del('n', '<C-t>', { buffer = bufnr })
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'));
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'));
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'));
  vim.keymap.set('n', '<C-h>', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles')) --alternative to H
  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Dir up'));
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close node'));
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical split'));
  vim.keymap.set('n', 'T', api.node.open.tab, opts('Open: New Tab'));
end
require("nvim-tree").setup {
  on_attach = tree_on_attach,
  actions = {
    open_file = {
      -- quit_on_open = true,
    },
  },
  -- trash = {
  --   cmd = "gio trash"
  -- },
  -- hijack_cursor = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = signs.Hint,
      info = signs.Info,
      warning = signs.Warn,
      error = signs.Error,
    }
  },
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    root_folder_label = false,
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}
-- [[ Configure Treesitter ]]
-- Advanced syntax highlighting
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'templ', 'lua', 'python', 'rust', 'tsx', 'javascript', 'java', 'bash', 'html', 'json',
    'vue', 'yaml', 'make', 'css', 'typescript', 'vimdoc', 'vim', 'dart', 'dockerfile' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' }, width = 4 },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      disable = {'dart'}, -- Disabled for performance resasons
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
local function quickfix()
  -- local isFirstCodeAction = true;
  vim.lsp.buf.code_action({
    -- filter = function(action, idx)
    --   if isFirstCodeAction then
    --     isFirstCodeAction = false
    --     return true
    --   else
    --     return false
    --   end
    -- end,
    apply = true,
  })
end
vim.keymap.set('n', '<leader>qf', quickfix, { desc = "Open diagnostics list and fix" })
-- vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
-- Use m key to change between workspace and document diagnostics
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble toggle diagnostics<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble toggle quickfix<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})

-- [[ Configure Go ]]
require('go').setup({
  run_in_floaterm = true,
  test_runner = 'go',
  floaterm = {            -- position
    posititon = 'center', -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
    width = 0.90,         -- width of float window if not auto
    height = 0.98,        -- height of float window if not auto

  },
})
-- [[ Configure Trouble ]]
require('trouble').setup {
  action_keys = {
    jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
    open_split = { "x" },       -- open buffer in new split
    open_vsplit = { "v" },      -- open buffer in new vsplit
    open_tab = { "<c-t>" },     -- open buffer in new tab
    jump_close = { "o", "l" },  -- jump to the diagnostic and close the list
    toggle_fold = { "h" },      -- toggle fold of current file
  },
  signs = {
    error = signs.Error,
    warning = signs.Warn,
    hint = signs.Hint,
    information = signs.Info,
  },
}
-- LSP settings.
-- Set lsp signs
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- Diagnostic popup
vim.diagnostic.config({
  virtual_text = true,
  float = {
    source = 'always',
  },
})
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    -- if vim.lsp.buf.server_ready() then
    if #vim.lsp.get_clients() > 0 then
      -- vim.diagnostic.open_float({ scope = 'line' })
      vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
    end
  end,
})
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- Create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gDt', "<cmd>tab split | lua require'telescope.builtin'.lsp_definitions()<cr>", '[G]oto [D]efinition In New [T]ab')
  nmap('gDs', "<cmd>vsplit | lua require'telescope.builtin'.lsp_definitions()<cr>", '[G]oto [D]efinition In New [S]plit')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- Hover documentation
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- Hover help
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    -- Disable default lsp formatting for spesific clients to prevent conflictions with prettier
    vim.lsp.buf.format({
      async = true,
      filter = function(client) return (client.name ~= "tsserver" and client.name ~= "volar") end
    })
    -- vim.lsp.buf.format({ async = true })
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- templ = { },
  -- htmx = { },
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    }
  },

  -- tailwindcss = {
  --   filetypes = { "templ", "astro", "javascript", "typescript", "react" },
  --   init_options = { userLanguages = { templ = "html" } },
  -- }
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


-- [[ Configure Nvim Autopairs ]]
require('nvim-autopairs').setup({
})
-- [[ Configure Mason ]]
vim.keymap.set('n', '<leader>m', ':Mason<CR>')
-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

-- Setup dartls language server
-- require('lspconfig')["dartls"].setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = servers["dartls"],
-- }
-- Setup flutter
require("flutter-tools").setup {
  lsp = {
  capabilities = capabilities,
  on_attach = on_attach,
  }
}


-- Add templ extension in orther to make lsp work automatically
vim.filetype.add({ extension = { templ = "templ" } })

mason_lspconfig.setup_handlers {
  function(server_name)
    -- If custom config exists
    if servers[server_name] then
      servers[server_name].capabilities = capabilities
      servers[server_name].on_attach = on_attach
      require('lspconfig')[server_name].setup(servers[server_name])
    else
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
-- Insert `(` after select function or method item
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- Java LSP Setup
-- local jdtls_default_config = require("lspconfig")["jdtls"].document_config.default_config
-- local config = {
--   on_attach = function()
--     require("jdtls.setup").add_commands()
--   end,
--   cmd = jdtls_default_config.cmd,
--   root_dir = jdtls_default_config.root_dir(),
--   settings = {
--     java = {
--       extendedClientCapabilities = {
--         classFileContentsSupport = true
--       },
--       maven = {
--         downloadSources = true
--
--       },
--       implementationsCodeLens = {
--         enabled = true
--       },
--       referencesCodeLens = {
--         enabled = true
--       },
--       references = {
--         includeDecompiledSources = true
--       },
--       format = {
--         enabled = true,
--         settings = {
--           url =
--           "https://gist.githubusercontent.com/ikws4/7880fdcb4e3bf4a38999a628d287b1ab/raw/9005c451ed1ff629679d6100e22d63acc805e170/jdtls-formatter-style.xml",
--         },
--       },
--     },
--     signatureHelp = { enabled = true },
--     importOrder = {
--       "java",
--       "javax",
--       "com",
--       "org"
--     }
--   },
--   init_options = {
--     -- extendedClientCapabilities = {
--     --   classFileContentsSupport = true
--     -- },
--     bundles = {},
--   },
-- }
-- require("jdtls").start_or_attach(config)
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
