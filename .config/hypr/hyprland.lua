------------------
---- MONITORS ----
------------------

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "1",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "alacritty"
local webBrowser = "firefox"
local webBrowserAlt = "firefox -P default-release"
local fileManager = "thunar"
local menu = "wofi --show drun --term=alacritty --width=30% --height=50% --columns 1 -I"
.. " -s " .. (os.getenv("HOME") or "") .. "/.config/wofi/themes/gruvbox.css"
.. " -o " .. (os.getenv("MAIN_DISPLAY") or "")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaync")
  hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("SSH_AUTH_SOCK", (os.getenv("XDG_RUNTIME_DIR") or "") .. "/gcr/ssh")
hl.env("TERMINAL", "alacritty")
hl.env("QT_QPA_PLATFORMTHEME","kde")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 2,
    col = {
      active_border = { colors = { "rgba(d3c6aaff)", "rgba(565956ff)" }, angle = 45 },
      inactive_border = "rgba(2d353bff)",
    },
    layout = "dwindle",
    allow_tearing = false,
  },

  decoration = {
    rounding = 0,
    blur = {
      enabled = true,
      size = 1,
      passes = 2,
      xray = true,
      special = true,
    },
    shadow = {
      enabled = false,
    },
    -- screen_shader = (os.getenv("HOME") or "") .. "/.config/hypr/grayscale.glsl",
  },

  animations = {
    enabled = true,
  },

  dwindle = {
    smart_split = true,
    special_scale_factor = 0.96,
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    background_color = 0x000000,
    disable_autoreload = true,
  },

  xwayland = {
    force_zero_scaling = true,
  },
})

-----------------------
---- ANIMATIONS -------
-----------------------

hl.curve("default", { type = "bezier", points = { { 0.05, 0.9 }, { 0.2, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 4, bezier = "default" })

---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout = "gb",
    repeat_delay = 200,
    repeat_rate = 30,
    sensitivity = -0.5,
    accel_profile = "flat",
    follow_mouse = 1,
    touchpad = {
      natural_scroll = true,
      tap_to_click = false,
    },
  },
})

hl.device({
  name = "dell07e6:00-06cb:76af-touchpad",
  accel_profile = "adaptive",
  sensitivity = 0,
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

---------------------
---- WINDOW RULES ---
---------------------

hl.window_rule({
  name = "no-solo-border",
  match = {
    float = false,
    workspace = "w[tv1]",
  },
  border_size = 0,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(webBrowser))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(webBrowserAlt))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Notification center
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw", {}))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Session
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())

-- Focus movement
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Workspace switching and window moving (1–10, where 10 uses the 0 key)
for i = 1, 10 do
  local key = i % 10 -- maps 10 → key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse: move and resize windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume (bindel → locked + repeating)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true })

-- Brightness (bindel → locked + repeating)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s -e2 +10%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s -e2 10%-"), { locked = true, repeating = true })

-- Media keys (bindl → locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshot: Print → grim region grab
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)"'), { locked = true })

-------------------------------
---- LOCAL OVERRIDES ----------
-------------------------------

require("hyprlandlocal")
