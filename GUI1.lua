-- LocalScript (в StarterPlayerScripts или StarterGui)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Создаем интерфейс
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300) -- Увеличиваем высоту фрейма для ползунков
frame.Position = UDim2.new(0.5, -100, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Чёрный фон
frame.Parent = screenGui

-- Функция для создания кнопок с обводкой
local function createButton(text, position)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0, 180, 0, 30)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(42, 42, 42) -- Темный фон кнопки
    button.TextColor3 = Color3.new(1, 1, 1) -- Белый текст
    button.TextSize = 18 -- Увеличенный размер текста
    button.Font = Enum.Font.SourceSansBold -- Жирный шрифт
    button.Parent = frame

    -- Добавляем обводку (UIStroke)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(238, 130, 238) -- Неоновый фиолетовый цвет
    stroke.Thickness = 1
    stroke.Parent = button

    return button
end

-- Функция для создания текстового поля (ползунка)
local function createTextBox(placeholder, position)
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 180, 0, 30)
    textBox.Position = position
    textBox.BackgroundColor3 = Color3.fromRGB(42, 42, 42) -- Темный фон
    textBox.TextColor3 = Color3.new(1, 1, 1) -- Белый текст
    textBox.PlaceholderText = placeholder -- Текст-подсказка
    textBox.TextSize = 18 -- Размер текста
    textBox.Font = Enum.Font.SourceSansBold -- Жирный шрифт
    textBox.Parent = frame

    -- Добавляем обводку (UIStroke)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(238, 130, 238) -- Неоновый фиолетовый цвет
    stroke.Thickness = 1
    stroke.Parent = textBox

    return textBox
end

-- Создаем кнопки
local speedButton = createButton("Walkspeed", UDim2.new(0, 10, 0, 10))
local jumpButton = createButton("Jump power", UDim2.new(0, 10, 0, 90))
local flyButton = createButton("Fly", UDim2.new(0, 10, 0, 170)) -- Кнопка Fly

-- Создаем текстовые поля (ползунки)
local speedTextBox = createTextBox("Enter Walkspeed", UDim2.new(0, 10, 0, 50))
local jumpTextBox = createTextBox("Enter Jump Power", UDim2.new(0, 10, 0, 130))

-- Функция для изменения скорости
speedButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            -- Получаем значение из текстового поля
            local speed = tonumber(speedTextBox.Text)
            if speed and speed > 0 then
                humanoid.WalkSpeed = speed
            else
                warn("Invalid Walkspeed value!")
            end
        end
    end
end)

-- Функция для изменения высоты прыжка
jumpButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            -- Получаем значение из текстового поля
            local jumpPower = tonumber(jumpTextBox.Text)
            if jumpPower and jumpPower > 0 then
                humanoid.JumpPower = jumpPower
            else
                warn("Invalid Jump Power value!")
            end
        end
    end
end)

-- Функция для Fly
flyButton.MouseButton1Click:Connect(function()
    -- Загружаем и выполняем внешний скрипт
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

-- Перемещение меню
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

-- Закрытие меню по нажатию клавиши K
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Игнорируем, если событие уже обработано игрой
    if input.KeyCode == Enum.KeyCode.K then
        screenGui.Enabled = not screenGui.Enabled -- Переключаем видимость меню
    end
end)
