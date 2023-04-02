-- ( indent-blankline )
vim.opt.list = true
vim.opt.listchars:append "space:⋅"

require("indent_blankline").setup {space_char_blankline = "."}

-- ( rainbow )
vim.g.rainbow_active = 1

-- ( autoclose )
require("autoclose").setup()

-- ( vim-cmake )
vim.g.cmake_build_dir_location = "./build"
vim.g.cmake_link_compile_commands = 1

-- ( treesitter )
require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = {"c", "cpp", "typescript", "python"},

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

-- ( nvim-tree )
require("nvim-tree").setup()

-- ( nvim surround )
require("nvim-surround").setup()

-- ( hjkl config )
-- require("delaytrain").setup {
--     delay_ms = 1000, -- How long repeated usage of a key should be prevented
--     grace_period = 1, -- How many repeated keypresses are allowed
--     keys = { -- Which keys (in which modes) should be delayed
--         ['nv'] = {'h', 'j', 'k', 'l'},
--         ['nvi'] = {'<Left>', '<Down>', '<Up>', '<Right>'}
--     },
--     ignore_filetypes = {} -- Example: set to {"help", "NvimTr*"} to
--     -- disable the plugin for help and NvimTree
-- }

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
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, {name = 'vsnip'} -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {{name = 'buffer'}})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--cmp.setup.cmdline({'/', '?'}, {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = {{name = 'buffer'}}
--})

-- Set up lspconfig.
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local on_attach = function(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true} -- , buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>h', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f',
                   function() vim.lsp.buf.format {async = true} end, bufopts)
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

local servers = {
    'pylsp', 
    'cmake', 
    'tsserver'}
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {on_attach = on_attach, capabilities = capabilities}
end
lspconfig["clangd"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
    }

}

-- ( hop )
require("hop").setup()

-- ( hex color viewer )
require("nvim-highlight-colors").setup()

-- ( LuaLine )
require("lualine").setup{
    options = { theme = "codedark" }
}

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
