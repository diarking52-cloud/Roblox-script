--[[
    NEVERLOSE.CC UI & Visuals for Roblox MM2
    Key: mrbecon99
    Mobile-friendly (Delta / Codex / Arceus X / Wave / Volt)
]]

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local Stats             = game:GetService("Stats")
local LocalPlayer       = Players.LocalPlayer
local Camera            = workspace.CurrentCamera

local CORRECT_KEY = "mrbecon99"

local ACCENT       = Color3.fromRGB(0, 180, 255)
local ACCENT_DARK  = Color3.fromRGB(0, 120, 200)
local BG_MAIN      = Color3.fromRGB(8, 14, 23)
local BG_HEADER    = Color3.fromRGB(12, 20, 31)
local BG_ELEMENT   = Color3.fromRGB(14, 22, 35)
local BG_HOVER     = Color3.fromRGB(20, 32, 48)
local TEXT_MAIN    = Color3.fromRGB(230, 235, 245)
local TEXT_DIM     = Color3.fromRGB(140, 155, 175)
local GREEN        = Color3.fromRGB(0, 255, 120)
local RED          = Color3.fromRGB(255, 70, 70)

local function addCorner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = obj
    return c
end

local function addStroke(obj, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or ACCENT
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = obj
    return s
end

local function addGradient(obj, c1, c2, rotation)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rotation or 90
    g.Parent = obj
    return g
end

----------------------------------------------------------------
-- KEY SYSTEM (мгновенная загрузка)
----------------------------------------------------------------
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NeverloseKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.IgnoreGuiInset = true
KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 340, 0, 210)
KeyFrame.Position = UDim2.new(0.5, -170, 0.5, -105)
KeyFrame.BackgroundColor3 = BG_MAIN
KeyFrame.BorderSizePixel = 0
KeyFrame.ClipsDescendants = true
addCorner(KeyFrame, 10)
addStroke(KeyFrame, ACCENT_DARK, 1, 0.4)
addGradient(KeyFrame, Color3.fromRGB(10, 16, 28), Color3.fromRGB(6, 10, 18), 90)

local KeyHeader = Instance.new("Frame", KeyFrame)
KeyHeader.Size = UDim2.new(1, 0, 0, 42)
KeyHeader.BackgroundColor3 = BG_HEADER
KeyHeader.BorderSizePixel = 0
addGradient(KeyHeader, Color3.fromRGB(16, 26, 42), Color3.fromRGB(10, 16, 26), 90)

local KeyAccentLine = Instance.new("Frame", KeyHeader)
KeyAccentLine.Size = UDim2.new(1, 0, 0, 2)
KeyAccentLine.Position = UDim2.new(0, 0, 1, -2)
KeyAccentLine.BackgroundColor3 = ACCENT
KeyAccentLine.BorderSizePixel = 0

local KeyTitle = Instance.new("TextLabel", KeyHeader)
KeyTitle.Size = UDim2.new(1, -20, 1, 0)
KeyTitle.Position = UDim2.new(0, 14, 0, 0)
KeyTitle.Text = "NEVERLOSE.CC  |  KEY SYSTEM"
KeyTitle.TextColor3 = ACCENT
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 13
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.BackgroundTransparency = 1

local KeySubTitle = Instance.new("TextLabel", KeyFrame)
KeySubTitle.Size = UDim2.new(1, -30, 0, 22)
KeySubTitle.Position = UDim2.new(0, 15, 0, 54)
KeySubTitle.Text = "Enter your key below:"
KeySubTitle.TextColor3 = TEXT_DIM
KeySubTitle.Font = Enum.Font.Gotham
KeySubTitle.TextSize = 11
KeySubTitle.TextXAlignment = Enum.TextXAlignment.Left
KeySubTitle.BackgroundTransparency = 1

local KeyInputHolder = Instance.new("Frame", KeyFrame)
KeyInputHolder.Size = UDim2.new(1, -30, 0, 38)
KeyInputHolder.Position = UDim2.new(0, 15, 0, 82)
KeyInputHolder.BackgroundColor3 = BG_ELEMENT
KeyInputHolder.BorderSizePixel = 0
addCorner(KeyInputHolder, 6)
addStroke(KeyInputHolder, ACCENT_DARK, 1, 0.6)

