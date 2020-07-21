--[[
 * ReaScript Name: CP_Move Snap Offset To Peak Sample
 * Author: Chris Prunotto
 * Author URI: www.chrisprunotto.com
 * Repository: https://github.com/ChrisPrunotto/ReaperResources
 * Licence: GPL v3
 * REAPER: 6.12c
 * Version: 1.0
--]]

--[[
 * Description: Moves snap offset to the peak sample +/- an offset.
 * Instructions: Select items. Run. Enter Offset.
--]]
 
--[[
 * Changelog:
 * v1.0 (2020-07-21)
  + Initial Release
--]]

---------USER CONFIG AREA-------------
default_value = "-50" -- Default is 50ms before peak.
--------------------------------------

-- functions --
function main(offset)
  for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
    local item = reaper.GetSelectedMediaItem(0,i)
    local peakval, peakpos = reaper.NF_GetMediaItemMaxPeakAndMaxPeakPos(item)
    
    peakoffset = peakpos + (offset/1000)
    
    reaper.SetMediaItemInfo_Value(item, "D_SNAPOFFSET", peakoffset)
  end
end

-- program --
reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

selected_items_count = reaper.CountSelectedMediaItems(0)

if selected_items_count > 0 then

  default_csv = default_value
  retval, output_csv = reaper.GetUserInputs("Snap Offset", 1, "Snap Offset in Milliseconds:", default_csv)
  
  if retval then
    if tonumber(output_csv) then
      main(output_csv)
    else reaper.ShowConsoleMsg("Please Enter A Number!")
    end
  end
end

reaper.Undo_EndBlock("Move Snap Offset to Peak", -1)
reaper.UpdateArrange()
reaper.PreventUIRefresh(-1)
