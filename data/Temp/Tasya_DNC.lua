-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    gs c step
        Uses the currently configured step on the target, with either <t> or <stnpc> depending on setting.

    gs c step t
        Uses the currently configured step on the target, but forces use of <t>.
    
    
    Configuration commands:
    
    gs c cycle mainstep
        Cycles through the available steps to use as the primary step when using one of the above commands.
        
    gs c cycle altstep
        Cycles through the available steps to use for alternating with the configured main step.
        
    gs c toggle usealtstep
        Toggles whether or not to use an alternate step.
        
    gs c toggle selectsteptarget
        Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.
--]]


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
    
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false

    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
    state.SkillchainPending = M(false, 'Skillchain Pending')

    tas_determine_haste_group()
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
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc')

	gear.AlternateTPRing = "Petrov Ring"

    select_default_macro_book()
end

-- Load job-specific keybinds.
function user_binds_on_load()
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind != gs c cycle altstep')
    send_command('bind ^- gs c toggle selectsteptarget')
    send_command('bind !- gs c toggle usealtstep')
    send_command('bind ^` input /ja "Chocobo Jig" <me>')
    send_command('bind !` input /ja "Chocobo Jig II" <me>')
end

-- Unload job-specific keybinds.
function user_binds_on_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind ^-')
    send_command('unbind !-')
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

    --==================================--
	-- Idle
    --==================================--

    sets.idle = {
        ammo="Vanir Battery",
        head="Iuitl Headgear +1",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Mekosuchinae Harness",hands=gear.HerculeanGloves.PDT,ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}

    sets.idle.Town = {
        ammo="Charis Feather",
        head="Maculele Tiara +1",neck="Charis Necklace",ear1="Infused Earring",ear2="Dawn Earring",
        body="Maculele Casaque +1",hands="Maculele Bangles +1",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Toetapper Mantle",waist="Patentia Sash",legs="Maculele Tights +1",feet="Maculele Toeshoes +1"}
    
    sets.idle.Weak = {
        ammo="Vanir Battery",
        head="Iuitl Headgear +1",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}
	
    --==================================--
	-- Defense
    --==================================--

    sets.defense.PDT = {
        ammo="Vanir Battery",
        head="Iuitl Headgear +1",neck="Loricate Torque +1",
        body="Emet Harness +1",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Shadow Mantle",waist="Flume Belt +1",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}

    sets.defense.MDT = set_combine(sets.defense.PDT, {head="Dampening Tam",ring2="Shadow Ring",back="Engulfer Cape +1"})
	
    --==================================--
	-- Resting
    --==================================--
    
    sets.resting = set_combine(sets.defense.PDT, {
        head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Mekosuchinae Harness",ring1="Paguroidea Ring",ring2="Sheltered Ring"})
    
    --==================================--
	-- Engaged - Single Weapon
    --==================================--
    
    sets.engaged = {
        ammo="Ginsen",
        head=gear.AdhemarBonnet.B,neck="Charis Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body=gear.AdhemarJacket.B,hands=gear.HerculeanGloves.TA,ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Patentia Sash",legs="Meghanada Chausses +1",feet=gear.RawhideBoots.D}

    sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Falcon Eye",
        head="Dampening Tam",neck="Combatant's Torque",
        back="Toetapper Mantle",feet=gear.HerculeanBoots.TA})
        
    sets.engaged.PDT = set_combine(sets.engaged, {
        head="Meghanada Visor +1",neck="Loricate Torque +1",
        body="Meghanada Cuirie +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",
        back="Agema Cape",waist="Sailfi Belt +1",legs="Meghanada Chausses +1",feet=gear.HerculeanBoots.WSD})
        
    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
        ammo="Falcon Eye",hands="Meghanada Gloves +1",ring2="Patricius Ring",feet="Meghanada Jambeaux +1"})
    
    --==================================--
	-- Engaged - Dual Wield
    --==================================--
    
    ---- Available Dual Wield gear options:
    ----
    ---- Enchufla: +4
	----
    ---- Charis Necklace: +3
    ----
    ---- Suppanomimi: +5
    ---- Eabani Earring: +4
    ---- Green Delve earring set: +7
    ----
	---- Maxixi Tiara +2: +4
	---- Maxixi Tiara +3: +8
	---- Thurandaut Chapeau (+1): +5
	----
    ---- Adhemar Jacket: +5
    ---- Adhemar Jacket +1: +6
    ---- Maculele Casaque: +10
    ---- Maculele Casaque +1: +11
    ----
    ---- Sombra Tights: +3
    ---- Sombra Tights +1: +4
    ----
    ---- Taeon Boots (base, in addition to possible DW augment): +4
    ---- Rawhide Boots: +3
	----
    ---- Haverton Ring: +5
	---- Haverton Ring +1: +6
    ----
    ---- Toetapper Mantle: +1-5
    ---- Senuna's Mantle (DW augment): +10-15
    ----
	---- Patentia Sash: +5
    ---- Shetal Stone: +6
    ---- Reiki Yotai: +7
	----
	---- Augmented Taeon armor (per piece): up to +5
	---- Augmented Herculean armor (per piece): up to +6 with fern stones, +4 with others
	
    -- Dancer has Dual Wield IV, which is DW+30. A 550 JP dancer has DW+35, which is effectively the same as DW5.
    --
    -- Base set has 5 DW. Other sets below are deltas from this set.
	
    sets.engaged.DWBase = {
	    ammo="Ginsen",
        head=gear.AdhemarBonnet.B,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.AdhemarJacket.B,hands=gear.HerculeanGloves.TA,ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Meghanada Chausses +1",feet=gear.HerculeanBoots.TA}
    
    --------------------------------------
    -- No Haste - 30 + 50 DW required to cap
    --------------------------------------
    
    sets.engaged.DW = set_combine(sets.engaged.DWBase, {
	    ear1="Suppanomimi",ear2="Eabani Earring",
        body=gear.AdhemarJacket.B,
        legs=gear.CarmineCuissesPlus1.D,feet=gear.TaeonBoots.TA})
	
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		ammo="Falcon Eye",head="Dampening Tam",neck="Combatant's Torque"})
	
	sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {
	    head="Iuitl Headgear +1",neck="Loricate Torque +1",
	    body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring"})
		
	sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {
	    head="Iuitl Headgear +1",neck="Loricate Torque +1",
	    hands=gear.HerculeanGloves.PDT,ring1="Defending Ring"})
    
    --------------------------------------
    -- 35% Haste - 30 + 19 DW required to cap
    --------------------------------------
    
    sets.engaged.DW.Haste_35 = set_combine(sets.engaged.DWBase, {
        ear1="Suppanomimi",ear2="Eabani Earring",
        body=gear.AdhemarJacket.B,
        feet=gear.TaeonBoots.TA})
	
    sets.engaged.DW.Acc.Haste_35 = set_combine(sets.engaged.DW.Haste_35, {
		ammo="Falcon Eye",head="Dampening Tam",neck="Combatant's Torque"})
	
	sets.engaged.DW.PDT.Haste_35 = set_combine(sets.engaged.DW.Haste_35, {
	    head="Iuitl Headgear +1",neck="Loricate Torque +1",
	    body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",
        feet=gear.HerculeanBoots.WSD})
		
	sets.engaged.DW.Acc.PDT.Haste_35 = set_combine(sets.engaged.DW.Acc.Haste_35, {
	    head="Iuitl Headgear +1",neck="Loricate Torque +1",
	    body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",
        feet=gear.HerculeanBoots.WSD})
    
    --------------------------------------
    -- 40% Haste - 30 + 13 DW required to cap
    --------------------------------------
    
    sets.engaged.DW.Haste_40 = set_combine(sets.engaged.DWBase, {
        body=gear.AdhemarJacket.B,ear1="Heartseeker Earring",ear2="Dudgeon Earring"})
	
    sets.engaged.DW.Acc.Haste_40 = set_combine(sets.engaged.DW.Haste_40, {
		ammo="Falcon Eye",head="Dampening Tam",neck="Combatant's Torque"})
	
	sets.engaged.DW.PDT.Haste_40 = set_combine(sets.engaged.DW.Haste_40, {
	    head="Iuitl Headgear +1",neck="Loricate Torque +1",
	    body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",
        feet=gear.HerculeanBoots.WSD})
		
	sets.engaged.DW.Acc.PDT.Haste_40 = set_combine(sets.engaged.DW.Acc.Haste_40, {
	    head="Iuitl Headgear +1",neck="Loricate Torque +1",
	    body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",
        feet=gear.HerculeanBoots.WSD})
    
    --------------------------------------
    -- 43% Haste - 30 + 6 DW required to cap
    --------------------------------------
    
    sets.engaged.DW.Haste_43 = sets.engaged.DWBase
	
    sets.engaged.DW.Acc.Haste_43 = set_combine(sets.engaged.DW.Haste_43, {
		ammo="Falcon Eye",head="Dampening Tam",neck="Combatant's Torque"})
    sets.engaged.DW.Learning.Haste_43 = set_combine(sets.engaged.DW.Haste_43, sets.Learning)
	
	sets.engaged.DW.PDT.Haste_43 = set_combine(sets.engaged.DW.Haste_43, {
	    head="Iuitl Headgear +1",neck="Loricate Torque +1",ear2="Suppanomimi",
	    body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",
        feet=gear.HerculeanBoots.WSD})
		
	sets.engaged.DW.Acc.PDT.Haste_43 = set_combine(sets.engaged.DW.Acc.Haste_43, {
	    head="Iuitl Headgear +1",neck="Loricate Torque +1",ear2="Suppanomimi",
	    body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",
        feet=gear.HerculeanBoots.WSD})
    
    --==================================--
	-- Job Abilities
    --==================================--

    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +1"}
    sets.precast.JA.Trance = {head="Horos Tiara +1"}

    sets.precast.Flourish1 = {}
	
	-- Physical and magic accuracy, but receives innate +100 physical accuracy.
    sets.precast.Flourish1['Violent Flourish'] = {
        ammo="Pemphredo Tathlum",
	    head="Dampening Tam",neck="Sanctity Necklace",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Horos Casaque +1",hands="Leyline Gloves",ring1="Etana Ring",ring2="Sangoma Ring",
		back="Grounded Mantle +1",waist="Eschan Stone",legs=gear.HerculeanTrousers.STR,feet=gear.HerculeanBoots.WSD}
	
	-- Desperate Flourish: magic accuracy.
    sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.precast.Flourish1['Violent Flourish'], {
        body="Samnuha Coat"})

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Maculele Bangles +1",back="Toetapper Mantle"}

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body="Maculele Casaque +1"}
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1"}

    sets.precast.Jig = {legs="Horos Tights +1",feet="Maxixi Toe Shoes +1"}
    sets.precast.Samba = {head="Maxixi Tiara +1",back="Senuna's Mantle"}

    -- Steps: accuracy.
    sets.precast.Step = {
        ammo="Falcon Eye",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Dominance Earring +1",ear2="Cessance Earring",
        body=gear.AdhemarJacket.B,hands=gear.HerculeanGloves.PDT,ring1="Ramuh Ring +1",ring2="Cacoethic Ring +1",
        back="Grounded Mantle +1",waist="Chaac Belt",legs=gear.HerculeanTrousers.STR,gear.HerculeanBoots.WSD}
        
    sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step, {feet="Maculele Toeshoes +1"})
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
	    ammo="Tsar's Egg",
        head="Anwig Salade",neck="Unmoving Collar +1",ear1="Enchanter Earring +1",ear2="Handler's Earring +1",
        body="Maxixi Casaque +1",hands=gear.HerculeanGloves.Waltz,ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
        back="Toetapper Mantle",waist="Chaac Belt",legs="Dashing Subligar",feet="Maxixi Toe Shoes +1"}
    
    sets.precast.Waltz.Self = set_combine(sets.precast.Waltz, {ring2="Asklepian Ring"})
    
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade"}

    --==================================--
	-- Weaponskills
    --==================================--
    
    sets.precast.WS.STR = {
	    ammo="Floestone",
        head="Lilitu Headpiece",neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.AdhemarJacket.B,hands=gear.AdhemarWristbands.B,ring1="Ifrit Ring +1",ring2="Epona's Ring",
        back="Toetapper Mantle",waist="Metalsinger Belt",legs=gear.HerculeanTrousers.STR,feet=gear.HerculeanBoots.WSD}
        
    sets.precast.WS.DEX = {
	    ammo="Charis Feather",
        head=gear.AdhemarBonnet.B,neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.AdhemarJacket.B,hands=gear.AdhemarWristbands.B,ring1="Ramuh Ring +1",ring2="Epona's Ring",
        back="Toetapper Mantle",waist="Windbuffet Belt +1",legs=gear.LustratioSubligar.B,feet=gear.HerculeanBoots.WSD}
    
    sets.precast.WS.Magic = {
	    ammo="Pemphredo Tathlum",
        head=gear.HerculeanHelm.MAB,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs="Limbo Trousers",feet=gear.HerculeanBoots.WSD}
        
    sets.precast.WS = sets.precast.WS
    
    --------------------------------------
	-- Dagger
    --------------------------------------
    
    -- Wasp Sting: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.
    sets.precast.WS['Wasp Sting'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Belt"})
    sets.precast.WS['Wasp Sting'].Acc = set_combine(sets.precast.WS['Wasp Sting'], {ammo="Falcon Eye"})
    
    -- Gust Slash: magical, wind-ele., 40% DEX 40% INT, 1.0/2.0/3.5 fTP.
    sets.precast.WS['Gust Slash'] = sets.precast.WS.Magic
    
    -- Shadowstitch: physical 1-hit, 100% CHR, 1.0 fTP, TP affects chance to bind.
    sets.precast.WS['Shadowstitch'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
    sets.precast.WS['Shadowstitch'].Acc = set_combine(sets.precast.WS['Shadowstitch'], {ammo="Falcon Eye"})
    
    -- Viper Bite: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.
    sets.precast.WS['Viper Bite'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Belt"})
    sets.precast.WS['Viper Bite'].Acc = set_combine(sets.precast.WS['Viper Bite'], {ammo="Falcon Eye"})
    
    -- Cyclone: magical AOE, wind-ele., 40% DEX 40% INT, 1.0/2.375/2.875 fTP.
    sets.precast.WS['Cyclone'] = sets.precast.WS.Magic
    sets.precast.WS['Cyclone'].TH = set_combine(sets.precast.WS['Cyclone'], {waist="Chaac Belt"})
    
    -- Energy Steal: steals MP, affected by MND and TP.
    sets.precast.WS['Energy Steal'] = {ear2="Moonshade Earring"}
    
    -- Energy Drain: steals MP, affected by MND and TP.
    sets.precast.WS['Energy Drain'] = {ear2="Moonshade Earring"}
    
    -- Dancing Edge: physical 5-hit, 40% DEX 40% CHR, 1.1875 fTP on all hits, TP affects accuracy.
    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Belt"})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Falcon Eye"})

    -- Shark Bite: physical 2-hit, 40% DEX 40% AGI, 4.5/6.8/8.5 fTP.
    sets.precast.WS['Shark Bite'] = set_combine(sets.precast.WS.DEX, {ear2="Moonshade Earring"})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {ammo="Falcon Eye"})
    sets.precast.WS['Shark Bite'].CF = set_combine(sets.precast.WS['Shark Bite'], {
        ammo="Charis Feather",head="Maculele Tiara +1",body="Meghanada Cuirie +1"})

    -- Evisceration: physical 5-hit, 50% DEX, 1.25 fTP on all hits, TP affects chance to crit.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS.DEX, {
        ammo="Charis Feather",
        head=gear.AdhemarBonnet.B,0neck="Fotia Gorget",ear2="Moonshade Earring",
        body="Abnoba Kaftan",
        back="Rancorous Mantle",waist="Fotia Belt"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Falcon Eye"})
    sets.precast.WS['Evisceration'].CF = sets.precast.WS['Evisceration']
    
    -- Aeolian Edge: magical AOE, wind-ele., 40% DEX 40% INT, 2.0/3.0/4.5 fTP.
    sets.precast.WS['Aeolian Edge'] = sets.precast.WS.Magic
    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], {waist="Chaac Belt"})
    
    -- Exenterator: physical 4-hit, 73~85% AGI, 1.0 fTP on all hits, TP affects duration of accuracy down.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",waist="Fotia Belt"})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Falcon Eye"})
    
    -- Pyrrhic Kleos: physical 4-hit, 40% STR 40% DEX, 1.75 fTP on all hits, TP affects duration of evasion down.
    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS.STR, {
        neck="Fotia Gorget",waist="Fotia Belt"})
    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {ammo="Falcon Eye"})
    sets.precast.WS['Pyrrhic Kleos'].CF = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
        ammo="Charis Feather",head="Maculele Tiara +1",body="Meghanada Cuirie +1"})

    -- Rudra's Storm: physical 1-hit, 80% DEX, 5.0/10.19/13.0 fTP.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS.DEX, {
        head="Lilitu Headpiece",ear1="Ishvara Earring",ear2="Moonshade Earring",hands="Meghanada Gloves +1"})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Falcon Eye"})
    sets.precast.WS["Rudra's Storm"].CF = set_combine(sets.precast.WS["Rudra's Storm"], {
        ammo="Charis Feather",head="Maculele Tiara +1",body="Meghanada Cuirie +1"})
    
    --------------------------------------
	-- Hand-to-Hand
    --------------------------------------
    
    -- Combo: physical 3-hit, 30% STR 30% DEX, 1.0/3.75/5.5 fTP.
    sets.precast.WS['Combo'] = set_combine(sets.precast.WS.STR, {ear2="Moonshade Earring"})
    
    -- Shoulder Tackle: physical 1-hit, 100% VIT, 1.0 fTP, TP affects chance to stun.
    sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS.STR, {neck="Fotia Gorget", aist="Fotia Belt"})
    
    -- Backhand Blow: physical 1-hit, 50% STR 50% DEX, 1.0 fTP, TP affects chance to crit.
    sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS.STR, {
        neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Belt"})
    
    -- Spinning Attack: physical 1-hit AOE, 100% STR, 1.0 fTP, TP affects AOE radius.
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS.STR, {neck="Fotia Gorget",waist="Fotia Belt"})
    
    --sets.precast.Skillchain = {hands="Maculele Bangles +1"}
	
    --==================================--
	-- Snapshot
    --==================================--
    
    -- Ranged snapshot gear
    sets.precast.RA = {
        head="Aurore Beret +1",hands="Iuitl Wristbands +1",
        legs=gear.AdhemarKecks.C,feet="Meghanada Jambeaux +1"}
    
    --==================================--
	-- Fast Cast
    --==================================--
	
	sets.precast.FC = {
        ammo="Impatiens",
        head=gear.HerculeanHelm.MAB,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.TaeonTabard.PetDTandFC,hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
        legs="Limbo Trousers"}
	
	if player.sub_job == 'NIN' then
		sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace",body="Passion Jacket"})
	end
	
    --==================================--
	-- Midcast
    --==================================--
    
    sets.midcast.FastRecast = {
        ammo="Sapience Orb",
        head=gear.HerculeanHelm.MAB,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.TaeonTabard.PetDTandFC,hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        legs="Limbo Trousers",feet="Iuitl Gaiters +1"}
	
    --==================================--
	-- Ninjutsu
    --==================================--
    
	if player.sub_job == 'NIN' then
		sets.midcast.Utsusemi = {
            ammo="Vanir Battery",
			head=gear.HerculeanHelm.MAB,neck="Combatant's Torque",ear1="Infused Earring",ear2="Novia Earring",
			body=gear.TaeonTabard.FC,hands="Leyline Gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
			back="Toetapper Mantle",waist="Ninurta's Sash",legs="Limbo Trousers",feet=gear.HerculeanBoots.WSD}
    end
	
    --==================================--
	-- Ranged Attacks
    --==================================--
    
    sets.midcast.RA = {
        head="Meghanada Visor +1",neck="Combatant's Torque",ear1="Enervating Earring",ear2="Neritic Earring",
        body="Meghanada Cuirie +1",hands="Meghanada Gloves +1",ring1="Hajduk Ring +1",ring2="Cacoethic Ring +1",
        back="Sokolski Mantle",waist="Eschan Stone",legs=gear.AdhemarKecks.C,feet="Meghanada Jambeaux +1"}

    --==================================--
	-- Active Buffs
    --==================================--
    
    --sets.buff['Saber Dance'] = {legs="Horos Tights +1"}
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +1"}
    
    --==================================--
	-- Miscellaneous Sets
    --==================================--
    
    sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
    sets.Kiting = {feet="Skadi's Jambeaux +1"}
    
    sets.Saris = {main=gear.TamingSari.High,sub=gear.TamingSari.Mid}
    sets.THSari = {main=gear.TamingSari.TH}
	
    --==================================--
	-- Organizer Items
    --==================================--
    
    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
	    odium="Odium",
        atoyac="Atoyac",
        calved_claws="Calved Claws",
        
		hachirin_no_obi="Hachirin-no-Obi",
		eschan_stone="Eschan Stone"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    --auto_presto(spell)

    if spell.english == "Aeolian Edge" then
		equip(sets.ElementalObi)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if state.SkillchainPending.value == true then
            equip(sets.precast.Skillchain)
        end
    end
