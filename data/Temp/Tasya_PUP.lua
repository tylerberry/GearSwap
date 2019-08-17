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
	include('Mote-TreasureHunter.lua')
    include('Tasya-Lib.lua')
    
    state.TreasureMode:set('Tag')
    
    event_list = L{}
    event_list:append(windower.register_event('mp change',tas_oneiros_ring))
    
    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
    
    -- Map automaton heads to combat roles
    petModes = {
        ['Harlequin Head'] = 'Melee',
        ['Sharpshot Head'] = 'Ranged',
        ['Valoredge Head'] = 'Tank',
        ['Stormwaker Head'] = 'Magic',
        ['Soulsoother Head'] = 'Heal',
        ['Spiritreaver Head'] = 'Nuke'}

    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}
    
    -- Var to track the current pet mode.
    state.PetMode = M{['description']='Pet Mode', 'None', 'Melee', 'Ranged', 'Tank', 'Magic', 'Heal', 'Nuke'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    --state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')

    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}}
        
    gear.AlternateTPRing = "Petrov Ring"

    update_pet_mode()
    select_default_macro_book()
end

-- Define sets used by this job file.
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
	    head="Blistering Sallet +1",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Hizamaru Haramaki +1",hands=gear.HerculeanGloves.PDT,ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Kumbira Cape",waist="Isa Belt",legs=gear.HerculeanTrousers.STR,feet="Hermes' Sandals +1"}

    sets.idle.Town = set_combine(sets.idle.Field, {feet=gear.HerculeanBoots.WSD})
    sets.idle.Weak = set_combine(sets.idle.Field, {feet=gear.HerculeanBoots.WSD})
        
    sets.idle.Pet = set_combine(sets.idle, {
        ear1="Handler's Earring",ear2="Handler's Earring +1",back="Visucius's Mantle",waist="Isa Belt"})

    sets.idle.Pet.Engaged = set_combine(sets.idle.Pet, {
        head="Foire Taj",neck="Wiglen Gorget",
        body="Foire Tobe",hands="Regimen Mittens",
        legs="Foire Churidars",feet="Foire Babouches"})

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {hands="Cirque Guanti +2",legs="Cirque Pantaloni +2"})
    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, {legs="Cirque Pantaloni +2",feet="Cirque Scarpe +2"})
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {legs="Cirque Pantaloni +2",feet="Cirque Scarpe +2"})
    
    --==================================--
	-- Resting
    --==================================--
    
    sets.resting = set_combine(sets.defense.PDT, {
	    neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
	    body="Hizamaru Haramaki +1",ring1="Paguroidea Ring",ring2="Sheltered Ring",
		back="Kumbira Cape"})

    --==================================--
	-- Defense
    --==================================--

    sets.defense.PDT = {
        head="Blistering Sallet +1",neck="Loricate Torque +1",ear1="Infused Earring",ear2="Colossus's Earring",
        body="Vrikodara Jupon",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Umbra Cape",waist="Isa Belt",legs=gear.HerculeanTrousers.STR,feet=gear.HerculeanBoots.WSD}

    sets.defense.MDT = {
        head="Otronif Mask +1",neck="Warder's Charm +1",ear1="Infused Earring",ear2="Colossus's Earring",
        body="Vrikodara Jupon",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2="Shadow Ring",
        back="Umbra Cape",waist="Isa Belt",legs=gear.HerculeanTrousers.STR,feet=gear.HerculeanBoots.WSD}

    --==================================--
	-- Engaged
    --==================================--

    sets.engaged = {
        head=gear.TaeonChapeau.TA,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.RawhideVest.A,hands=gear.HerculeanGloves.TA,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Visucius's Mantle",waist="Windbuffet Belt +1",legs=gear.TaeonTights.TA,feet=gear.HerculeanBoots.WSD}
        
	sets.engaged.Acc = set_combine(sets.engaged, {neck="Combatant's Torque"})
    
    --==================================--
	-- Job Abilities
    --==================================--

    sets.precast.JA.Maneuver = {neck="Buffoon's Collar +1",body="Cirque Farsetto +2",hands="Foire Dastanas",back="Visucius's Mantle"}
    sets.precast.JA.Repair = {legs="Desultor Tassets"} --feet="Foire Babouches"
    sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}

	if player.sub_job == 'DNC' then
		-- Waltz set (chr and vit)
		sets.precast.Waltz = {
			head="Anwig Salade",neck="Unmoving Collar +1",ear1="Roundel Earring",ear2="Handler's Earring +1",
			body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
			back="Iximulew Cape",waist="Chaac Belt",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}
        
		-- Don't need any special gear for Healing Waltz.
		sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade"}
    end
	
    --==================================--
	-- Weaponskills
    --==================================--
    
    sets.precast.WS = {
        head=gear.TaeonChapeau.TA,neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.RawhideVest.A,hands=gear.HerculeanGloves.TA,ring1="Ifrit Ring +1",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Windbuffet Belt +1",legs="Hizamaru Hizayoroi +1",feet=gear.HerculeanBoots.WSD}

    --------------------------------------
	-- Hand-to-Hand
    --------------------------------------
    
    -- Combo: physical 3-hit, 30% STR 30% DEX, 1.0/3.75/5.5 fTP.
    sets.precast.WS['Combo'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})
    
    -- Shoulder Tackle: physical 1-hit, 100% VIT, 1.0 fTP, TP affects chance to stun.
    sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
    
    -- One Inch Punch: physical 1-hit, 100% VIT, 1.0 fTP, TP affects amount of defense ignored.
    sets.precast.WS['One Inch Punch'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Ishvara Earring",waist="Fotia Belt"})
    
    -- Backhand Blow: physical 1-hit, 50% STR 50% DEX, 1.0 fTP, TP affects chance to crit.
    sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",body="Abnoba Kaftan",waist="Fotia Belt"})
    
    -- Raging Fists: physical 5-hit, 30% STR 30% DEX, 1.0/4.6/9.0 fTP.
    sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})
    
    -- Spinning Attack: physical 1-hit AOE, 100% STR, 1.0 fTP, TP affects AOE radius.
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Ishvara Earring",waist="Fotia Belt"})
    
    -- Howling Fist: physical 1-hit, 20% STR 50% DEX, 2.5/4.75/8.0 fTP.
    sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {ear1="Ishvara Earring",ear2="Moonshade Earring"})
    
    -- Dragon Kick: physical 1-hit, 50% STR 50% DEX, 2.0/3.6/6.5 fTP.
    sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {ear1="Ishvara Earring",ear2="Moonshade Earring"})
    
    -- Asuran Fists: physical 8-hit, 15% STR 15% VIT, 1.0 fTP, TP affects accuracy.
    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
        ear2="Moonshade Earring"})
    
    -- Tornado Kick: physical 2-hit, 40% STR 40% VIT, 2.25/4.25/7.5 fTP.
    sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {ear1="Ishvara Earring",ear2="Moonshade Earring"})
    
    -- Shijin Spiral: physical 5-hit, 73~85% DEX, 1.0625 fTP, TP affects chance to apply plague.
    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",waist="Fotia Belt"})
    
    -- Stringing Pummel: physical 6-hit, 32% STR 32% VIT, 1.0 fTP, TP affects chance to crit.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",body="Abnoba Kaftan",back="Rancorous Mantle",waist="Fotia Belt"})
    
    -- Victory Smite: physical 4-hit, 80% STR, 2.25 fTP, TP affects chance to crit.
    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",body="Abnoba Kaftan",back="Rancorous Mantle",waist="Fotia Belt"})

    --==================================--
	-- Fast Cast
    --==================================--
    
    sets.precast.FC = {
        ammo="Impatiens",
        head=gear.HerculeanHelm.MAB,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.TaeonTabard.FC,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Lebeche Ring",
        back="Swith Cape +1",legs="Gyve Trousers",feet="Chelona Boots +1"}

    if player.sub_job == 'NIN' then
		sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace"})
	end
    
    --==================================--
	-- Midcast
    --==================================--
	
	sets.midcast.FastRecast = {
		head=gear.HerculeanHelm.MAB,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Anhur Robe",hands="Leyline Gloves",ring1="Prolix Ring",
        back="Swith Cape +1",legs="Gyve Trousers",feet="Chelona Boots +1"}
	
    --==================================--
	-- Pet Actions
    --==================================--
    
    sets.midcast.Pet.Cure = {legs="Foire Churidars"}

    sets.midcast.Pet['Elemental Magic'] = {feet="Pitre Babouches"}

    sets.midcast.Pet.WeaponSkill = {head="Cirque Cappello +2",hands="Cirque Guanti +2",legs="Cirque Pantaloni +2"}

    --==================================--
	-- Miscellaneous Sets
    --==================================--
             
    sets.Kiting = {feet="Hermes' Sandals +1"}
    sets.TreasureHunter = {waist="Chaac Belt"}
	
    --==================================--
	-- Organizer Items
    --==================================--
    
    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
        midnights="Midnights",
		denouements="Denouements",
		divinator="Divinator",
        divinator2="Divinator II",
        
        oneiros_ring="Oneiros Ring",
        petrov="Petrov Ring"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "WeaponSkill"
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == 'Wind Maneuver' then
        handle_equipping_gear(player.status)
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
    update_pet_mode()
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        display_pet_status()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end

-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'maneuver' then
        if pet.isvalid then
            local man = defaultManeuvers[state.PetMode.value]
            if man and tonumber(cmdParams[2]) then
                man = man[tonumber(cmdParams[2])]
            end

            if man then
                send_command('input /pet "'..man..'" <me>')
            end
        else
            add_to_chat(123,'No valid pet.')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
        return petModes[pet.head] or 'None'
    else
        return 'None'
    end
end

-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    state.PetMode:set(get_pet_mode())
    update_custom_groups()
end

-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end

-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
        
        if magicPetModes:contains(state.PetMode.value) then
            petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end
        
        add_to_chat(122, petInfoString)
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 9)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 9)
    else
        set_macro_page(1, 9)
    end
end
