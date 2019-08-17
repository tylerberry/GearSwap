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
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')

	select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    event_list:map(windower.unregister_event)
    event_list:clear()
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
        head="Jumalik Helm",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Kumarbi's Akar",hands="Sulevia's Gauntlets +1",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Sulevia's Cuisses +1",feet="Amm Greaves"}

	sets.idle.Town = sets.idle.Field
	
	sets.idle.Weak = sets.idle.Field
	
	--==================================--
	-- Defense
	--==================================--
    
	sets.defense.PDT = {
        ammo="Vanir Battery",
        head="Jumalik Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Jumalik Mail",hands="Sulevia's Gauntlets +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Shadow Mantle",waist="Flume Belt +1",legs="Sulevia's Cuisses +1",feet="Amm Greaves"}

	sets.defense.MDT = {
        ammo="Vanir Battery",
        head="Jumalik Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Jumalik Mail",hands="Sulevia's Gauntlets +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape +1",waist="Flume Belt +1",legs="Sulevia's Cuisses +1",feet="Amm Greaves"}
	
	--==================================--
	-- Resting
	--==================================--
    
	sets.resting = set_combine(sets.defense.PDT, {
	    head="Jumalik Helm",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
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
        back="Bleating Mantle",waist="Sailfi Belt +1",legs=gear.TaeonTights.TA,feet="Valorous Greaves"}
        
	sets.engaged.Acc = set_combine(sets.engaged, {
        neck="Lissome Necklace",hands="Leyline Gloves",ring2="Ramuh Ring +1",back="Grounded Mantle +1"})
	
	sets.engaged.PDT = sets.engaged
    
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
        neck="Lissome Necklace",hands="Leyline Gloves",ring2="Ramuh Ring +1",back="Grounded Mantle +1"})
	
	--==================================--
	-- Job Abilities
	--==================================--
	
	if player.sub_job == 'DNC' then
		-- Waltz has CHR and VIT mods.
		sets.precast.Waltz = {
			head="Anwig Salade",
			waist="Chaac Belt"}
			
		-- No gear needed for Healing Waltz.
		sets.precast.Waltz['Healing Waltz'] = {}
	end
	
	--==================================--
	-- Weaponskills
	--==================================--
	
	sets.precast.WS = {
        ammo="Floestone",
        head="Sulevia's Mask +1",neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's Gauntlets +1",ring1="Ifrit Ring +1",ring2="Ifrit Ring +1",
        back="Bleating Mantle",waist="Prosilio Belt +1",legs="Sulevia's Cuisses +1",feet="Sulevia's Leggings +1"}
	
	sets.precast.WS.Magic = {
        ammo="Pemphredo Tathlum",
        head="Jumalik Helm",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Novio Earring",
        body="Founder's Breastplate",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs="Limbo Trousers",feet="Founder's Greaves"}

	--------------------------------------
	-- Polearm
	--------------------------------------
    
    -- Double Thrust: physical 2-hit, 30% STR 30% DEX, 1.0/1.5/2.0 fTP.
	sets.precast.WS['Double Thrust'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
    
    -- Thunder Thrust: magical, lightning-ele., 40% STR 40% INT, 1.5/2.0/2.5 fTP.
	sets.precast.WS['Thunder Thrust'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})
    
    -- Raiden Thrust: magical, lightning-ele., 40% STR 40% INT, 1.0/2.0/3.0 fTP.
	sets.precast.WS['Raiden Thrust'] = set_combine(sets.precast.WS.Magic, {ear2="Moonshade Earring"})
    
    -- Leg Sweep: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to stun.
	sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",waist="Fotia Belt"})
    
    -- Penta Thrust: physical 5-hit, 20% STR 20% DEX, 1.0 fTP, TP affects accuracy.
	sets.precast.WS['Penta Thrust'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Belt"})
    
    -- Vorpal Thrust: physical 1-hit, 50% STR 50% AGI, 1.0 fTP, TP affects chance to crit.
	sets.precast.WS['Vorpal Thrust'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",back="Rancorous Mantle",waist="Fotia Belt"})
    
    -- Skewer: physical 3-hit, 50% STR, 1.0 fTP, TP affects chance to crit.
	sets.precast.WS['Skewer'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",back="Rancorous Mantle",waist="Fotia Belt"})
    
    -- Wheeling Thrust: physical 1-hit, 80% STR, 1.75 fTP, TP affects amount of defense ignored.
	sets.precast.WS['Wheeling Thrust'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
    
    -- Impulse Drive: physical 2-hit, 100% STR, 1.0/3.0/5.5 fTP.
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
    
    -- Drakesbane: physical 4-hit, 50% STR, 1.0 fTP, TP affects chance to crit.
	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",back="Rancorous Mantle",waist="Fotia Belt"})
    
    -- Sonic Thrust: physical 1-hit AOE, 40% STR 40% DEX, 3.0/3.7/4.5 fTP.
	sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {
        ear1="Ishvara Earring",ear2="Moonshade Earring"})
    
    -- Camlann's Torment: physical 3-hit, 60% STR 60% VIT, 3.0 fTP, TP affects amount of defense ignored.
	sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})
    
    -- Stardiver: physical 4-hit, 73~85% STR, 0.75/1.25/1.75 fTP.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Belt"})
	
	--==================================--
	-- Fast Cast
	--==================================--
	
    -- Sets for fast cast gear for spells
	sets.precast.FC = {
        neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.TaeonTabard.FC,hands="Leyline Gloves",ring1="Prolix Ring",
        legs="Limbo Trousers"}

	if player.sub_job == 'NIN' then
		-- Fast cast gear for specific spells or spell maps
		sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace"})
	end
	
	--==================================--
	-- Midcast
	--==================================--

	sets.midcast.FastRecast = {
        ammo="Sapience Orb",
        head=gear.TaeonChapeau.TA,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.TaeonTabard.FC,hands="Leyline Gloves",ring1="Prolix Ring",
        legs="Limbo Trousers",feet=gear.TaeonBoots.TA}
	
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
    
	sets.Kiting = {legs=gear.CarmineCuissesPlus1.D}
	sets.Reive = {neck="Ygnas's Resolve +1"}
    
	--==================================--
	-- Organizer Items
	--==================================--
	
    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
        reienkyo="Reienkyo",
        koresuke="Koresuke",
		mercurial_spear="Mercurial Spear",
        
        duplus_grip="Duplus Grip",
        tzacab_grip="Tzacab Grip",
        bloodrain_strap="Bloodrain Strap",
        
		remedy="Remedy"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

end

function job_customize_idle_set(idleSet)

end

function job_customize_melee_set(meleeSet)

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
