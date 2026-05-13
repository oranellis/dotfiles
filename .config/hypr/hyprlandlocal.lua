hl.monitor({
  output = "desc:Iiyama North America PL3466WQ 0000000000000",
  mode = "3440x1440@144",
  position = "auto",
  scale = "1.25",
})

hl.monitor({
  output = "desc:Advanced Micro Peripherals Ltd ES07D03 EVE213400057",
  mode = "3840x2160@144",
  position = "auto",
  scale = "1.5",
})

hl.env("QT_QPA_PLATFORM", "xcb")

hl.on("hyprland.start", function()
  hl.exec_cmd("xrdb -merge ~/.Xresources 2>/dev/null")
end)
