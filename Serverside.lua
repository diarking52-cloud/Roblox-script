--[[
    📱 Fantasy V3 Style GUI — Client Version
    Работает в: Delta, Fluxus, Codex, Arceus X, Hydrogen
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Удаляем старый
pcall(function()
    CoreGui:FindFirstChild("FantasyV3") and CoreGui.FantasyV3:Destroy()
end)

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FantasyV3"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Цвета Fantasy V3
local Colors = {
    Bg = Color3.fromRGB(18, 18, 22),
    Secondary = Color3.fromRGB(25, 25, 32),
    Accent = Color3.fromRGB(160, 100, 255),
    AccentHover = Color3.fromRGB(190, 140, 255),
    Text = Color3.fromRGB(240, 240, 245),
    SubText = Color3.fromRGB(150, 150, 160),
    Red = Color3.fromRGB(255, 60, 60),
    Cyan = Color3.fromRGB(60, 220, 220),
    Green = Color3.fromRGB(80, 230, 100),
}

local function Create(cls, props)
    local o = Instance.new(cls)
    for k, v in pairs(props) do
        if k ~= "Parent" then o[k] = v end
    end
    if props.Parent then o.Parent = props.Parent end
    return o
end

-- ========== ГЛАВНОЕ ОКНО ==========
local Main = Create("Frame", {
    Parent = ScreenGui,
    Size = UDim2.new(0, 480, 0, 320),
    Position = UDim2.new(0.5, -240, 0.5, -160),
    BackgroundColor3 = Colors.Bg,
    BorderSizePixel = 0,
    Active = true,
    Draggable = true,
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = Main})
Create("UIStroke", {
    Color = Colors.Accent,
    Thickness = 1.5,
    Transparency = 0.3,
    Parent = Main
})

-- Топбар
local TopBar = Create("Frame", {
    Parent = Main,
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundColor3 = Colors.Secondary,
    BorderSizePixel = 0,
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = TopBar})
Create("Frame", {
    Parent = TopBar,
    Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -14),
    BackgroundColor3 = Colors.Secondary,
    BorderSizePixel = 0,
})

Create("TextLabel", {
    Parent = TopBar,
    Size = UDim2.new(1, -100, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Text = "⚡ RakNet Server-Side V3",
    TextColor3 = Colors.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
})

-- Кнопка закрытия
local CloseBtn = Create("TextButton", {
    Parent = TopBar,
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -38, 0.5, -15),
    BackgroundColor3 = Colors.Red,
    Text = "✕",
    TextColor3 = Colors.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    BorderSizePixel = 0,
    AutoButtonColor = false,
})
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = CloseBtn})
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Консоль (лог)
local Console = Create("ScrollingFrame", {
    Parent = Main,
    Size = UDim2.new(1, -20, 1, -120),
    Position = UDim2.new(0, 10, 0, 52),
    BackgroundColor3 = Color3.fromRGB(12, 12, 16),
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Colors.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
})
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = Console})
Create("UIListLayout", {
    Padding = UDim.new(0, 2),
    Parent = Console,
})
Create("UIPadding", {
    PaddingTop = UDim.new(0, 6),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
    Parent = Console,
})

local function Log(text, color)
    local lbl = Create("TextLabel", {
        Parent = Console,
        Size = UDim2.new(1, -10, 0, 18),
        BackgroundTransparency = 1,
        Text = "[" .. os.date("%H:%M:%S") .. "] " .. text,
        TextColor3 = color or Colors.SubText,
        Font = Enum.Font.Code,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    task.wait()
    Console.CanvasPosition = Vector2.new(0, Console.AbsoluteCanvasSize.Y)
end

-- Панель кнопок
local BtnBar = Create("Frame", {
    Parent = Main,
    Size = UDim2.new(1, -20, 0, 44),
    Position = UDim2.new(0, 10, 1, -54),
    BackgroundTransparency = 1,
})
Create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 8),
    Parent = BtnBar,
})

-- Универсальная кнопка
local function MakeButton(text, color, callback)
    local b = Create("TextButton", {
        Parent = BtnBar,
        Size = UDim2.new(0, 148, 0, 40),
        BackgroundColor3 = color,
        Text = text,
        TextColor3 = Colors.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        BorderSizePixel = 0,
        AutoButtonColor = false,
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = b})
    
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.2)
        }):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = color
        }):Play()
    end)
    b.MouseButton1Click:Connect(function()
        Log("Нажато: " .. text, Colors.Accent)
        if callback then callback() end
    end)
    return b
end

-- ========== КНОПКИ ==========
MakeButton("KILL ALL", Colors.Red, function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum and plr ~= LocalPlayer then
                hum.Health = 0
            end
        end
    end
    Log("Убил всех игроков", Colors.Red)
end)

MakeButton("SKIP STAGE", Colors.Cyan, function()
    local RS = game:GetService("ReplicatedStorage")
    local count = 0
    for _, obj in pairs(RS:GetDescendants()) do
        if obj:IsA("RemoteEvent") and obj.Name:lower():find("skip") then
            pcall(function() obj:FireServer() end)
            count = count + 1
        end
    end
    Log("Отправлено skip-событий: " .. count, Colors.Cyan)
end)

MakeButton("SKIP TO END", Colors.Green, function()
    local RS = game:GetService("ReplicatedStorage")
    for _, obj in pairs(RS:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local n = obj.Name:lower()
            if n:find("end") or n:find("finish") or n:find("complete") then
                pcall(function() obj:FireServer() end)
            end
        end
    end
    Log("Попытка skip to end", Colors.Green)
end)

MakeButton("GOD MODE", Colors.Accent, function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.MaxHealth = math.huge
            hum.Health = math.huge
        end
    end
    Log("God mode включён", Colors.Accent)
end)

MakeButton("FREEZE ALL", Colors.Cyan, function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character and plr ~= LocalPlayer then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then root.Anchored = true end
        end
    end
    Log("Все заморожены", Colors.Cyan)
end)

MakeButton("UNFREEZE ALL", Colors.Green, function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then root.Anchored = false end
        end
    end
    Log("Все разморожены", Colors.Green)
end)

-- Анимация появления
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 480, 0, 320),
    Position = UDim2.new(0.5, -240, 0.5, -160)
}):Play()

Log("Fantasy V3 загружен!", Colors.Green)
Log("Тип: Client-Side (mobile)", Colors.SubText)
Log("Игрок: " .. LocalPlayer.Name, Colors.Accent)
