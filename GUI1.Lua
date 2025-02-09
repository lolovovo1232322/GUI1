-- LocalScript (в StarterPlayerScripts или StarterGui)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300) 
frame.Position = UDim2.new(0.5, -100, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) 
frame.Parent = screenGui

local function createButton(text, position)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0, 180, 0, 30)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(42, 42, 42) 
    button.TextColor3 = Color3.new(1, 1, 1) 
    button.TextSize = 18 
    button.Font = Enum.Font.SourceSansBold 
    button.Parent = frame

   
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(238, 130, 238) 
    stroke.Thickness = 1
    stroke.Parent = button

    return button
end


local function createTextBox(placeholder, position)
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 180, 0, 30)
    textBox.Position = position
    textBox.BackgroundColor3 = Color3.fromRGB(42, 42, 42) 
    textBox.TextColor3 = Color3.new(1, 1, 1) 
    textBox.PlaceholderText = placeholder 
    textBox.TextSize = 18 
    textBox.Font = Enum.Font.SourceSansBold 
    textBox.Parent = frame

    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(238, 130, 238) 
    stroke.Thickness = 1
    stroke.Parent = textBox

    return textBox
end


local speedButton = createButton("Walkspeed", UDim2.new(0, 10, 0, 10))
local jumpButton = createButton("Jump power", UDim2.new(0, 10, 0, 90))
local flyButton = createButton("Fly", UDim2.new(0, 10, 0, 170)) 


local speedTextBox = createTextBox("Enter Walkspeed", UDim2.new(0, 10, 0, 50))
local jumpTextBox = createTextBox("Enter Jump Power", UDim2.new(0, 10, 0, 130))


speedButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            
            local speed = tonumber(speedTextBox.Text)
            if speed and speed > 0 then
                humanoid.WalkSpeed = speed
            else
                warn("Invalid Walkspeed value!")
            end
        end
    end
end)


jumpButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            
            local jumpPower = tonumber(jumpTextBox.Text)
            if jumpPower and jumpPower > 0 then
                humanoid.JumpPower = jumpPower
            else
                warn("Invalid Jump Power value!")
            end
        end
    end
end)


flyButton.MouseButton1Click:Connect(function()
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)


local dragging = false
local dragStartPos
local frameStartPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
        frameStartPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local dragDelta = Vector2.new(input.Position.X, input.Position.Y) - dragStartPos
        frame.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + dragDelta.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset + dragDelta.Y)
    end
end)


UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end 
    if input.KeyCode == Enum.KeyCode.K then
        screenGui.Enabled = not screenGui.Enabled 
    end
end)
