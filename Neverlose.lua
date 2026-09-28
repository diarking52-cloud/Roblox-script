-- Neverlose.cc UI & Visuals Script with Key System for Roblox (MM2)
-- Key: mrbeconbestscript

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local CORRECT_KEY = "mrbeconbestscript"

----------------------------------------------------------------
-- KEY SYSTEM GUI
----------------------------------------------------------------
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NeverloseKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 360, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -180, 0.5, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(8, 14, 23)
KeyFrame.BorderSizePixel = 0
KeyFrame.ClipsDescendants = true

-- Key System Header
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
KeySubTitle.Position = UDim2.new(0, 10, 0, 45)
KeySubTitle.Text = "Enter key to continue:"
KeySubTitle.TextColor3 = Color3.fromRGB(180, 190, 200)
KeySubTitle.Font = Enum.Font.Gotham
KeySubTitle.TextSize = 12
KeySubTitle.TextXAlignment = Enum.TextXAlignment.Left
KeySubTitle.BackgroundTransparency = 1

-- Key TextBox
local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1, -20, 0, 35)
KeyInput.Position = UDim2.new(0, 10, 0, 75)
KeyInput.BackgroundColor3 = Color3.fromRGB(14, 22, 35)
KeyInput.BorderSizePixel = 0
KeyInput.PlaceholderText = "Paste key here..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 12

-- Submit Button
local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(0.48, -10, 0, 35)
SubmitBtn.Position = UDim2.new(0, 10, 0, 125)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "SUBMIT"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 12

-- Paste Key Button
local PasteBtn = Instance.new("TextButton", KeyFrame)
PasteBtn.Size = UDim2.new(0.48, -10, 0, 35)
PasteBtn.Position = UDim2.new(0.52, 5, 0, 125)
PasteBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
PasteBtn.BorderSizePixel = 0
PasteBtn.Text = "PASTE KEY"
PasteBtn.TextColor3 = Color3.fromRGB(180, 190, 200)
PasteBtn.Font = Enum.Font.GothamBold
PasteBtn.TextSize = 12

-- Status Label
local StatusLabel = Instance.new("TextLabel", KeyFrame)
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 0, 168)
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.BackgroundTransparency = 1

PasteBtn.MouseButton1Click:Connect(function()
    if setclipboard or getclipboard then
        local clipboard = getclipboard and getclipboard() or ""
        KeyInput.Text = clipboard
    end
end)

----------------------------------------------------------------
-- MAIN SCRIPT FUNCTION (LOADS AFTER VALID KEY)
----------------------------------------------------------------
local function LoadMainScript()
    KeyGui:Destroy()

    -- Config state
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
    -- CUSTOM CROSSHAIR
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
    -- VISUALS (CHAMS & SELF CHAMS)
    ------------------------------------------------------------
    local highlights = {}

    local function ApplyChams(player)
        if not player.Character then return end
        
        local isSelf = (player == LocalPlayer)
        if isSelf and not Config.Visuals.ChamsSelf then
            if highlights[player] then highlights[player]:Destroy() highlights[player] = nil end
            return
        end
        if not isSelf and not Config.Visuals.Chams then
            if highlights[player] then highlights[player]:Destroy() highlights[player] = nil end
            return
        end

        if not highlights[player] or not highlights[player].Parent then
            local highlight = Instance.new("Highlight")
            highlight.Name = "NL_Chams"
            highlight.FillColor = isSelf and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 50, 50)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Adornee = player.Character
            highlight.Parent = player.Character
            highlights[player] = highlight
        end
    end

    RunService.RenderStepped:Connect(function()
        CrosshairFrame.Visible = Config.Visuals.Crosshair

        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                ApplyChams(player)
            end
        end
    end)

    ------------------------------------------------------------
    -- MOVEMENT & COMBAT (BOMB JUMP & FORCE SHOOT)
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
        if Config.Combat.ForceShoot or Config.Combat.AutoShoot then
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("GunScript") then
                tool:Activate()
            end
        end
    end)

    ------------------------------------------------------------
    -- NEVERLOSE MAIN GUI
    ------------------------------------------------------------
    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "NeverloseUI"
    MainGui.ResetOnSpawn = false
    MainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame", MainGui)
    MainFrame.Size = UDim2.new(0, 550, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(8, 14, 23)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

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

    -- Header Bar
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
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    -- Sidebar
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 120, 1, -35)
    Sidebar.Position = UDim2.new(0, 0, 0, 35)
    Sidebar.BackgroundColor3 = Color3.fromRGB(10, 16, 26)
    Sidebar.BorderSizePixel = 0

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -125, 1, -40)
    ContentArea.Position = UDim2.new(0, 122, 0, 38)
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
        listLayout.Padding = UDim.new(0, 8)

        Tabs[name] = tabFrame

        local btn = Instance.new("TextButton", Sidebar)
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.Position = UDim2.new(0, 0, 0, (#TabButtons) * 35)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(150, 160, 180)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
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
        frame.Size = UDim2.new(1, -10, 0, 30)
        frame.BackgroundColor3 = Color3.fromRGB(14, 22, 35)
        frame.BorderSizePixel = 0

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 220)
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1

        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0, 40, 0, 20)
        btn.Position = UDim2.new(1, -50, 0.5, -10)
        btn.BackgroundColor3 = defaultConfig and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(30, 40, 55)
        btn.Text = defaultConfig and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 10
        btn.BorderSizePixel = 0

        local state = defaultConfig
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(30, 40, 55)
            btn.Text = state and "ON" or "OFF"
            callback(state)
        end)
    end

    -- Tabs Creation
    local CombatTab = CreateTab("COMBAT")
    local VisualsTab = CreateTab("VISUALS")
    local MovementTab = CreateTab("MOVEMENT")

    Tabs["COMBAT"].Visible = true
    TabButtons[1].TextColor3 = Color3.fromRGB(0, 180, 255)

    -- Options
    CreateToggle(CombatTab, "Force Shoot", Config.Combat.ForceShoot, function(val) Config.Combat.ForceShoot = val end)
    CreateToggle(CombatTab, "Auto Shoot", Config.Combat.AutoShoot, function(val) Config.Combat.AutoShoot = val end)

    CreateToggle(VisualsTab, "Show Crosshair (Draggable)", Config.Visuals.Crosshair, function(val) Config.Visuals.Crosshair = val end)
    CreateToggle(VisualsTab, "Chams (Enemies)", Config.Visuals.Chams, function(val) Config.Visuals.Chams = val end)
    CreateToggle(VisualsTab, "Chams (Self)", Config.Visuals.ChamsSelf, function(val) Config.Visuals.ChamsSelf = val end)

    CreateToggle(MovementTab, "Bomb Jump (No Timer)", Config.Movement.BombJump, function(val) Config.Movement.BombJump = val end)
end

-- Key Verification
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
        StatusLabel.Text = "Key Accepted! Loading..."
        task.wait(0.5)
        LoadMainScript()
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
        StatusLabel.Text = "Invalid Key! Try again."
    end
end)
