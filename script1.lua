--// PLAYER
local player = game.Players.LocalPlayer

--// GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

-- KEY FRAME
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,300,0,150)
frame.Position = UDim2.new(0.5,-150,0.5,-75)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0,260,0,40)
box.Position = UDim2.new(0,20,0,20)
box.PlaceholderText = "ใส่คีย์"
box.TextScaled = true

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0,260,0,40)
btn.Position = UDim2.new(0,20,0,80)
btn.Text = "ยืนยัน"
btn.TextScaled = true

local key = "445566"

-- MENU
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,200,0,260)
menu.Position = UDim2.new(0,20,0.5,-130)
menu.BackgroundColor3 = Color3.fromRGB(20,20,20)
menu.Visible = false

-- ปุ่มเปิดปิด
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0,100,0,40)
toggleBtn.Position = UDim2.new(0,20,0,20)
toggleBtn.Text = "OPEN"
toggleBtn.TextScaled = true
toggleBtn.Visible = false

-- สร้างปุ่ม
local function makeBtn(text, y)
	local b = Instance.new("TextButton", menu)
	b.Size = UDim2.new(0,160,0,40)
	b.Position = UDim2.new(0,20,0,y)
	b.Text = text
	b.TextScaled = true
	return b
end

local speedBtn = makeBtn("Speed", 10)
local flyBtn = makeBtn("Fly", 60)
local espBtn = makeBtn("ESP", 110)
local jumpBtn = makeBtn("High Jump", 160)
local closeBtn = makeBtn("Close", 210)

-- KEY CHECK
btn.MouseButton1Click:Connect(function()
	if box.Text == key then
		frame.Visible = false
		menu.Visible = true
		toggleBtn.Visible = true
	end
end)

-- เปิด/ปิดเมนู
toggleBtn.MouseButton1Click:Connect(function()
	menu.Visible = not menu.Visible
end)

closeBtn.MouseButton1Click:Connect(function()
	menu.Visible = false
end)

-- SPEED
local speedOn = false
speedBtn.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	local hum = player.Character and player.Character:FindFirstChild("Humanoid")
	if hum then
		hum.WalkSpeed = speedOn and 50 or 16
	end
end)

-- FLY
local flying = false
local bv

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	local char = player.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")

	if flying then
		bv = Instance.new("BodyVelocity", root)
		bv.Velocity = Vector3.new(0,50,0)
		bv.MaxForce = Vector3.new(99999,99999,99999)
	else
		if bv then bv:Destroy() end
	end
end)

-- ESP
local espOn = false
espBtn.MouseButton1Click:Connect(function()
	espOn = not espOn
	
	for _,plr in pairs(game.Players:GetPlayers()) do
		if plr ~= player and plr.Character then
			if espOn then
				if not plr.Character:FindFirstChild("Highlight") then
					local h = Instance.new("Highlight")
					h.Parent = plr.Character
					h.FillColor = Color3.fromRGB(255,0,0)
				end
			else
				local h = plr.Character:FindFirstChild("Highlight")
				if h then h:Destroy() end
			end
		end
	end
end)

-- HIGH JUMP
local jumpOn = false
jumpBtn.MouseButton1Click:Connect(function()
	jumpOn = not jumpOn
	
	local hum = player.Character and player.Character:FindFirstChild("Humanoid")
	if hum then
		hum.UseJumpPower = true
		hum.JumpPower = jumpOn and 120 or 50
	end
end)
