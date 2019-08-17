-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    include('Tasya-Lib.lua')
    
	event_list = L{}
    
    state.MagicBurst = M(false, 'Magic Burst')
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
    event_list:map(windower.unregister_event)
    event_list:clear()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
	--state.RangedMode:options('Normal')
	--state.HybridMode:options('Normal')
	--state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT')
	--state.RestingMode:options('Normal')
	--state.PhysicalDefenseMode:options('PDT')
	--state.MagicalDefenseMode:options('MDT')

    event_list:append(windower.register_event('mpp change',tas_fucho_no_obi))
    
    select_default_macro_book()
end

-- Load job-specific keybinds.
function user_binds_on_load()
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c toggle MagicBurst')
end

-- Unload job-specific keybinds.
function user_binds_on_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()

end

-- Define sets and vars used by this job file.
function init_gear_sets()

    --==================================--
	-- Augmented gear and base sets
    --==================================--

    include('Tasya-Gear.lua')
    tas_shared_augmented_gear()
    
    gear.default.idle_belt = "Slipor Sash"
    
    gear.Lathi = {}
    gear.Lathi.C = {name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15'}}
    
    gear.BaneCape = {}
    gear.BaneCape.MAcc = {name="Bane Cape", augments={'Elem. magic skill +10','Dark magic skill +6','"Mag.Atk.Bns."+1','"Fast Cast"+1'}}
    
    gear.TaranussCape = {}
    gear.TaranussCape.MAB = {name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
    
    sets.DarkAffinity = {head="Pixie Hairpin +1",ring1="Archon Ring"}
    
    sets.MagicAccuracy = {
	    main=gear.Grioavolr.MAB,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Erra Pendant",ear1="Dignitary's Earring",ear2="Gwati Earring",
        body=gear.MerlinicJubbah.MAB,hands="Hagondes Cuffs +1",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.TaranussCape.MAB,waist="Eschan Stone",legs=gear.PsyclothLappas.D,feet="Medium's Sabots"}
    
    sets.MagicAttack = {
        ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Saevus Pendant +1",ear1="Friomisi Earring",ear2="Barkarole Earring",
        body=gear.MerlinicJubbah.MAB,hands=gear.AmalricGagesPlus1.A,ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back=gear.TaranussCape.MAB,waist=gear.ElementalObi,legs=gear.MerlinicShalwar.MAB,feet=gear.MerlinicCrackows.MAB}

    --==================================--
	-- Idle
    --==================================--

    sets.idle.Field = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
        head="Befouled Crown",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Witching Robe",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Assiduity Pants +1",feet="Serpentes Sabots"}
    
    sets.idle.Town = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
        head="Befouled Crown",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Witching Robe",hands="Serpentes Cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Assiduity Pants +1",feet="Serpentes Sabots"}

    sets.idle.Weak = {
        main="Terra's Staff",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Assiduity Pants +1",feet="Hagondes Sabots +1"}
        
    --==================================--
	-- Defense
    --==================================--

    sets.defense.PDT = {
        main="Terra's Staff",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Infused Earring",ear2="Dawn Earring",
        body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Moonlight Cape",waist="Slipor Sash",legs="Assiduity Pants +1",feet="Hagondes Sabots +1"}

    sets.defense.MDT = set_combine(sets.defense.PDT, {
        neck="Warder's Charm +1",ring2="Shadow Ring"})
	
	sets.defense.Stun = set_combine(sets.defense.MDT, {
        body="Onca Suit",hands=empty,legs=empty,feet=empty})
        
    --==================================--
	-- Resting
    --==================================--
    
    sets.resting = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
        head="Befouled Crown",neck="Eidolon Pendant +1",ear1="Infused Earring",ear2="Dawn Earring",
        body="Witching Robe",hands="Serpentes Cuffs",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Assiduity Pants +1",feet="Chelona Boots +1"}
        
    --==================================--
	-- Engaged
    --==================================--

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    sets.engaged = {
        ammo="Hasty Pinion +1",
        head=gear.TelchineCap.DA,neck="Combatant's Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Onca Suit",hands=empty,ring1="Petrov Ring",ring2="Ramuh Ring +1",
        back="Aurist's Cape +1",waist="Windbuffet Belt +1",legs=empty,feet=empty}
        
    --==================================--
	-- Job Abilities
    --==================================--
    
    sets.precast.JA['Mana Wall'] = {back=gear.TaranussCape.MAB} -- {feet="Goetia Sabots +2"}
    --sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
	if player.sub_job == 'RDM' then
		-- equip to maximize HP (for Tarus) and minimize MP loss before using convert
		sets.precast.JA.Convert = {}
	end
	
    --==================================--
	-- Weaponskills
    --==================================--
    
    sets.precast.WS = {
        head=gear.TelchineCap.DA,neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Onca Suit",hands=empty,ring1="Rajas Ring",ring2="Shiva Ring +1",
        back="Aurist's Cape +1",waist="Windbuffet Belt +1",legs=empty,feet=empty}
    
    sets.precast.WS.Magic = sets.MagicAttack

    --------------------------------------
	-- Staffs
    --------------------------------------
        
    sets.precast.WS['Vidohunir'] = sets.precast.WS.Magic
    
	sets.precast.WS['Myrkr'] = {
	    ammo="Ghastly Tathlum +1",
	    head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Moonshade Earring",
		body=gear.AmalricDoubletPlus1.A,hands=gear.TelchineGloves.FCandEnh,ring1="Etana Ring",ring2="Stikini Ring +1",
		back=gear.BaneCape.MAcc,waist="Luminary Sash",legs=gear.AmalricSlopsPlus1.A,feet="Medium's Sabots"}
    
	sets.exported={
    main="Masamune",
    sub="Utu Grip",
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Attack+18','Weapon Skill Acc.+10','STR+14','Accuracy+12',}},
    body={ name="Valorous Mail", augments={'Pet: Mag. Acc.+3','Crit.hit rate+3','Weapon skill damage +5%','Accuracy+15 Attack+15',}},
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +4%','CHR+8','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
    legs="Hiza. Hizayoroi +2",
    feet={ name="Valorous Greaves", augments={'STR+14','Accuracy+6','Weapon skill damage +6%','Accuracy+3 Attack+3','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Ishvara Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	
    --==================================--
	-- Fast Cast
    --==================================--

    sets.precast.FC = {
	    main=gear.Grioavolr.MAB,sub="Clerisy Strap +1",ammo="Impatiens",
        head=gear.VanyaHood.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Anhur Robe",hands=gear.TelchineGloves.FCandEnh,ring1="Lebeche Ring",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs=gear.PsyclothLappas.D,feet="Regal Pumps +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris",ear2="Mendicant's Earring",feet=gear.VanyaClogs.D})
    sets.precast.FC.Curaga = sets.precast.FC.Cure

    --==================================--
	-- Midcast
    --==================================--

    sets.midcast.FastRecast = {
        main=gear.Grioavolr.MAB,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
        head=gear.VanyaHood.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.MerlinicJubbah.MAB,hands=gear.TelchineGloves.FCandEnh,ring1="Defending Ring",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs=gear.PsyclothLappas.D,feet="Regal Pumps +1"}
    
    --==================================--
	-- Bard Songs
    --==================================--
	
	if player.sub_job == 'BRD' then
		sets.midcast.BardSong = {
            main=gear.Grioavolr.MAB,sub="Enki Strap",ammo="Pemphredo Tathlum",
			head=gear.MerlinicHood.MAB,neck="Incanter's Torque",ear1="Dignitary's Earring",ear2="Gwati Earring",
			body=gear.MerlinicJubbah.MAB,hands="Hagondes Cuffs +1",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
			back="Kumbira Cape",waist="Eschan Stone",legs=gear.MerlinicShalwar.MAB,feet=gear.MerlinicCrackows.MAB}
	end

    --==================================--
	-- Dark Magic
    --==================================--
    
    sets.midcast['Dark Magic'] = {
	    main="Rubicundity",sub="Genbu's Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body=gear.MerlinicJubbah.MAB,hands="Hagondes Cuffs +1",ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.TaranussCape.MAB,waist="Eschan Stone",legs=gear.PsyclothLappas.D,feet="Medium's Sabots"}

    sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], {
        ear1="Dignitary's Earring",ear2="Hirudinea Earring",
        body=gear.MerlinicJubbah.DrainAspir,
        waist="Fucho-no-Obi",feet=gear.MerlinicCrackows.MAB})

    sets.midcast['Aspir III'] = sets.midcast.Aspir
    
    sets.midcast.Death = sets.MagicAttack
    
    sets.midcast.Drain = sets.midcast.Aspir

    sets.midcast.Stun = {
        main=gear.Grioavolr.MAB,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=gear.VanyaHood.D,neck="Incanter's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Hagondes Coat +1",hands=gear.TelchineGloves.FCandEnh,ring1="Evanescence Ring",ring2="Stikini Ring +1",
        back=gear.TaranussCape.MAB,waist="Eschan Stone",legs=gear.PsyclothLappas.D,feet="Medium's Sabots"}
    
    if player.sub_job == 'SCH' then
        sets.midcast.Klimaform = sets.midcast.FastRecast
    end
	
    --==================================--
	-- Elemental Magic
    --==================================--
	
    sets.midcast['Elemental Magic'] = set_combine(sets.MagicAttack, {main=gear.Lathi.C,sub="Enki Strap"})

    sets.midcast['Elemental Magic'].Proc = {
        main="Terra's Staff",sub="Mephitis Grip",ammo="Impatiens",
        head=gear.VanyaHood.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Spaekona's Coat +1",hands=gear.TelchineGloves.FCandEnh,ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Swith Cape +1",waist="Witful Belt",legs=gear.PsyclothLappas.D,feet="Regal Pumps +1"}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		main=gear.Grioavolr.MAB,sub="Enki Strap",neck="Sanctity Necklace",waist="Eschan Stone"})

    --sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {body="Hagondes Coat +1"})
    --sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {body="Hagondes Coat +1"})
	
	sets.midcast.Comet = set_combine(sets.midcast['Elemental Magic'], sets.DarkAffinity)
	sets.midcast.Comet.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, sets.DarkAffinity)
        
    sets.midcast.ElementalEnfeeble = sets.MagicAccuracy
	
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, {head=empty, body="Twilight Cloak"})
        
    --==================================--
	-- Enhancing Magic
    --==================================--
    
    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
        head="Befouled Crown",neck="Incanter's Torque",ear1="Augmenting Earring",
        body=gear.TelchineChasuble.Enh,hands=gear.TelchineGloves.FCandEnh,
        back="Fi Follet Cape +1",waist="Olympus Sash",legs="Shedir Seraweels",feet="Regal Pumps +1"})
    
    sets.midcast.EnhancingDuration = set_combine(sets.midcast,FastRecast, {
        head=gear.TelchineCap.Enh,neck="Incanter's Torque",
        body=gear.TelchineChasuble.Enh,hands=gear.TelchineGloves.FCandEnh,
        legs=gear.TelchineBraconi.Enh,feet=gear.TelchinePigaches.Enh})
    
    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {legs="Shedir Seraweels"})
    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {neck="Stone Gorget",waist="Siegel Sash",legs="Shedir Seraweels"})

    --==================================--
	-- Enfeebling Magic
    --==================================--
    
    sets.midcast['Enfeebling Magic'] = set_combine(sets.MagicAccuracy, {waist="Rumination Sash"})
    
    --==================================--
	-- Healing Magic
    --==================================--
    
    sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
        main="Tamaxchi",sub="Genbu's Shield",ammo="Esper Stone +1",
        head=gear.VanyaHood.A,neck="Incanter's Torque",ear1="Novia Earring",ear2="Gifted Earring",
        body=gear.VanyaRobe.C,hands="Hagondes Cuffs +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",
        back="Aurist's Cape +1",waist="Ninurta's Sash",legs=gear.VanyaSlops.C,feet=gear.VanyaClogs.D})

    sets.midcast.Curaga = sets.midcast.Cure
    
    if player.sub_job == 'WHM' or player.sub_job == 'SCH' then
        sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {
            neck="Debilis Medallion",ring1="Haoma's Ring",ring2="Haoma's Ring",feet=gear.VanyaClogs.D})
    end

    --==================================--
	-- Active Buffs
    --==================================--
    
    sets.buff['Mana Wall'] = {back=gear.TaranussCape.MAB} -- {feet="Goetia Sabots +2"}

    --==================================--
	-- Miscellaneous Sets
    --==================================--
    
    sets.Kiting = {feet="Crier's Gaiters"}
    
    sets.MagicBurst = {
		neck="Mizukage-no-Kubikazari",                                                              -- 10
		body=gear.HeliosJacket.MAB,hands=gear.AmalricGagesPlus1.A,ring1="Mujin Band",ring2="Locus Ring", -- x + (5) + (5) + 5
		back=gear.TaranussCape.MAB,legs=gear.MerlinicShalwar.MAB}         -- 5 + 10 + x

    --==================================--
	-- Organizer Items
    --==================================--
    
    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
	    echo="Echo Drops",
		refoccilation_stone="Refoccilation Stone",
        hachirin_no_obi="Hachirin-no-Obi"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Ninurta's Sash"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Refoccilation Stone"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if state.MagicBurst.value and (spell.skill == 'Elemental Magic' or spell.english == 'Death') then
            equip(sets.MagicBurst)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == 'Mana Wall' then
        enable('back')
        enable('feet')
        equip(sets.buff['Mana Wall'])
        disable('back')
        disable('feet')
    end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('back')
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Called when a generally-handled state value has been changed.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    MNDPotencySpells = S{'Paralyze', 'Slow'}
    INTAccuracySpells = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Break', 'Breakga', 'Bind', 'Dispel', 'Gravity'}
    EnfPotencySpells = S{'Poison', 'Poison II', 'Poisonga', 'Distract', 'Frazzle'}
    
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        
        lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
            'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
            'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
            'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
            'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
        
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	return meleeSet
end

-- Modify the default defense set after it was constructed.
function customize_defense_set(defenseSet)
	return defenseSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 15)
end

