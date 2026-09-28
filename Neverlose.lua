-- Neverlose.cc Hub | Universal Compatibility Edition
-- Key / Keypass: neverlose.cc

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- 1. Проверка поддержки функций экзекьютора (Feature Check)
local isDrawingSupported = pcall(function() return Drawing.new("Line") end)
local isFireTouchSupported = (firetouchinterest ~= nil)

-- 2. Внутриигровое уведомление о поддержке
local function showNotification(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end)
end

if isDrawingSupported then
    showNotification("Neverlose.cc", "Экзекьютор полностью поддерживается! (Drawing: OK)", 4)
else
    showNotification("Neverlose.cc", "Внимание: Drawing не поддерживается. Прицел отключен.", 5)
end

-- 3. ОСНОВНОЙ ИНТЕРФЕЙС (Neverlose UI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeverloseHub"
ScreenGui.ResetOnSpawn = false

-- Безопасный инжект в CoreGui / PlayerGui
local successGui, _ = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not successGui then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 420)
MainFrame.Position = UDim2.new(0.5, -170, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 16, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 8)
UICornerMain.Parent = MainFrame

-- Заголовок Neverlose.cc
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
Title.Text = "  neverlose.cc | MM2 Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 8)
UICornerTitle.Parent = Title

local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -20, 1, -55)
Container.Position = UDim2.new(0, 10, 0, 48)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 480)
Container.ScrollBarThickness = 4
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = Container
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)

local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(20, 26, 45)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 220, 255)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 15
    btn.Parent = Container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 4. ФУНКЦИОНАЛ ММ2

-- Aimbot / Shot Murderer / Flick Shot
local AimbotEnabled = false
createButton("Aimbot / Lock Murderer [Переключатель]", function()
    AimbotEnabled = not AimbotEnabled
    showNotification("Aimbot", AimbotEnabled and "Включен" or "Выключен", 2)
end)

RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local backpack = p:FindFirstChild("Backpack")
                local hasKnife = (backpack and backpack:FindFirstChild("Knife")) or p.Character:FindFirstChild("Knife")
                if hasKnife and p.Character:FindFirstChild("HumanoidRootPart") then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, p.Character.HumanoidRootPart.Position)
                end
            end
        end
    end
end)

-- Kill All (Работает при наличии ножа)
createButton("Kill All (Murderer)", function()
    if not isFireTouchSupported then
        showNotification("Ошибка", "firetouchinterest не поддерживается экзекьютором!", 3)
        return
    end
    local char = LocalPlayer.Character
    local knife = (char and char:FindFirstChild("Knife")) or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
    if knife and char and char:FindFirstChild("HumanoidRootPart") then
        knife.Parent = char
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
                pcall(function()
                    firetouchinterest(knife.Handle, p.Character.HumanoidRootPart, 0)
                    firetouchinterest(knife.Handle, p.Character.HumanoidRootPart, 1)
                end)
            end
        end
    end
end)

-- Bomb Jump
createButton("Bomb Jump", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 150, 0)
    end
end)

-- Wallhop
local WallhopEnabled = false
createButton("Wallhop [Включить/Выключить]", function()
    WallhopEnabled = not WallhopEnabled
    showNotification("Wallhop", WallhopEnabled and "Включен" or "Выключен", 2)
end)

UserInputService.JumpRequest:Connect(function()
    if WallhopEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Spinbot (Скорость: 20)
local SpinEnabled = false
createButton("Spinbot 20x [Переключатель]", function()
    SpinEnabled = not SpinEnabled
    showNotification("Spinbot", SpinEnabled and "Включен" or "Выключен", 2)
end)

RunService.RenderStepped:Connect(function()
    if SpinEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
    end
end)

-- Auto Grab Gun (Авто-подбор оружия)
RunService.Stepped:Connect(function()
    if isFireTouchSupported and workspace:FindFirstChild("GunDrop") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local gun = workspace.GunDrop
        pcall(function()
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, gun, 0)
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, gun, 1)
        end)
    end
end)

-- 5. НАСТРАИВАЕМЫЙ ПРИЦЕЛ (Crosshair: Длина 30, Толщина 5)
if isDrawingSupported then
    local LineHorizontal = Drawing.new("Line")
    LineHorizontal.Visible = true
    LineHorizontal.Color = Color3.fromRGB(0, 255, 255)
    LineHorizontal.Thickness = 5

    local LineVertical = Drawing.new("Line")
    LineVertical.Visible = true
    LineVertical.Color = Color3.fromRGB(0, 255, 255)
    LineVertical.Thickness = 5

    RunService.RenderStepped:Connect(function()
        local viewportSize = Camera.ViewportSize
        local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)

        LineHorizontal.From = Vector2.new(center.X - 15, center.Y)
        LineHorizontal.To = Vector2.new(center.X + 15, center.Y)

        LineVertical.From = Vector2.new(center.X, center.Y - 15)
        LineVertical.To = Vector2.new(center.X, center.Y + 15)
    end)
end
