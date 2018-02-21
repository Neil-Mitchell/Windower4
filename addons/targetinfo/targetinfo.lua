_addon.name = 'TargetInfo'
_addon.author = 'Arcon'
_addon.version = '1.0.1.0'
_addon.language = 'English'

require('luau')
texts = require('texts')

-- Config

defaults = {}
defaults.ShowHexID = true
defaults.ShowFullID = true
defaults.ShowSpeed = true
defaults.ShowClaimName = true
defaults.ShowClaimID = true
defaults.ShowTargetName = true
defaults.ShowTargetID = true
defaults.display = {}
defaults.display.pos = {}
defaults.display.pos.x = 0
defaults.display.pos.y = 0
defaults.display.bg = {}
defaults.display.bg.red = 0
defaults.display.bg.green = 0
defaults.display.bg.blue = 0
defaults.display.bg.alpha = 102
defaults.display.text = {}
defaults.display.text.font = 'Consolas'
defaults.display.text.red = 255
defaults.display.text.green = 255
defaults.display.text.blue = 255
defaults.display.text.alpha = 255
defaults.display.text.size = 12

settings = config.load(defaults)

text_box = texts.new(settings.display, settings)

-- Constructor

initialize = function(text, settings)
    local properties = L{}
    if settings.ShowFullID then
        properties:append('ID:            ${full||%08s}')
    end
    if settings.ShowHexID then
        properties:append('Hex ID:        ${hex||%.8X}')
    end
    if settings.ShowSpeed then
        properties:append('Speed:           ${speed}')
    end
    if settings.ShowClaimName then
        properties:append('Claim: ${claim_name||%16s}')
    end
    if settings.ShowClaimID then
        properties:append('Claim ID: ${claim_id||%13s}')
    end
    if settings.ShowTargetName then
        properties:append('Target: ${target_name||%15s}')
    end
    if settings.ShowTargetID then
        properties:append('Target ID: ${target_id||%12s}')
    end

    text:clear()
    text:append(properties:concat('\n'))
end

text_box:register_event('reload', initialize)

windower.register_event('incoming chunk',function(id)
    if id == 0xB and text_box:visible() then
        zoning_bool = true
    elseif id == 0xA and zoning_bool then
        zoning_bool = nil
    end
end)

-- Events

windower.register_event('prerender', function()
    local mob = windower.ffxi.get_mob_by_target('st') or windower.ffxi.get_mob_by_target('t')
    local player = windower.ffxi.get_player()
    if zoning_bool then
        text_box:hide()
        return
    end
    if mob and mob.id > 0 then
        local mobclaim = windower.ffxi.get_mob_by_id(mob.claim_id)
        local target = windower.ffxi.get_mob_by_index(mob.target_index)
        local info = {}
        info.hex = mob.id % 0x100000000
        info.full = mob.id
        local speed
        if mob.status == 5 or mob.status == 85 then
            speed = (100 * (mob.movement_speed / 4)):round(2)
        else
            speed = (100 * (mob.movement_speed / 5 - 1)):round(2)
        end
        info.speed = (
            speed > 0 and
                '\\cs(0,255,0)' .. ('+' .. speed):lpad(' ', 5)
            or speed < 0 and
                '\\cs(255,0,0)' .. speed:string():lpad(' ', 5)
            or
                '\\cs(102,102,102)' .. ('+' .. speed):lpad(' ', 5)) .. '%\\cr'
        if mob.id == player.id then
            info.claim_name = mobclaim and mobclaim.name or 'None'
            info.claim_id = mobclaim and mobclaim.id or 'None'
            info.target_name = mob and mob.name or 'None'
            info.target_id = mob and mob.id or 'None'
        elseif mobclaim and mobclaim.id > 0 then
            info.claim_name = mobclaim and mobclaim.name or 'None'
            info.claim_id = mobclaim and mobclaim.id or 'None'
            info.target_name = target and target.name or 'None'
            info.target_id = target and target.id or 'None'
        elseif target and target.id > 0 then
            info.claim_name = mobclaim and mobclaim.name or 'None'
            info.claim_id = mobclaim and mobclaim.id or 'None'
			info.target_name = target and target.name or 'None'
            info.target_id = target and target.id or 'None'
        else
            info.claim_name = mobclaim and mobclaim.name or 'None'
            info.claim_id = mobclaim and mobclaim.id or 'None'
            info.target_name = target and target.name or 'None'
			info.target_id = target and target.id or 'None'
        end
        text_box:update(info)
        text_box:show()
    else
        text_box:hide()
    end
end)

--[[
Copyright © 2013-2015, Windower
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of Windower nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Windower BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]