local KeyInput = Instance.new("TextBox", KeyInputHolder)
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.new(0, 10, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.PlaceholderText = "Enter key..."
KeyInput.Text = ""
KeyInput.TextColor3 = TEXT_MAIN
KeyInput.PlaceholderColor3 = TEXT_DIM
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 12
KeyInput.ClearTextOnFocus = false

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(1, -30, 0, 38)
SubmitBtn.Position = UDim2.new(0, 15, 0, 132)
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
StatusLabel.Position = UDim2.new(0, 15, 0, 178)
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
    KeyGui:Destroy()

    local executorName = "Mobile"
    pcall(function()
        if identifyexecutor then executorName = identifyexecutor() end
    end)

    local Config = {
        Visuals = {
            Boxes        = false,
            BoxesSelf    = false,
            Chams        = false,
            ChamsSelf    = false,
            Crosshair    = false,
        },
        Combat = {
            Aimbot       = false,
            AimbotFOV    = 120,
            AimbotSmooth = 0.15,
            ForceShoot   = false,
            AutoShoot    = false,
        },
        Movement = {
            BombJump     = false,
            JumpPower    = 55,
        }
    }

    ------------------------------------------------------------
    -- WATERMARK
    ------------------------------------------------------------
    local WatermarkGui = Instance.new("ScreenGui")
    WatermarkGui.Name = "NeverloseWatermark"
    WatermarkGui.ResetOnSpawn = false
    WatermarkGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local WatermarkFrame = Instance.new("Frame", WatermarkGui)
    WatermarkFrame.Size = UDim2.new(0, 300, 0, 26)
    WatermarkFrame.Position = UDim2.new(0, 10, 0, 10)
    WatermarkFrame.BackgroundColor3 = BG_MAIN
    WatermarkFrame.BorderSizePixel = 0
    addCorner(WatermarkFrame, 6)
    addStroke(WatermarkFrame, ACCENT_DARK, 1, 0.5)

    local WatermarkText = Instance.new("TextLabel", WatermarkFrame)
    WatermarkText.Size = UDim2.new(1, -10, 1, 0)
    WatermarkText.Position = UDim2.new(0, 6, 0, 0)
    WatermarkText.BackgroundTransparency = 1
    WatermarkText.TextColor3 = TEXT_MAIN
    WatermarkText.Font = Enum.Font.GothamBold
    WatermarkText.TextSize = 9
    WatermarkText.TextXAlignment = Enum.TextXAlignment.Left

    local lastUpdate, frameCount, fps = os.clock(), 0, 60

    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local now = os.clock()
        if now - lastUpdate >= 1 then
            fps = math.floor(frameCount / (now - lastUpdate))
            frameCount = 0
            lastUpdate = now
        end
        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        WatermarkText.Text = string.format("NEVERLOSE.CC | FPS: %d | Ping: %dms | %s", fps, ping, executorName)
    end)

    ------------------------------------------------------------
    -- CHAMS
    ------------------------------------------------------------
    local chamsInstances = {}

    local function applyChams(plr, isSelf)
        if not plr.Character then return end
        if chamsInstances[plr] then return end
        local hl = Instance.new("Highlight")
        hl.Name = "NeverloseChams"
        hl.Adornee = plr.Character
        hl.FillColor = isSelf and GREEN or ACCENT
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.FillTransparency = 0.55
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = plr.Character
        chamsInstances[plr] = hl
    end

    local function removeChams(plr)
        if chamsInstances[plr] then
            chamsInstances[plr]:Destroy()
            chamsInstances[plr] = nil
        end
    end

    ------------------------------------------------------------
    -- CORNER BOX ESP (BillboardGui — работает на мобиле)
    ------------------------------------------------------------
    local espBoxes = {}

    local function getWeaponIcon(toolName)
        if not toolName then return "🔫" end
        local n = string.lower(toolName)
        if n:find("knife") then return "🔪" end
        if n:find("gun") or n:find("pistol") or n:find("revolver") then return "🔫" end
        if n:find("bomb") or n:find("c4") then return "💣" end
        if n:find("bow") then return "🏹" end
        return "🔫"
    end

    local function getEquippedTool(plr)
        local char = plr.Character
        if not char then return nil end
        return char:FindFirstChildOfClass("Tool")
    end

    local function createESP(plr)
        local gui = Instance.new("BillboardGui")
        gui.Name = "NeverloseESP"
        gui.Adornee = plr.Character
        gui.Size = UDim2.new(4, 0, 6, 0)
        gui.StudsOffset = Vector3.new(0, 0, 0)
        gui.AlwaysOnTop = true
        gui.LightInfluence = 0
        gui.MaxDistance = 500
        gui.Parent = plr.Character

        local holder = Instance.new("Frame", gui)
        holder.Size = UDim2.new(1, 0, 1, 0)
        holder.BackgroundTransparency = 1

        local corners = {}
        local cornerData = {
            {UDim2.new(0, 0, 0, 0), UDim2.new(0, 30, 0, 2)},
            {UDim2.new(0, 0, 0, 0), UDim2.new(0, 2, 0, 30)},
            {UDim2.new(1, -30, 0, 0), UDim2.new(0, 30, 0, 2)},
            {UDim2.new(1, -2, 0, 0), UDim2.new(0, 2, 0, 30)},
            {UDim2.new(0, 0, 1, -2), UDim2.new(0, 30, 0, 2)},
            {UDim2.new(0, 0, 1, -30), UDim2.new(0, 2, 0, 30)},
            {UDim2.new(1, -30, 1, -2), UDim2.new(0, 30, 0, 2)},
            {UDim2.new(1, -2, 1, -30), UDim2.new(0, 2, 0, 30)},
        }

        for _, data in ipairs(cornerData) do
            local line = Instance.new("Frame", holder)
            line.Size = data[2]
            line.Position = data[1]
            line.BackgroundColor3 = ACCENT
            line.BorderSizePixel = 0
            table.insert(corners, line)
        end

        local distLabel = Instance.new("TextLabel", gui)
        distLabel.Name = "DistanceLabel"
        distLabel.Size = UDim2.new(1, 0, 0, 20)
        distLabel.Position = UDim2.new(0, 0, 1, 2)
        distLabel.BackgroundTransparency = 1
        distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        distLabel.TextStrokeTransparency = 0
        distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        distLabel.Font = Enum.Font.GothamBold
        distLabel.TextSize = 12
        distLabel.Text = "0 studs"

        local weaponIcon = Instance.new("TextLabel", gui)
        weaponIcon.Name = "WeaponIcon"
        weaponIcon.Size = UDim2.new(0, 30, 0, 30)
        weaponIcon.Position = UDim2.new(0.5, -15, 1, 22)
        weaponIcon.BackgroundTransparency = 1
        weaponIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
        weaponIcon.TextStrokeTransparency = 0
        weaponIcon.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        weaponIcon.Font = Enum.Font.GothamBold
        weaponIcon.TextSize = 20
        weaponIcon.Text = "🔫"

        return {
            Gui = gui,
            Corners = corners,
            DistanceLabel = distLabel,
            WeaponIcon = weaponIcon,
        }
    end

    local function updateESP(esp, plr, isSelf)
        if not esp or not plr.Character then return end
        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local color = isSelf and GREEN or ACCENT
        for _, c in ipairs(esp.Corners) do
            c.BackgroundColor3 = color
        end

        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            local myPos = myChar.HumanoidRootPart.Position
            local targetPos = hrp.Position
            local dist = math.floor((myPos - targetPos).Magnitude)
            esp.DistanceLabel.Text = dist .. " studs"
        end

        local tool = getEquippedTool(plr)
        esp.WeaponIcon.Text = getWeaponIcon(tool and tool.Name or nil)
    end

    ------------------------------------------------------------
    -- CROSSHAIR
    ------------------------------------------------------------
    local CrosshairGui = Instance.new("ScreenGui")
    CrosshairGui.Name = "NeverloseCrosshair"
    CrosshairGui.ResetOnSpawn = false
    CrosshairGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local CrosshairFrame = Instance.new("Frame", CrosshairGui)
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
                        if dist < shortest then
                            shortest = dist
                            closest = plr
                        end
                    end
                end
            end
        end
        return closest
    end

    local function runAimbot()
        if not Config.Combat.Aimbot then return end
        local target = getClosestPlayerInFOV()
        if not target then return end
        local head = target.Character and target.Character:FindFirstChild("Head")
        if not head then return end
        local newCFrame = CFrame.new(Camera.CFrame.Position, head.Position)
        Camera.CFrame = Camera.CFrame:Lerp(newCFrame, Config.Combat.AimbotSmooth)
    end

    ------------------------------------------------------------
    -- MAIN RENDER LOOP
    ------------------------------------------------------------
    RunService.RenderStepped:Connect(function()
        for _, plr in ipairs(Players:GetPlayers()) do
            local isSelf = (plr == LocalPlayer)
            local showBox   = (isSelf and Config.Visuals.BoxesSelf) or (not isSelf and Config.Visuals.Boxes)
            local showChams = (isSelf and Config.Visuals.ChamsSelf) or (not isSelf and Config.Visuals.Chams)

            if showBox and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if not espBoxes[plr] or not espBoxes[plr].Gui.Parent then
                    espBoxes[plr] = createESP(plr)
                end
                espBoxes[plr].Gui.Enabled = true
                updateESP(espBoxes[plr], plr, isSelf)
            elseif espBoxes[plr] then
                espBoxes[plr].Gui.Enabled = false
            end

            if showChams and plr.Character then
                applyChams(plr, isSelf)
            else
                removeChams(plr)
            end
        end

        CrosshairFrame.Visible = Config.Visuals.Crosshair
        runAimbot()
    end)

    -- Force Shoot / Auto Shoot
    task.spawn(function()
        while task.wait(0.1) do
            if Config.Combat.ForceShoot or Config.Combat.AutoShoot then
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    pcall(function() tool:Activate() end)
                end
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
            if hrp then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, Config.Movement.JumpPower, hrp.Velocity.Z)
            end
        end
    end)

    Players.PlayerRemoving:Connect(function(plr)
        if espBoxes[plr] then
            if espBoxes[plr].Gui then espBoxes[plr].Gui:Destroy() end
            espBoxes[plr] = nil
        end
        removeChams(plr)
    end)

    ------------------------------------------------------------
    -- MAIN GUI
    ------------------------------------------------------------
    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "NeverloseUI"
    MainGui.ResetOnSpawn = false
    MainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Кнопка NL по центру снизу, draggable
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
    addStroke(OpenBtn, ACCENT, 1.5, 0.2)

    local draggingBtn, dragStartBtn, startPosBtn
    OpenBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingBtn = true
            dragStartBtn = input.Position
            startPosBtn = OpenBtn.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingBtn and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartBtn
            OpenBtn.Position = UDim2.new(startPosBtn.X.Scale, startPosBtn.X.Offset + delta.X, startPosBtn.Y.Scale, startPosBtn.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingBtn = false
        end
    end)

    local MainFrame = Instance.new("Frame", MainGui)
    MainFrame.Size = UDim2.new(0, 470, 0, 310)
    MainFrame.Position = UDim2.new(0.5, -235, 0.5, -155)
    MainFrame.BackgroundColor3 = BG_MAIN
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = true
    addCorner(MainFrame, 12)
    addStroke(MainFrame, ACCENT_DARK, 1, 0.5)

    OpenBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local draggingUI, dragStartUI, startPosUI
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingUI = true
            dragStartUI = input.Position
            startPosUI = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingUI and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartUI
            MainFrame.Position = UDim2.new(startPosUI.X.Scale, startPosUI.X.Offset + delta.X, startPosUI.Y.Scale, startPosUI.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingUI = false
        end
    end)

    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = BG_HEADER
    Header.BorderSizePixel = 0

    local AccentLine = Instance.new("Frame", Header)
    AccentLine.Size = UDim2.new(1, 0, 0, 2)
    AccentLine.Position = UDim2.new(0, 0, 1, -2)
    AccentLine.BackgroundColor3 = ACCENT
    AccentLine.BorderSizePixel = 0

    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Position = UDim2.new(0, 14, 0, 0)
    Title.Text = "NEVERLOSE.CC  |  MM2"
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
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = RED
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.AutoButtonColor = false
    addCorner(CloseBtn, 6)
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)

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
        tabFrame.ScrollBarImageColor3 = ACCENT
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
        btn.Font = Enum.Font.GothamMedium
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
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                local
