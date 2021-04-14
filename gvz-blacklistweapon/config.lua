Config = {
    
    BlacklistWeaponLog = true, -- Discorda Log Atar 
    KickPlayer = false,  -- Oyuncuyu Oyundan Kickler

    KickMessage = 'çen çilah mı aldın çen discord.gg/S8TaJaaW',

    DiscordWebhook = 'https://discord.com/api/webhooks/831783120083615745/qxYm4XdtPDVD0PtVjXGvKRE0-lEwTnq7Tei5_BGYmPbL9MmvVahV8z9elbfVUXuwr51J',
    WebhookName = 'gvz-blacklistweapon',
    WebhookAvatarUrl = 'https://cdn.discordapp.com/attachments/785071461516836874/802859048495349770/G3VEZE.png', 

    BlacklistedWeapons = {
        "WEAPON_BULLPUPSHOTGUN",
        "WEAPON_GRENADELAUNCHER",
        "WEAPON_GRENADELAUNCHER_SMOKE",
        "WEAPON_RPG",
        "WEAPON_STINGER",
        "WEAPON_MINIGUN",
    },
}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)