---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 0, Y = 3, Scale = 0.33 },
}

local SettingsProgress = {
    Background = {
        X = 175.0,
        Y = 30,
        Width = 60,
        Height = 4,

        RGBA = {
            R = 240,
            G = 240,
            B = 240,
            A = 100,
        },
    },
    Bar = {
        X = 175.0,
        Y = 30,
        Width = 60,
        Height = 4,

        RGBA = {
            R = 93,
            G = 182,
            B = 229,
            A = 240,
        },
    },
    Height = 60
}

function RageUI.ProgressSeparator(Label, Progress)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Items = {}
            for i = 1, Progress.ProgressMax do
                table.insert(Items, i)
            end

            local Option = RageUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                if (Label ~= nil) then
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + 220.0, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255,1)
                
                    RenderRectangle(CurrentMenu.X + SettingsProgress.Background.X, CurrentMenu.Y + SettingsProgress.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsProgress.Background.Width + CurrentMenu.WidthOffset, SettingsProgress.Background.Height, SettingsProgress.Background.RGBA.R, SettingsProgress.Background.RGBA.G, SettingsProgress.Background.RGBA.B, SettingsProgress.Background.RGBA.A)
                    RenderRectangle(CurrentMenu.X + SettingsProgress.Bar.X, CurrentMenu.Y + SettingsProgress.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, ((Progress.ProgressStart / #Items) * (SettingsProgress.Bar.Width + CurrentMenu.WidthOffset)), SettingsProgress.Bar.Height, SettingsProgress.Bar.RGBA.R, SettingsProgress.Bar.RGBA.G, SettingsProgress.Bar.RGBA.B, SettingsProgress.Bar.RGBA.A)
                end
                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (RageUI.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = RageUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            RageUI.Options = RageUI.Options + 1
        end
    end
end