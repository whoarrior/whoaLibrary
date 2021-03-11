WHOA_LIB_LINE_HEIGHT  = 25
WHOA_LIB_LINE_PADDING = 5
WHOA_LIB_BTN_WIDTH    = 185

local BTN_HEIGHT = WHOA_LIB_LINE_HEIGHT + 2
local ANCHOR     = "TOPLEFT"

local ANCHORS = {
    "CENTER",
    "TOPLEFT",
    "TOP",
    "TOPRIGHT",
    "RIGHT",
    "BOTTOMRIGHT",
    "BOTTOM",
    "BOTTOMLEFT",
    "LEFT",
}

function whoaLibrary_createFrame(spec, parent, point, xOffset, yOffset, width, alignment, scale)
    local f = CreateFrame("Frame", spec, parent)
    f:SetPoint(point, parent, point, xOffset, yOffset)
    f:SetWidth(width)
    f:SetHeight(20)
    if scale ~= nil and scale >= 1 then
        f:SetScale(scale)
    end
    f.text = f:CreateFontString(spec.."text", "OVERLAY")
    f.text:SetAllPoints(f)
    f.text:SetFontObject(TextStatusBarText)
    f.text:SetJustifyH(alignment)
end

function whoaLibrary_createButton(width, x, y, label, onClick)
    local o = CreateFrame("Button", nil, whoaCharacterStats.optionPanel, "UIPanelButtonTemplate")
    o:SetSize(width, BTN_HEIGHT)
    o:SetText(label)
    o:SetPoint(ANCHOR, x, y)
    o:SetScript("OnClick", onClick)
end

function whoaLibrary_createCheckButton(name, x, y, label, desc, cvar, onClick)
    local o = CreateFrame("CheckButton", name, whoaCharacterStats.optionPanel, "InterfaceOptionsCheckButtonTemplate")
    o:SetScript("OnClick", function(self)
        local tick = self:GetChecked()
        onClick(self, tick and true or false)
        if tick then
            PlaySound(856) -- # SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
        else
            PlaySound(857) -- # SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
        end
    end)
    o.label = _G[o:GetName() .. "Text"]
    o.label:SetText(label)
    o.tooltipText = label
    o.tooltipRequirement = desc
    o:SetChecked(cvar)
    o:SetPoint(ANCHOR, x, y)
end

function whoaLibrary_createDropDown(name, array, x, y, label, cvar, save, update)
    local info = {}
    local o = CreateFrame("Frame", name, whoaCharacterStats.optionPanel, "UIDropDownMenuTemplate")
    o:SetPoint(ANCHOR, x, y)
    o.initialize = function()
        wipe(info)
        for _, v in pairs(array) do
            info.text = v
            info.value = v
            info.func = function(self)
                save(self.value)
                _G[n.."Text"]:SetText(self:GetText())
                update()
            end
            info.checked = v == cvar()
            UIDropDownMenu_AddButton(info)
        end
    end
    local oLabel = o:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    oLabel:SetPoint("BOTTOMLEFT", o, "TOPLEFT", 25, -2)
    oLabel:SetJustifyH("LEFT")
    oLabel:SetHeight(18)
    oLabel:SetText(label)
end

function whoaLibrary_createSlider(name, label, percent, x, y, min, max, update)
    local o = CreateFrame("Slider", name, whoaCharacterStats.optionPanel, "HorizontalSliderTemplate")
    o:SetPoint(ANCHOR, x, y)
    o:SetSize(170, 16)
    o:SetMinMaxValues(min, max)
    local oLabel = o:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    oLabel:SetPoint("BOTTOMLEFT", o, "TOPLEFT", 26, -2)
    oLabel:SetJustifyH("LEFT")
    oLabel:SetHeight(18)
    oLabel:SetText(label)
    local oMin = o:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    oMin:SetPoint("TOPLEFT", o, "BOTTOMLEFT", 2, -1)
    if percent then
        oMin:SetFormattedText("%s%%", (min * 100))
    else
        oMin:SetText(min)
    end
    local oMax = o:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    oMax:SetPoint("TOPRIGHT", o, "BOTTOMRIGHT", -2, -1)
    if percent then
        oMax:SetFormattedText("%s%%", (max * 100))
    else
        oMax:SetText(max)
    end
    local oValue = o:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    oValue:SetPoint("TOP", o, "BOTTOM", 0, -1)
    oValue:SetText(whoaRound(o:GetValue(), 0))
    o:SetScript("OnValueChanged", function(self, value)
        update(value)
        if percent then
            oValue:SetFormattedText("%s%%", (whoaRound(value, 2) * 100))
        else
            oValue:SetText(whoaRound(value, 0))
        end
    end)
end
