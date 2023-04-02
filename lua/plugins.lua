return require('packer').startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'EdenEast/nightfox.nvim'

    -- Sidebar with folders
    use 'nvim-tree/nvim-tree.lua'

    -- Look&feel
    use 'lukas-reineke/indent-blankline.nvim'
    use 'luochen1990/rainbow'
    use 'm4xshen/autoclose.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'brenoprata10/nvim-highlight-colors'

    -- LSP
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'ray-x/lsp_signature.nvim'

    -- Surround by '', (), {} and etc
    use 'kylechui/nvim-surround'

    -- hjkl training
    -- use 'ja-ford/delaytrain.nvim'

    -- Compile stuff
    use 'cdelledonne/vim-cmake'

    -- Snippets
    use 'onsails/lspkind.nvim'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'rafamadriz/friendly-snippets'

    -- Completion stuff
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    -- Hop
    use {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
    }

    -- Line
    use 'nvim-lualine/lualine.nvim'

    -- Diagramming
    use 'jbyuki/venn.nvim'

    -- Converting
    use 'glts/vim-magnum'
    use 'glts/vim-radical'

end)
