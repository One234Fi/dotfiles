require("outline").setup({
    outline_window = {
        -- Where to open the split window: right/left
        position = 'right',
        -- The default split commands used are 'topleft vs' and 'botright vs'
        -- depending on `position`. You can change this by providing your own
        -- `split_command`.
        -- `position` will not be considered if `split_command` is non-nil.
        -- This should be a valid vim command used for opening the split for the
        -- outline window. Eg, 'rightbelow vsplit'.
        split_command = nil,

        -- Percentage or integer of columns
        width = 25, 
        -- Whether width is relative to the total width of nvim
        -- When relative_width = true, this means take 25% of the total
        -- screen width for outline window.
        relative_width = true,

        -- Auto close the outline window if goto_location is triggered and not for
        -- peek_location
        auto_close = false,
        -- Automatically scroll to the location in code when navigating outline window.
        auto_jump = false,
        -- boolean or integer for milliseconds duration to apply a temporary highlight
        -- when jumping. false to disable.
        jump_highlight_duration = 300,

        -- Vim options for the outline window
        show_numbers = false,
        show_relative_numbers = false,
        wrap = false,

        show_cursorline = true,
        -- Enable this only if you enabled cursorline so your cursor color can
        -- blend with the cursorline, in effect, as if your cursor is hidden
        -- in the outline window.
        -- This is useful because with cursorline, there isn't really a need
        -- to know the vertical column position of the cursor and it may even
        -- be distracting, rendering lineno/guides/icons unreadable.
        -- This makes your line of cursor have the same color as if the cursor
        -- wasn't focused on the outline window.
        -- This feature is experimental.
        hide_cursor = false,

        -- Whether to auto-focus on the outline window when it is opened.
        -- Set to false to *always* retain focus on your previous buffer when opening
        -- outline.
        -- If you enable this you can still use bangs in :Outline! or :OutlineOpen! to
        -- retain focus on your code. If this is false, retaining focus will be
        -- enforced for :Outline/:OutlineOpen and you will not be able to have the
        -- other behaviour.
        focus_on_open = true,
        -- Winhighlight option for outline window.
        -- See :help 'winhl'
        -- To change background color to "CustomHl" for example, append "Normal:CustomHl".
        -- Note that if you're adding highlight changes, you should append to this
        -- default value, otherwise details/lineno will not have highlights.
        winhl = "OutlineDetails:Comment,OutlineLineno:LineNr",
    },

    outline_items = {
        -- Whether to highlight the currently hovered symbol and all direct parents
        highlight_hovered_item = true,
        -- Show extra details with the symbols (lsp dependent) as virtual next
        show_symbol_details = true,
        -- Show corresponding line numbers of each symbol on the left column as
        -- virtual text, for quick navigation when not focused on outline.
        -- Why? See this comment:
        -- https://github.com/simrat39/symbols-outline.nvim/issues/212#issuecomment-1793503563
        show_symbol_lineno = true,
    },

    -- Options for outline guides which help show tree hierarchy of symbols
    guides = {
        enabled = true,
        markers = {
            -- It is recommended for bottom and middle markers to use the same number
            -- of characters to align all child nodes vertically.
            bottom = '└',
            middle = '├',
            vertical = '│',
        },
    },

    symbol_folding = {
        -- Depth past which nodes will be folded by default
        autofold_depth = nil,
        -- Automatically unfold currently hovered symbol
        auto_unfold_hover = true,
        markers = { '', '' },
    },

    preview_window = {
        -- Automatically open preview of code location when navigating outline window
        auto_preview = false,
        -- Automatically open hover_symbol when opening preview (see keymaps for
        -- hover_symbol).
        -- If you disable this you can still open hover_symbol using your keymap
        -- below.
        open_hover_on_preview = false,
        width = 50,     -- Percentage or integer of columns
        min_width = 50, -- This is the number of columns
        -- Whether width is relative to the total width of nvim.
        -- When relative_width = true, this means take 50% of the total
        -- screen width for preview window, ensure the result width is at least 50
        -- characters wide.
        relative_width = true,
        -- Border option for floating preview window.
        -- Options include: single/double/rounded/solid/shadow or an array of border
        -- characters.
        -- See :help nvim_open_win() and search for "border" option.
        border = 'single',
        -- winhl options for the preview window, see ':h winhl'
        winhl = '',
        -- Pseudo-transparency of the preview window, see ':h winblend'
        winblend = 0
    },

    -- These keymaps can be a string or a table for multiple keys.
    -- Set to `{}` to disable. (Using 'nil' will fallback to default keys)
    keymaps = { 
        show_help = '?',
        close = {"<Esc>", "q"},
        -- Jump to symbol under cursor.
        -- It can auto close the outline window when triggered, see
        -- 'auto_close' option above.
        goto_location = "<Cr>",
        -- Jump to symbol under cursor but keep focus on outline window.
        peek_location = "o",
        -- Visit location in code and close outline immediately
        goto_and_close = "<S-Cr>",
        -- Change cursor position of outline window to match current location in code.
        -- "Opposite" of goto/peek_location.
        restore_location = "<C-g>",
        -- Open LSP/provider-dependent symbol hover information
        hover_symbol = "<C-space>",
        -- Preview location code of the symbol under cursor
        toggle_preview = "K",
        -- Symbol actions
        rename_symbol = "r",
        code_actions = "a",
        -- These fold actions are collapsing tree nodes, not code folding
        fold = "h",
        unfold = "l",
        fold_toggle = "<Tab>",
        -- Toggle folds for all nodes.
        -- If at least one node is folded, this action will fold all nodes.
        -- If all nodes are folded, this action will unfold all nodes.
        fold_toggle_all = "<S-Tab>",
        fold_all = "W",
        unfold_all = "E",
        fold_reset = "R",
        -- Move down/up by one line and peek_location immediately.
        -- You can also use outline_window.auto_jump=true to do this for any
        -- j/k/<down>/<up>.
        down_and_jump = "<C-j>",
        up_and_jump = "<C-k>",
    },

    providers = {
        priority = { 'lsp', 'coc', 'markdown' },
        lsp = {
            -- Lsp client names to ignore
            blacklist_clients = {},
        },
    },

    symbols = {
        icon_fetcher = function(_) return "" end,
    }

})
