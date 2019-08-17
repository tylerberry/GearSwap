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

    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false

    state.FootworkWS = M(false, 'Footwork on WS')
    
	event_list = L{}
	event_list:append(windower.register_event('mp change',tas_oneiros_ring))

    impetus_hit_count = 0
    event_list:append(windower.raw_register_event('action',on_action_for_impetus))
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Counter')
    
    gear.AlternateTPRing = "Petrov Ring"

    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
end

function user_unload()
-- Called when this job file is unloaded (eg: job change)
    event_list:map(windower.unregister_event)
    event_list:clear()
end

-- Define sets and vars used by this job file.
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
	    ammo="Ginsen",
        head="Dampening Tam",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Hizamaru Haramaki +1",hands=gear.HerculeanGloves.PDT,ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Iximulew Cape",waist="Black Belt",legs=gear.TaeonTights.TA,feet=gear.HerculeanBoots.WSD}

    sets.idle.Town = {
	    ammo="Ginsen",
        head=gear.AdhemarBonnetPlus1.B,neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Hizamaru Haramaki +1",hands=gear.TaeonGloves.TA,ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Bleating Mantle",waist="Black Belt",legs=gear.TaeonTights.TA,feet=gear.HerculeanBoots.WSD}
    
    sets.idle.Weak = {
	    ammo="Ginsen",
        head=gear.AdhemarBonnetPlus1.B,neck="Wiglen Gorget",ear1="Colossus's Earring",ear2="Ethereal Earring",
        body="Emet Harness +1",gear.TaeonGloves.TA,ring1="Sheltered Ring",ring2="Defending Ring",
        back="Iximulew Cape",waist="Black Belt",legs=gear.TaeonTights.TA,feet=gear.HerculeanBoots.WSD}

    --==================================--
	-- Defense
    --==================================--
    
    sets.defense.PDT = {
	    ammo="Iron Gobbet",
        head="Uk'uxkaj Cap",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Shadow Mantle",waist="Black Belt",legs=gear.TaeonTights.TA,feet=gear.HerculeanBoots.WSD}
        
    sets.defense.MDT = {
	    ammo="Vanir Battery",
        head="Dampening Tam",neck="Loricate Torque +1",
        body="Otronif Harness +1",hands="Anchorite's Gloves +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",waist="Black Belt",legs=gear.TaeonTights.TA,feet=gear.HerculeanBoots.WSD}
    
    --==================================--
	-- Resting
    --==================================--
    
    sets.resting = set_combine(sets.defense.PDT, {
	    head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Hizamaru Haramaki +1",ring1="Sheltered Ring",ring2="Paguroidea Ring"})

    --==================================--
	-- Engaged
    --==================================--

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    sets.engaged = {
	    ammo="Ginsen",
        head=gear.AdhemarBonnetPlus1.B,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.AdhemarJacketPlus1.B,hands=gear.HerculeanGloves.TA,ring1=gear.TPRing,ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs=gear.TaeonTights.TA,feet=gear.HerculeanBoots.WSD}
		
    sets.engaged.Acc = set_combine(sets.engaged, {ammo="Falcon Eye",neck="Combatant's Torque",back="Grounded Mantle +1"})

    -- Defensive melee hybrid sets
    sets.engaged.PDT = {
	    ammo="Ginsen",
        head="Uk'uxkaj Cap",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Patricius Ring",ring2="Epona's Ring",
        back="Iximulew Cape",waist="Windbuffet Belt +1",legs="Hesychast's Hose +1",feet="Otronif Boots +1"}
        
    sets.engaged.Acc.PDT = {
	    ammo="Falcon Eye",
        head="Whirlpool Mask",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Patricius Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Qaaxo Tights",feet="Qaaxo Leggings"}

    -- Hundred Fists/Impetus melee set
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Tantra Cyclas +2"})
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Tantra Cyclas +2"})

    -- Footwork combat form
    sets.engaged.Footwork = {
        ammo="Ginsen",
        head="Felistris Mask",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Windbuffet Belt +1",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
        
    sets.engaged.Footwork.Acc = {
        ammo="Honed Tathlum",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Otronif Harness +1",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
	
    --==================================--
	-- Job Abilities
    --==================================--
    
    -- Precast sets to enhance JAs on use
    --sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}
    --sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +1"}
    --sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +1"}
    --sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
    --sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +1"}
    --sets.precast.JA['Footwork'] = {feet="Tantra Gaiters +2"}
    --sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
    --sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +1"}

    sets.precast.JA['Chi Blast'] = {
        head="Melee Crown +2",
        body="Otronif Harness +1",hands="Hesychast's Gloves +1",
        back="Tuilha Cape",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}

    sets.precast.JA['Chakra'] = {
        ammo="Iron Gobbet",
        head="Felistris Mask",
        body="Anchorite's Cyclas +1",hands="Hesychast's Gloves +1",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Qaaxo Tights",feet="Thurandaut Boots +1"}

	if player.sub_job == 'DNC' then
		-- Waltz set (chr and vit)
		sets.precast.Waltz = {
            ammo="Sonia's Plectrum",
			head="Anwig Salade",ear1="Enchanter Earring +1",ear2="Handler's Earring +1",
			hands=gear.TaeonGloves.Waltz,ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
			back="Iximulew Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.RawhideBoots.D}
        
		-- Don't need any special gear for Healing Waltz.
		sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade"}

		sets.precast.Step = {waist="Chaac Belt"}
		sets.precast.Flourish1 = {waist="Chaac Belt"}
	end
    
    --==================================--
	-- Weaponskills
    --==================================--
    
    sets.precast.WS = {
	    ammo="Floestone",
        head=gear.AdhemarBonnetPlus1.B,neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.AdhemarJacketPlus1.B,hands=gear.RyuoTekko.A,ring1="Ifrit Ring +1",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Prosilio Belt +1",legs="Hizamaru Hizayoroi +1",feet=gear.HerculeanBoots.WSD}
	
    sets.precast.WS.Magical = {
        ammo="Pemphredo Tathlum",
        head=gear.HerculeanHelm.MAB,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Novio Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs="Limbo Trousers",feet=gear.HerculeanBoots.WSD}
    
    sets.precast.WSAcc = {ammo="F",back="Anchoret's Mantle"}
    sets.precast.MaxTP = {ear2="Cessance Earring"}

    --------------------------------------
	-- Hand-to-Hand
    --------------------------------------
    
    -- Combo: physical 3-hit, 30% STR 30% DEX, 1.0/3.75/5.5 fTP.
    sets.precast.WS['Combo'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})
    
    -- Shoulder Tackle: physical 1-hit, 100% VIT, 1.0 fTP, TP affects chance to stun.
    sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", aist="Fotia Belt"})
    
    -- One Inch Punch: physical 1-hit, 100% VIT, 1.0 fTP, TP affects amount of defense ignored.
    sets.precast.WS['One Inch Punch'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})
    
    -- Backhand Blow: physical 1-hit, 50% STR 50% DEX, 1.0 fTP, TP affects chance to crit.
    sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Belt"})
    
    -- Raging Fists: physical 5-hit, 30% STR 30% DEX, 1.0/4.6/9.0 fTP.
    sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})
    sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
    
    -- Spinning Attack: physical 1-hit AOE, 100% STR, 1.0 fTP, TP affects AOE radius.
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})
    
    -- Howling Fist: physical 1-hit, 20% STR 50% DEX, 2.5/4.75/8.0 fTP.
    sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})
    sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
    
    -- Dragon Kick: physical 1-hit, 50% STR 50% DEX, 2.0/3.6/6.5 fTP.
    sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})
    sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
    
    -- Asuran Fists: physical 8-hit, 15% STR 15% VIT, 1.0 fTP, TP affects accuracy.
    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
        ear2="Moonshade Earring",ring2="Spiral Ring",back="Buquwik Cape"})
    sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
    
    -- Tornado Kick: physical 2-hit, 40% STR 40% VIT, 2.25/4.25/7.5 fTP.
    sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {ammo="Tantra Tathlum",ring1="Spiral Ring"})
    sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)
    
    -- Shijin Spiral: physical 5-hit, 73~85% DEX, 1.0625 fTP, TP affects chance to apply plague.
    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
        legs="Manibozho Brais",feet="Daihanshi Habaki"})
    sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
    
    -- Ascetic's Fury: physical 1-hit, 50% STR 50% VIT, 1.0 fTP, TP affects chance to crit.
    sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
        ammo="Tantra Tathlum",ring1="Spiral Ring",back="Buquwik Cape",feet="Qaaxo Leggings"})
    sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
    
    -- Victory Smite: physical 4-hit, 80% STR, 2.25 fTP, TP affects chance to crit.
    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {neck="Nefarious Collar +1",back="Rancorous Mantle"})
    sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)

    --------------------------------------
	-- Staff
    --------------------------------------
    
    sets.precast.WS['Cataclysm'] = sets.precast.WS.Magical

    --==================================--
	-- Fast Cast
    --==================================--
    
    sets.precast.FC = {ammo="Impatiens",head="Haruspex Hat",ear2="Loquacious Earring",hands="Leyline Gloves"}

	if player.sub_job == 'NIN' then
		sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace"})
    end
    
    --==================================--
	-- Midcast
    --==================================--
    
    sets.midcast.FastRecast = {
        head="Whirlpool Mask",ear2="Loquacious Earring",
        body=gear.TaeonTabard.TA,hands="Leyline Gloves",
        waist="Black Belt",legs="Limbo Trousers",feet="Otronif Boots +1"}
    
    --==================================--
	-- Ninjutsu
    --==================================--
    
	if player.sub_job == 'NIN' then
		-- Specific spells
		sets.midcast.Utsusemi = {
			head="Whirlpool Mask",ear2="Loquacious Earring",
			body="Otronif Harness +1",hands="Leyline Gloves",
			waist="Black Belt",legs="Qaaxo Tights",feet="Otronif Boots +1"}
	end
    
    --==================================--
	-- Miscellaneous Sets
    --==================================--
	
    sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
    sets.Footwork = {feet="Anchorite's Gaiters +1"}
    sets.Impetus = {body="Tantra Cyclas +2"}
    sets.Kiting = {feet="Herald's Gaiters"}
	sets.Reive = {neck="Ygnas's Resolve +1"}
    sets.TreasureHunter = {waist="Chaac Belt"}

	--==================================--
	-- Organizer Items
    --==================================--
	
    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
        denouements="Denouements",
		calved_claws="Calved Claws",
		terras_staff="Terra's Staff",
		kitty_rod="Kitty Rod",
        
        petrov_ring="Petrov Ring",
        oneiros_ring="Oneiros Ring",
        
		hachirin_no_obi="Hachirin-no-Obi"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
            if (state.OffenseMode.current == 'Fodder' and impetus_hit_count > 5) or (impetus_hit_count > 8) then
                equip(sets.Impetus)
            end
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.Footwork)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        send_command('cancel Footwork')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 75 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
    
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(8, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 1)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 1)
    else
        set_macro_page(3, 1)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            impetus_hit_count = 0
                        else
                            impetus_hit_count = impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            impetus_hit_count = 0
                        else
                            impetus_hit_count = impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                impetus_hit_count = impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
        
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
    else
        impetus_hit_count = 0
    end
    
end

