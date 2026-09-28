-- Neverlose.cc UI & Visuals Script for Roblox (MM2)
-- Key: luharp
-- Key Link: https://loot-link.com/s?luharp

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local CORRECT_KEY = "luharp"
local KEY_LINK = "https://loot-link.com/s?luharp"

----------------------------------------------------------------
-- 1. KEY SYSTEM GUI
----------------------------------------------------------------
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NeverloseKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 360, 0, 220)
KeyFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
KeyFrame.BackgroundColor3 = Color3.fromRGB(8, 14, 23)
KeyFrame.BorderSizePixel = 0
KeyFrame.ClipsDescendants = true

local KeyHeader = Instance.new("Frame", KeyFrame)
KeyHeader.Size = UDim2.new(1, 0, 0, 35)
KeyHeader.BackgroundColor3 = Color3.fromRGB(12, 20, 31)
KeyHeader.BorderSizePixel = 0

local KeyTitle = Instance.new("TextLabel", KeyHeader)
KeyTitle.Size = UDim2.new(1, -20, 1, 0)
KeyTitle.Position = UDim2.new(0, 10, 0, 0)
KeyTitle.Text = "NEVERLOSE.CC | KEY SYSTEM"
KeyTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 13
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.BackgroundTransparency = 1

local KeySubTitle = Instance.new("TextLabel", KeyFrame)
KeySubTitle.Size = UDim2.new(1, -20, 0, 25)
KeySubTitle.Position = UDim2.new(0, 10, 0, 40)
KeySubTitle.Text = "Get key at Lootlabs or enter below:"
KeySubTitle.TextColor3 = Color3.fromRGB(180, 190, 200)
KeySubTitle.Font = Enum.Font.Gotham
KeySubTitle.TextSize = 11
KeySubTitle.TextXAlignment = Enum.TextXAlignment.Left
KeySubTitle.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1, -20, 0, 35)
KeyInput.Position = UDim2.new(0, 10, 0, 70)
KeyInput.BackgroundColor3 = Color3.fromRGB(14, 22, 35)
KeyInput.BorderSizePixel = 0
KeyInput.PlaceholderText = "Enter key (luharp)..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 12

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(0.48, -10, 0, 32)
SubmitBtn.Position = UDim2.new(0, 10, 0, 115)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "SUBMIT"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 11

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.48, -10, 0, 32)
GetKeyBtn.Position = UDim2.new(0.52, 5, 0, 115)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Text = "GET KEY (LOOTLABS)"
GetKeyBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 10

local StatusLabel = Instance.new("TextLabel", KeyFrame)
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 0, 155)
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.BackgroundTransparency = 1

GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_LINK)
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
        StatusLabel.Text = "Lootlabs link copied to clipboard!"
    else
        KeyInput.Text = KEY_LINK
    end
end)

