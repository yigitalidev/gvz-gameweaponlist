RegisterServerEvent('blacklist:drop')
AddEventHandler('blacklist:drop', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.kick(Config.KickMessage)
end)

RegisterServerEvent('blacklist:dclog')
AddEventHandler('blacklist:dclog', function(text)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    dclog(xPlayer, text)
end)

function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
    
    for k, v in ipairs(GetPlayerIdentifiers(xPlayer.source)) do
        if string.match(v, 'discord:') then
            identifierDiscord = v
        end
        if string.match(v, 'ip:') then
            identifierIp = v
        end
    end
	
	local discord_webhook = GetConvar('discord_webhook', Config.DiscordWebhook)
	if discord_webhook == '' then
	  return
	end
	local headers = {
	  ['Content-Type'] = 'application/json'
	}
	local data = {
	  ['username'] = Config.WebhookName,
	  ['avatar_url'] = Config.WebhookAvatarUrl,
	  ['embeds'] = {{
		['author'] = {
          ['name'] = 'gvz-blacklistweapon',
          ['icon_url'] = 'https://cdn.discordapp.com/attachments/785071461516836874/802859048495349770/G3VEZE.png'
        },
        ['footer'] = {
            ['text'] = 'CREATED BY G3VEZE#7918'
        },
		['color'] = 12914,
		['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%SZ')
	  }}
    }
    text = '**Description:** ' ..text..'\n**ID**: '..tonumber(xPlayer.source)..'\n**Steam:** '..xPlayer.identifier..'\n **Player Name:** '..xPlayer.getName()
    if identifierDiscord ~= nil then
        text = text..'\n**Discord:** <@'..string.sub(identifierDiscord, 9)..'>'
        identifierDiscord = nil
    end
    if identifierIp ~= nil then
        text = text..'\n**Ip:** '..string.sub(identifierIp, 4)
        identifierIp = nil
    end
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