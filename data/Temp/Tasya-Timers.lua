active_songs = {}
active_spells = {}

always_aoe = S{'Barfira','Barstonra','Barwatera','Baraera','Barblizzara','Barthundra',
    'Barsleepra','Barpoisonra','Barparalyzra','Barblindra','Barsilencera','Barvira','Barpetra','Baramnesra',
    'Protectra','Protectra II','Protectra III','Protectra IV','Protectra V',
    'Shellra','Shellra II','Shellra III','Shellra IV','Shellra V',
    'Boost-STR','Boost-DEX','Boost-AGI','Boost-VIT','Boost-MND','Boost-INT','Boost-CHR',
    'Auspice'}

barelement = S{'Barfire','Barstone','Barwater','Baraero','Barblizzard','Barthunder'}
barelementra = S{'Barfira','Barstonra','Barwatera','Baraera','Barblizzara','Barthundra'}
barstatus = S{'Barsleep','Barpoison','Barparalyze','Barblind','Barsilence','Barvirus','Barpetrify','Baramnesia'}
barstatusra = S{'Barsleepra','Barpoisonra','Barparalyzra','Barblindra','Barsilencera','Barvira','Barpetra','Baramnesra'}
gainstat = S{'Gain-STR','Gain-DEX','Gain-AGI','Gain-VIT','Gain-MND','Gain-INT','Gain-CHR'}
booststat = S{'Boost-STR','Boost-DEX','Boost-AGI','Boost-VIT','Boost-MND','Boost-INT','Boost-CHR'}

-- These buffs are consumable and don't get timers.
no_timer = S{'Stoneskin','Blink'}

function tas_adjust_timers(spell, spellMap)
    if spell.interrupted then return end
    
    if spell.type == 'BardSong' then
        adjust_bard_song_timer(spell, spellMap)
    elseif spell.skill == 'Enhancing Magic' then
        adjust_enhancing_magic_timer(spell, spellMap)
    elseif spell.skill == 'Geomancy' and spell.english:startswith('Indi') then
        adjust_indi_magic_timer(spell, spellMap)
    end
end

function tas_reset_timers()
    for i,v in pairs(active_spells) do
        send_command('timers delete "'..v..'"')
    end
    active_spells = {}
end

