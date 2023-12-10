-- default keybinding: b
-- add the following to your input.conf to change the default keybinding:
-- keyname script_binding auto_load_subs
local utils = require 'mp.utils'

local credentials = {
  '--opensubtitles', 'USERNAME', 'PASSWORD'
}
local lang = "en"
function display_error()
  mp.msg.warn("Subtitle download failed: ")
  mp.osd_message("Subtitle download failed")
end

function load_sub_fn()
  --path = mp.get_property("path")
  path = mp.get_property("media-title")
  srt_path = string.gsub(path, "%.%w+$", ".srt")
  t = { args = { "subliminal", credentials[1], credentials[2], credentials[3] ,"download", "-s", "-f", "-l", lang, srt_path } }

  mp.osd_message("Searching subtitle...")
  res = utils.subprocess(t)
  if res.error == nil then
    if mp.commandv("sub_add", srt_path) then
      mp.msg.warn("Subtitle download succeeded")
      mp.osd_message("Subtitle '" .. srt_path .. "' download succeeded")
    else
      display_error()
    end
  else
    display_error()
  end
end

mp.add_key_binding("b", "auto_load_subs", load_sub_fn)
