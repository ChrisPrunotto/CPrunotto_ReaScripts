--[[
 * ReaScript Name: CP_Move Snap Offset To Start of Media Item
 * Author: Chris Prunotto
 * Author URI: www.chrisprunotto.com
 * Repository: https://github.com/ChrisPrunotto/ReaperResources
 * Licence: GPL v3
 * REAPER: 6.12c
 * Version: 1.0
--]]

--[[
 * Description: Moves snap offset to the start of the media item.
 * Instructions: Select items. Run.
--]]
 
--[[
 * Changelog:
 * v1.0 (2020-07-21)
  + Initial Release
--]]

-- functions --
function main()
  for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
    local item = reaper.GetSelectedMediaItem(0,i)
    reaper.SetMediaItemInfo_Value(item, "D_SNAPOFFSET", 0)
  end
end

-- program --
reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()
main()
reaper.Undo_EndBlock("Move Snap Offset to Start of Media Item", -1)
reaper.UpdateArrange()
reaper.PreventUIRefresh(-1)
