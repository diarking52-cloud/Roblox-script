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

local ACCENT     = Color3.fromRGB(255, 255, 255)
local BG_MAIN    = Color3.fromRGB(22, 22, 26)
local BG_SIDEBAR = Color3.fromRGB(16, 16, 19)
local BG_HEADER  = Color3.fromRGB(28, 28, 32)
local BG_ELEMENT = Color3.fromRGB(32, 32, 37)
local TEXT_MAIN  = Color3.fromRGB(235, 235, 240)
local TEXT_DIM   = Color3.fromRGB(130, 130, 140)
local GREEN      = Color3.fromRGB(90, 220, 120)
local RED        = Color3.fromRGB(230, 70, 70)
local ORANGE     = Color3.fromRGB(255, 150, 50)
local TOGGLE_ON  = Color3.fromRGB(90, 160, 255)
local TOGGLE_OFF = Color3.fromRGB(55, 55, 62)

local function addCorner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = obj
end

local function addStroke(obj, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = obj
end

local MainGui = Instance.new("ScreenGui")
MainGui.Name = "NeverloseUI"
MainGui.ResetOnSpawn = false
MainGui.IgnoreGuiInset = true
MainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame", MainGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 170)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -85)
KeyFrame.BackgroundColor3 = BG_MAIN
KeyFrame.BorderSizePixel = 0
addCorner(KeyFrame, 10)

local KeyHeader = Instance.new("Frame", KeyFrame)
KeyHeader.Size = UDim2.new(1, 0, 0, 36)
KeyHeader.BackgroundColor3 = BG_HEADER
KeyHeader.BorderSizePixel = 0
addCorner(KeyHeader, 10)

local KeyTitle = Instance.new("TextLabel", KeyHeader)
KeyTitle.Size = UDim2.new(1, -20, 1, 0)
KeyTitle.Position = UDim2.new(0, 14, 0, 0)
KeyTitle.Text = "NEVERLOSE.CC"
KeyTitle.TextColor3 = TEXT_MAIN
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 13
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1, -30, 0, 34)
KeyInput.Position = UDim2.new(0, 15, 0, 55)
KeyInput.BackgroundColor3 = BG_ELEMENT
KeyInput.BorderSizePixel = 0
KeyInput.PlaceholderText = "Enter key..."
KeyInput.Text = ""
KeyInput.TextColor3 = TEXT_MAIN
KeyInput.PlaceholderColor3 = TEXT_DIM
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 12
KeyInput.ClearTextOnFocus = false
addCorner(KeyInput, 6)

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(1, -30, 0, 34)
SubmitBtn.Position = UDim2.new(0, 15, 0, 100)
SubmitBtn.BackgroundColor3 = BG_ELEMENT
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "SUBMIT"
SubmitBtn.TextColor3 = TEXT_MAIN
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 11
SubmitBtn.AutoButtonColor = false
addCorner(SubmitBtn, 6)

