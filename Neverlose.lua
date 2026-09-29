[
    
--[[
    NEVERLOSE.CC | MM2 Delta Edition
    Key: mrbecon99
]]

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local LocalPlayer       = Players.LocalPlayer
local Camera            = workspace.CurrentCamera

local CORRECT_KEY = "mrbecon99"

local ACCENT     = Color3.fromRGB(0, 180, 255)
local BG_MAIN    = Color3.fromRGB(8, 14, 23)
local BG_HEADER  = Color3.fromRGB(12, 20, 31)
local BG_ELEMENT = Color3.fromRGB(14, 22, 35)
local TEXT_MAIN  = Color3.fromRGB(230, 235, 245)
local TEXT_DIM   = Color3.fromRGB(140, 155, 175)
local GREEN      = Color3.fromRGB(0, 255, 120)
local RED        = Color3.fromRGB(255, 70, 70)

local function addCorner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = obj
end

----------------------------------------------------------------
-- ЕДИНЫЙ ScreenGui (чтобы Delta не крашилась)
----------------------------------------------------------------
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "NeverloseUI"
MainGui.ResetOnSpawn = false
MainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

----------------------------------------------------------------
-- KEY SYSTEM (внутри MainGui)
----------------------------------------------------------------
local KeyFrame = Instance.new("Frame", MainGui)
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 320, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyFrame.BackgroundColor3 = BG_MAIN
KeyFrame.BorderSizePixel = 0
addCorner(KeyFrame, 10)

local KeyHeader = Instance.new("Frame", KeyFrame)
KeyHeader.Size = UDim2.new(1, 0, 0, 40)
KeyHeader.BackgroundColor3 = BG_HEADER
KeyHeader.BorderSizePixel = 0
addCorner(KeyHeader, 10)

local KeyTitle = Instance.new("TextLabel", KeyHeader)
KeyTitle.Size = UDim2.new(1, -20, 1, 0)
KeyTitle.Position = UDim2.new(0, 14, 0, 0)
KeyTitle.Text = "NEVERLOSE.CC | KEY"
KeyTitle.TextColor3 = ACCENT
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 13
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1, -30, 0, 38)
KeyInput.Position = UDim2.new(0, 15, 0, 60)
KeyInput.BackgroundColor3 = BG_ELEMENT
KeyInput.BorderSizePixel = 0
KeyInput.PlaceholderText = "Enter key..."
KeyInput.Text = ""
KeyInput.TextColor3 = TEXT_MAIN
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 12
KeyInput.ClearTextOnFocus = false
addCorner(KeyInput, 6)

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(1, -30, 0, 38)
SubmitBtn.Position = UDim2.new(0, 15, 0, 110)
SubmitBtn.BackgroundColor3 = ACCENT
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "SUBMIT"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 12
SubmitBtn.AutoButtonColor = false
addCorner(SubmitBtn, 6)

local StatusLabel = Instance.new("TextLabel", KeyFrame)
StatusLabel.Size = UDim2.new(1, -30, 0, 20)
StatusLabel.Position = UDim2.new(0, 15, 0, 158)
StatusLabel.Text = ""
StatusLabel.TextColor3 = RED
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.BackgroundTransparency = 1

