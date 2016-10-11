-- watchtimer for mpv
-- by DonHansDampf github.com/DonHansDampf/watchtimer

local msg = require "mp.msg"
local utils = require "mp.utils"
local options = require "mp.options"

function osd(str)
  return mp.osd_message(str, 3)
end

function timestamp(duration)
  local hours = duration / 3600
  local minutes = duration % 3600 / 60
  local seconds = duration % 60
  return string.format("%02d:%02d:%02.03f",
                       hours,
                       minutes,
                       seconds)
end

function timer_start()
  local time_hour = os.date("%H")
  local time_min = os.date("%M")
  local time_sec = os.date("%S")
  local time = os.date("%X")

  if start_time then
    local end_time_hour = time_hour
    local end_time_min = time_min
    local end_time_sec = time_sec
    local end_time = time

    -- calculate watchtime
    local watch_time_hour = end_time_hour - start_time_hour
    local watch_time_min = end_time_min - start_time_min
    local watch_time_sec = end_time_sec - start_time_sec
    local watch_time = string.format("%02d:%02d:%02d",
                                     watch_time_hour,
                                     watch_time_min,
                                     watch_time_sec
    )

    osd(string.format("Watched from %s till %s; Duration: %s",
                      start_time,
                      end_time,
                      watch_time
    ))

    start_time_hour, start_time_min, start_time_sec, start_time = nil
  else
    start_time_hour = time_hour
    start_time_min = time_min
    start_time_sec = time_sec
    start_time = time

    osd(string.format("Started watching at: %s",
                      start_time
    ))
  end
end

mp.add_key_binding("t", "watchtimer_start", timer_start)
