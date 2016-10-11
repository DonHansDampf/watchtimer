-- watchtimer for mpv
-- by DonHansDampf github.com/DonHansDampf/watchtimer

local msg = require "mp.msg"
local utils = require "mp.utils"
local options = require "mp.options"

function osd(str)
  return mp.osd_message(str, 3)
end

function timer_start()
  local time_int = os.time()
  local time_string = os.date("%X", time_int)

  if start_time_int then
    local end_time_int = time_int
    local end_time_string = time_string

    -- calculate watchtime
    local watch_time_int = os.difftime(end_time_int, start_time_int)
    local watch_time_string = os.date("!%X", watch_time_int)

    osd(string.format("Watched from %s till %s; Duration: %s",
                      start_time_string,
                      end_time_string,
                      watch_time_string
    ))

    start_time_int = nil
  else
    start_time_int = time_int
    start_time_string = time_string

    osd(string.format("Started watching at: %s",
                      start_time_string
    ))
  end
end

mp.add_key_binding("t", "watchtimer", timer_start)
