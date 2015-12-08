if not _G.BetterLightFX then
    _G.BetterLightFX = {}
    BetterLightFX.debug_enabled = true
    BetterLightFX.debug_systemprint = false
    BetterLightFX.current_color = Color.White
    BetterLightFX.current_states = nil
    BetterLightFX.is_setting_color = false
    
    --[[Note: Whichever state was set last, will persist until removed.
    States:
    nil
    Suspicion
    PointOfNoReturn
    Bleedout
    
    ]]
    
end

--Override LightFX



function BetterLightFX:PrintDebug(message)
    if BetterLightFX.debug_enabled then
        
        if BetterLightFX.debug_systemprint and managers and managers.chat then
            managers.chat:_receive_message(ChatManager.GAME, "BetterLightFX", message, tweak_data.system_chat_color)
        else
            log(message)
        end
    end
end

function BetterLightFX:PrintDebugElapsed(elapsedtime, message)
    if elapsedtime > 0.01 then
        BetterLightFX:PrintDebug(message .. " took " .. string.format("%.2f", elapsedtime) .. " seconds.")
    end
end


function BetterLightFX:SetCurrentState(state)
    if BetterLightFX.current_state and not state then
        BetterLightFX.current_state = nil
    elseif not BetterLightFX.current_state and state then
        BetterLightFX.current_state = state
    end
end

function BetterLightFX:PushColor(color, state)
    
    --Color is already being set
    if BetterLightFX.is_setting_color then
        do return end
    end
    
    --Standardize the color
    if color then
        if color.red > 1 then
            color.red = color.red / 255.0
        end
        if color.green > 1 then
            color.green = color.green / 255.0
        end
        if color.blue > 1 then
            color.blue = color.blue / 255.0
        end
        if color.alpha > 1 then
            color.alpha = color.alpha / 255.0
        end
    end
    
    --Same color, no need to update.
    if BetterLightFX.current_color == color then
        do return end
    end
    
    if SystemInfo:platform() == Idstring("WIN32") and managers.network.account:has_alienware() and not BetterLightFX.is_setting_color and state == BetterLightFX.current_state then
        BetterLightFX.is_setting_color = true
        BetterLightFX:PrintDebug("Set new color: r="..color.red.." g="..color.green.." b="..color.blue.." a="..color.alpha)
        BetterLightFX.current_color = color
        LightFX:set_lamps(math.floor(BetterLightFX.current_color.red * 255.0), math.floor(BetterLightFX.current_color.green * 255.0), math.floor(BetterLightFX.current_color.blue * 255.0), math.floor(BetterLightFX.current_color.alpha * 255.0))
        BetterLightFX.is_setting_color = false
    end
end

function BetterLightFX:SetColor(red, green, blue, alpha, state)
    if state then
        BetterLightFX:PrintDebug("State setting color: ".. state)
    else
        BetterLightFX:PrintDebug("State setting color: nil")
    end
    --BetterLightFX:PrintDebug("Set new color: r="..color.red.." g="..color.green.." b="..color.blue.." a="..color.alpha)
    BetterLightFX:PushColor(Color(alpha, red, green, blue), state)
end

