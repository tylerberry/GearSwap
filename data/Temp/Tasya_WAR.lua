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
	event_list = L{}
end

function job_file_unload()
    event_list:map(windower.unregister_event)
    event_list:clear()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal')
	state.RangedMode:options('Normal')
	state.HybridMode:options('Normal')
	state.WeaponskillMode:options('Normal')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')

	select_default_macro_book()
end

-- Load job-specific keybinds.
function user_binds_on_load()

end

-- Unload job-specific keybinds.
function user_binds_on_unload()

end

-- Called when this job file is unloaded (eg: job change)
function user_unload()

end

function init_gear_sets()
	
    --==================================--
	-- Augmented gear and base sets
    --==================================--

    include('Tasya-Gear.lua')
    tas_shared_augmented_gear()
    
    --==================================--
	-- Idle
    --==================================--
	
	sets.idle.Field = {
        ammo="Vanir Battery",
        head=empty,neck="Coatl Gorget +1",ear1="Infused Earring",ear2="Dawn Earring",
        body="Lugra Cloak +1",hands="Redan Gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs=gear.OdysseanCuisses.TP,feet="Valorous Greaves"}

	sets.idle.Town = {
        ammo="Vanir Battery",
        head=empty,neck="Coatl Gorget +1",ear1="Infused Earring",ear2="Dawn Earring",
        body="Lugra Cloak +1",hands="Redan Gloves",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs=gear.OdysseanCuisses.TP,feet="Valorous Greaves"}
	
	sets.idle.Weak = {
        ammo="Vanir Battery",
        head=empty,neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Lugra Cloak +1",hands="Redan Gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs=gear.OdysseanCuisses.TP,feet="Valorous Greaves"}
	
    --==================================--
	-- Defense
    --==================================--
    
	sets.defense.PDT = {
        ammo="Vanir Battery",
        head="Jumalik Helm",neck="Loricate Torque +1",ear1="Colossus's Earring",ear2="Ethereal Earring",
        body="Jumalik Mail",hands="Redan Gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Shadow Mantle",waist="Flume Belt +1",legs="Founder's Hose",feet="Amm Greaves"}

	sets.defense.MDT = sets.defense.PDT
    
    --==================================--
	-- Resting
    --==================================--
	
	sets.resting = set_combine(sets.defense.PDT, {
	    head="Jumalik Helm",neck="Coatl Gorget +1",
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
        body="Founder's Breastplate",hands="Sulevia's Gauntlets +1",ring1="Rajas Ring",ring2="Petrov Ring",
        back="Bleating Mantle",waist="Sailfi Belt +1",legs=gear.OdysseanCuisses.TP,feet="Valorous Greaves"}
        
	sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Seething Bomblet +1",
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
	
    sets.precast.JA['Berserk'] = {back="Cichol's Mantle"}
    sets.precast.JA['Blood Rage'] = {body="Boii Lorica +1"}
    sets.precast.JA['Restraint'] = {hands="Boii Mufflers +1"}
    
	if player.sub_job == 'DNC' then
		-- Waltz has CHR and VIT mods.
		sets.precast.Waltz = {
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
        head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Founder's Breastplate",hands="Leyline Gloves",ring1="Petrov Ring",ring2="Rajas Ring",
        back=gear.NihtMantle.WS,waist="Windbuffet Belt +1",legs=gear.ValorousHose.WSD,feet="Valorous Greaves"}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {back="Grounded Mantle +1"})

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
	sets.precast.WS['Frostbite'] = set_combine(sets.precast.WS, {})
    
    -- Freezebite: magical, ice-ele., 40% STR 40% INT, 1.0/1.5/3.0 fTP.
	sets.precast.WS['Freezebite'] = set_combine(sets.precast.WS, {})
    
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
    
    -- Herculean Slash: physical 1-hit, 80% VIT, 3.5 fTP, TP affects duration of paralyze.
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS, {
        ear2="Ishvara Earring"})
    
    -- Resolution: physical 5-hit, 73~85% STR, 0.71875/1.5/2.25 fTP.
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Gorget"})
    
    -- Torcleaver: physical 1-hit, 80% VIT, 4.75/7.5/10.0 fTP.
	sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
        ear1="Ishvara Earring",ear2="Moonshade Earring"})
	
    --==================================--
	-- Fast Cast
    --==================================--
	
    -- Sets for fast cast gear for spells
	sets.precast.FC = {
        ammo="Impatiens",
        head=gear.CarmineMask1.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        hands="Leyline Gloves",ring1="Prolix Ring",ring2="Lebeche Ring",
        legs="Enif Cosciales",feet="Odyssean Greaves"}
	
    --==================================--
	-- Midcast
    --==================================--

    -- Generic spell recast set
	sets.midcast.FastRecast = {
        ammo="Sapience Orb",
        head=gear.CarmineMask1.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        hands="Leyline Gloves",ring1="Prolix Ring",ring2="Lebeche Ring",
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
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
	    head=empty,ear1="Enchanter Earring +1",ear2="Hirudinea Earring",body="Lugra Cloak +1",ring2="Evanescence Ring",back=gear.NihtMantle.WS})
	sets.midcast['Drain III'] = sets.midcast.Drain
	sets.midcast.Aspir = sets.midcast.Drain
	
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
	
    --==================================--
	-- Ninjutsu
    --==================================--
    
	sets.midcast.Utsusemi = {}

    --==================================--
	-- Active Buffs
    --==================================--
	
	
    --==================================--
	-- Miscellaneous Sets
    --==================================--
    
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Reive = {neck="Ygnas's Resolve +1"}
    
    --==================================--
	-- Organizer
    --==================================--
	
    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
		humility="Humility",
        montante="Montante +1",
        meekculler="Meekculler",
        bloodrain_strap="Bloodrain Strap",
        tzacab_grip="Tzacab Grip",
        duplus_grip="Duplus Grip",
        
		remedy="Remedy"})
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

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)

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

end

-- Called when a generally-handled state value has been changed.
function job_state_change(stateField, newValue, oldValue)

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

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

-- Job-specific toggles.
function job_toggle_state(field)

end

-- Request job-specific mode lists.
-- Return the list, and the current value for the requested field.
function job_get_option_modes(field)

end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_option_mode(field, val)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'NIN' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'SAM' then
		set_macro_page(2, 20)
	else
		set_macro_page(5, 20)
	end
end
