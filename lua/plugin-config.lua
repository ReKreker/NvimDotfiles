require('leap').add_default_mappings()
require("indent_blankline").setup{space_char_blankline = "."}
require("autoclose").setup()
require("nvim-surround").setup()
--require("hop").setup()
require("nvim-highlight-colors").setup()
require("lualine").setup{options={theme="codedark"}}

require("eyeliner").setup {
    highlight_on_key = true, -- show highlights only after keypress
    dim = true               -- dim all other characters if set to true (recommended!)
}

-- require("lightspeed").setup {
--     ignore_case = false,
--     exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
--     --- s/x ---
--     jump_to_unique_chars = { safety_timeout = 400 },
--     match_only_the_start_of_same_char_seqs = true,
--     force_beacons_into_match_width = false,
--     -- Display characters in a custom way in the highlighted matches.
--     substitute_chars = { ['\r'] = '¬', },
--     -- Leaving the appropriate list empty effectively disables "smart" mode,
--     -- and forces auto-jump to be on or off.
--     safe_labels = {},
--     labels = {},
--     -- These keys are captured directly by the plugin at runtime.
--     special_keys = {
--         next_match_group = '<space>',
--         prev_match_group = '<tab>',
--     },
--     --- f/t ---
--     limit_ft_matches = 4,
--     repeat_ft_with_target_char = false,
-- }

-- ( treesitter )
require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = {"c", "cpp", "typescript", "python", "cmake"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    -- List of parsers to ignore installing (for "all")

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat,
                                    vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    }
}

-- ( nvim-cmp )
local cmp = require 'cmp'
local lspkind = require 'lspkind'

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item) return vim_item end
        })
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        {name = 'vsnip'} -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {{name = 'buffer'}})
})

-- Set up lspconfig.
vim.lsp.set_log_level("debug")
local servers = {
    --'ruff_lsp',
    'pylsp',
    --'jedi_language_server',
    -- 'texlab',
    -- 'cmake',
    'clangd',
    -- 'tsserver'
    }

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
})

local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local on_attach = function(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<F3>',
                   function() vim.lsp.buf.format {async = true} end, bufopts)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    require("lsp_signature").on_attach({
          bind = true, -- This is mandatory, otherwise border config won't get registered.
          hint_prefix = "> ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
          handler_opts = {
            border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
          },
          floating_window_above_cur_line = false,
          select_signature_key = "<M-n>"
    }, bufnr)
end

require("mason-lspconfig").setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ["clangd"] = function()
        lspconfig.clangd.setup({
            cmd = {
                "clangd",
                "--background-index",
                -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
                -- to add more checks, create .clang-tidy file in the root directory
                -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
                "--clang-tidy",
                "--completion-style=bundled",
                "--cross-file-rename",
                "--header-insertion=iwyu",
            },
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
})


-- ( Diagrams )
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end
vim.api.nvim_set_keymap('n', '<space>v', ":lua Toggle_venn()<CR>", { noremap = true})
