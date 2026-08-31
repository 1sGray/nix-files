hl.config({
    general = {
        gaps_in = 2, -- Gaps between windows. Def: 5
        gaps_out = 10, -- Gaps between windows and monitor edges. Def: 20
        border_size = 4, -- Size of the border around windows. Opt: [0 - 20], Def: 1
        layout = "scrolling", -- Which layout to use. Options: "dwindle"/"master"/"scrolling"/"monocle". Def: "dwindle"
        col = {
            active_border = "rgba(7fc8ffee)",   -- Border color for the active window. Def: 0xffffffff
            inactive_border = "rgba(505050ff)", -- Border color for inactive windows. Def: 0xff444444
        },
    },

decoration = {
    rounding = 10, -- Rounded corners’ radius (in layout px). Opt: [0 - 100], Def: 0
    rounding_power = 2, -- Adjusts the curve used for rounding corners, larger is smoother, 1.0 is a triangular corner, 2.0 is a circle, 4.0 is a squircle. Opt: [1.0 - 10.0] , Def: 2.0
    active_opacity = 1.0, -- Opacity of active windows. Opt: [0.0 - 1.0] Def: 1.0
    inactive_opacity = 1.0, -- Opacity of inactive windows. Opt: [0.0 - 1.0] Def: 1.0

    -- Opt: , Def:

    shadow = {
        enabled = true, -- Enable drop shadows on windows. Def: true
        range = 4, -- Shadow range (size) in pixels Opt: [0 - 100] , Def: 4
        render_power = 3, -- In what power to render the falloff. More power, the faster the falloff. Opt: [1 - 4] , Def: 3
        color = 0xee1a1a1a, -- Active window shadow’s color. Alpha dictates the opacity. Def: 0xee1a1a1a
    },

    blur = {
        enabled = true, -- Enable kawase window background blur. Def:true
        size = 3, -- Blur size (distance). Def: 8
        passes = 2, -- The amount of passes to perform. Opt: [0 - 10] , Def: 1
        vibrancy = 0.1696, -- Increase saturation of blurred colors. Opt: [0.0 - 1.0] , Def: 0.1696
    },
},

    animations = { enabled = true },
    dwindle = { preserve_split = true },
})