function adjust_bard_song_timer(spell, spellMap)
    local current_time = os.time()
    
    -- active_songs contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(active_songs) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        active_songs[song_name] = nil
    end
    
    local dur = calculate_bard_song_duration(spell.name, spellMap)
    if active_songs[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).
        
        -- If new song will outlast the one in our list, replace it.
        if active_songs[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            active_songs[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(active_songs) then
            maxsongs = table.length(active_songs)
        end
        
        -- Create or update new song timers.
        if table.length(active_songs) < maxsongs then
            active_songs[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(active_songs) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                active_songs[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                active_songs[spell.name] = current_time + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        end
    end
end

function adjust_enhancing_magic_timer(spell, spellMap)
    local current_time = os.time()
    local display_name = spell.english .. ' [' .. spell.target.name .. ']'
    local tag = spell.english .. ' @ ' .. spell.target.name
    local duration = calculate_enhancing_magic_duration(spell, spell.english, spellMap)
	local buff_number = buff_icon_number(spell.english)
    
    if no_timer:contains(spell.english) then return end
    
    if spell.target.type == 'SELF' then target = 'SELF' end
    
    if buffactive['Accession'] or always_aoe:contains(spell.english) then
        display_name = spell.english..' [AoE]'
    elseif spell.target.type == 'SELF' then
        display_name = spell.english
    end
    
    if barelement:contains(spell.english) then
        tag = 'barelement'
    elseif barelementra:contains(spell.english) then
        tag = 'barelementra'
    elseif barstatus:contains(spell.english) then
        tag = 'barstatus'
    elseif barstatusra:contains(spell.english) then
        tag = 'barstatusra'
    elseif gainstat:contains(spell.english) then
        tag = 'gainstat'
    
    -- Intentionally not causing Boost spells to overwrite each other, because sometimes you will cast Boost-DEX on the
    -- melee and then Boost-INT on the mages, and you want to know when both will wear.
    
    --elseif booststat:contains(spell.english) then
    --    tag = 'booststat'
    end
	
	if active_spells[tag] then
        send_command('timers delete "'..active_spells[tag]..'"')
        active_spells[tag] = nil
	end
	
    active_spells[tag] = display_name
	
    send_command('timers create "'..display_name..'" '..duration..' down spells/'..buff_number..'.png')
end

function adjust_indi_magic_timer(spell, spellMap)
    local current_time = os.time()
    local display_name = spell.english
	local tag = 'indi'
    local duration = calculate_indi_magic_duration(spell.english, spellMap)
	local buff_number = buff_icon_number(spell.english)
    
    if buffactive['Entrust'] and spell.target.type ~= 'SELF' then
        tag = 'entrust'
        display_name = spell.english .. ' [Entrust]'
    end
	
    if active_spells[tag] then
        send_command('timers delete "'..active_spells[tag]..'"')
    end
	
	active_spells[tag] = display_name
	
    send_command('timers create "'..display_name..'" '..duration..' down spells/'..buff_number..'.png')
end

-- Utility function to calculate the duration of an bard song based on the equipment used to cast it.
-- You shouldn't call this directly. It is called from tas_adjust_timers(), which is the function you should
-- call in your aftercast function.

function calculate_bard_song_duration(spellName, spellMap)
    local mult = 1.0
    
    if player.equipment.range == 'Homestead Flute' then mult = mult + 0.2 end
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.25 end -- change to 0.3 with 95 or 99 Daur
    if player.equipment.range == 'Gjallarhorn' then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    if player.equipment.range == 'Marsyas' then mult = mult + 0.5 end
    
    if player.equipment.main == 'Carnwenhan' then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95
    if player.equipment.main == 'Kali' then mult = mult + 0.05 end
    if player.equipment.main == 'Legato Dagger' then mult = mult + 0.05 end
    
    if player.equipment.sub == 'Carnwenhan' then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, also stop offhanding your mythic
    if player.equipment.sub == 'Kali' then mult = mult + 0.05 end
    if player.equipment.sub == 'Legato Dagger' then mult = mult + 0.05 end
    
    if player.equipment.neck == 'Aoidos\' Matinee' then mult = mult + 0.1 end
    if player.equipment.body == 'Aoidos\' Hngrln. +1' then mult = mult + 0.1 end
    if player.equipment.body == 'Aoidos\' Hngrln. +2' then mult = mult + 0.1 end
    if player.equipment.body == 'Fili Hongreline' then mult = mult + 0.11 end
    if player.equipment.body == 'Fili Hongreline +1' then mult = mult + 0.12 end
    if player.equipment.legs == 'Mdk. Shalwar +1' then mult = mult + 0.1 end
    if player.equipment.feet == 'Brioso Slippers' then mult = mult + 0.1 end
    if player.equipment.feet == 'Brioso Slippers +1' then mult = mult + 0.11 end
    
    if spellMap == 'Paeon' and (player.equipment.head == 'Brioso Roundlet' or
      player.equipment.head == 'Brioso Roundlet +1') then
        mult = mult + 0.1
    end
    
    if spellMap == 'Madrigal' and (player.equipment.head == 'Aoidos\' Calot +2' or
      player.equipment.head == 'Fili Calot +2' or
      player.equipment.head == 'Fili Calot +2') then
        mult = mult + 0.1
    end
    
    if spellMap == 'Minuet' and (player.equipment.body == 'Aoidos\' Hngrln. +2' or
      player.equipment.body == 'Fili Hongreline' or
      player.equipment.body == 'Fili Hongreline +1') then
        mult = mult + 0.1
    end
    
    if spellMap == 'March' and (player.equipment.hands == 'Ad. Mnchtte. +2' or
      player.equipment.hands == 'Fili Manchettes' or
      player.equipment.hands == 'Fili Manchettes +1') then
        mult = mult + 0.1
    end
    
    if spellMap == 'Ballad' and (player.equipment.legs == 'Aoidos\' Rhing. +2' or
      player.equipment.legs == 'Fili Rhingrave' or
      player.equipment.legs == 'Fili Rhingrave +1') then
        mult = mult + 0.1
    end
    
    if spellName == "Sentinel's Scherzo" then
        if player.equipment.feet == 'Aoidos\' Cothrn. +2' or
          player.equipment.feet == 'Fili Cothurnes' or
          player.equipment.feet == 'Fili Cothurnes +1' then
            mult = mult + 0.1
        end
        
        if buffactive['Soul Voice'] then
            mult = mult * 2
        elseif buffactive.Marcato then
            mult = mult * 1.5
        end
    end
    
    if buffactive.Troubadour then
        mult = mult * 2
    end
    
    local totalDuration = math.floor(mult * 120)

    return totalDuration
end
 
-- Utility function to calculate the duration of an enhancing spell based on the equipment used to cast it.
-- You shouldn't call this directly. It is called from tas_adjust_timers(), which is the function you should
-- call in your aftercast function.
 
function calculate_enhancing_magic_duration(spell, spellName, spellMap)
    local mult = 1.0
 
    -- *** EDIT THIS SECTION ***
	-- *** The values for Telchine pieces are dependant on what you happen to have them augmented with.
	-- *** Enh. Mag. Eff. Duration +1 = 0.01, +5 = 0.05, +10 = 0.10, etc.
    if player.equipment.Head == 'Telchine Cap' then mult = mult + 0.10 end
    if player.equipment.Body == 'Telchine Chas.' then mult = mult + 0.09 end
    if player.equipment.Hands == 'Telchine Gloves' then mult = mult + 0.10 end
    if player.equipment.Legs == 'Telchine Braconi' then mult = mult + 0.05 end
    if player.equipment.Feet == 'Telchine Pigaches' then mult = mult + 0.08 end
    
    -- Other all-jobs gear
    if player.equipment.Body == 'Shabti Cuirass' then mult = mult + 0.09 end
    if player.equipment.Body == 'Shabti Cuirass +1' then mult = mult + 0.10 end
    
    -- RDM
    if player.equipment.Hands == 'Atrophy Gloves' then mult = mult + 0.15 end
    if player.equipment.Hands == 'Atrophy Gloves +1' then mult = mult + 0.16 end
    if player.equipment.Back == 'Estoqueur\'s Cape' then mult = mult + 0.10 end
    if player.equipment.Back == 'Sucellos\'s Cape' then mult = mult + 0.20 end
    if player.equipment.Feet == 'Estq. Houseaux +2' then mult = mult + 0.20 end
    if player.equipment.Feet == 'Leth. Houseaux' then mult = mult + 0.25 end
    if player.equipment.Feet == 'Leth. Houseaux +1' then mult = mult + 0.30 end
    
    -- WHM
    if player.equipment.Hands == 'Dynasty Mitts' then mult = mult + 0.05 end
    
    -- RUN
    if player.equipment.Legs == 'Futhark Trousers' then mult = mult + 0.10 end
    if player.equipment.Legs == 'Futhark Trousers +1' then mult = mult + 0.20 end
    if player.equipment.Head == 'Erilaz Galea' then mult = mult + 0.10 end
    if player.equipment.Head == 'Erilaz Galea +1' then mult = mult + 0.15 end
 
    local base = 1 -- Seems to be a magic number. Maybe casting time-related?
 
    if spellName == 'Haste' then base = base + 180 end
    if spellName == 'Stoneskin' then base = base + 300 end
    if spellName:startswith("Bar") then base = base + 480 end
    if spellName == 'Blink' then base = base + 300 end
    if spellName == 'Aquaveil' then base = base + 600 end
    if string.find(spellName,'storm') then base = base + 180 end
    if spellName == 'Auspice' then base = base + 180 end
    if spellName:startswith("Boost") then base = base + 300 end
    if spellName == 'Phalanx' then base = base + 180 end
    if spellName:startswith("Protect") then base = base + 1800 end
    if spellName:startswith("Shell") then base = base + 1800 end
    if spellName:startswith("Refresh") then base = base + 150 end
    if spellName:startswith("Regen") then 
        base = base + 60 + 1 -- 1 is a magic number
        
		if player.equipment.Body == 'Telchine Chas.' then
			base = base + 12
		end
        
        if player.main_job == 'SCH' then
            if buffactive['Light Arts'] then
                base = base + 48 -- 48 seconds default bonus from being in Light Arts
            
                -- *** EDIT THIS SECTION ***
                -- *** 3 seconds per JP spent in Light Arts JP category.
                base = base + 60
            
                if player.equipment.Back == 'Lugh\'s Cape' then
                    base = base + 15
                end
            end
            
            if player.equipment.Main == 'Coeus' then
                base = base + 12
            end
        elseif player.main_job == 'WHM' then
        
            -- *** EDIT THIS SECTION ***
            -- *** 3 seconds per JP spent in Regen duration JP category.
			base = base + 60
            
            if player.equipment.Hands == 'Ebers Mitts' then 
                base = base + 20
            elseif player.equipment.Hands == 'Ebers Mitts +1' then 
                base = base + 22
            end
            
            if player.equipment.Legs == 'Theo. Pantaloons' or player.equipment.Legs == 'Theo. Pant. +1' then
                base = base + 18
            end
        end
    end
    if spellName == 'Adloquium' then base = base + 180 end
    if spellName:startswith("Animus") then base = base + 180 end
    if spellName == 'Crusade' then base = base + 300 end
    if spellName == 'Embrava' then base = base + 90 end
    if spellName:startswith("En") then base = base + 180 end
    if spellName:startswith("Flurry") then base = base + 180 end
    if spellName == 'Foil' then base = base + 30 end
    if spellName:startswith("Gain") then base = base + 180 end
    if spellName == 'Reprisal' then base = base + 60 end
    if spellName:startswith("Temper") then base = base + 180 end
    if string.find(spellName,'Spikes') then base = base + 180 end
 
    if buffactive['Perpetuance'] then
        if player.equipment.Hands == 'Arbatel Bracers' then
            mult = mult * 2.5
        elseif player.equipment.Hands == 'Arbatel Bracers +1' then
            mult = mult * 2.55
        else
            mult = mult * 2
        end
    end
 
    if buffactive['Composure'] then
        if spell.target.type == 'SELF' and not always_aoe:contains(spell.english) then
            mult = mult * 3
        else
            local estoqueur_worn = 0
            local lethargy_worn = 0
            local lethargy_plus_worn = 0
            
            if player.equipment.Head == 'Estq. Chappel +2' then estoqueur_worn = estoqueur_worn + 1 end
            if player.equipment.Head == 'Lethargy Chappel' then lethargy_worn = lethargy_worn + 1 end
            if player.equipment.Head == 'Leth. Chappel +1' then lethargy_plus_worn = lethargy_plus_worn + 1 end
            
            if player.equipment.Body == 'Estq. Sayon +2' then estoqueur_worn = estoqueur_worn + 1 end
            if player.equipment.Body == 'Lethargy Sayon' then lethargy_worn = lethargy_worn + 1 end
            if player.equipment.Body == 'Lethargy Sayon +1' then lethargy_plus_worn = lethargy_plus_worn + 1 end
            
            if player.equipment.Hands == 'Estq. Ganthrt. +2' then estoqueur_worn = estoqueur_worn + 1 end
            if player.equipment.Hands == 'Leth. Gantherots' then lethargy_worn = lethargy_worn + 1 end
            if player.equipment.Hands == 'Leth. Gantherots +1' then lethargy_plus_worn = lethargy_plus_worn + 1 end
            
            if player.equipment.Legs == 'Estqr. Fuseau +2' then estoqueur_worn = estoqueur_worn + 1 end
            if player.equipment.Legs == 'Leth. Fuseau' then lethargy_worn = lethargy_worn + 1 end
            if player.equipment.Legs == 'Leth. Fuseau +1' then lethargy_plus_worn = lethargy_plus_worn + 1 end
            
            if player.equipment.Feet == 'Estq. Houseaux +2' then estoqueur_worn = estoqueur_worn + 1 end
            if player.equipment.Feet == 'Leth. Houseaux' then lethargy_worn = lethargy_worn + 1 end
            if player.equipment.Feet == 'Leth. Houseaux +1' then lethargy_plus_worn = lethargy_plus_worn + 1 end
            
            if estoqueur_worn == 5 then
                mult = mult + 0.50
            elseif estoqueur_worn == 4 then
                mult = mult + 0.35
            elseif estoqueur_worn == 3 then
                mult = mult + 0.20
            elseif estoqueur_worn == 2 then
                mult = mult + 0.10
            end
            
            if lethargy_worn == 5 then
                mult = mult + 0.50
            elseif lethargy_worn == 4 then
                mult = mult + 0.35
            elseif lethargy_worn == 3 then
                mult = mult + 0.20
            elseif lethargy_worn == 2 then
                mult = mult + 0.10
            end
            
            if lethargy_plus_worn == 5 then
                mult = mult + 0.50
            elseif lethargy_plus_worn == 4 then
                mult = mult + 0.35
            elseif lethargy_plus_worn == 3 then
                mult = mult + 0.20
            elseif lethargy_plus_worn == 2 then
                mult = mult + 0.10
            end
        end
    end         
 
    local totalDuration = math.floor(mult*base)
 
    --add_to_chat(123, 'Duration: '..base..' x '..mult..' = '..totalDuration)
 
    return totalDuration
end

-- Utility function to calculate the duration of an indi spell based on the equipment used to cast it.
-- You shouldn't call this directly. It is called from tas_adjust_timers(), which is the function you should
-- call in your aftercast function.
 
function calculate_indi_magic_duration(spellName, spellMap)
    local base = 180 + 2 -- casting time, magic number
 
    -- *** EDIT THIS SECTION ***
    -- *** You get 2 extra seconds of base duration per point spent in the "Indi spell duration" JP category.
    base = base + 40
    
    local mult = 1.0
 
    -- *** EDIT THIS SECTION ***
    -- *** The values for Lifestream Cape are dependant on what you happen to have it augmented with.
	-- *** Indi. Eff. Dur. +1 = 0.01, +10 = 0.10, +20 = 0.20, etc.
    if player.equipment.Back == 'Lifestream Cape' then mult = mult + 0.20 end
 
    -- Most GEO equipment affects the base duration. Only the Lifestream Cape is a multiplier.
    if player.equipment.Main == 'Solstice' then base = base + 15 end
    if player.equipment.Sub == 'Solstice' then base = base + 15 end
    if player.equipment.Legs == 'Bagua Pants' then base = base + 12 end
    if player.equipment.Legs == 'Bagua Pants +1' then base = base + 15 end
    if player.equipment.Feet == 'Azimuth Gaiters' then base = base + 15 end
    if player.equipment.Feet == 'Azimuth Gaiters +1' then base = base + 20 end
    if player.equipment.Back == 'Nantosuelta\'s Cape' then base = base + 20 end
 
    local totalDuration = math.floor(mult*base)
 
    add_to_chat(123, 'Indi duration: '..base..' x '..mult..' = '..totalDuration)
 
    return totalDuration
end

-- Utility function to get the correct number for various buff icons.

function buff_icon_number(spellName)
	if spellName == 'Protect' then return '00043' end
	if spellName == 'Protect II' then return '00044' end
	if spellName == 'Protect III' then return '00045' end
	if spellName == 'Protect IV' then return '00046' end
	if spellName == 'Protect V' then return '00047' end
	
	if spellName == 'Shell' then return '00043' end
	if spellName == 'Shell II' then return '00044' end
	if spellName == 'Shell III' then return '00045' end
	if spellName == 'Shell IV' then return '00046' end
	if spellName == 'Shell V' then return '00047' end
	
	if spellName == 'Protectra' then return '00125' end
	if spellName == 'Protectra II' then return '00126' end
	if spellName == 'Protectra III' then return '00127' end
	if spellName == 'Protectra IV' then return '00128' end
	if spellName == 'Protectra V' then return '00129' end
	
	if spellName == 'Shellra' then return '00130' end
	if spellName == 'Shellra II' then return '00131' end
	if spellName == 'Shellra III' then return '00132' end
	if spellName == 'Shellra IV' then return '00133' end
	if spellName == 'Shellra V' then return '00134' end
	
	if spellName == 'Stoneskin' then return '00054' end
	
	return '00001'
end