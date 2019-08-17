-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2

	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    include('Tasya-Lib.lua')
    
	event_list = L{}
    
    ready_moves = S{
        'Sic','Whirl Claws','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop','Rage','Head Butt',
        'Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Roar','Gloeosuccus',
        'Palsy Pollen','Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit','Numbing Noise','Nimble Snap',
        'Cyclotail','Spoil','Rhino Guard','Rhino Attack','Power Attack','Hi-Freq Field','Sandpit','Sandblast',
        'Venom Spray','Mandibular Bite','Metallic Body','Bubble Shower','Bubble Curtain','Scissor Guard',
        'Big Scissors','Grapple','Spinning Top','Double Claw','Filamented Hold','Frog Kick','Queasyshroom',
        'Silence Gas','Numbshroom','Spore','Dark Spore','Shakeshroom','Blockhead','Secretion','Fireball',
        'Tail Blow','Plague Breath','Brain Crush','Infrasonics','??? Needles','Needleshot','Chaotic Eye','Blaster',
        'Scythe Tail','Ripper Fang','Chomp Rush','Intimidate','Recoil Dive','Water Wall','Snow Cloud',
        'Wild Carrot','Sudden Lunge','Spiral Spin','Noisome Powder','Wing Slap','Beak Lunge','Suction','Drainkiss',
        'Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker',
        'Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath','Sensilla Blades',
        'Tegmina Buffet','Molting Plumage','Swooping Frenzy','Pentapeck','Sweeping Gouge','Zealous Snort',
        'Somersault','Tickling Tendrils','Stink Bomb','Nectarous Deluge','Nepenthic Plunge','Pecking Flurry',
        'Pestilent Plume','Foul Waters','Spider Web','Sickle Slash','Frogkick','Ripper Fang','Scythe Tail',
        'Chomp Rush'}
    
    mab_ready_moves = S{
        'Cursed Sphere','Venom','Toxic Spit','Venom Spray','Bubble Shower','Fireball','Plague Breath','Snow Cloud',
        'Acid Spray','Silence Gas','Dark Spore','Charged Whisker','Purulent Ooze','Aqua Breath','Stink Bomb',
        'Nectarous Deluge','Nepenthic Plunge','Foul Waters','Dust Cloud','Sheep Song','Scream','Dream Flower',
        'Roar','Gloeosuccus','Palsy Pollen','Soporific','Geist Wall','Numbing Noise','Spoil','Hi-Freq Field',
        'Sandpit','Sandblast','Filamented Hold','Spore','Infrasonics','Chaotic Eye','Blaster','Intimidate',
        'Noisome Powder','TP Drainkiss','Jettatura','Spider Web','Corrosive Ooze','Molting Plumage',
        'Swooping Frenzy','Pestilent Plume'}	
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
	state.OffenseMode:options('Normal', 'Acc')
	--state.RangedMode:options('Normal')
	--state.HybridMode:options('Normal')
	--state.WeaponskillMode:options('Normal')
	--state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Reraise')
	--state.RestingMode:options('Normal')
	--state.PhysicalDefenseMode:options('PDT')
	--state.MagicalDefenseMode:options('MDT')
	
	update_combat_form()
    select_default_macro_book()
end

-- Load job-specific keybinds.
function user_binds_on_load()

end

