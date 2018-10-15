--// Cheers to ParkourPenguin for his initial filter script, which saved me some time:
--// https://forum.cheatengine.org/viewtopic.php?p=5685269&sid=58fdc55ed1a1c516759178c37508fd69

--// README: To use this script, simply place it in the autorun directory of your Cheat Engine installation
--//         folder. If you have CE open when you add this script, you will need to restart it.
--//         You should see a new right-click menu item in the results list: "Remove 'E' and "Nan" results"
--//   NOTE: Consider right-clicking on one of the column headers (Address, Value, or Previous) to bring up
--//         the menu. If you right-click on one of the results and choose "Remove 'E' and "Nan" results",
--//         then the result you right-clicked on will be removed since CE selects results with right-click
--//         as well.

--// Store current list of search results
local foundList = getMainForm().Foundlist3

--// Set up item removal for click simulation 
local menuItemRemove 
for i=0, foundList.PopupMenu.Items.Count-1 do 
  if foundList.PopupMenu.Items[i].Name == "Removeselectedaddresses1" then 
    menuItemRemove = foundList.PopupMenu.Items[i] 
    break 
  end 
end 

--// Create menu item
local menuItem = createMenuItem(foundList.PopupMenu) 
menuItem.Caption = "Remove \'E\' and \"Nan\" results" 

--// When menu item is clicked, run this function
menuItem.OnClick = function()

  --// Store "Found" results total for for-loop below
  local found = foundList.Items.Count
  for i = 0, found-1 do

    --// Store current and previous values
    local valueString = getMainForm().Foundlist3.Items[i].SubItems[0]
    local previousString = getMainForm().Foundlist3.Items[i].SubItems[1]

    --// If current or previous values contain an uppercase letter (E for
    --// exponent or N for "Nan"), then set their selected state to true
    if string.match(valueString, "%u") or string.match(previousString, "%u") then
        foundList.Items[i].Selected = true
    end
  end

  --// Simulate a click on "Remove selected addresses", which will remove
  --// addresses selected from the above for-loop. 
  menuItemRemove.DoClick()

end 

--// Create new right-click menu item in results list
foundList.PopupMenu.Items.insert(menuItemRemove.MenuIndex+1, menuItem)