----------------------------------------------------------------
-- MAIN SCRIPT
----------------------------------------------------------------
local function LoadMainScript()
    KeyFrame.Visible = false

    local Config = {
        Combat = {
            Aimbot       = false,
            AimbotFOV    = 120,
            AimbotSmooth = 0.15,
            Prediction   = false,
            ForceShoot   = false,
            AutoShoot    = false,
        },
        Visuals = {
            ESP          = false,
            ESP_Self     = false,
            SkinChanger  = false,
            SkinName     = "Default",
        },
        Misc = {
            AntiFling = false,
        },
        Movement = {
            BombJump  = false,
            JumpPower = 55,
        }
    }

    ------------------------------------------------------------
    -- ANTI-FLING
    ------------------------------------------------------------
    local antiFlingConn
    local function startAntiFling()
        if antiFlingConn then return end
        antiFlingConn = RunService.Stepped:Connect(function()
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    for _, part in ipairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            pcall(function() part.CanCollide = false end)
                        end
                    end
                end
            end
        end)
    end
    local function stopAntiFling()
        if antiFlingConn then antiFlingConn:Disconnect(); antiFlingConn = nil end
    end

    ------------------------------------------------------------
    -- SKIN CHANGER
    ------------------------------------------------------------
    local function applySkin(skinName)
        local char = LocalPlayer.Character
        if not char then return end
        local colors = {
            Default = {Color3.fromRGB(255, 204, 153), Color3.fromRGB(0, 0, 0)},
            Red     = {Color3.fromRGB(200, 30, 30),   Color3.fromRGB(50, 0, 0)},
            Blue    = {Color3.fromRGB(30, 100, 255),  Color3.fromRGB(0, 0, 80)},
            Green   = {Color3.fromRGB(30, 200, 60),   Color3.fromRGB(0, 60, 20)},
            Purple  = {Color3.fromRGB(150, 30, 220),  Color3.fromRGB(40, 0, 70)},
            Gold    = {Color3.fromRGB(255, 200, 30),  Color3.fromRGB(100, 70, 0)},
        }
        local c = colors[skinName] or colors.Default
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                pcall(function() part.Color = (part.Name == "Head") and c[1] or c[2] end)
            elseif part:IsA("Accessory") then
                local handle = part:FindFirstChildWhichIsA("BasePart")
                if handle then pcall(function() handle.Color = c[1] end) end
            end
        end
    end

    ------------------------------------------------------------
    -- CROSSHAIR (внутри MainGui)
    ------------------------------------------------------------
    local CrosshairFrame = Instance.new("Frame", MainGui)
    CrosshairFrame.Size = UDim2.new(0, 20, 0, 20)
    CrosshairFrame.Position = UDim2.new(0.5, -10, 0.5, -10)
    CrosshairFrame.BackgroundTransparency = 1
    CrosshairFrame.Visible = false

    local LineV = Instance.new("Frame", CrosshairFrame)
    LineV.Size = UDim2.new(0, 2, 0, 20)
    LineV.Position = UDim2.new(0.5, -1, 0, 0)
    LineV.BackgroundColor3 = ACCENT
    LineV.BorderSizePixel = 0

    local LineH = Instance.new("Frame", CrosshairFrame)
    LineH.Size = UDim2.new(0, 20, 0, 2)
    LineH.Position = UDim2.new(0, 0, 0.5, -1)
    LineH.BackgroundColor3 = ACCENT
    LineH.BorderSizePixel = 0

    ------------------------------------------------------------
    -- ESP
    ------------------------------------------------------------
    local espBoxes = {}
    local espLabels = {}

    local function createESP(plr)
        if not plr.Character then return end
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "NeverloseBox"
        box.Adornee = plr.Character
        box.AlwaysOnTop = true
        box.ZIndex = 5
        box.Size = Vector3.new(2, 5, 2)
        box.Transparency = 0.7
        box.Color3 = ACCENT
        box.Parent = plr.Character

        local label = Instance.new("BillboardGui")
        label.Name = "NeverloseLabel"
        label.Adornee = plr.Character
        label.Size = UDim2.new(0, 100, 0, 20)
        label.StudsOffset = Vector3.new(0, 3.5, 0)
        label.AlwaysOnTop = true
        label.LightInfluence = 0
        label.MaxDistance = 300
        label.Parent = plr.Character

        local text = Instance.new("TextLabel", label)
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.fromRGB(255, 255, 255)
        text.TextStrokeTransparency = 0
        text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        text.Font = Enum.Font.GothamBold
        text.TextSize = 12
        text.Text = "0 studs"

        espBoxes[plr] = box
        espLabels[plr] = text
    end

    local function removeESP(plr)
        if espBoxes[plr] then pcall(function() espBoxes[plr]:Destroy() end); espBoxes[plr] = nil end
        if espLabels[plr] then pcall(function() espLabels[plr].Parent:Destroy() end); espLabels[plr] = nil end
    end

    local function updateESP(plr, isSelf)
        if not espBoxes[plr] or not plr.Character then return end
        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        pcall(function() espBoxes[plr].Color3 = isSelf and GREEN or ACCENT end)
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") and espLabels[plr] then
            local dist = math.floor((myChar.HumanoidRootPart.Position - hrp.Position).Magnitude)
            pcall(function() espLabels[plr].Text = dist .. " studs" end)
        end
    end

    ------------------------------------------------------------
    -- AIMBOT
    ------------------------------------------------------------
    local function getClosestPlayerInFOV()
        local closest, shortest = nil, Config.Combat.AimbotFOV
        local mousePos = UserInputService:GetMouseLocation()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local head = plr.Character:FindFirstChild("Head")
                local hum  = plr.Character:FindFirstChildOfClass("Humanoid")
                if head and hum and hum.Health > 0 then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                        if dist < shortest then shortest = dist; closest = plr end
                    end
                end
            end
        end
        return closest
    end

    local function getPredictedPosition(target)
        if not target or not target.Character then return nil end
        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
        local head = target.Character:FindFirstChild("Head")
        if not hrp or not head then return nil end
        local pos = head.Position
        if Config.Combat.Prediction then
            local distance = (Camera.CFrame.Position - head.Position).Magnitude
            local travelTime = distance / 1500
            pos = head.Position + (hrp.Velocity * travelTime)
        end
        return pos
    end

    local function runAimbot()
        if not Config.Combat.Aimbot then return end
        local target = getClosestPlayerInFOV()
        if not target then return end
        local pos = getPredictedPosition(target)
        if not pos then return end
        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, pos), Config.Combat.AimbotSmooth)
    end

    ------------------------------------------------------------
    -- RENDER
    ------------------------------------------------------------
    RunService.RenderStepped:Connect(function()
        for _, plr in ipairs(Players:GetPlayers()) do
            local isSelf = (plr == LocalPlayer)
            local show = (isSelf and Config.Visuals.ESP_Self) or (not isSelf and Config.Visuals.ESP)
            if show and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if not espBoxes[plr] or not espBoxes[plr].Parent then createESP(plr) end
                updateESP(plr, isSelf)
            else
                removeESP(plr)
            end
        end
        CrosshairFrame.Visible = false
        runAimbot()
    end)

    -- Force / Auto Shoot
    task.spawn(function()
        while task.wait(0.1) do
            if Config.Combat.ForceShoot or Config.Combat.AutoShoot then
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then pcall(function() tool:Activate() end) end
            end
        end
    end)

    -- BOMB JUMP
    local function hasBombEquipped()
        local char = LocalPlayer.Character
        if not char then return false end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then return false end
        local n = string.lower(tool.Name)
        return n:find("bomb") or n:find("c4") or n:find("grenade")
    end

    UserInputService.JumpRequest:Connect(function()
        if Config.Movement.BombJump and hasBombEquipped() then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Velocity = Vector3.new(hrp.Velocity.X, Config.Movement.JumpPower, hrp.Velocity.Z) end
        end
    end)

    Players.PlayerRemoving:Connect(function(plr) removeESP(plr) end)

    ------------------------------------------------------------
    -- MAIN MENU
    ------------------------------------------------------------
    local OpenBtn = Instance.new("TextButton", MainGui)
    OpenBtn.Size = UDim2.new(0, 48, 0, 48)
    OpenBtn.Position = UDim2.new(0.5, -24, 1, -80)
    OpenBtn.BackgroundColor3 = BG_MAIN
    OpenBtn.BorderSizePixel = 0
    OpenBtn.Text = "NL"
    OpenBtn.TextColor3 = ACCENT
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.TextSize = 16
    OpenBtn.AutoButtonColor = false
    addCorner(OpenBtn, 24)

    local draggingBtn, dragStartBtn, startPosBtn
    OpenBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingBtn = true; dragStartBtn = input.Position; startPosBtn = OpenBtn.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingBtn and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartBtn
            OpenBtn.Position = UDim2.new(startPosBtn.X.Scale, startPosBtn.X.Offset + delta.X, startPosBtn.Y.Scale, startPosBtn.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingBtn = false end
    end)

    local MainFrame = Instance.new("Frame", MainGui)
    MainFrame.Size = UDim2.new(0, 460, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -230, 0.5, -160)
    MainFrame.BackgroundColor3 = BG_MAIN
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = true
    addCorner(MainFrame, 12)

    OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

    local draggingUI, dragStartUI, startPosUI
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingUI = true; dragStartUI = input.Position; startPosUI = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingUI and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartUI
            MainFrame.Position = UDim2.new(startPosUI.X.Scale, startPosUI.X.Offset + delta.X, startPosUI.Y.Scale, startPosUI.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingUI = false end
    end)

    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = BG_HEADER
    Header.BorderSizePixel = 0

    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Position = UDim2.new(0, 14, 0, 0)
    Title.Text = "NEVERLOSE.CC | MM2"
    Title.TextColor3 = ACCENT
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 12
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    local CloseBtn = Instance.new("TextButton", Header)
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Position = UDim2.new(1, -34, 0.5, -14)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 20, 25)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "x"
    CloseBtn.TextColor3 = RED
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.AutoButtonColor = false
    addCorner(CloseBtn, 6)
    CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 110, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(7, 12, 20)
    Sidebar.BorderSizePixel = 0

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -120, 1, -50)
    ContentArea.Position = UDim2.new(0, 112, 0, 48)
    ContentArea.BackgroundTransparency = 1

    local Tabs, TabButtons = {}, {}

    local function CreateTab(name)
        local tabFrame = Instance.new("ScrollingFrame", ContentArea)
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.ScrollBarThickness = 2
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        local listLayout = Instance.new("UIListLayout", tabFrame)
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 5)
        Tabs[name] = tabFrame

        local btn = Instance.new("TextButton", Sidebar)
        btn.Size = UDim2.new(1, -10, 0, 32)
        btn.Position = UDim2.new(0, 5, 0, (#TabButtons) * 34 + 6)
        btn.Text = "  " .. name
        btn.TextColor3 = TEXT_DIM
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 10
        btn.BackgroundColor3 = Color3.fromRGB(7, 12, 20)
        btn.BorderSizePixel = 0
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.AutoButtonColor = false
        addCorner(btn, 6)

        btn.MouseButton1Click:Connect(function()
            for tName, frame in pairs(Tabs) do frame.Visible = (tName == name) end
            for _, button in pairs(TabButtons) do
                button.TextColor3 = TEXT_DIM
                button.BackgroundColor3 = Color3.fromRGB(7, 12, 20)
            end
            btn.TextColor3 = ACCENT
            btn.BackgroundColor3 = BG_ELEMENT
        end)
        table.insert(TabButtons, btn)
        return tabFrame
    end

    local function CreateToggle(parentTab, text, default, callback)
        local frame = Instance.new("Frame", parentTab)
        frame.Size = UDim2.new(1, -10, 0, 30)
        frame.BackgroundColor3 = BG_ELEMENT
        frame.BorderSizePixel = 0
        addCorner(frame, 6)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.Text = text
        label.TextColor3 = TEXT_MAIN
        label.Font = Enum.Font.Gotham
        label.TextSize = 10
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1

        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0, 36, 0, 18)
        btn.Position = UDim2.new(1, -46, 0.5, -9)
        btn.BackgroundColor3 = default and ACCENT or Color3.fromRGB(35, 45, 60)
        btn.Text = default and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 9
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        addCorner(btn, 9)

        local state = default
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and ACCENT or Color3.fromRGB(35, 45, 60)
            btn.Text = state and "ON" or "OFF"
            callback(state)
        end)
    end

    local function CreateSlider(parentTab, text, min, max, default, callback)
        local frame = Instance.new("Frame", parentTab)
        frame.Size = UDim2.new(1, -10, 0, 42)
        frame.BackgroundColor3 = BG_ELEMENT
        frame.BorderSizePixel = 0
        addCorner(frame, 6)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, -20, 0, 18)
        label.Position = UDim2.new(0, 12, 0, 4)
        label.Text = text .. ": " .. default
        label.TextColor3 = TEXT_MAIN
        label.Font = Enum.Font.Gotham
        label.TextSize = 10
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1

        local bar = Instance.new("Frame", frame)
        bar.Size = UDim2.new(1, -24, 0, 6)
        bar.Position = UDim2.new(0, 12, 0, 28)
        bar.BackgroundColor3 = Color3.fromRGB(25, 35, 50)
        bar.BorderSizePixel = 0
        addCorner(bar, 3)

        local fill = Instance.new("Frame", bar)
        fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        fill.BackgroundColor3 = ACCENT
        fill.BorderSizePixel = 0
        addCorner(fill, 3)

        local dragging = false
        bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                local val = math.floor(min + (max - min) * rel)
                fill.Size = UDim2.new(rel, 0, 1, 0)
                label.Text = text .. ": " .. val
                callback(val)
            end
        end)
    end

    local CombatTab   = CreateTab("COMBAT")
    local VisualsTab  = CreateTab("VISUALS")
    local MiscTab     = CreateTab("MISC")
    local MovementTab = CreateTab("MOVEMENT")

    Tabs["COMBAT"].Visible = true
    TabButtons[1].TextColor3 = ACCENT
    TabButtons[1].BackgroundColor3 = BG_ELEMENT

    CreateToggle(CombatTab, "Aimbot", Config.Combat.Aimbot, function(v) Config.Combat.Aimbot = v end)
    CreateSlider(CombatTab, "Aimbot FOV", 10, 500, Config.Combat.AimbotFOV, function(v) Config.Combat.AimbotFOV = v end)
    CreateSlider(CombatTab, "Aimbot Smooth", 1, 100, 15, function(v) Config.Combat.AimbotSmooth = v / 100 end)
    CreateToggle(CombatTab, "Prediction", Config.Combat.Prediction, function(v) Config.Combat.Prediction = v end)
    CreateToggle(CombatTab, "Force Shoot", Config.Combat.ForceShoot, function(v) Config.Combat.ForceShoot = v end)
    CreateToggle(CombatTab, "Auto Shoot", Config.Combat.AutoShoot, function(v) Config.Combat.AutoShoot = v end)

    CreateToggle(VisualsTab, "ESP Box", Config.Visuals.ESP, function(v) Config.Visuals.ESP = v end)
    CreateToggle(VisualsTab, "ESP Box (Self)", Config.Visuals.ESP_Self, function(v) Config.Visuals.ESP_Self = v end)
    CreateToggle(VisualsTab, "Skin Changer", Config.Visuals.SkinChanger, function(v)
        Config.Visuals.SkinChanger = v
        if v then applySkin(Config.Visuals.SkinName) end
    end)

    CreateToggle(MiscTab, "Anti-Fling", Config.Misc.AntiFling, function(v)
        Config.Misc.AntiFling = v
        if v then startAntiFling() else stopAntiFling() end
    end)

    CreateToggle(MovementTab, "Bomb Jump", Config.Movement.BombJump, function(v) Config.Movement.BombJump = v end)
    CreateSlider(MovementTab, "Jump Power", 20, 150, Config.Movement.JumpPower, function(v) Config.Movement.JumpPower = v end)
end

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        LoadMainScript()
    else
        StatusLabel.TextColor3 = RED
        StatusLabel.Text = "Invalid Key!"
    end
end)
