local SettingsButton = {
    Rectangle = { Y = 0, Width = 500, Height = 47 },
    Text = { X = 25, Y = 29, Scale = 0.25 },
    LeftBadge = { Y = -2, Width = 40, Height = 40 },
    RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
    RightText = { X = 405, Y = 4, Scale = 0.23 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---@type table
local SettingsList = {
    LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 240, Y = 25, Width = 28, Height = 28 },
    RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 374, Y = 25, Width = 28, Height = 28 },
    Text = { X = 400, Y = 6, Scale = 0.23 },
}


local function RenderBadge(Item, X, Y, Selected)
    local Color = Selected and Item.Color or Item.Color2
    local Badge = Item.Badge

    if Selected then
        local OutlineColor = { R = 255, G = 255, B = 255, A = 255 }
        RenderSprite(Badge.Dictionary, Badge.Texture, X - 50.25, Y + 15.75, SettingsList.LeftArrow.Width + 5,
            SettingsList.LeftArrow.Height + 5, 0, OutlineColor.R, OutlineColor.G, OutlineColor.B, OutlineColor.A)
    end
    RenderSprite(Badge.Dictionary, Badge.Texture, X - 48, Y + 18, SettingsList.LeftArrow.Width,
        SettingsList.LeftArrow.Height, 0, Color.R, Color.G, Color.B, Color.A)
end

