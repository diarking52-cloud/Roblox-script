local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function createESP(player)
	if player == LocalPlayer then return end

	local function setupCharacter(char)
		local hrp = char:WaitForChild("HumanoidRootPart", 5)
		if not hrp then return end

		-- 1. Chams / Highlight (Подсветка тела как на скриншоте)
		local hl = char:FindFirstChild("OverdriveHighlight") or Instance.new("Highlight")
		hl.Name = "OverdriveHighlight"
		hl.Adornee = char
		hl.FillColor = Color3.fromRGB(255, 255, 255) -- Белое свечение
		hl.FillTransparency = 0.5
		hl.OutlineColor = Color3.fromRGB(0, 150, 255)
		hl.OutlineTransparency = 0.2
		hl.Parent = char

		-- 2. Box ESP + Ник / Расстояние (Рамка вокруг игрока)
		local bb = char:FindFirstChild("OverdriveBox") or Instance.new("BillboardGui")
		bb.Name = "OverdriveBox"
		bb.Size = UDim2.new(4, 0, 5.5, 0)
		bb.AlwaysOnTop = true
		bb.Adornee = hrp
		bb.Parent = char

		local boxFrame = bb:FindFirstChild("BoxFrame") or Instance.new("Frame")
		boxFrame.Name = "BoxFrame"
		boxFrame.Size = UDim2.new(1, 0, 1, 0)
		boxFrame.BackgroundTransparency = 1
		boxFrame.BorderSizePixel = 2
		boxFrame.BorderColor3 = Color3.fromRGB(0, 120, 255) -- Синяя рамка
		boxFrame.Parent = bb

		local textLabel = bb:FindFirstChild("InfoLabel") or Instance.new("TextLabel")
		textLabel.Name = "InfoLabel"
		textLabel.Size = UDim2.new(1, 0, 0, 15)
		textLabel.Position = UDim2.new(0, 0, 1, 2)
		textLabel.BackgroundTransparency = 1
		textLabel.TextSize = 10
		textLabel.Font = Enum.Font.SourceSansBold
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.Parent = bb
	end

	if player.Character then
		setupCharacter(player.Character)
	end
	player.CharacterAdded:Connect(setupCharacter)
end

-- Динамическое обновление расстояния
RunService.RenderStepped:Connect(function()
	local myChar = LocalPlayer.Character
	local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")

	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			local hrp = p.Character:FindFirstChild("HumanoidRootPart")
			local bb = p.Character:FindFirstChild("OverdriveBox")

			if hrp and bb and bb:FindFirstChild("InfoLabel") and myHrp then
				local dist = math.floor((myHrp.Position - hrp.Position).Magnitude)
				bb.InfoLabel.Text = p.Name .. " [" .. dist .. "m]"
			end
		end
		end