end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Wild Flourish" then
            state.SkillchainPending:set()
            send_command('wait 5;gs c unset SkillchainPending')
        elseif spell.type:lower() == "weaponskill" then
            state.SkillchainPending:toggle()
            send_command('wait 6;gs c unset SkillchainPending')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        tas_determine_haste_group()
        handle_equipping_gear(player.status)
    elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Engaged' then
        tas_determine_haste_group()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if state.Buff['Climactic Flourish'] then
        return 'CF'
    end

    return default_wsmode
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    tas_determine_haste_group()
end

function customize_idle_set(idleSet)
    if player.hpp < 80 and not areas.Cities:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

function customize_melee_set(meleeSet)
    if state.DefenseMode.value ~= 'None' then
        if buffactive['saber dance'] then
            meleeSet = set_combine(meleeSet, sets.buff['Saber Dance'])
        end
        if state.Buff['Climactic Flourish'] then
            meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
        end
    end
    
    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end
        
        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', ['..state.MainStep.current

    if state.UseAltStep.value == true then
        msg = msg .. '/'..state.AltStep.current
    end
    
    msg = msg .. ']'

    if state.SelectStepTarget.value == true then
        steps = steps..' (Targeted)'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doStep = ''
        if state.UseAltStep.value == true then
            doStep = state[state.CurrentStep.current..'Step'].current
            state.CurrentStep:cycle()
        else
            doStep = state.MainStep.current
        end        
        
        send_command('@input /ja "'..doStep..'" <t>')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function auto_presto(spell)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
        
        if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
            cast_delay(1.1)
            send_command('@input /ja "Presto" <me>')
        end
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(3, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 20)
    elseif player.sub_job == 'SAM' then
        set_macro_page(2, 20)
    else
        set_macro_page(5, 20)
    end
end