local StatusLabel = Instance.new("TextLabel", KeyFrame)
StatusLabel.Size = UDim2.new(1, -30, 0, 18)
StatusLabel.Position = UDim2.new(0, 15, 0, 140)
StatusLabel.Text = ""
StatusLabel.TextColor3 = RED
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.BackgroundTransparency = 1local function LoadMainScript()
    KeyFrame:Destroy()

    local Config = {
        Combat = {
            Aimbot       = false,
            AimbotFOV    = 120,
            AimbotSmooth = 0.15,
            Prediction   = false,
            ForceShoot   = false,
            AutoShoot    = false,
            ShootMurder  = false,
        },
        Visuals = {
            ESP          = false,
            ESP_Self     = false,
            SkinChanger  = false,
            WeaponSkin   = "Default",
            Invisible    = false,
        },
        Misc = {
            AntiFling        = false,
            AntiFlingMurder  = false,
            AntiFlingSheriff = false,
        },
        Movement = {
            BombJump  = false,
            JumpPower = 55,
        }
    }

    local function getRole(plr)
        local char = plr.Character
        if not char then return "Unknown" end
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                local n = string.lower(tool.Name)
                if n:find("knife") then return "Murder" end
                if n:find("gun") or n:find("revolver") or n:find("pistol") then return "Sheriff" end
            end
        end
        return "Innocent"
    end

    local function getMurderPlayer()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                for _, tool in ipairs(plr.Character:GetChildren()) do
                    if tool:IsA("Tool") and string.lower(tool.Name):find("knife") then
                        return plr
                    end
                end
            end
        end
        return nil
    end

    local antiFlingConn
    local function isTargetForAntiFling(plr)
        if not Config.Misc.AntiFling and not Config.Misc.AntiFlingMurder and not Config.Misc.AntiFlingSheriff then return false end
        local role = getRole(plr)
        if Config.Misc.AntiFling and role ~= "Unknown" then return true end
        if Config.Misc.AntiFlingMurder and role == "Murder" then return true end
        if Config.Misc.AntiFlingSheriff and role == "Sheriff" then return true end
        return false
    end

    local function startAntiFling()
        if antiFlingConn then return end
        antiFlingConn = RunService.Stepped:Connect(function()
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and isTargetForAntiFling(plr) then
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

    local invisibleState = false
    local invisibleParts = {}

    local function setInvisible(state)
        invisibleState = state
        local char = LocalPlayer.Character
        if not char then return end
        if state then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    invisibleParts[part] = {
                        Transparency = part.Transparency,
                        LocalTransparencyModifier = part.LocalTransparencyModifier,
                    }
                    pcall(function()
                        part.Transparency = 1
                        part.LocalTransparencyModifier = 1
                    end)
                end
            end
        else
            for part, data in pairs(invisibleParts) do
                if part and part.Parent then
                    pcall(function()
                        part.Transparency = data.Transparency
                        part.LocalTransparencyModifier = data.LocalTransparencyModifier
                    end)
                end
            end
            invisibleParts = {}
        end
    end

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        if invisibleState then setInvisible(true) end
    end)

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

    local weaponColors = {
        Default = nil,
        Black   = Color3.fromRGB(15, 15, 15),
        Red     = Color3.fromRGB(200, 30, 30),
        Blue    = Color3.fromRGB(30, 100, 255),
        Green   = Color3.fromRGB(30, 200, 60),
        Purple  = Color3.fromRGB(150, 30, 220),
        Gold    = Color3.fromRGB(255, 200, 30),
        Pink    = Color3.fromRGB(255, 100, 200),
        Cyan    = Color3.fromRGB(0, 255, 255),
        White   = Color3.fromRGB(240, 240, 240),
    }
    local weaponOriginalColors = {}

    local function applyWeaponSkin(colorName)
        local color = weaponColors[colorName]
        local char = LocalPlayer.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then return end
        if color == nil then
            for part, orig in pairs(weaponOriginalColors) do
                if part and part.Parent then
                    pcall(function() part.Color = orig end)
                end
            end
            weaponOriginalColors = {}
            return
        end
        for _, part in ipairs(tool:GetDescendants()) do
            if part:IsA("BasePart") then
                if not weaponOriginalColors[part] then
                    weaponOriginalColors[part] = part.Color
                end
                pcall(function() part.Color = color end)
            end
        end
    end

    task.spawn(function()
        while task.wait(1) do
            if Config.Visuals.WeaponSkin ~= "Default" then
                pcall(function() applyWeaponSkin(Config.Visuals.WeaponSkin) end)
            end
        end
    end)

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
        label.Size = UDim2.new(0, 130, 0, 40)
        label.StudsOffset = Vector3.new(0, 3.5, 0)
        label.AlwaysOnTop = true
        label.LightInfluence = 0
        label.MaxDistance = 300
        label.Parent = plr.Character

        local text = Instance.new("TextLabel", label)
        text.Size = UDim2.new(1, 0, 0.5, 0)
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.fromRGB(255, 255, 255)
        text.TextStrokeTransparency = 0
        text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        text.Font = Enum.Font.GothamBold
        text.TextSize = 12
        text.Text = "0 studs"

        local roleLabel = Instance.new("TextLabel", label)
        roleLabel.Size = UDim2.new(1, 0, 0.5, 0)
        roleLabel.Position = UDim2.new(0, 0, 0.5, 0)
        roleLabel.BackgroundTransparency = 1
        roleLabel.TextColor3 = ACCENT
        roleLabel.TextStrokeTransparency = 0
        roleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        roleLabel.Font = Enum.Font.GothamBold
        roleLabel.TextSize = 11
        roleLabel.Text = "Innocent"

        espBoxes[plr] = box
        espLabels[plr] = {dist = text, role = roleLabel}
    end

    local function removeESP(plr)
        if espBoxes[plr] then pcall(function() espBoxes[plr]:Destroy() end); espBoxes[plr] = nil end
        if espLabels[plr] then pcall(function() espLabels[plr].dist.Parent:Destroy() end); espLabels[plr] = nil end
    end

    local function updateESP(plr, isSelf)
        if not espBoxes[plr] or not plr.Character then return end
        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local role = getRole(plr)
        local color = ACCENT
        if role == "Murder" then color = RED
        elseif role == "Sheriff" then color = ORANGE
        elseif isSelf then color = GREEN end
        pcall(function() espBoxes[plr].Color3 = color end)
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") and espLabels[plr] then
            local dist = math.floor((myChar.HumanoidRootPart.Position - hrp.Position).Magnitude)
            pcall(function()
                espLabels[plr].dist.Text = dist .. " studs"
                espLabels[plr].role.Text = role
                espLabels[plr].role.TextColor3 = color
            end)
        end
    end    local function getClosestPlayerInFOV()
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

    local function shootMurder()
        local murder = getMurderPlayer()
        if not murder or not murder.Character then return end
        local head = murder.Character:FindFirstChild("Head")
        if not head then return end
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
        task.wait(0.02)
        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then pcall(function() tool:Activate() end) end
    end

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
        runAimbot()
    end)

    task.spawn(function()
        while task.wait(0.1) do
            if Config.Combat.ForceShoot or Config.Combat.AutoShoot then
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then pcall(function() tool:Activate() end) end
            end
        end
    end)

    task.spawn(function()
        while task.wait(0.15) do
            if Config.Combat.ShootMurder then shootMurder() end
        end
    end)

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

    local ShootMurderBtn = Instance.new("TextButton", MainGui)
    ShootMurderBtn.Size = UDim2.new(0, 90, 0, 44)
    ShootMurderBtn.Position = UDim2.new(0.5, -45, 0, 100)
    ShootMurderBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    ShootMurderBtn.BorderSizePixel = 0
    ShootMurderBtn.Text = "SHOOT MURDER"
    ShootMurderBtn.TextColor3 = TEXT_MAIN
    ShootMurderBtn.Font = Enum.Font.GothamBold
    ShootMurderBtn.TextSize = 10
    ShootMurderBtn.AutoButtonColor = false
    addCorner(ShootMurderBtn, 8)

    local draggingSM, dragStartSM, startPosSM, movedSM
    ShootMurderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSM = true; movedSM = false
            dragStartSM = input.Position; startPosSM = ShootMurderBtn.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingSM and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartSM
            if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then movedSM = true end
            ShootMurderBtn.Position = UDim2.new(startPosSM.X.Scale, startPosSM.X.Offset + delta.X, startPosSM.Y.Scale, startPosSM.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSM = false end
    end)
    ShootMurderBtn.MouseButton1Click:Connect(function()
        if not movedSM then shootMurder() end
    end)

    local OpenBtn = Instance.new("TextButton", MainGui)
    OpenBtn.Size = UDim2.new(0, 48, 0, 48)
    OpenBtn.Position = UDim2.new(0.5, -24, 1, -80)
    OpenBtn.BackgroundColor3 = BG_MAIN
    OpenBtn.BorderSizePixel = 0
    OpenBtn.Text = "NL"
    OpenBtn.TextColor3 = TEXT_MAIN
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.TextSize = 16
    OpenBtn.AutoButtonColor = false
    addCorner(OpenBtn, 24)
    addStroke(OpenBtn, TOGGLE_ON, 1, 0.3)

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
    MainFrame.Size = UDim2.new(0, 520, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
    MainFrame.BackgroundColor3 = BG_MAIN
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = true
    addCorner(MainFrame, 10)

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

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = BG_HEADER
    TopBar.BorderSizePixel = 0

    local TopTitle = Instance.new("TextLabel", TopBar)
    TopTitle.Size = UDim2.new(0, 250, 1, 0)
    TopTitle.Position = UDim2.new(0, 14, 0, 0)
    TopTitle.Text = "NEVERLOSE.CC"
    TopTitle.TextColor3 = TEXT_MAIN
    TopTitle.Font = Enum.Font.GothamBold
    TopTitle.TextSize = 13
    TopTitle.TextXAlignment = Enum.TextXAlignment.Left
    TopTitle.BackgroundTransparency = 1

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.Position = UDim2.new(1, -34, 0.5, -13)
    CloseBtn.BackgroundColor3 = BG_ELEMENT
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "x"
    CloseBtn.TextColor3 = TEXT_DIM
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.AutoButtonColor = false
    addCorner(CloseBtn, 6)
    CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 130, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = BG_SIDEBAR
    Sidebar.BorderSizePixel = 0

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -145, 1, -55)
    ContentArea.Position = UDim2.new(0, 140, 0, 52)
    ContentArea.BackgroundTransparency = 1

    local Tabs, TabButtons = {}, {}

    local function CreateTab(name, icon)
        local tabFrame = Instance.new("ScrollingFrame", ContentArea)
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.ScrollBarThickness = 2
        tabFrame.ScrollBarImageColor3 = TOGGLE_ON
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        local listLayout = Instance.new("UIListLayout", tabFrame)
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 6)
        Tabs[name] = tabFrame
        local btn = Instance.new("TextButton", Sidebar)
        btn.Size = UDim2.new(1, -12, 0, 34)
        btn.Position = UDim2.new(0, 6, 0, (#TabButtons) * 38 + 8)
        btn.Text = "  " .. (icon or "") .. "  " .. name
        btn.TextColor3 = TEXT_DIM
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 11
        btn.BackgroundColor3 = BG_SIDEBAR
        btn.BorderSizePixel = 0
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.AutoButtonColor = false
        addCorner(btn, 6)
        btn.MouseButton1Click:Connect(function()
            for tName, frame in pairs(Tabs) do frame.Visible = (tName == name) end
            for _, button in pairs(TabButtons) do
                button.TextColor3 = TEXT_DIM
                button.BackgroundColor3 = BG_SIDEBAR
            end
            btn.TextColor3 = TEXT_MAIN
            btn.BackgroundColor3 = BG_ELEMENT
        end)
        table.insert(TabButtons, btn)
        return tabFrame
    end

    local function CreateToggle(parentTab, text, default, callback)
        local frame = Instance.new("Frame", parentTab)
        frame.Size = UDim2.new(1, -10, 0, 32)
        frame.BackgroundColor3 = BG_ELEMENT
        frame.BorderSizePixel = 0
        addCorner(frame, 6)
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.Text = text
        label.TextColor3 = TEXT_MAIN
        label.Font = Enum.Font.Gotham
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        local switch = Instance.new("Frame", frame)
        switch.Size = UDim2.new(0, 32, 0, 16)
        switch.Position = UDim2.new(1, -44, 0.5, -8)
        switch.BackgroundColor3 = default and TOGGLE_ON or TOGGLE_OFF
        switch.BorderSizePixel = 0
        addCorner(switch, 8)
        local dot = Instance.new("Frame", switch)
        dot.Size = UDim2.new(0, 12, 0, 12)
        dot.Position = default and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
        dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        dot.BorderSizePixel = 0
        addCorner(dot, 6)
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.AutoButtonColor = false
        local state = default
        btn.MouseButton1Click:Connect(function()
            state = not state
            switch.BackgroundColor3 = state and TOGGLE_ON or TOGGLE_OFF
            dot.Position = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
            callback(state)
        end)
    end

    local function CreateSlider(parentTab, text, min, max, default, callback)
        local frame = Instance.new("Frame", parentTab)
        frame.Size = UDim2.new(1, -10, 0, 44)
        frame.BackgroundColor3 = BG_ELEMENT
        frame.BorderSizePixel = 0
        addCorner(frame, 6)
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, -20, 0, 18)
        label.Position = UDim2.new(0, 12, 0, 4)
        label.Text = text .. ": " .. default
        label.TextColor3 = TEXT_MAIN
        label.Font = Enum.Font.Gotham
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        local bar = Instance.new("Frame", frame)
        bar.Size = UDim2.new(1, -24, 0, 6)
        bar.Position = UDim2.new(0, 12, 0, 30)
        bar.BackgroundColor3 = TOGGLE_OFF
        bar.BorderSizePixel = 0
        addCorner(bar, 3)
        local fill = Instance.new("Frame", bar)
        fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        fill.BackgroundColor3 = TOGGLE_ON
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

    local GameTab   = CreateTab("GAME", "G")
    local VisTab    = CreateTab("VISUALS", "V")
    local TargetTab = CreateTab("TARGET", "T")
    local MiscTab   = CreateTab("MISC", "M")

    Tabs["GAME"].Visible = true
    TabButtons[1].TextColor3 = TEXT_MAIN
    TabButtons[1].BackgroundColor3 = BG_ELEMENT

    CreateToggle(GameTab, "Shoot Murder", Config.Combat.ShootMurder, function(v) Config.Combat.ShootMurder = v end)
    CreateToggle(GameTab, "Invisibility", Config.Visuals.Invisible, function(v)
        Config.Visuals.Invisible = v
        setInvisible(v)
    end)
    CreateToggle(GameTab, "Anti-Fling", Config.Misc.AntiFling, function(v)
        Config.Misc.AntiFling = v
        if v then startAntiFling() else
            if not Config.Misc.AntiFlingMurder and not Config.Misc.AntiFlingSheriff then stopAntiFling() end
        end
    end)
    CreateToggle(GameTab, "Anti-Fling Murder", Config.Misc.AntiFlingMurder, function(v)
        Config.Misc.AntiFlingMurder = v
        if v then startAntiFling() else
            if not Config.Misc.AntiFling and not Config.Misc.AntiFlingSheriff then stopAntiFling() end
        end
    end)
    CreateToggle(GameTab, "Anti-Fling Sheriff", Config.Misc.AntiFlingSheriff, function(v)
        Config.Misc.AntiFlingSheriff = v
        if v then startAntiFling() else
            if not Config.Misc.AntiFling and not Config.Misc.AntiFlingMurder then stopAntiFling() end
        end
    end)

    CreateToggle(VisTab, "ESP Box", Config.Visuals.ESP, function(v) Config.Visuals.ESP = v end)
    CreateToggle(VisTab, "ESP Box (Self)", Config.Visuals.ESP_Self, function(v) Config.Visuals.ESP_Self = v end)
    CreateToggle(VisTab, "Skin Changer (Body)", Config.Visuals.SkinChanger, function(v)
        Config.Visuals.SkinChanger = v
        if v then applySkin("Red") else applySkin("Default") end
    end)
    CreateToggle(VisTab, "Weapon Skin (Red)", false, function(v)
        if v then
            Config.Visuals.WeaponSkin = "Red"
            applyWeaponSkin("Red")
        else
            Config.Visuals.WeaponSkin = "Default"
            applyWeaponSkin("Default")
        end
    end)

    CreateToggle(TargetTab, "Aimbot", Config.Combat.Aimbot, function(v) Config.Combat.Aimbot = v end)
    CreateSlider(TargetTab, "Aimbot FOV", 10, 500, Config.Combat.AimbotFOV, function(v) Config.Combat.AimbotFOV = v end)
    CreateSlider(TargetTab, "Aimbot Smooth", 1, 100, 15, function(v) Config.Combat.AimbotSmooth = v / 100 end)
    CreateToggle(TargetTab, "Prediction", Config.Combat.Prediction, function(v) Config.Combat.Prediction = v end)
    CreateToggle(TargetTab, "Force Shoot", Config.Combat.ForceShoot, function(v) Config.Combat.ForceShoot = v end)
    CreateToggle(TargetTab, "Auto Shoot", Config.Combat.AutoShoot, function(v) Config.Combat.AutoShoot = v end)

    CreateToggle(MiscTab, "Bomb Jump", Config.Movement.BombJump, function(v) Config.Movement.BombJump = v end)
    CreateSlider(MiscTab, "Jump Power", 20, 150, Config.Movement.JumpPower, function(v) Config.Movement.JumpPower = v end)
end

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        local ok, err = pcall(LoadMainScript)
        if not ok then
            warn("Ошибка в скрипте: " .. tostring(err))
        end
    else
        StatusLabel.TextColor3 = RED
        StatusLabel.Text = "Invalid Key!"
    end
end)
