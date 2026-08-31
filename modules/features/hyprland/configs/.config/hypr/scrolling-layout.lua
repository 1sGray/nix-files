hl.config({

    scrolling = {

        fullscreen_on_one_column = true, -- when enabled, a single column on a workspace will always span the entire screen. Def: true.

        column_width = 0.5, -- the default width of a column. Opt: [0.1~1.0], Def: 0.5

        focus_fit_method = 1, -- When a column is focused, what method should be used to bring it into view. Opt: 0 = center, 1 = fit, Def: 1

        follow_focus = true, -- when a window is focused, should the layout move to bring it into view automatically. Def = true.
        follow_min_visible = 0.4, -- when a window is focused, require that at least a given fraction of it is visible for focus to follow. Hard input (e.g., binds, clicks) will always follow. Opt: [0.1~1.0], Def = 0.4

        explicit_column_widths = "0.333, 0.5, 0.667, 1.0", -- A comma-separated list of preconfigured widths for colresize +conf/-conf Def = "0.333, 0.5, 0.667, 1.0"

        wrap_focus = true, -- When enabled, causes hl.dsp.layout("focus l/r") to wrap around at the beginning and end. Def = true.
        wrap_swapcol = true, -- When enabled, causes hl.dsp.layout("swapcol l/r") to wrap around at the beginning and end. Def = true

        direction = "right", -- Direction in which new windows appear and the layout scrolls. Opt: "left"/"right"/"down"/"up", Def = "right"

    },

})
