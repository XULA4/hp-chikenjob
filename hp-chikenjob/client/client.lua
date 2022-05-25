local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

ESX = nil
local sleep = 1000
local text = false

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function ()
    while true do
        sleep = 1000
        local player = PlayerPedId()
          for i = 1, #vusca do
             if #(GetEntityCoords(player) - vusca[i].coords) <= 1.5 then
                  sleep = 7
                  if vusca[i].type == "chiken" then
                    text = "~f~[E]~s~ Get chiken"             
                  elseif vusca[i].type == "cleaningchiken" then
                      text = "~f~[E]~s~ Wash chiken"
                  elseif vusca[i].type == "processchiken" then
                      text = "~f~[E]~s~ Process chiken"
                  elseif vusca[i].type == "chickennuggets" then
                      text = "~f~[E]~s~ Get Nuggets"
                  elseif vusca[i].type == "cooking" then
                      text = "~f~[E]~s~ Get Chikentyson"
                  end
                  DrawText3D(vusca[i].coords.x, vusca[i].coords.y, vusca[i].coords.z, text or "Empty")
                  if IsControlJustReleased(0, 38) and #(GetEntityCoords(player) - vusca[i].coords) <= 1.5 then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "collecting",
                        duration = 5000,
                        label = 'Processing...',
                        useWhileDead = false,
                        canCancel = false,
                         controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "mp_arresting",
                            anim = "a_uncuff",
                            flags = 49,
                        },
                        }, function(status)
                        if not status then
                            TriggerServerEvent('hp-chikenjob:Product', vusca[i].Items, vusca[i].ReqItems)
                        else
                            ESX.ShowNotification('Transaction canceled')
                        end
                    end)
                end
             end
          end
          Citizen.Wait(sleep)
      end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(200, 255, 255, 200)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
	local coords = vector3(-67.3418, 6243.2510, 31.0771)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 178)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Chicken factory')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	local coords = vector3(129.6462, -1465.6404, 29.3570)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 384)
	SetBlipScale(blip, 0.7)
	SetBlipColour(blip, 3)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Chikentyson Dealer')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.NPCText.x, Config.NPCText.y, Config.NPCText.z, false)
        if distance < 5 then
            sleep = 5
            DrawText3D(Config.NPCText.x, Config.NPCText.y, Config.NPCText.z, '~g~E ~w~- Sell Chikentyson')
            if IsControlJustPressed(0, 38) then
                Chatting()
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- NPC
Citizen.CreateThread(function()
    if Config.NPCEnable == true then
        RequestModel(Config.NPCHash)
        while not HasModelLoaded(Config.NPCHash) do
            Wait(1)
        end
    
        stanley = CreatePed(1, Config.NPCHash, Config.NPCDealer.x, Config.NPCDealer.y, Config.NPCDealer.z, Config.NPCDealer.h, false, true)
        SetBlockingOfNonTemporaryEvents(stanley, true)
        SetPedDiesWhenInjured(stanley, false)
        SetPedCanPlayAmbientAnims(stanley, true)
        SetPedCanRagdollFromPlayerImpact(stanley, false)
        SetEntityInvincible(stanley, true)
        FreezeEntityPosition(stanley, true)
    end
end)

function Chatting()
     text31("Dealer : where is my food man", 3)
     Citizen.Wait(1700)
     text31("Me : Calm down here my friend", 3)
     Citizen.Wait(1700)
     TriggerEvent("mythic_progbar:client:progress", {
        name = "selling",
        duration = 5000,
        label = 'You Deliver the Package',
        useWhileDead = false,
        canCancel = false,
         controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        }, function(status)
        if not status then
            OpenMenu()
        else
            ESX.ShowNotification('Transaction canceled')
        end
    end)
     Citizen.Wait(2000)
     text31("Dealer : The food looks delicious, man!", 3)
end

RegisterCommand("menufix",function()
    ESX.UI.Menu.CloseAll()
end)

text31 = function(text, duration)
    local sure = duration * 1000
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(sure, 1)
  end
  
function OpenMenu()
    local elements = {
        {label = 'Selling Chikentyson',   value = 'chikentyson'},
        {label = 'Close',       value = 'closemenu'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_actions', {
        title    = 'Selling Chikentyson',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'chikentyson' then
            TriggerServerEvent("hp-chikenjob:Sell")
        elseif data.current.value == 'closemenu' then
            menu.close()
        end
    end)
end