function RageUI.ListColor(Label, Items, Index, Description, Style, Enabled, Actions, Submenu, IndexColor)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;

    if CurrentMenu ~= nil then
        if CurrentMenu.Display then
            ---@type number
            local Option = RageUI.Options + 1

            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                ---@type number
                local Selected = CurrentMenu.Index == Option

                ---@type boolean
                local LeftArrowHovered, RightArrowHovered = false, false

                RageUI.ItemsSafeZone(CurrentMenu)

                local Hovered = false;
                local LeftBadgeOffset = ((Style.LeftBadge == RageUI.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
                local RightBadgeOffset = ((Style.RightBadge == RageUI.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)
                local RightOffset = 0
                ---@type boolean
                if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0) or (CurrentMenu.CursorStyle == 1) then
                    Hovered = RageUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton);
                end
                if Selected then
                    RenderSprite("commonmenu", "bouton", CurrentMenu.X + 15,
                        CurrentMenu.Y + 20 + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight +
                        RageUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset - 46,
                        SettingsButton.SelectedSprite.Height - 1, 0, Config.dRageUI.color.R,
                        Config.dRageUI.color.G, Config.dRageUI.color.B, Config.dRageUI.color.A)
                    --add
                    RenderSprite(SettingsList.LeftArrow.Dictionary, SettingsList.LeftArrow.Texture,
                        CurrentMenu.X + SettingsList.LeftArrow.X,
                        CurrentMenu.Y + SettingsList.LeftArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                        SettingsList.LeftArrow.Width, SettingsList.LeftArrow.Height, 0, 255, 255, 255, 255)
                    RenderSprite(SettingsList.RightArrow.Dictionary, SettingsList.RightArrow.Texture,
                        CurrentMenu.X + SettingsList.RightArrow.X,
                        CurrentMenu.Y + SettingsList.RightArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                        SettingsList.RightArrow.Width, SettingsList.RightArrow.Height, 0, 255, 255, 255, 255)


                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X,
                        CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0,
                        SettingsButton.Text.Scale, 255, 255, 255, 255)
                else
                    RenderSprite(SettingsList.LeftArrow.Dictionary, SettingsList.LeftArrow.Texture,
                        CurrentMenu.X + SettingsList.LeftArrow.X,
                        CurrentMenu.Y + SettingsList.LeftArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                        SettingsList.LeftArrow.Width, SettingsList.LeftArrow.Height, 0, 163, 159, 148, 255)
                    RenderSprite(SettingsList.RightArrow.Dictionary, SettingsList.RightArrow.Texture,
                        CurrentMenu.X + SettingsList.RightArrow.X,
                        CurrentMenu.Y + SettingsList.RightArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset,
                        SettingsList.RightArrow.Width, SettingsList.RightArrow.Height, 0, 163, 159, 148, 255)

                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X,
                        CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0,
                        SettingsButton.Text.Scale, 150, 150, 150, 255)
                    RenderSprite("commonmenu", "bouton", CurrentMenu.X + 15,
                        CurrentMenu.Y + 20 + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight +
                        RageUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset - 46,
                        SettingsButton.SelectedSprite.Height - 1, 0, 16, 16, 16, 150)
                end

                local MaxVisibleBadges = 5
                local StartIndex = math.max(1, Index - math.floor(MaxVisibleBadges / 2))
                local EndIndex = math.min(#Items, StartIndex + MaxVisibleBadges - 1)
                StartIndex = EndIndex - MaxVisibleBadges + 1

                local BadgeX = CurrentMenu.X + SettingsButton.Text.X + 265
                for i = StartIndex, EndIndex do
                    RenderBadge(Items[i], BadgeX + 20,
                        CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 1,
                        i == Index)
                    BadgeX = BadgeX + SettingsList.LeftArrow.Width + -5 -- espacement entre les badges
                end

                RightOffset = RightBadgeOffset * 1.3 + RightOffset



                if type(Style) == "table" then
                    if Style.Enabled == true or Style.Enabled == nil then
                        if type(Style) == 'table' then
                            if Style.LeftBadge ~= nil then
                                if Style.LeftBadge ~= RageUI.BadgeStyle.None then
                                    local BadgeData = Style.LeftBadge(Selected)

                                    RenderSprite("commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X,
                                        CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight +
                                        RageUI.ItemOffset, SettingsButton.LeftBadge.Width,
                                        SettingsButton.LeftBadge.Height, 0,
                                        BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255,
                                        BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255,
                                        BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255,
                                        BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end

                            if Style.RightBadge ~= nil then
                                if Style.RightBadge ~= RageUI.BadgeStyle.None then
                                    local BadgeData = Style.RightBadge(Selected)

                                    RenderSprite("commonmenu", BadgeData.BadgeTexture or "",
                                        CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset,
                                        CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight +
                                        RageUI.ItemOffset, SettingsButton.RightBadge.Width,
                                        SettingsButton.RightBadge.Height, 0,
                                        BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255,
                                        BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255,
                                        BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255,
                                        BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end
                        end
                    else
                        ---@type table
                        local LeftBadge = RageUI.BadgeStyle.Lock
                        ---@type number
                        if LeftBadge ~= RageUI.BadgeStyle.None and LeftBadge ~= nil then
                            local BadgeData = LeftBadge(Selected)

                            RenderSprite("commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X,
                                CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight +
                                RageUI.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0,
                                BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour.G or 255,
                                BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour.A or 255)
                        end
                    end
                else
                    error("UICheckBox Style is not a `table`")
                end

                LeftArrowHovered = RageUI.IsMouseInBounds(
                    CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset - RightOffset +
                    CurrentMenu.SafeZoneSize.X,
                    CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 2.5 +
                    CurrentMenu.SafeZoneSize.Y, 15, 22.5)

                RightArrowHovered = RageUI.IsMouseInBounds(
                    CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset + CurrentMenu.SafeZoneSize.X -
                    RightOffset -
                    MeasureStringWidth(ListText, 0, SettingsList.Text.Scale),
                    CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 2.5 +
                    CurrentMenu.SafeZoneSize.Y, 15, 22.5)
                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height

                RageUI.ItemsDescription(CurrentMenu, Description, Selected);

                if Selected and (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) and not (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) then
                    Index = Index - 1
                    if Index < 1 then
                        Index = #Items
                    end
                    if (Actions.onListChange ~= nil) then
                        Actions.onListChange(Index, Items[Index]);
                    end
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                elseif Selected and (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) and not (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) then
                    Index = Index + 1
                    if Index > #Items then
                        Index = 1
                    end
                    if (Actions.onListChange ~= nil) then
                        Actions.onListChange(Index, Items[Index]);
                    end
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                end

                if Selected and (CurrentMenu.Controls.Select.Active or ((Hovered and CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)

                    if (Actions.onSelected ~= nil and not isWaitingForServer) then
                        Actions.onSelected(Index, Items[Index]);
                    end

                    if Submenu ~= nil and type(Submenu) == "table" then
                        RageUI.NextMenu = Submenu[Index]
                    end
                elseif Selected then
                    if (Actions.onActive ~= nil) then
                        Actions.onActive()
                    end
                end
            end

            RageUI.Options = RageUI.Options + 1
        end
    end
end