----------------------------------------------------------------
-- 2. MAIN SCRIPT FUNCTION
----------------------------------------------------------------
local function LoadMainScript()
    KeyGui:Destroy()

    local executorName = (identifyexecutor and identifyexecutor()) or "Unknown Executor"

    local Config = {
        Visuals = {
            Boxes = false,
            BoxesSelf = false,
            Chams = false,
            ChamsSelf = false,
            Crosshair = false,
        },
        Combat = {
            ForceShoot = false,
            AutoShoot = false,
        },
        Movement = {
            BombJump = false,
            JumpPower = 50,
        }
    }

    ------------------------------------------------------------
    -- FPS, PING & EXECUTOR WATERMARK
    ------------------------------------------------------------
    local WatermarkGui = Instance.new("ScreenGui")
    WatermarkGui.Name = "NeverloseWatermark"
    WatermarkGui.ResetOnSpawn = false
    WatermarkGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local WatermarkFrame = Instance.new("Frame", WatermarkGui)
    WatermarkFrame.Size = UDim2.new(0, 280, 0, 25)
    WatermarkFrame.Position = UDim2.new(0, 10, 0, 10)
    WatermarkFrame.BackgroundColor3 = Color3.fromRGB(10, 16, 26)
    WatermarkFrame.BorderSizePixel = 0

    local WatermarkText = Instance.new("TextLabel", WatermarkFrame)
    WatermarkText.Size = UDim2.new(1, -10, 1, 0)
    WatermarkText.Position = UDim2.new(0, 5, 0, 0)
    WatermarkText.BackgroundTransparency = 1
    WatermarkText.TextColor3 = Color3.fromRGB(220, 220, 220)
    WatermarkText.Font = Enum.Font.GothamBold
    WatermarkText.TextSize = 10
    WatermarkText.TextXAlignment = Enum.TextXAlignment.Left

    local lastUpdate = os.clock()
    local frameCount = 0
    local fps = 60

    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local now = os.clock()
        if now - lastUpdate >= 1 then
            fps = math.floor(frameCount / (now - lastUpdate))
            frameCount = 0
            lastUpdate = now
        end
        
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        WatermarkText.Text = string.format("NEVERLOSE.CC | FPS: %d | Ping: %dms | Exec: %s", fps, ping, executorName)
    end)

    ------------------------------------------------------------
    -- CORNER BOX ESP
    ------------------------------------------------------------
    local boxDrawings = {}

    local function CreateCornerBox()
        local box = {
            Lines = {}
        }
        for i = 1, 8 do
            local line = Drawing.new("Line")
            line.Thickness = 1.5
            line.Color = Color3.fromRGB(0, 180, 255)
            line.Visible = false
            table.insert(box.Lines, line)
        end
        return box
    end

    local function UpdateCornerBox(box, hrp, isSelf)
        if not hrp then return end
        local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        if not onScreen then
            for _, line in ipairs(box.Lines) do line.Visible = false end
            return
        end

        local scale = 1000 / vector.Z
        local width, height = 30 * scale / 15, 50 * scale / 15
        local x, y = vector.X - width / 2, vector.Y - height / 2

        local color = isSelf and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(0, 180, 255)
        local l = width * 0.25

        -- Top-Left
        box.Lines[1].From, box.Lines[1].To = Vector2.new(x, y), Vector2.new(x + l, y)
        box.Lines[2].From, box.Lines[2].To = Vector2.new(x, y), Vector2.new(x, y + l)
        -- Top-Right
        box.Lines[3].From, box.Lines[3].To = Vector2.new(x + width, y), Vector2.new(x + width - l, y)
        box.Lines[4].From, box.Lines[4].To = Vector2.new(x + width, y), Vector2.new(x + width, y + l)
        -- Bottom-Left
        box.Lines[5].From, box.Lines[5].To = Vector2.new(x, y + height), Vector2.new(x + l, y + height)
        box.Lines[6].From, box.Lines[6].To = Vector2.new(x, y + height), Vector2.new(x, y + height - l)
        -- Bottom-Right
        box.Lines[7].From, box.Lines[7].To = Vector2.new(x + width, y + height), Vector2.new(x + width - l, y + height)
        box.Lines[8].From, box.Lines[8].To = Vector2.new(x + width, y + height), Vector2.new(x + width, y + height - l)

        for _, line in ipairs(box.Lines) do
            line.Color = color
            line.Visible = true
        end
    end

    RunService.RenderStepped:Connect(function()
        for _, plr in pairs(Players:GetPlayers()) do
            local isSelf = (plr == LocalPlayer)
            local shouldShow = (isSelf and Config.Visuals.BoxesSelf) or (not isSelf and Config.Visuals.Boxes)

            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and shouldShow then
                if not boxDrawings[plr] then
                    boxDrawings[plr] = CreateCornerBox()
                end
                UpdateCornerBox(boxDrawings[plr], plr.Character.HumanoidRootPart, isSelf)
            else
                if boxDrawings[plr] then
                    for _, line in ipairs(boxDrawings[plr].Lines) do line.Visible = false end
                end
            end
        end
    end)

    ------------------------------------------------------------
    -- DRAGGABLE CROSSHAIR
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
    LineV.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    LineV.BorderSizePixel = 0

    local LineH = Instance.new("Frame", CrosshairFrame)
    LineH.Size = UDim2.new(0, 20, 0, 2)
    LineH.Position = UDim2.new(0, 0, 0.5, -1)
    LineH.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    LineH.BorderSizePixel = 0

    local draggingCrosshair, dragStart, startPos
    CrosshairFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingCrosshair = true
            dragStart = input.Position
            startPos = CrosshairFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if draggingCrosshair and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            CrosshairFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingCrosshair = false
        end
    end)

    ------------------------------------------------------------
    -- COMBAT & MOVEMENT
    ------------------------------------------------------------
    UserInputService.JumpRequest:Connect(function()
        if Config.Movement.BombJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, Config.Movement.JumpPower, hrp.Velocity.Z)
            end
        end
    end)

    RunService.Heartbeat:Connect(function()
        CrosshairFrame.Visible = Config.Visuals.Crosshair
        if Config.Combat.ForceShoot or Config.Combat.AutoShoot then
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("GunScript") then
                tool:Activate()
            end
        end
    end)

    ------------------------------------------------------------
    -- NEVERLOSE MAIN GUI WITH TOGGLE BUTTON (NL ICON)
    ------------------------------------------------------------
    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "NeverloseUI"
    MainGui.ResetOnSpawn = false
    MainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Toggle NL Button
    local OpenBtn = Instance.new("TextButton", MainGui)
    OpenBtn.Size = UDim2.new(0, 40, 0, 40)
    OpenBtn.Position = UDim2.new(0, 10, 0.5, -20)
    OpenBtn.BackgroundColor3 = Color3.fromRGB(10, 16, 26)
    OpenBtn.BorderSizePixel = 1
    OpenBtn.BorderColor3 = Color3.fromRGB(0, 180, 255)
    OpenBtn.Text = "NL"
    OpenBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.TextSize = 14

    local MainFrame = Instance.new("Frame", MainGui)
    MainFrame.Size = UDim2.new(0, 500, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(8, 14, 23)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    OpenBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Make MainFrame Draggable
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

    -- Header
    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 35)
    Header.BackgroundColor3 = Color3.fromRGB(12, 20, 31)
    Header.BorderSizePixel = 0

    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.Text = "NEVERLOSE.CC | MM2"
    Title.TextColor3 = Color3.fromRGB(0, 180, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    -- Sidebar
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 110, 1, -35)
    Sidebar.Position = UDim2.new(0, 0, 0, 35)
    Sidebar.BackgroundColor3 = Color3.fromRGB(10, 16, 26)
    Sidebar.BorderSizePixel = 0

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -115, 1, -40)
    ContentArea.Position = UDim2.new(0, 112, 0, 38)
    ContentArea.BackgroundTransparency = 1

    local Tabs = {}
    local TabButtons = {}

    local function CreateTab(name)
        local tabFrame = Instance.new("ScrollingFrame", ContentArea)
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.ScrollBarThickness = 2

        local listLayout = Instance.new("UIListLayout", tabFrame)
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 6)

        Tabs[name] = tabFrame

        local btn = Instance.new("TextButton", Sidebar)
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.Position = UDim2.new(0, 0, 0, (#TabButtons) * 32)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(150, 160, 180)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 11
        btn.BackgroundColor3 = Color3.fromRGB(10, 16, 26)
        btn.BorderSizePixel = 0

        btn.MouseButton1Click:Connect(function()
            for tName, frame in pairs(Tabs) do
                frame.Visible = (tName == name)
            end
            for _, button in pairs(TabButtons) do
                button.TextColor3 = Color3.fromRGB(150, 160, 180)
            end
            btn.TextColor3 = Color3.fromRGB(0, 180, 255)
        end)

        table.insert(TabButtons, btn)
        return tabFrame
    end

    local function CreateToggle(parentTab, text, defaultConfig, callback)
        local frame = Instance.new("Frame", parentTab)
        frame.Size = UDim2.new(1, -10, 0, 28)
        frame.BackgroundColor3 = Color3.fromRGB(14, 22, 35)
        frame.BorderSizePixel = 0

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 8, 0, 0)
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 220)
        label.Font = Enum.Font.Gotham
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1

        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0, 36, 0, 18)
        btn.Position = UDim2.new(1, -44, 0.5, -9)
        btn.BackgroundColor3 = defaultConfig and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(30, 40, 55)
        btn.Text = defaultConfig and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 9
        btn.BorderSizePixel = 0

        local state = defaultConfig
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(30, 40, 55)
            btn.Text = state and "ON" or "OFF"
            callback(state)
        end)
    end

    -- Tabs
    local CombatTab = CreateTab("COMBAT")
    local VisualsTab = CreateTab("VISUALS")
    local MovementTab = CreateTab("MOVEMENT")

    Tabs["COMBAT"].Visible = true
    TabButtons[1].TextColor3 = Color3.fromRGB(0, 180, 255)

    -- Controls
    CreateToggle(CombatTab, "Force Shoot", Config.Combat.ForceShoot, function(val) Config.Combat.ForceShoot = val end)
    CreateToggle(CombatTab, "Auto Shoot", Config.Combat.AutoShoot, function(val) Config.Combat.AutoShoot = val end)

    CreateToggle(VisualsTab, "Corner Box ESP", Config.Visuals.Boxes, function(val) Config.Visuals.Boxes = val end)
    CreateToggle(VisualsTab, "Corner Box (Self)", Config.Visuals.BoxesSelf, function(val) Config.Visuals.BoxesSelf = val end)
    CreateToggle(VisualsTab, "Show Crosshair", Config.Visuals.Crosshair, function(val) Config.Visuals.Crosshair = val end)

    CreateToggle(MovementTab, "Bomb Jump (No Timer)", Config.Movement.BombJump, function(val) Config.Movement.BombJump = val end)
end

-- Key Submission Logic
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
        StatusLabel.Text = "Key Accepted! Loading..."
        task.wait(0.5)
        LoadMainScript()
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
        StatusLabel.Text = "Invalid Key! Get key from Lootlabs."
    end
end)

