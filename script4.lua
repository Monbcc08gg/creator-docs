-- UI + Auto Spam SpawnLuckyBlock

local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local remote = rs:WaitForChild("SpawnLuckyBlock")

-- สถานะ
local running = false

-- สร้าง UI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,200,0,100)
frame.Position = UDim2.new(0.5,-100,0.5,-50)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Parent = gui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1,0,1,0)
btn.Text = "OFF"
btn.TextScaled = true
btn.Parent = frame

-- ปุ่มเปิด/ปิด
btn.MouseButton1Click:Connect(function()
    running = not running
    btn.Text = running and "ON" or "OFF"
end)

-- ยิงรัว
task.spawn(function()
    while true do
        if running then
            pcall(function()
                remote:FireServer()
            end)
        end
        task.wait(0.1) -- ปรับความไวตรงนี้ (ยิ่งน้อยยิ่งรัว)
    end
end)
