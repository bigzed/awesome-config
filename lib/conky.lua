local awful = require("awful")
local gears = require("gears")

do
  local conky = nil

  function get_conky(default)
    if conky and conky.valid then
      return conky
    end

    conky = awful.client.iterate(function(c) return c.class == "Conky" end) ()
    return conky or default
  end

  function raise_conky()
    get_conky({}).ontop = true
  end

  function lower_conky()
    get_conky({}).ontop = false
  end

  local t = timer({ timeout = 0.01 })
  t:connect_signal("timeout", function()
    t:stop()
    lower_conky()
  end)
  
  function lower_conky_delayed()
    t:again()
  end

  function toggle_conky()
    local conky = get_conky({})
    conky.ontop = not conky.ontop
  end
end

