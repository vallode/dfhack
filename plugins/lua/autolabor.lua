local _ENV = mkmodule('plugins.autolabor')

local gui = require('gui')
local overlay = require('plugins.overlay')
local widgets = require('gui.widgets')

local function is_labor_panel_visible()
    local info = df.global.game.main_interface.info
    return info.open and info.current_mode == df.info_interface_mode_type.LABOR
end

AutolaborOverlay = defclass(AutolaborOverlay, overlay.OverlayWidget)
AutolaborOverlay.ATTRS{
    default_pos={x=7,y=-13},
    default_enabled=true,
    viewscreens='dwarfmode',
    frame={w=29, h=5},
    frame_style=gui.MEDIUM_FRAME,
    frame_background=gui.CLEAR_PEN,
}

function AutolaborOverlay:init()
    self:addviews{
        widgets.Label{
            frame={t=0, l=0},
            text_pen=COLOR_RED,
            text={
                'DFHack autolabor is active!', NEWLINE,
                'Any changes made on this', NEWLINE,
                'screen will have no effect.'
            },
        },
    }
end

function AutolaborOverlay:render(dc)
    if not is_labor_panel_visible() or not isEnabled() then
        return false
    end
    AutolaborOverlay.super.render(self, dc)
end

OVERLAY_WIDGETS = {
    overlay=AutolaborOverlay,
}

return _ENV