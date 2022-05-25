ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('hp-chikenjob:Product')
AddEventHandler('hp-chikenjob:Product', function(item, reqItem)
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)
     if type(item) == "table" then
      if reqItem ~= nil then
         for i,z in pairs(reqItem) do 
            if xPlayer.getInventoryItem(z.name).count >= z.count then
               xPlayer.removeInventoryItem(z.name, z.count)
            else
               xPlayer.showNotification("You Don't Have Requested Item")
               return false
            end
         end
      end
      TriggerEvent('hp-chikenjob:additem', src, item)
    end
end) 

RegisterServerEvent('hp-chikenjob:additem')
AddEventHandler('hp-chikenjob:additem', function(source, item)
   local src = source 
   local xPlayer = ESX.GetPlayerFromId(src)
   for k,v in pairs(item) do
      xPlayer.addInventoryItem(v.name, v.count)
   end
end)


RegisterNetEvent("hp-chikenjob:Sell")
AddEventHandler("hp-chikenjob:Sell", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('chikentyson').count > 0 then
                local money = Config.Price
                local count = xPlayer.getInventoryItem('chikentyson').count
                xPlayer.removeInventoryItem('chikentyson', count)
                dclog(xPlayer, '** '..count.. ' sold chikentyson ' ..money.. ' $ dollars won**')
                xPlayer.addMoney(money*count)
            elseif xPlayer.getInventoryItem('chikentyson').count < 1 then
                xPlayer.showNotification("You Dont Have Chikentyson")
            end
        end
    end)

function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
  
    local discord_webhook = "Your Server Webhook"
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "Put Username Here",
      ["avatar_url"] = "Put Your Avatar here",
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. xPlayer.identifier
        },
        ["color"] = 1942002,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
    local replacements = {
        ['&' ] = '&amp;',
        ['<' ] = '&lt;',
        ['>' ] = '&gt;',
        ['\n'] = '<br/>'
    }

    return str
        :gsub('[&<>\n]', replacements)
        :gsub(' +', function(s)
            return ' '..('&nbsp;'):rep(#s-1)
        end)
end
