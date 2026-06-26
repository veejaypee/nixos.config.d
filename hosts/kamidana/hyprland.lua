-- hyprland.lua

----------------
-- VARIABLES --
----------------

local terminal = "alacritty"
local menu = "wofi --show drun"

local mainMod = "SUPER"

----------------
-- MONITORS ---
----------------

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

hl.monitor({
    output = "DP-1",
    mode = "3840x2160@240",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "DP-3",
    mode = "3840x2160@60",
    position = "-3840x0",
    scale = 1,
})

-------------------
-- ENVIRONMENT ---
-------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

----------------
-- SETTINGS ---
----------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border = {
                colors = {
                    "rgba(33ccffee)",
                    "rgba(00ff99ee)",
                },
                angle = 45,
            },

            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing = true,

        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },

    input = {
        kb_layout = "us",
        kb_variant = "altgr-intl",

        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-----------------
-- PER DEVICE ---
-----------------

hl.device({
    name = "epic-mouse-v1",

    sensitivity = -0.5,
})
--------------------
-- ANIMATIONS -----
--------------------

-- Beziers (curves)
hl.curve("easeOutQuint", {
    { 0.23, 1.0 },
    { 0.32, 1.0 },
})

hl.curve("easeInOutCubic", {
    { 0.65, 0.05 },
    { 0.36, 1.0 },
})

hl.curve("linear", {
    { 0.0, 0.0 },
    { 1.0, 1.0 },
})

hl.curve("almostLinear", {
    { 0.5,  0.5 },
    { 0.75, 1.0 },
})

hl.curve("quick", {
    { 0.15, 0.0 },
    { 0.1,  1.0 },
})

-- Global animations toggle
hl.animation({
    name = "global",
    enabled = true,
    duration = 10,
    curve = "default",
})

hl.animation({
    name = "border",
    enabled = true,
    duration = 5.39,
    curve = "easeOutQuint",
})

hl.animation({
    name = "windows",
    enabled = true,
    duration = 4.79,
    curve = "easeOutQuint",
})

hl.animation({
    name = "windowsIn",
    enabled = true,
    duration = 4.1,
    curve = "easeOutQuint",
    style = "popin 87%",
})

hl.animation({
    name = "windowsOut",
    enabled = true,
    duration = 1.49,
    curve = "linear",
    style = "popin 87%",
})

hl.animation({
    name = "fadeIn",
    enabled = true,
    duration = 1.73,
    curve = "almostLinear",
})

hl.animation({
    name = "fadeOut",
    enabled = true,
    duration = 1.46,
    curve = "almostLinear",
})

hl.animation({
    name = "fade",
    enabled = true,
    duration = 3.03,
    curve = "quick",
})

hl.animation({
    name = "layers",
    enabled = true,
    duration = 3.81,
    curve = "easeOutQuint",
})

hl.animation({
    name = "layersIn",
    enabled = true,
    duration = 4.0,
    curve = "easeOutQuint",
    style = "fade",
})

hl.animation({
    name = "layersOut",
    enabled = true,
    duration = 1.5,
    curve = "linear",
    style = "fade",
})

hl.animation({
    name = "fadeLayersIn",
    enabled = true,
    duration = 1.79,
    curve = "almostLinear",
})

hl.animation({
    name = "fadeLayersOut",
    enabled = true,
    duration = 1.39,
    curve = "almostLinear",
})

hl.animation({
    name = "workspaces",
    enabled = true,
    duration = 1.94,
    curve = "almostLinear",
    style = "fade",
})

hl.animation({
    name = "workspacesIn",
    enabled = true,
    duration = 1.21,
    curve = "almostLinear",
    style = "fade",
})

hl.animation({
    name = "workspacesOut",
    enabled = true,
    duration = 1.94,
    curve = "almostLinear",
    style = "fade",
})

------------------
-- CORE BINDS ---
------------------

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + C", hl.dsp.window.kill())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.toggle_floating())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P", hl.dsp.layout.pseudo())

-- direction focus (vim style)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
--------------------
-- WORKSPACES -----
--------------------

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.workspace(i))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.move_to_workspace(i))
end

hl.bind(mainMod .. " + 0", hl.dsp.workspace(10))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.move_to_workspace(10))

------------------------
-- SPECIAL WORKSPACE --
------------------------

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.move_to_workspace("special:magic"))

------------------
-- MOUSE BINDS ---
------------------

hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace({ direction = "next" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace({ direction = "prev" }))

hl.bind_mouse(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind_mouse(mainMod .. " + mouse:273", hl.dsp.window.resize())

--------------------------
-- MEDIA / SYSTEM KEYS ---
--------------------------

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+")
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-")
)

-- media playback
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
