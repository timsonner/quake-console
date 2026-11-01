-- Quake console panel. Omarchy's default is a centered box, half the screen
-- tall and twice as wide as it is tall. This one is full width and about 70%
-- of the work area tall. The default fitter rewrites the workspace rule
-- whenever the console opens or the window count changes, so this one writes
-- after it.
--
-- The window is slightly see-through. override sets that exactly: the
-- terminal tag would otherwise multiply it again.

o.window("org\\.omarchy\\.agent", { opacity = "0.8 override 0.8 override" })

local QUAKE_SHARE = 0.7
local QUAKE = "special:qconsole"
local quake_below = nil

local function quake_apply(bottom, force)
  if not force and quake_below == bottom then
    return
  end
  quake_below = bottom

  hl.workspace_rule({
    workspace = QUAKE,
    gaps_in = 0,
    gaps_out = { top = 0, right = 0, bottom = bottom, left = 0 },
    no_border = true,
  })
  hl.exec_scheduled_prop_refresh_immediately()
end

local function quake_fit(monitor, force)
  if not monitor or not monitor.scale or monitor.scale <= 0 then
    return
  end

  local height = monitor.height
  if monitor.transform % 2 == 1 then
    height = monitor.width
  end

  local reserved = monitor.reserved
  height = height / monitor.scale - reserved.top - reserved.bottom
  local tall = math.floor(height * QUAKE_SHARE)
  quake_apply(math.floor(height - tall), force)
end

local function quake_monitor()
  local ws = hl.get_workspace(QUAKE)
  local mon = ws and ws.visible and ws.monitor
  if mon and mon.scale and mon.scale > 0 then
    return mon
  end
  return hl.get_active_monitor()
end

quake_fit(quake_monitor(), true)

hl.on("monitor.layout_changed", function()
  quake_fit(quake_monitor(), false)
end)

hl.on("monitor.focused", function()
  quake_fit(quake_monitor(), false)
end)

-- Opening, or landing on another screen, can change how many windows the
-- default fitter sees. Always rewrite then, even if the height is unchanged.
hl.on("workspace.special_active", function(ws, mon)
  if ws and ws.name == QUAKE then
    quake_fit(mon, true)
  end
end)

hl.on("workspace.move_to_monitor", function(ws, mon)
  if ws and ws.name == QUAKE then
    quake_fit(mon, true)
  end
end)

local function quake_recount()
  local ws = hl.get_workspace(QUAKE)
  if ws and ws.visible then
    quake_fit(quake_monitor(), true)
  end
end

hl.on("window.open", quake_recount)
hl.on("window.destroy", quake_recount)
hl.on("window.move_to_workspace", quake_recount)
hl.on("window.update_rules", quake_recount)
