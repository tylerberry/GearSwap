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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
	
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')

	select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end

function init_gear_sets()

    --==================================--
	-- Augmented gear and base sets
    --==================================--

    include('Tasya-Gear.lua')
    tas_shared_augmented_gear()
    
    gear.NihtMantle = {}
    gear.NihtMantle.WS = {name="Niht Mantle"}
    
    sets.MagicAttack = {
        ammo="Pemphredo Tathlum",
        head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Novio Earring",
        body="Founder's Breastplate",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs=gear.EschiteCuisses.D,feet="Founder's Greaves"}
    
    --==================================--
	-- Idle
    --==================================--
	
	sets.idle.Field = {
        ammo="Vanir Battery",
        head=empty,neck="Coatl Gorget +1",ear1="Infused Earring",ear2="Dawn Earring",
        body="Lugra Cloak +1",hands="Sulevia's Gauntlets +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs=gear.OdysseanCuisses.TP,feet="Amm Greaves"}

	sets.idle.Town = {
        ammo="Vanir Battery",
        head=empty,neck="Coatl Gorget +1",ear1="Infused Earring",ear2="Dawn Earring",
        body="Lugra Cloak +1",hands="Sulevia's Gauntlets +1",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs=gear.OdysseanCuisses.TP,feet="Amm Greaves"}
	
	sets.idle.Weak = {
        ammo="Vanir Battery",
        head="Jumalik Helm",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Jumalik Mail",hands="Sulevia's Gauntlets +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs=gear.OdysseanCuisses.TP,feet="Amm Greaves"}
	
    --==================================--
	-- Defense
    --==================================--
    
	sets.defense.PDT = {
        ammo="Vanir Battery",
        head="Jumalik Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Jumalik Mail",hands="Sulevia's Gauntlets +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Shadow Mantle",waist="Flume Belt +1",legs="Sulevia's Cuisses +1",feet="Amm Greaves"}

	sets.defense.MDT = sets.defense.PDT
    
    --==================================--
	-- Resting
    --==================================--
	
	sets.resting = set_combine(sets.defense.PDT, {
		body="Kumarbi's Akar",ring1="Paguroidea Ring",ring2="Sheltered Ring"})
	
    --==================================--
	-- Engaged
    --==================================--

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {
        ammo="Ginsen",
        head="Sulevia's Mask +1",neck="Ganesha's Mala",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Founder's Breastplate",hands="Sulevia's Gauntlets +1",ring1="Hetairoi Ring",ring2="Petrov Ring",
        back="Bleating Mantle",waist="Sailfi Belt +1",legs=gear.OdysseanCuisses.TP,feet="Valorous Greaves"}
        
	sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Seething Bomblet +1",
        neck="Combatant's Torque",ear2="Dignitary's Earring",
        ring2="Cacoethic Ring +1",
        back="Grounded Mantle +1"})
	
	sets.engaged.PDT = set_combine(sets.engaged, {
        head="Sulevia's Mask +1",neck="Loricate Torque +1",
        body="Emet Harness +1",hands="Sulevia's Gauntlets +1",ring1="Defending Ring",
        back="Grounded Mantle +1",waist="Sailfi Belt +1",legs="Sulevia's Cuisses +1"})
        
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
        ammo="Seething Bomblet +1"})
	
    --==================================--
	-- Job Abilities
    --==================================--
	
	--sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets +1"}
	--sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}
	--sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Gauntlets +1"}
    sets.precast.JA['Last Resort'] = {back="Ankou's Mantle"}
	--sets.precast.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +1"}
	
	if player.sub_job == 'DNC' then
		-- Waltz has CHR and VIT mods.
		sets.precast.Waltz = {
			head="Anwig Salade",
			belt="Chaac Belt"}
			
		-- No gear needed for Healing Waltz.
		sets.precast.Waltz['Healing Waltz'] = {}
	end

	if player.sub_job == 'NIN' then
		-- Fast cast gear for specific spells or spell maps
		sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace"})
	end
	
    --==================================--
	-- Weaponskills
    --==================================--
	
	sets.precast.WS = {
        ammo="Seething Bomblet +1",
        head="Sulevia's Mask +1",neck="Ganesha's Mala",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's Gauntlets +1",ring1="Ifrit Ring +1",ring2="Rajas Ring",
        back=gear.NihtMantle.WS,waist="Windbuffet Belt +1",legs="Sulevia's Cuisses +1",feet="Sulevia's Leggings +1"}
	
	sets.precast.WS.Magic = set_combine(sets.MagicAttack, {ammo="Seething Bomblet +1",neck="Baetyl Pendant"})

	--------------------------------------
	-- Great Sword
	--------------------------------------
    
    -- Hard Slash: physical 1-hit, 100% STR, 1.5/1.75/2.0 fTP.
	sets.precast.WS['Hard Slash'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Gorget"})
    
    -- Power Slash: physical 1-hit, 60% STR 60% VIT, 1.0, TP affects chance to crit.
	sets.precast.WS['Power Slash'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Ishvara Earring",back="Rancorous Mantle",waist="Fotia Gorget",feet="Thereoid Greaves"})
    
    -- Frostbite: magical, ice-ele., 40% STR 40% INT, 1.0/2.0/2.5 fTP.
	sets.precast.WS['Frostbite'] = sets.precast.WS.Magic
    
    -- Freezebite: magical, ice-ele., 40% STR 40% INT, 1.0/1.5/3.0 fTP.
	sets.precast.WS['Freezebite'] = sets.precast.WS.Magic
    
    -- Shockwave: physical AOE, 30% STR 30% MND, 1.0 fTP, TP affects duration of sleep.
	sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Gorget"})
    
    -- Crescent Moon: physical 1-hit, 80% STR, 1.5/1.75/2.75 fTP.
	sets.precast.WS['Crescent Moon'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Gorget"})
    
    -- Sickle Moon: physical 2-hit, 40% STR 40% AGI, 1.5/2.0/2.75 fTP.
	sets.precast.WS['Sickle Moon'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Gorget"})
    
    -- Spinning Slash: physical 1-hit, 30% STR 30% INT, 2.5/3.0/3.5 fTP.
	sets.precast.WS['Spinning Slash'] = set_combine(sets.precast.WS, {
        ear2="Ishvara Earring"})
    
    -- Ground Strike: physical 1-hit, 50% STR 50% INT, 1.5/1.75/3.0 fTP.
	sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Gorget"})
    
    -- Herculean Slash: magical, ice-ele., 80% VIT, 3.5 fTP, TP affects duration of paralyze.
	sets.precast.WS['Herculean Slash'] = sets.precast.WS.Magic
    
    -- Resolution: physical 5-hit, 73~85% STR, 0.71875/1.5/2.25 fTP.
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Gorget"})
    
    -- Torcleaver: physical 1-hit, 80% VIT, 4.75/7.5/10.0 fTP.
	sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
        ear1="Ishvara Earring",ear2="Moonshade Earring"})

	--------------------------------------
	-- Scythe
	--------------------------------------
    
	sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {})
	
    --==================================--
	-- Fast Cast
    --==================================--
	
    -- Sets for fast cast gear for spells
	sets.precast.FC = {
        ammo="Impatiens",
        head=gear.CarmineMaskPlus1.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        hands="Leyline Gloves",ring1="Prolix Ring",ring2="Lebeche Ring",
        legs="Enif Cosciales",feet="Odyssean Greaves"}
	
    --==================================--
	-- Midcast
    --==================================--

    -- Generic spell recast set
	sets.midcast.FastRecast = {
        ammo="Sapience Orb",
        head=gear.CarmineMaskPlus1.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        hands="Leyline Gloves",ring1="Prolix Ring",
        legs="Enif Cosciales",feet="Odyssean Greaves"}
	
    --==================================--
	-- Dark Magic
    --==================================--
	
	sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Founder's Breastplate",hands="Leyline Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
        back=gear.NihtMantle.WS,waist="Eschan Stone",legs="Founder's Hose",feet="Odyssean Greaves"}
        
    sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {back="Chuparrosa Mantle"})
    
	sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], {
	    head=empty,ear1="Enchanter Earring +1",ear2="Hirudinea Earring",body="Lugra Cloak +1",ring2="Evanescence Ring",back=gear.NihtMantle.WS})
        
    sets.midcast.Drain = sets.midcast.Aspir
	sets.midcast['Drain III'] = sets.midcast.Drain
	
    --==================================--
	-- Elemental Magic
    --==================================--
	
	sets.midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Novio Earring",
        body="Founder's Breastplate",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs=gear.EschiteCuisses.D,feet="Founder's Greaves"}
	
    --==================================--
	-- Enfeebling Magic
    --==================================--
	
	sets.midcast['Enfeebling Magic'] = {}
	
    --==================================--
	-- Enhancing Magic
    --==================================--
	
	sets.midcast['Enhancing Magic'] = {}
	
    --==================================--
	-- Healing Magic
    --==================================--
	
	sets.midcast['Healing Magic'] = {}
	
	sets.midcast.Cure = sets.midcast['Healing Magic']
	
    --==================================--
	-- Ninjutsu
    --==================================--
    
	sets.midcast.Utsusemi = {}

    --==================================--
	-- Active Buffs
    --==================================--
	
	--sets.buff.Souleater = {head="Ignominy Burgeonet +1"}
	--sets.buff['Last Resort'] = {feet="Fallen's Sollerets +1"}
	--sets.buff['Dark Seal'] = {head="Fallen's Burgeonet +1"}
	--sets.buff['Nether Void'] = {legs="Heathen's Flanchard +1"}
	
    --==================================--
	-- Miscellaneous Sets
    --==================================--
    
	sets.Kiting = {legs=gear.CarmineCuissesPlus1.D}
	sets.Reive = {neck="Ygnas's Resolve +1"}
    
	--==================================--
	-- Additional items for Organizer
	--==================================--
	
    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
        zulfiqar="Zulfiqar",
		humility="Humility",
        montante="Montante +1",
        meekculler="Meekculler",
        
        bloodrain_strap="Bloodrain Strap",
        tzacab_grip="Tzacab Grip",
        duplus_grip="Duplus Grip",
        
		echo_drops="Echo Drops",
		remedy="Remedy"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and buffactive['Reive Mark'] then
		equip(sets.buff['Reive Mark'])
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.default_spell_map == 'Absorb' or spell.english == 'Dread Spikes' then
	    if buffactive['Dark Seal'] and sets.buff['Dark Seal'] then
    	    equip(sets.buff['Dark Seal'])
		end
	end
	
	if spell.default_spell_map == 'Drain' or spell.default_spell_map == 'Absorb' then
	    if buffactive['Nether Void'] and sets.buff['Nether Void'] then
    	    equip(sets.buff['Nether Void'])
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Souleater" and sets.buff.Souleater then
	    if gain then
		    enable('head')
			equip(sets.buff.Souleater)
			disable('head')
		else
            enable('head')
            handle_equipping_gear(player.status)
		end
    elseif buff == "Last Resort" and sets.buff['Last Resort'] then
	    if gain then
		    enable('feet')
			equip(sets.buff['Last Resort'])
			disable('feet')
		else
            enable('feet')
            handle_equipping_gear(player.status)
		end
    end
end

function job_customize_idle_set(idleSet)
    if buffactive['Reive Mark'] then
        idleSet = set_combine(idleSet, sets.buff['Reive Mark'])
    end
    return idleSet
end

function job_customize_melee_set(meleeSet)
    if buffactive['Reive Mark'] then
        meleeSet = set_combine(meleeSet, sets.buff['Reive Mark'])
    end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(3, 8)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 8)
	elseif player.sub_job == 'SAM' then
		set_macro_page(2, 8)
	elseif player.sub_job == 'DNC' then
	    set_macro_page(4, 8)
	else
		set_macro_page(5, 8)
	end
end
