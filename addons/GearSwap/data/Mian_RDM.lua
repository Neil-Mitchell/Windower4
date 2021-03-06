function get_sets()

  mote_include_version = 2

  include('Mote-Include.lua')

end

function job_setup()

  include('Kay-Include.lua')

  initialize_job()


  gear.main = player.equipment.main
  gear.sub = player.equipment.sub

end

function user_setup()

  state.IdleMode:options('Normal','Combat')
  state.OffenseMode:options('Normal','DW')
  state.WeaponskillMode:options('Normal','HNM')
  state.PhysicalDefenseMode:options('PDT')
  state.MagicalDefenseMode:options('MDT')
  state.CastingMode:options('Normal','Acc','Combat')

  sleeps            = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Bind'}
  elemental_debuffs = S{'Burn','Choke','Shock','Rasp','Drown','Frost'}

  spikes            = S{'Blaze Spikes','Shock Spikes','Ice Spikes'}

  casting_mode = ''

  send_command('bind !f9 gs c cycle IdleMode')

end

function init_gear_sets()

	--Misc
	sets.MND
	 = {ammo="Sturm's report"
	   ,neck="Morgana's choker"
	   ,ear1="Star earring"
	   ,ear2="Star earring"
	   ,body="Errant houppelande"
	   ,hands="Devotee's mitts +1"
	   ,ring1="Tamas ring"
     ,back=prism_cape['Fast Cast']    
	   ,waist="Penitent's rope"
	   ,legs="Errant slops"
	   ,feet="Errant pigaches"}
	   
	sets.INT
	 = {ammo="Phantom tathlum"
	   ,head="Warlock's chapeau"
	   ,neck="Lemegeton medallion +1"
	   ,ear1="Abyssal earring"
     --,ear2="Morion earring +1"
	   ,body="Errant houppelande"
	   ,hands="Errant cuffs"
	   ,ring1="Tamas ring"
     ,ring2="Snow ring"
     ,back=prism_cape['Fast Cast']    
	   ,waist="Penitent's rope"
	   ,legs="Errant slops"
	   ,feet="Custom F boots"}
	
	-- grips														 	   
	sets.grip
	 = {Fire 	    = {sub="Fire Grip"}
     ,Earth 	  = {sub="Earth Grip"}
     ,Water 	  = {sub="Water Grip"}
     ,Wind 	    = {sub="Wind Grip"}
     ,Ice 	    = {sub="Ice Grip"}
     ,Lightning = {sub="Thunder Grip"}
     ,Light 	  = {sub="Light Grip"}
     ,Dark 	    = {sub="Dark Grip"}}
     
	-- idle
	sets.idle
	 = {main="Terra's staff"
	   ,sub="Bugard leather strap +1"
	   ,ammo="Bibiki seashell"
		 ,head="Duelist's chapeau"
		 ,neck="Chocobo whistle"         
		 ,ear1="Merman's earring"
		 ,ear2="Merman's earring"
     ,body="Dalmatica"        
     ,hands="Duelist's gloves"       
     ,ring1="Merman's ring" 
     ,ring2="Merman's ring"
     ,back="Hexerei cape"       
     ,waist="Resolute belt"          
     ,legs="Crimson cuisses"
     ,feet="Duelist's boots"}
     
  sets.idle.Combat                                   
   = set_combine(sets.idle
                ,{main=""
                 ,sub=""})
   
  sets.idle.Town                                     
   = set_combine(sets.idle
                ,{neck="Orochi nodowa"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"})
   
  sets.idle.Combat                                   
   = set_combine(sets.idle
                ,{main=""
                 ,sub=""})
   
  sets.idle.Town.Combat                              
   = set_combine(sets.idle.Combat
                ,{neck="Orochi nodowa"
                 ,ring2="Warp ring"
                 ,back="Nexus cape"})
	
	sets.resting
	 = {main="Chatoyant staff"
	   ,ammo="Bibiki seashell"
	   ,neck="Grandiose chain"
	   ,ear1="Magnetic earring"
	   ,ear2="Relaxing earring"
	   ,body="Errant houppelande"
	   ,waist="Duelist's belt"
	   ,feet="Avocat pigaches"}
  
  -- precast magic
  sets.precast.FC
   = {head="Warlock's chapeau"
     ,ear2="Loquacious earring"
     ,body="Duelist's tabard"
     ,back=prism_cape['Fast Cast']}
	                                                   
	-- midcast magic                                   
	sets.midcast.FastRecast
	 = set_combine(sets.precast.FC
	              ,{hands="Dusk gloves"
	               ,waist="Velocious belt"
	               ,feet="Dusk ledelsens +1"})
	               
  sets.midcast['Utsusemi: Ni']
   = set_combine(sets.midcast.FastRecast
                ,{ear1="Magnetic earring"})

	sets.midcast['Utsusemi: Ichi'] 
	 = set_combine(sets.midcast['Utsusemi: Ni']
	              ,{waist="Resolute belt"
                 ,back=prism_cape['Spell Interrupt']})

sets.midcast['Healing Magic']
   = set_combine(sets.MND
                ,sets.midcast.FastRecast
                ,{ear1="Magnetic earring"})
                                                     
  sets.midcast['Divine Magic']
   = set_combine(sets.MND
                ,{head="Elite beret"
                 --,legs="Nashira seraweels"
                 })
                 
  sets.midcast['Divine Magic'].Acc
   = set_combine(sets.midcast['Divine Magic']
                ,{--[[ring2="Omega ring"
                 ,]]back=prism_cape['Magic Accuracy']})
                                                     
  sets.midcast['Enfeebling Magic']
   = {head="Duelist's chapeau"
     ,neck="Enfeebling torque"
     ,body="Warlock's tabard"
     --,legs="Nashira seraweels"
     ,feet="Avocat pigaches"}
                                                     
  sets.midcast['Enfeebling Magic']['BlackMagic'] 
   = set_combine(sets.INT
                ,{})
   
  sets.midcast['Enfeebling Magic']['BlackMagic'].Acc
   = set_combine(sets.midcast['Enfeebling Magic']['BlackMagic']
                ,sets.midcast['Enfeebling Magic']
                ,{ammo="Sturm's report"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']})
  
  sets.midcast['Enfeebling Magic']['WhiteMagic']
   = set_combine(sets.MND
                ,{})
   
  sets.midcast['Enfeebling Magic']['WhiteMagic'].Acc
   = set_combine(sets.midcast['Enfeebling Magic']['WhiteMagic']
                ,sets.midcast['Enfeebling Magic']
                ,{ammo="Sturm's report"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']})
  
  sets.midcast['Elemental Magic']
   = set_combine(sets.INT
                ,{--[[ear1="Novio earring"
                 ,]]ear2="Moldavite earring"
                 ,hands="Zenith mitts"
                 ,feet="Duelist's boots"})
   
  sets.midcast['Elemental Magic'].Acc
   = set_combine(sets.midcast['Elemental Magic']
                ,{ammo="Sturm's report"
                 ,head="Warlock's chapeau"
                 ,hands="Duelist's gloves"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']
                 ,legs="Duelist's tights"
                 --[[,feet="Nashira crackows"]]})
                                                     
  sets.midcast['Dark Magic']
   = set_combine(sets.INT
                ,{ammo="Sturm's report"
                 --,neck="Dark torque"
                 --,body="Nashira manteel"
                 ,hands="Crimson finger gauntlets"
                 --,ring2="Omega ring"
                 --[[,back="Merciful cape"]]})
                 
  sets.midcast['Dark Magic'].Acc
   = set_combine(sets.midcast['Dark Magic']
                ,{back=prism_cape['Magic Accuracy']})
                                                     
  sets.midcast['Enhancing Magic']
   = set_combine(sets.midcast.FastRecast
                ,{ear1="Magnetic earring"
                 ,hands="Duelist's gloves"
                 ,waist="Velocious belt"
                 ,legs="Warlock's tights"})
                                                     
  -- custom midcast magic                            
  sets.midcast['Stoneskin']
   = set_combine(sets.MND
                ,sets.midcast.FastRecast
                ,{ear1="Magnetic earring"
                 ,body="Warlock's tabard"
                 ,back=prism_cape['Spell Interrupt']
                 ,waist="Resolute belt"})
                 
  sets.midcast['Phalanx']
   = set_combine(sets.midcast['Stoneskin']
                ,{hands="Duelist's gloves"
                 --,back="Merciful cape"
                 ,legs="Warlock's tights"})                 
                
  sets.midcast['Blink']
   = set_combine(sets.midcast['Stoneskin']
                ,{})
                
  sets.midcast['Aquaveil']
   = set_combine(sets.midcast['Stoneskin']
                ,{})
                 
  sets.midcast.Cure
   = set_combine(sets.midcast['Healing Magic']
                ,{--[[ammo="White tathlum"
                 ,]]neck="Fylgja torque +1"
                 --,ear1="Roundel earring"
                 ,body="Duelist's tabard"
                 ,hands="Devotee's mitts +1"
                 ,back=prism_cape['Cure Potency']
                 ,waist="Duelist's belt"
                 ,legs="Warlock's tights"
                 ,feet="Errant pigaches"})
                 
  sets.midcast.Curaga
   = set_combine(sets.midcast.Cure
                ,{})

  sets.midcast['Cursna']
   = set_combine(sets.midcast['Healing Magic']
                ,{--[[ammo="White tathlum"]]})
                
  sets.midcast.Sleep
   = set_combine(sets.midcast.FastRecast
                ,sets.INT
                ,sets.midcast['Enfeebling Magic']
                ,{hands="Bricta's cuffs"
                 --,ring2="Omega ring"
                 ,back=prism_cape['Magic Accuracy']
                 ,legs="Warlock's tights"})
                
  sets.midcast.EleEnfeebs
   = set_combine(sets.INT
                ,{back=prism_cape['Magic Accuracy']})
                
  sets.midcast.Spikes
   = set_combine(sets.INT
                ,{back=prism_cape['Spell Interrupt']})
  
  -- engaged
  sets.engaged
   = {ammo="Bibiki seashell"
     ,head="Walahra turban"     
     ,neck="Peacock amulet" 
     ,ear1="Merman's earring"
     ,ear2="Brutal earring"
     --,body=scorpion_harness['Haste']
     ,hands="Dusk gloves"
     ,ring1="Sniper's ring +1"    
     ,ring2="Sniper's ring +1"
     ,back="Cuchulain's mantle" 
     ,waist="Velocious belt"
     ,legs="Dusk trousers"
     ,feet="Dusk ledelsens +1"}
     
  sets.engaged.DW                                   
   = set_combine(sets.engaged,{ear1="Suppanomimi"})
  
  -- ws
  sets.precast.WS
   = {neck="Fotia gorget"          
     ,ear1="Merman's earring"
     ,ear2="Brutal earring"
     ,body="Antares harness"
     ,ring1="Sniper's ring +1"    
     ,ring2="Flame ring"     
     ,back="Cuchulain's mantle" 
     ,waist="Swordbelt +1"         
     ,legs="Dusk trousers"}
	
end

function job_midcast(spell,action,spellMap,eventArgs)

  if spell.skill == 'Enfeebling Magic' then
    equip(sets.midcast[spell.skill][spell.type])
  else 
    equip(sets.midcast[spell.skill])
  end

end

function job_post_midcast(spell,action,spellMap,eventsArgs)

  if spell.skill == 'Enhancing Magic' or (spell.skill == 'Healing Magic' and not (spellMap == 'Cure' or spellMap == 'Curaga')) then
    if player.status == 'Idle' and state.IdleMode.value == 'Normal' and state.CastingMode.value ~= 'Combat' then
      equip({main="Seveneyes",sub="Muse tariqah"})
    end
  elseif spellMap == 'Cure' or spellMap == 'Curaga' then
    equip({main="Chatoyant staff",sub="Raptor leather strap +1"})
  else
    if player.status == 'Idle' and state.IdleMode.value == 'Normal' and state.CastingMode.value ~= 'Combat' then
      
      if spell.skill == 'Enfeebling Magic' then
        
        if state.CastingMode.value == 'Normal' then
          equip({main="Alkalurops"})
        else
          equip({main="Chatoyant staff"})
        end
        
        if spell.type == 'WhiteMagic' then
          equip({sub="Raptor leather strap +1"})
        elseif spell.type == 'BlackMagic' then
          equip({sub="Bugard leather strap +1"})
        end 
        
      end
      
      if state.CastingMode.value == 'Acc' and player.status ~= 'Engaged' then
        equip(sets.grip[spell.element])
      end
      
    end
  end

  if spell.skill ~= 'Enhancing Magic' or spell.skill ~= 'Enfeebling Magic' then
    if spell.element == world.weather_element or spell.element == world.day_element then
      
      if world.weather_element ~= 'Dark' and spellMap == 'Cure' then
        equip({waist="Hachirin-no-obi"})
      end
      
      if spell.skill == 'Elemental Magic' then
        equip({waist="Hachirin-no-obi"})
      end
      
    end
  end
  
end

function job_get_spell_map(spell, default_spell_map)
  if spell.skill == 'Enfeebling Magic' and sleeps:contains(spell.english) then
    return 'Sleep'
  elseif spell.skill == 'Elemental Magic' and elemental_debuffs:contains(spell.english) then
    return 'EleEnfeebs'
  elseif spell.skill == 'Enhancing Magic' and spikes:contains(spell.english) then
    return 'Spikes'
  end
  
end

function job_status_change(new,old)

  if new == 'Engaged' then
    send_command('gs c set IdleMode Combat;gs c set CastingMode Combat')
  end
  
end

function job_buff_change(name,gain)

  sleep_swap(name,gain)
  
  if name == 'Elemental Seal' then
    if gain then
      casting_mode = state.CastingMode.value
      if (state.CastingMode.value ~= 'Normal' or state.CastingMode.value ~= 'Combat') then
        send_command('gs c set CastingMode Normal')
      end
    else
      send_command('gs c set CastingMode '..casting_mode)
    end
  end

end

--[[ function customize_idle_set(idleSet)

 if daytime then 
    idleSet = set_combine(idleSet,{hands="Garden bangles",waist="Lycopodium sash"})
  end

  return idleSet
  
end]]