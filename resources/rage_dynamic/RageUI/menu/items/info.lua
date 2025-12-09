local SettingsInfo = {
    Rectangle = { X = 450, Y = 67, Width = 432, Height = 45, Color = { 13, 20, 34, 255 }}, -- +10 sur Y
    Text = {
        Title = { X = 480, Y = 70, Scale = 0.30 }, -- +10 sur Y
        Right = { X = 480, Y = 102, Scale = 0.25, Color = { 255, 255, 255, 255 }}, -- +10 sur Y
        Left = { X = 895, Y = 102, Scale = 0.25, Color = { 255, 255, 255, 255 }}, -- +10 sur Y
    },
}

function RageUI.Info(Title, RightText, LeftText)
    local LineCount = #RightText >= #LeftText and #RightText or #LeftText
    
    if Title ~= nil then
        RenderText(Title, RageUI.CurrentMenu.WidthOffset + SettingsInfo.Text.Title.X - 5, SettingsInfo.Text.Title.Y + 62, 100, SettingsInfo.Text.Title.Scale, 255, 255, 255, 255, 0)
    end    
    
    if RightText ~= nil then
        RenderText(table.concat(RightText, "\n"), RageUI.CurrentMenu.WidthOffset + SettingsInfo.Text.Right.X + 0, SettingsInfo.Text.Right.Y + 62, 99, SettingsInfo.Text.Right.Scale, SettingsInfo.Text.Right.Color[1], SettingsInfo.Text.Right.Color[2], SettingsInfo.Text.Right.Color[3], SettingsInfo.Text.Right.Color[4], 0, true)
    end
    
    if LeftText ~= nil then
        RenderText(table.concat(LeftText, "\n"), RageUI.CurrentMenu.WidthOffset + SettingsInfo.Text.Left.X - 5, SettingsInfo.Text.Left.Y + 62, 100, SettingsInfo.Text.Left.Scale, SettingsInfo.Text.Left.Color[1], SettingsInfo.Text.Left.Color[2], SettingsInfo.Text.Left.Color[3], SettingsInfo.Text.Left.Color[4], 2, true)
    end

    RenderSprite("commonmenu", "gradient_bgd", SettingsInfo.Rectangle.X + 20, SettingsInfo.Rectangle.Y + 62, SettingsInfo.Rectangle.Width, SettingsInfo.Rectangle.Height + (LineCount * 20), 0, 0, 0, 0, 255)
end