-- Unload job-specific keybinds.
function user_binds_on_unload()
	-- Unbinds the Jug Pet, Reward, Correlation, Treasure, PetMode, MDEF Mode hotkeys.
	
    --send_command('unbind !=')
	--send_command('unbind ^=')
	--send_command('unbind !f8')
	--send_command('unbind ^f8')
	--send_command('unbind @f8')
	--send_command('unbind ^f11')
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

    gear.PastoralistsMantle = {}
    gear.PastoralistsMantle.PetDT = {name="Pastoralist's Mantle", augments={'STR+1 DEX+1','Accuracy+2','Pet: Accuracy+13 Pet: Rng. Acc.+13','Pet: Damage taken -4%'}}

    --==================================--
	-- Idle
    --==================================--
    
    sets.idle.Field = {
		main="Deacon Tabar",sub="Arktoi",ammo="Vanir Battery",
		head="Jumalik Helm",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
		body="Kumarbi's Akar",hands="Macabre Gauntlets +1",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Iuitl Tights +1",feet="Amm Greaves"}

	sets.idle.Reraise = set_combine(sets.idle.Field, {head="Twilight Helm",body="Twilight Mail"})
    
	sets.idle.Field.Pet = set_combine(sets.idle.Field, {
		main="Izizoeksi",sub="Astolfo",
		head="Anwig Salade",neck="Shepherd's Chain",ear1="Handler's Earring",ear2="Handler's Earring +1",
		body=gear.EmichoHaubert.D,hands=gear.TaeonGloves.PetDTandWaltz,ring2="Thurandaut Ring",
		back=gear.PastoralistsMantle.PetDT,waist="Isa Belt",legs=gear.TaeonTights.PetDT,feet=gear.TaeonBoots.PetDT})

	sets.idle.Field.Pet.Engaged = set_combine(sets.idle.Pet, {
        ammo="Demonry Core",body=gear.TaeonTabard.PetDTandFC})
        
    sets.idle.Town = sets.idle.Field
    
    sets.idle.Weak = sets.idle.Reraise
	
	--==================================--
	-- Defense
    --==================================--
    
	sets.defense.PDT = {
		ammo="Vanir Battery",
		head="Jumalik Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Macabre Gauntlets +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Shadow Mantle",waist="Flume Belt +1",legs="Iuitl Tights +1",feet="Amm Greaves"}
	
	sets.defense.MDT = {
		ammo="Vanir Battery",
		head="Skormoth Mask",neck="Loricate Torque +1",ear1="Colossus's Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Macabre Gauntlets +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Nierenschutz",legs="Iuitl Tights +1",feet="Amm Greaves"}
    
	--==================================--
	-- Resting
    --==================================--
    
	sets.resting = set_combine(sets.defense.PDT, {
		neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
		body="Kumarbi's Akar",ring1="Paguroidea Ring",ring2="Sheltered Ring"})

    --==================================--
    -- Engaged - Single Weapon
    --==================================--
	
	sets.engaged = {
		main="Deacon Tabar",sub="Arktoi",ammo="Ginsen",
		head=gear.TaeonChapeau.TA,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.TaeonTabard.TA,hands=gear.ValorousMitts.TP,ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs=gear.TaeonTights.TA,feet=gear.TaeonBoots.TA}
	
	sets.engaged.Acc = set_combine(sets.engaged, {
		sub="Arktoi",neck="Lissome Necklace",back="Grounded Mantle +1"})

    --==================================--
    -- Engaged - Dual Wield
    --==================================--
	
	sets.engaged.DW = {
		main="Deacon Tabar",sub="Arktoi",ammo="Ginsen",
		head=gear.TaeonChapeau.TA,neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body=gear.TaeonTabard.TA,hands=gear.ValorousMitts.TP,ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Patentia Sash",legs=gear.TaeonTights.TA,feet=gear.TaeonBoots.TA}
	
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		sub="Arktoi",neck="Lissome Necklace",back="Grounded Mantle +1"})

	--==================================--
	-- Job Abilities
    --==================================--
    
	sets.precast.JA['Bestial Loyalty'] = {hands="Ankusa Gloves +1"}
	sets.precast.JA['Call Beast'] = {hands="Ankusa Gloves +1"}
    sets.precast.JA.Familiar = {legs="Ankusa Trousers +1"}
    sets.precast.JA['Killer Instinct'] = {head="Ankusa Helm +1"}
	sets.precast.JA.Spur = {back="Artio's Mantle",feet="Nukumi Ocreae +1"}
	sets.precast.JA.Tame = {head="Totemic Helm +1"}
	
	sets.precast.JA.Charm = {
		head="Stout Bonnet",neck="Unmoving Collar +1",ear1="Enchanter Earring +1",ear2="Handler's Earring +1",
		body="Totemic Jackcoat +1",hands="Ankusa Gloves +1",ring1=gear.DarkRing.physical,ring2="Carbuncle Ring +1",
		waist="Chaac Belt",legs="Ankusa Trousers +1",feet="Ankusa Gaiters +1"}

	sets.precast.JA.Reward = {
		ammo="Pet Food Theta",
		head="Stout Bonnet",neck="Aife's Medal",ear1="Lifestorm Earring",ear2="Neptune's Pearl",
		body="Totemic Jackcoat +1",hands="Leyline Gloves",ring1="Leviathan Ring +1",ring2="Leviathan Ring +1",
		back=gear.PastoralistsMantle.PetDT,waist="Flume Belt +1",legs="Ankusa Trousers +1",feet="Ankusa Gaiters +1"}

	if player.sub_job == 'DNC' then
		-- Waltz set (chr and vit)
		sets.precast.Waltz = {
            --ammo="Sonia's Plectrum",
            head="Anwig Salade",neck="Unmoving Collar +1",ear1="Enchanter Earring +1",ear2="Handler's Earring +1",
			body="Totemic Jackcoat +1",hands=gear.TaeonGloves.PetDTandWaltz,ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
			back="Laic Mantle",waist="Chaac Belt",legs="Dashing Subligar",feet="Ankusa Gaiters +1"}
            
        sets.precast.Waltz.Self = {ring2="Asklepian Ring"}

		-- Don't need any special gear for Healing Waltz.
		sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade"}
	end

    --==================================--
    -- Weaponskills
    --==================================--
	
	sets.precast.WS = {
		ammo="Floestone",
		head=gear.DespairHelm.D,neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.TaeonTabard.TA,hands=gear.DespairFingerGauntlets.B,ring1="Ifrit Ring +1",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Metalsinger Belt",legs=gear.TaeonTights.TA,feet=gear.TaeonBoots.TA}

	sets.precast.WS.Magic = {
		ammo="Pemphredo Tathlum",
		head="Jumalik Helm",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Novio Earring",
		body="Jumalik Mail",hands="Leyline Gloves",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1",
		back="Toro Cape",waist="Eschan Stone",legs="Limbo Trousers",feet=gear.TaeonBoots.TA}
		
    --------------------------------------
    -- Axe
    --------------------------------------
	
	-- Raging Axe: physical 2-hit, 60% STR, 1.0/1.5/2.0 fTP.
	sets.precast.WS['Raging Axe'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
	
	-- Smash Axe: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to stun.
	sets.precast.WS['Smash Axe'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
	
	-- Gale Axe: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to inflict Choke.
	sets.precast.WS['Gale Axe'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Belt"})
	
	-- Avalanche Axe: physical 1-hit, 60% STR, 1.5/2.0/2.5 fTP.
	sets.precast.WS['Avalanche Axe'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
	
	-- Spinning Axe: physical 2-hit, 60% STR, 2.0/2.5/3.0 fTP.
	sets.precast.WS['Spinning Axe'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
	
	-- Rampage: physical 5-hit, 50% STR, 1.0 fTP, TP affects chance to crit.
	sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {
    	neck="Fotia Gorget",ear2="Moonshade Earring",back="Rancorous Mantle",waist="Fotia Belt"})
	
	-- Calamity: physical 1-hit, 50% STR 50% VIT, 2.5/6.5/10.375 fTP.
	sets.precast.WS['Calamity'] = set_combine(sets.precast.WS, {ear1="Ishvara Earring",ear2="Moonshade Earring"})
	
	-- Mistral Axe: physical 1-hit ranged, 50% STR, 4.0/10.5/13.625 fTP.
	sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS, {ear1="Ishvara Earring",ear2="Moonshade Earring"})
	
	-- Decimation: physical 3-hit, 50% STR, 1.75 fTP, TP affects accuracy.
	sets.precast.WS['Decimation'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Belt"})
	
	-- Primal Rend: magical, light ele., 30% DEX 60% CHR, 3.0625/5.8359/7.5625 fTP
	sets.precast.WS['Primal Rend'] = set_combine(sets.precast.WS.Magic, {ear2="Moonshade Earring"})
	
	-- Bora Axe: physical 1-hit ranged, 100% DEX, 4.5 fTP, TP affects chance to bind.
	sets.precast.WS['Bora Axe'] = set_combine(sets.precast.WS, {ear2="Ishvara Earring",ring1="Ramuh Ring +1"})
	
	-- Cloudsplitter: magical, lightning ele., 40% STR 40% MND, 3.75/6.6992/8.5 fTP.
	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS.Magic, {ear2="Moonshade Earring"})
	
	-- Ruinator: physical 4-hit, 73~85% STR, 1.08 fTP, TP affects accuracy.
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Belt"})
        
	--==================================--
	-- Fast Cast
    --==================================--
    
    sets.precast.FC = {
		ammo="Impatiens",
		neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
		body=gear.TaeonTabard.FC,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Lebeche Ring",
		legs="Limbo Trousers"}
        
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace"})

	--==================================--
	-- Midcast
    --==================================--
    
    --==================================--
	-- Enhancing Magic
    --==================================--
    
    if S{'WHM', 'RDM', 'SCH'}:contains(player.sub_job) then
        sets.midcast.Stoneskin = {
            neck="Stone Gorget",ear1="Earthcry Earring",hands="Stone Mufflers",legs="Haven Hose"}
    end
    
    --==================================--
	-- Pet Sic/Ready
    --==================================--

	sets.midcast.Pet.ReadyRecast = {sub="Charmer's Merlin",legs="Desultor Tassets"}
	sets.midcast.Pet.EngagedRecast = {legs="Desultor Tassets"}
    
	sets.midcast.Pet.WS = {
		ammo="Demonry Core",
		head=gear.EmichoCoronet.C,neck="Empath Necklace",ear1="Sabong Earring",ear2="Domesticator's Earring",
		body=gear.EmichoHaubert.D,hands=gear.ValorousMitts.Pet,ring1="Varar Ring +1",ring2="Varar Ring +1",
		back=gear.PastoralistsMantle.PetDT,waist="Incarnation Sash",legs=gear.ValorousHose.Pet,feet=gear.ValorousGreaves.Pet}

	-- This will equip for Magical Ready moves like Fireball.
	sets.midcast.Pet.WS.MAB = set_combine(sets.midcast.Pet.WS, {neck="Deino Collar",body=gear.EmichoHaubert.D})
	
	sets.midcast.Pet.WSAxes = {main="Digirbalag",sub="Arktoi"}
	sets.midcast.Pet.WSAxes.MAB = {main=gear.Kumbhakarna.Acc1,sub="Deacon Tabar"}
	
    --sets.midcast.Pet.TPBonusAxes = {main=gear.Kumbhakarna.Acc1,sub=gear.Kumbhakarna.Ready2}
	sets.midcast.Pet.TPBonusAxes = {main=gear.Kumbhakarna.Acc1,sub="Arktoi"}
	sets.midcast.Pet.TPBonusAxes.MAB = {main=gear.Kumbhakarna.Acc1,sub="Deacon Tabar"}
	
	sets.midcast.Pet.TPBonusHands = {hands="Nukumi Manoplas +1"}

    --==================================--
	-- Miscellaneous Sets
    --==================================--
    
	sets.Kiting = {feet="Skadi's Jambeaux +1"}
	
    --==================================--
	-- Organizer Items
    --==================================--
    
    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
        bubbly_broth="Bubbly Broth",
		spicy_broth="Spicy Broth"})
end

-----------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	cancel_conflicting_buffs(spell, action, spellMap, eventArgs)

    if ready_moves:contains(spell.name) and pet.status == 'Engaged' then
		classes.CustomClass = "WS"
		if player.status == 'Engaged' then
			equip(sets.midcast.Pet.EngagedRecast)
		else
			equip(sets.midcast.Pet.ReadyRecast)
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

end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
	if mab_ready_moves:contains(spell.english) and pet.status == 'Engaged' then
		equip(sets.midcast.Pet.WS.MAB)
		
		if buffactive['Unleash'] then
			if player.status ~= 'Engaged' then
				equip(sets.midcast.Pet.WSAxes.MAB)
			end
		else
			equip(sets.midcast.Pet.TPBonusHands)
			if player.status ~= 'Engaged' then
				equip(sets.midcast.Pet.TPBonusAxes.MAB)
			end
		end
	elseif ready_moves:contains(spell.english) and pet.status == 'Engaged' then
		equip(sets.midcast.Pet.WS)
		
		if buffactive['Unleash'] then
			if player.status ~= 'Engaged' then
				equip(sets.midcast.Pet.WSAxes)
			end
		else
			equip(sets.midcast.Pet.TPBonusHands)
			if player.status ~= 'Engaged' then
				equip(sets.midcast.Pet.TPBonusAxes)
			end
		end
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a generally-handled state value has been changed.
function job_state_change(stateField, newValue, oldValue)

end

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

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
    update_combat_form()
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
-------------------------------------------------------------------------------------------------------------------9

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == "Thorfinn Shield +1" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job:upper() == 'DNC' then
        set_macro_page(2, 6)
    elseif player.sub_job:upper() == 'RDM' then
        set_macro_page(3, 6)
    else
        set_macro_page(1, 6)
    end
end