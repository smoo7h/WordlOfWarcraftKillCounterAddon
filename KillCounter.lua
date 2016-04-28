

function KillCount_OnLoad(frame)
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:RegisterEvent("PLAYER_PVP_KILLS_CHANGED")
    frame:RegisterForClicks("RightButtonUp")
    frame:RegisterForDrag("LeftButton")
    
end

function KillCount_OnEvent(frame, event, ...)
	text1 = "Killing Blows    "
	text2 = "Honorable Kills\n"
	text3 ="              "
	text4 = " "	
	killingBlows = getKillingBlows()
	statHon = GetStatisticId("Honorable Kills", "Total Honorable Kills")
	infoHon = GetStatistic(statHon)
	infoCommaHon = comma_value(infoHon)
	
    KillCountFrameText:SetText(text1 .. text2 .. killingBlows .. text4 .. text3 .. infoCommaHon)
end

function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end


function getKillingBlows()

	
	statNum1 = GetStatisticId("Killing Blows", "Arena Killing Blows")
	info1 = GetStatistic(statNum1)
	statNum2 = GetStatisticId("Killing Blows", "Battleground Killing Blows")
	info2 = GetStatistic(statNum2)
	
	
	if tonumber(info1) == nil and tonumber(info2) == nil then
		infoComma = 0
	elseif tonumber(info1) == nil then
		infoComma = comma_value(info2)
	elseif tonumber(info2) == nil then
		infoComma = comma_value(info1)
	else
		total = info1 + info2 
		infoComma = comma_value(total)
	end
	
	return infoComma
end

function GetStatisticId(CategoryTitle, StatisticTitle)
	local str = ""
	for _, CategoryId in pairs(GetStatisticsCategoryList()) do
		local Title, ParentCategoryId, Something
		Title, ParentCategoryId, Something = GetCategoryInfo(CategoryId)
		
		if Title == CategoryTitle then
			local i
			local statisticCount = GetCategoryNumAchievements(CategoryId)
			for i = 1, statisticCount do
				local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText
				IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText = GetAchievementInfo(CategoryId, i)
				if Name == StatisticTitle then
					return IDNumber
				end
			end
		end
	end
	return -1
end



