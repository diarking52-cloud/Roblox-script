local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2_Minion_Hub"
screenGui.Parent = CoreGui or LocalPlayer:WaitForChild("PlayerGui")

-- Кнопка с миньоном
local minionBtn = Instance.new("ImageButton")
minionBtn.Name = "MinionOpenBtn"
minionBtn.Size = UDim2.new(0, 55, 0, 55)
minionBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
minionBtn.Image = "rbxassetid://13835619932"
minionBtn.BackgroundTransparency = 1
minionBtn.Active = true
minionBtn.Draggable = true
minionBtn.Parent = screenGui

-- Меню
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 180, 0, 210)
mainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 120, 255)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Text = "MM2 Menu\nFPS: -- | Ping: --ms"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 12
title.Parent = mainFrame

local function createBtn(text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.Parent = mainFrame
    return btn
end

local espBtn = createBtn("ESP: ВКЛ", UDim2.new(0.05, 0, 0.22, 0), Color3.fromRGB(0, 150, 0))
local shootBtn = createBtn("Shoot Murderer", UDim2.new(0.05, 0, 0.44, 0), Color3.fromRGB(0, 100, 200))
local killAllBtn = createBtn("Kill All (Murder)", UDim2.new(0.05, 0, 0.66, 0), Color3.fromRGB(180, 0, 0))

local espEnabled = true

minionBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Расчет FPS и Ping
local frameCount = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTime = tick()
    
    if currentTime - lastTime >= 1 then
        local fps = math.floor(frameCount / (currentTime - lastTime))
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        title.Text = "MM2 Menu\nFPS: " .. fps .. " | Ping: " .. ping .. "ms"
        frameCount = 0
        lastTime = currentTime
    end
end)

local function getRoleColor(player)
    if not player.Character then return Color3.fromRGB(0, 150, 255) end
    if player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife") then
        return Color3.fromRGB(255, 0, 0)
    elseif player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun") then
        return Color3.fromRGB(0, 150, 255)
    end
    return Color3.fromRGB(0, 255, 100)
end

-- Функция создания Corner Box (Угловых рамок)
local function createCornerBox(parent, color)
    local frame = Instance.new("Frame")
    frame.Name = "CornerBoxFrame"
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local function addLine(size, pos)
        local l = Instance.new("Frame")
        l.BackgroundColor3 = color
        l.BorderSizePixel = 0
        l.Size = size
        l.Position = pos
        l.Parent = frame
    end

    local thickness = 2
    local length = 8

    -- Верхний левый угол
    addLine(UDim2.new(0, length, 0, thickness), UDim2.new(0, 0, 0, 0))
    addLine(UDim2.new(0, thickness, 0, length), UDim2.new(0, 0, 0, 0))
    -- Верхний правый угол
    addLine(UDim2.new(0, length, 0, thickness), UDim2.new(1, -length, 0, 0))
    addLine(UDim2.new(0, thickness, 0, length), UDim2.new(1, -thickness, 0, 0))
    -- Нижний левый угол
    addLine(UDim2.new(0, length, 0, thickness), UDim2.new(0, 0, 1, -thickness))
    addLine(UDim2.new(0, thickness, 0, length), UDim2.new(0, 0, 1, -length))
    -- Нижний правый угол
    addLine(UDim2.new(0, length, 0, thickness), UDim2.new(1, -length, 1, -thickness))
    addLine(UDim2.new(0, thickness, 0, length), UDim2.new(1, -thickness, 1, -length))

    return frame
end

-- Создание Corner Box ESP
local function createESP(player)
    if player == LocalPlayer then return end

    local function setupCharacter(char)
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        if not hrp then return end

        local color = getRoleColor(player)

        -- Highlight (Белая/Цветная подсветка силуэта)
        local hl = char:FindFirstChild("MM2Highlight") or Instance.new("Highlight")
        hl.Name = "MM2Highlight"
        hl.Adornee = char
        hl.FillColor = Color3.fromRGB(240, 240, 240)
        hl.FillTransparency = 0.5
        hl.OutlineColor = color
        hl.OutlineTransparency = 0
        hl.Enabled = espEnabled
        hl.Parent = char

        -- Corner Box ESP
        local bb = char:FindFirstChild("MM2Box") or Instance.new("BillboardGui")
        bb.Name = "MM2Box"
        bb.Size = UDim2.new(3.2, 0, 4.8, 0)
        bb.AlwaysOnTop = true
        bb.Adornee = hrp
        bb.Enabled = espEnabled
        bb.Parent = char

        if not bb:FindFirstChild("CornerBoxFrame") then
            createCornerBox(bb, color)
        end

        local textLabel = bb:FindFirstChild("InfoLabel") or Instance.new("TextLabel")
        textLabel.Name = "InfoLabel"
        textLabel.Size = UDim2.new(1, 0, 0, 15)
        textLabel.Position = UDim2.new(0, 0, 1, 2)
        textLabel.BackgroundTransparency = 1
        textLabel.TextSize = 11
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextStrokeTransparency = 0
        textLabel.Parent = bb
    end

    if player.Character then
        task.spawn(function() setupCharacter(player.Character) end)
    end
    player.CharacterAdded:Connect(setupCharacter)
end

espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espBtn.Text = espEnabled and "ESP: ВКЛ" or "ESP: ВЫКЛ"
    espBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)

    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local hl = p.Character:FindFirstChild("MM2Highlight")
            local bb = p.Character:FindFirstChild("MM2Box")
            if hl then hl.Enabled = espEnabled end
            if bb then bb.Enabled = espEnabled end
        end
    end
end)

shootBtn.MouseButton1Click:Connect(function()
    local gun = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun"))
    if not gun then return end
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
            local targetHrp = p.Character:FindFirstChild("HumanoidRootPart")
            if targetHrp and gun:FindFirstChild("Shoot") then
                gun.Parent = LocalPlayer.Character
                gun.Shoot:FireServer(targetHrp.Position)
            end
        end
    end
end)

killAllBtn.MouseButton1Click:Connect(function()
    local knife = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife"))
    local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not knife or not myHrp then return end

    knife.Parent = LocalPlayer.Character
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            myHrp.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
            task.wait(0.1)
            if knife:FindFirstChild("Stab") then knife.Stab:FireServer() end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not espEnabled then return end
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local bb = p.Character:FindFirstChild("MM2Box")

            if hrp and bb and bb:FindFirstChild("InfoLabel") and myHrp then
                local dist = math.floor((myHrp.Position - hrp.Position).Magnitude)
                bb.InfoLabel.Text = dist .. " studs"
            end
        end
    end
end)

for _, p in ipairs(Players:GetPlayers()) do createESP(p) end
Players.PlayerAdded:Connect(createESP)
