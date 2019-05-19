local TeleportFromTo = {
	["Sandy Offices"] = {
		positionFrom = { ['x'] = 1848.66, ['y'] = 3690.31, ['z'] = 34.27, nom = "Go Main Offices"},
		positionTo = { ['x'] = 1853.73, ['y'] = 3716.17, ['z'] = 1.08, nom = "Exit the Main Offices"},
	},

	["Meth Lab"] = {
		positionFrom = { ['x'] = 996.81, ['y'] = -3200.59, ['z'] = -36.39, nom = "Exit Meth Lab"},
		positionTo = { ['x'] = -341.6, ['y'] = 3744.83, ['z'] = 69.97, nom = "Enter Meth  Lab"},
	},
	
	["Money Wash"] = {
		positionFrom = { ['x'] = -490.2, ['y'] = -2682.38, ['z'] = 21.75, nom = "Enter Money Wash"},
		positionTo = { ['x'] = 1138.16, ['y'] = -3198.75, ['z'] = -39.67, nom = "Exit Money Wash"},
	},
	
	["Coke Lab"] = {
		positionFrom = { ['x'] = -443.78, ['y'] = 5601.63, ['z'] = 68.37, nom = "Enter Coke lab"},
		positionTo = { ['x'] = 1088.65, ['y'] = -3187.5, ['z'] = -38.99, nom = "Exit Coke lab"},
	},

	["Weed Lab"] = {
		positionFrom = { ['x'] = 2224.69, ['y'] = 5604.91, ['z'] = 54.92, nom = "Enter Weed Lab"},
		positionTo = { ['x'] = 1066.4, ['y'] = -3183.16, ['z'] = -39.16, nom = "Exit Weed Lab"},
	},

	["Shadow"] = {
		positionFrom = { ['x'] = -690.59, ['y'] = -893.19, ['z'] = 24.71, nom = "Enter the Shadow  Lounge"},
		positionTo = { ['x'] = 996.88, ['y'] = -3158.31, ['z'] = -38.91, nom = "Exit the Shadow  Lounge"},
	},
	
	["Sandy Station jail cells"] = {
		positionFrom = { ['x'] = 1851.12, ['y'] = 3683.30, ['z'] = 34.32, nom = "Enter Cell Block"},
		positionTo = { ['x'] = 1849.465, ['y'] = 3682.871, ['z'] = -118.76, nom = "Exit Cell Block"},
	},
	
	["Paleto Station"] = {
		positionFrom = { ['x'] = -442.352, ['y'] = 6012.365, ['z'] = 31.76, nom = "Enter the station"},
		positionTo = { ['x'] = -441.880, ['y'] = 6010.498, ['z'] = -118.761 , nom = "Exit the station"},
	},
	
	["Courthouse"] = {
		positionFrom = { ['x'] = 233.35, ['y'] = -410.89, ['z'] = 48.11, nom = "Enter the City Court"},
		positionTo = { ['x'] = 236.101, ['y'] = -413.360, ['z'] = -118.150, nom = "Exit the court"},
	},	
	
	["Courtroom"] = {
		positionFrom = { ['x'] = 225.338, ['y'] = -419.71, ['z'] = -118.150, nom = "Go inside the court room"},
		positionTo = { ['x'] = 238.794, ['y'] = -334.078, ['z'] = -118.760, nom = "Exit the court room"},
	},
	
	["UD Heist"] = {
		positionFrom = { ['x'] = 10.20, ['y'] = -671.30, ['z'] = 33.45, nom = "Use the elevator"},
		positionTo = { ['x'] = -0.04, ['y'] = -705.78, ['z'] = 16.13, nom = "Use the elevator"},
	},
	
  
}

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing


function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function Drawing.drawMissionText(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
end

function msginf(msg, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(duree, 1)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k, j in pairs(TeleportFromTo) do

			--msginf(k .. " " .. tostring(j.positionFrom.x), 15000)
			if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 150.0)then
				DrawMarker(1, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, .801, 255, 255, 255,255, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 5.0)then
					Drawing.draw3DText(j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1.100, j.positionFrom.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
					if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 2.0)then
						ClearPrints()
						SetTextEntry_2("STRING")
						AddTextComponentString("Press ~r~E~w~ to ".. j.positionFrom.nom)
						DrawSubtitleTimed(2000, 1)
						if IsControlJustPressed(1, 38) then
							DoScreenFadeOut(1000)
							Citizen.Wait(2000)
							SetEntityCoords(GetPlayerPed(-1), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
							DoScreenFadeIn(1000)
						end
					end
				end
			end

			if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 150.0)then
				DrawMarker(1, j.positionTo.x, j.positionTo.y, j.positionTo.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, .801, 255, 255, 255,255, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 5.0)then
					Drawing.draw3DText(j.positionTo.x, j.positionTo.y, j.positionTo.z - 1.100, j.positionTo.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
					if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 2.0)then
						ClearPrints()
						SetTextEntry_2("STRING")
						AddTextComponentString("Press ~r~E~w~ to ".. j.positionTo.nom)
						DrawSubtitleTimed(2000, 1)
						if IsControlJustPressed(1, 38) then
							DoScreenFadeOut(1000)
							Citizen.Wait(2000)
							SetEntityCoords(GetPlayerPed(-1), j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1)
							DoScreenFadeIn(1000)
						end
					end
				end
			end
		end
	end
end)
