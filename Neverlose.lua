----------------------------------------------------------------
-- KEY SYSTEM (без кнопки GET KEY)
----------------------------------------------------------------
local CORRECT_KEY = "mrbecon99"

local ACCENT       = Color3.fromRGB(0, 180, 255)
local ACCENT_DARK  = Color3.fromRGB(0, 120, 200)
local BG_MAIN      = Color3.fromRGB(8, 14, 23)
local BG_HEADER    = Color3.fromRGB(12, 20, 31)
local BG_ELEMENT   = Color3.fromRGB(14, 22, 35)
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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NeverloseKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.IgnoreGuiInset = true
KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 340, 0, 220)
KeyFrame.Position = UDim2.new(0.5, -170, 0.5, -110)
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

-- Кнопка SUBMIT на всю ширину (GET KEY убран)
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

SubmitBtn.MouseEnter:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 210, 255)}):Play()
end)
SubmitBtn.MouseLeave:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.15), {BackgroundColor3 = ACCENT}):Play()
end)

local StatusLabel = Instance.new("TextLabel", KeyFrame)
StatusLabel.Size = UDim2.new(1, -30, 0, 20)
StatusLabel.Position = UDim2.new(0, 15, 0, 178)
StatusLabel.Text = ""
StatusLabel.TextColor3 = RED
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.BackgroundTransparency = 1

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        StatusLabel.TextColor3 = GREEN
        StatusLabel.Text = "Key Accepted! Loading..."
        task.wait(0.4)
        LoadMainScript()
    else
        StatusLabel.TextColor3 = RED
        StatusLabel.Text = "Invalid Key!"
    end
end)
