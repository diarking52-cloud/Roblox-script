local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Настройки
local ADMIN_NAME = "Rip_pupsik200695" -- Ваш ник

-- Функция создания блока перед игроком
local function spawnBlock(player)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = character.HumanoidRootPart
    local part = Instance.new("Part")
    part.Size = Vector3.new(4, 4, 4)
    part.Position = hrp.Position + (hrp.CFrame.LookVector * 10)
    part.BrickColor = BrickColor.Random()
    part.Material = Enum.Material.Neon
    part.Parent = Workspace
end

-- Выдача денег в Leaderstats
local function giveLeaderstats(player)
    local leaderstats = player:FindFirstChild("leaderstats") or Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player
    
    local coins = leaderstats:FindFirstChild("Coins") or Instance.new("IntValue")
    coins.Name = "Coins"
    coins.Value = (coins.Value or 0) + 1000
    coins.Parent = leaderstats
end

-- Слушатель чата для выполнения админ-команд на сервере
Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        -- Проверка прав (работает только для вас)
        if player.Name == ADMIN_NAME then
            if message == "!block" then
                spawnBlock(player)
                print("[Server]: Блок заспавнен для " .. player.Name)
            elseif message == "!coins" then
                giveLeaderstats(player)
                print("[Server]: Монеты выданы " .. player.Name)
            end
        end
    end)
end)

print("[ServerScript]: Серверный модуль успешно загружен!")
