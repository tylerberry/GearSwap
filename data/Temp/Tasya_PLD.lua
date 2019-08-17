-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    include('Tasya-Lib.lua')
	include('Tasya-Timers.lua')

    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')
    
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
    
	event_list = L{}
    event_list:append(windower.register_event('mpp change', tas_fucho_no_obi))
    
    update_defense_mode()
	tas_reset_timers()
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
    state.CastingMode:options('Normal', 'Resistant')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    gear.AlternateIdleBelt = "Flume Belt +1"

    select_default_macro_book()
end

-- Load job-specific keybinds.
function user_binds_on_load()
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')
end

-- Unload job-specific keybinds.
function user_binds_on_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
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
    
    sets.DarkAffinity = {head="Pixie Hairpin +1",ring1="Archon Ring"}

    sets.Enmity = {
        ammo="Iron Gobbet",
        head="Loess Barbuta +1",neck="Unmoving Collar +1",ear1="Friomisi Earring",ear2="Cryptic Earring",
        body="Souveran Cuirass",hands="Yorium Gauntlets",ring1="Apeile Ring +1",ring2="Apeile Ring",
        back="Weard Mantle",waist="Creed Baudrier",legs="Souveran Diechlings",feet=gear.EschiteGreaves.A}

    sets.MagicAttack = {
        ammo="Pemphredo Tathlum",
        head="Jumalik Helm",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Novio Earring",
        body="Founder's Breastplate",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs=gear.EschiteCuisses.D,feet="Founder's Greaves"}

    --sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    --==================================--
    -- Idle
    --==================================--

    sets.idle = {
        ammo="Homiliary",
        head="Jumalik Helm",neck="Coatl Gorget +1",ear1="Infused Earring",ear2="Dawn Earring",
        body="Jumalik Mail",hands="Sulevia's Gauntlets +1",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Solemnity Cape",waist=gear.IdleBelt,legs="Sulevia's Cuisses +1",feet="Amm Greaves"}

    --sets.idle.Town = {
    --    main="Anahera Sword",ammo="Sapience Orb",
    --    head="Reverence Coronet +1",neck="Creed Collar",ear1="Creed Earring",ear2="Bloodgem Earring",
    --    body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Sheltered Ring",ring2="Meridian Ring",
    --    back="Fierabras's Mantle",waist=gear.IdleBelt,legs="Crimson Cuisses",feet="Reverence Leggings +1"}

    --sets.idle.Weak = {
    --    ammo="Iron Gobbet",
    --    head="Reverence Coronet +1",neck="Creed Collar",ear1="Creed Earring",ear2="Bloodgem Earring",
    --    body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Sheltered Ring",ring2="Meridian Ring",
    --    back="Fierabras's Mantle",waist="Flume Belt +1",legs="Crimson Cuisses",feet="Reverence Leggings +1"}

    --sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)

    --==================================--
    -- Defense=
    --==================================--

    sets.defense.PDT = {
        ammo="Iron Gobbet",
        head="Sulevia's Mask +1",neck="Loricate Torque +1",
        body="Souveran Cuirass",hands="Sulevia's Gauntlets +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Weard mantle",waist="Flume Belt +1",legs="Souveran Diechlings",feet="Souveran Schuhs"}

    --sets.defense.Reraise = {ammo="Iron Gobbet",
    --    head="Twilight Helm",neck="Loricate Torque +1",ear1="Creed Earring",ear2="Bloodgem Earring",
    --    body="Twilight Mail",hands="Reverence Gauntlets +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
    --    back="Weard Mantle",waist="Nierenschutz",legs="Reverence Breeches +1",feet="Reverence Leggings +1"}

    --sets.defense.Charm = {ammo="Iron Gobbet",
    --    head="Reverence Coronet +1",neck="Lavalier +1",ear1="Creed Earring",ear2="Buckler Earring",
    --    body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
    --    back="Shadow Mantle",waist="Flume Belt",legs="Reverence Breeches +1",feet="Reverence Leggings +1"}

    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {
        ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Loricate Torque +1",
        body="Reverence Surcoat +1",hands="Odyssean Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
        back="Solemnity Cape",waist="Nierenschutz",legs="Sulevia's Cuisses +1",feet="Eschite Greaves"}

    --==================================--
    -- Resting
    --==================================--

    sets.resting = set_combine(sets.defense.PDT, {
        ammo="Homiliary",
        head="Jumalik Helm",neck="Coatl Gorget +1",ear1="Infused Earring",ear2="Dawn Earring",
        body="Jumalik Mail",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        waist=gear.IdleBelt})

    --==================================--
    -- Engaged - Single Weapon
    --==================================--

    sets.engaged = {
        ammo="Ginsen",
        head="Sulevia's Mask +1",neck="Combatant's Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Founder's Breastplate",hands="Sulevia's Gauntlets +1",ring1="Hetairoi Ring",ring2="Petrov Ring",
        back="Bleating Mantle",waist="Sailfi Belt +1",legs="Sulevia's Cuisses +1",feet="Valorous Greaves"}

    sets.engaged.Acc = set_combine(sets.engaged, {
        ear2="Dignitary's Earring",ring1="Cacoethic Ring +1",back="Grounded Mantle +1"})

    sets.engaged.PDT = set_combine(sets.engaged, {
        head="Sulevia's Mask +1",neck="Loricate Torque +1",
        body="Souveran Cuirass",hands="Sulevia's Gauntlets +1",ring1="Defending Ring",
        back="Weard Mantle",waist="Tempus Fugit",legs="Sulevia's Cuisses +1",feet="Amm Greaves"})
        
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        head="Sulevia's Mask +1",neck="Loricate Torque +1",
        body="Souveran Cuirass",hands="Sulevia's Gauntlets +1",ring1="Defending Ring",
        back="Weard Mantle",waist="Tempus Fugit",legs="Sulevia's Cuisses +1"})
        
    --sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    --sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    --==================================--
    -- Engaged - Dual Wield
    --==================================--
    
    if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
        sets.engaged.DW = set_combine(sets.engaged, {ear1="Suppanomimi",ear2="Eabani Earring",legs=gear.CarmineCuissesPlus1.D}) -- Reiki Yotai, Shetal Stone

        sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
            ring1="Cacoethic Ring +1",back="Grounded Mantle +1"})

        sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {body="Reverence Surcoat +1",neck="Loricate Torque +1",ring1="Defending Ring"})
        sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {body="Reverence Surcoat +1",neck="Loricate Torque +1",ring1="Defending Ring"})
        sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
        sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)
    end

    --==================================--
    -- Job Abilities
    --==================================--

    sets.precast.JA['Cover'] = {head="Reverence Coronet +1"}
    --sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +2"}
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity, {body="Caballarius Surcoat +1"})
    sets.precast.JA['Holy Circle'] = sets.Enmity -- set_combine(sets.Enmity, {feet="Reverence Leggings +1"})
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity, {legs="Caballarius Breeches +1"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity, {head="Caballarius Coronet +1"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, {feet="Caballarius Leggings +1"})
    sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Caballarius Gauntlets +1"})

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = set_combine(sets.Enmity, {
        head="Reverence Coronet +1",
        body="Reverence Surcoat +1",hands="Leyline Gloves",ring1="Rufescent Ring",
        back="Weard Mantle",legs="Sulevia's Cuisses +1",feet="Sulevia's Leggings +1"})

    if player.sub_job == 'DNC' then
        sets.precast.Flourish1 = {waist="Chaac Belt"}
        
        sets.precast.Step = {waist="Chaac Belt"}
    
        -- Waltz set (chr and vit)
        --sets.precast.Waltz = {ammo="Sonia's Plectrum",
        --    head="Reverence Coronet +1",
        --    body="Gorney Haubert +1",hands="Reverence Gauntlets +1",ring2="Asklepian Ring",
        --    back="Iximulew Cape",waist="Caudata Belt",legs="Reverence Breeches +1",feet="Whirlpool Greaves"}

        -- Don't need any special gear for Healing Waltz.
        sets.precast.Waltz['Healing Waltz'] = {}
    end

    if player.sub_job == 'WAR' then
        sets.precast.JA['Provoke'] = sets.Enmity
    end

    --==================================--
    -- Weaponskills
    --==================================--

    sets.precast.WS = {
        ammo="Floestone",
        head="Sulevia's Mask +1",neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's Gauntlets +1",ring1="Ifrit Ring +1",ring2="Ifrit Ring +1",
        back="Bleating Mantle",waist="Metalsinger Belt",legs="Sulevia's Cuisses +1",feet="Sulevia's Leggings +1"}

    sets.precast.WS.DEX = {
        ammo="Jukukik Feather",
        head="Sulevia's Mask +1",neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Sulevia's Platemail +1",hands="Sulevia's Gauntlets +1",ring1="Hetairoi Ring",ring2="Ramuh Ring +1",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs=gear.LustratioSubligar.B,feet="Sulevia's Leggings +1"}
    
    sets.precast.WS.Magic = sets.MagicAttack
    
    --------------------------------------
	-- Dagger
    --------------------------------------
    
    -- Wasp Sting: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.
    sets.precast.WS['Wasp Sting'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Belt"})
    
    -- Gust Slash: magical, wind-ele., 40% DEX 40% INT, 1.0/2.0/3.5 fTP.
    sets.precast.WS['Gust Slash'] = sets.precast.WS.Magic
    
    -- Shadowstitch: physical 1-hit, 100% CHR, 1.0 fTP, TP affects chance to bind.
    sets.precast.WS['Shadowstitch'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
    
    -- Viper Bite: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.
    sets.precast.WS['Viper Bite'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Belt"})
    
    -- Cyclone: magical AOE, wind-ele., 40% DEX 40% INT, 1.0/2.375/2.875 fTP.
    sets.precast.WS['Cyclone'] = sets.precast.WS.Magic
    sets.precast.WS['Cyclone'].TH = set_combine(sets.precast.WS['Cyclone'], {waist="Chaac Belt"})
    
    -- Energy Steal: steals MP, affected by MND and TP.
    sets.precast.WS['Energy Steal'] = {ear2="Moonshade Earring"}
    
    -- Energy Drain: steals MP, affected by MND and TP.
    sets.precast.WS['Energy Drain'] = {ear2="Moonshade Earring"}
    
    -- Aeolian Edge: magical AOE, wind-ele., 40% DEX 40% INT, 2.0/3.0/4.5 fTP.
    sets.precast.WS['Aeolian Edge'] = sets.precast.WS.Magic
    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], {waist="Chaac Belt"})

    --------------------------------------
    -- Sword
    --------------------------------------

    -- Fast Blade: physical 2-hit, 40% STR 40% DEX, 1.0/1.5/2.0 fTP.
    sets.precast.WS['Fast Blade'] = set_combine(sets.precast.WS.DEX, {ear1="Ishvara Earring",ear2="Moonshade Earring"})

    -- Burning Blade: magical fire-ele., 40% STR 40% INT, 1.0/2.098/3.398 fTP.
    sets.precast.WS['Burning Blade'] = set_combine(sets.precast.WS.Magic, {ear2="Moonshade Earring"})

    -- Red Lotus Blade: magical fire-ele., 40% STR 40% INT, 1.0/2.383/3.75 fTP.
    sets.precast.WS['Burning Blade'] = set_combine(sets.precast.WS.Magic, {ear2="Moonshade Earring"})

    -- Flat Blade: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to stun.
    sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})

    -- Shining Blade: magical light-ele., 40% STR 40% MND, 1.125/2.223/3.523 fTP.
    sets.precast.WS['Shining Blade'] = set_combine(sets.precast.WS.Magic, {
        ear2="Moonshade Earring",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1"})

    -- Seraph Blade: magical light-ele., 40% STR 40% MND, 1.125/2.625/4.125 fTP.
    sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS.Magic, {
        ear2="Moonshade Earring",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1"})

    -- Circle Blade: physical 1-hit AOE, 100% STR, 1.0 fTP, TP affects AOE radius.
    sets.precast.WS['Circle Blade'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Belt"})

    -- Spirits Within: breath damage, no stat modifier, damage determined only by current HP and TP.
    sets.precast.WS['Spirits Within'] = {ear2="Moonshade Earring"}

    -- Vorpal Blade: physical 4-hit, 60% STR, 1.375 fTP, TP affects chance to crit.
    sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",
        back="Rancorous Mantle",waist="Fotia Belt",feet="Thereoid Greaves"})
        
    -- Swift Blade: physical 3-hit, 50% STR 50% MND, 1.5 fTP, TP affects accuracy.
    sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ring1="Rufescent Ring",waist="Fotia Belt"})

    -- Savage Blade: physical 2-hit, 50% MND 50% STR, 4.0/10.25/13.75 fTP.
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ear1="Ishvara Earring",ear2="Moonshade Earring",ring1="Rufescent Ring"})

    -- Sanguine Blade: magical dark-ele., 50% MND 30% STR, 2.75 fTP, TP affects HP drain.
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.Magic, sets.DarkAffinity)

    -- Requiescat: physical 5-hit non-elemental, 73~85% MND, fTP 1.0, TP affects attack power.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",
        hands=gear.DespairFingerGauntlets.B,ring1="Leviathan Ring +1",ring2="Leviathan Ring +1",
        waist="Fotia Belt",legs="Founder's Hose"})

    -- Atonement: physical 2-hit, 1.0/1.5/2.0 fTP, damage modified by enmity, TP affects enmity modifier.
    sets.precast.WS['Atonement'] = set_combine(sets.Enmity, {
        neck="Fotia Gorget",ear1="Moonshade Earring",waist="Fotia Belt"})

    -- Chant du Cygne: physical 3-hit, 80% DEX, 2.25 fTP, TP affects chance to crit.
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear2="Moonshade Earring",
        back="Rancorous Mantle",waist="Fotia Belt",feet="Thereoid Greaves"})

    --==================================--
    -- Fast Cast
    --==================================--

    sets.precast.FC = {
        ammo="Impatiens",
        head=gear.CarmineMaskPlus1.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.OdysseanChestplate.FC,hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
        legs="Enif Cosciales",feet="Odyssean Greaves"}
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear1="Mendicant's Earring",ear2="Nourishing Earring +1",body="Jumalik Mail"})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    --==================================--
    -- Midcast
    --==================================--

    sets.midcast.FastRecast = {
        ammo="Sapience Orb",
        head=gear.CarmineMaskPlus1.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.OdysseanChestplate.FC,hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        waist="Ninurta's Sash",legs="Enif Cosciales",feet="Odyssean Greaves"}

    --==================================--
    -- Dark Magic
    --==================================--

    sets.midcast.Stun = sets.Enmity

    --==================================--
    -- Divine Magic
    --==================================--

    sets.midcast['Divine Magic'] = sets.midcast.FastRecast
    
    sets.midcast.Flash = set_combine(sets.Enmity, {legs="Enif Cosciales"})
    
    sets.midcast.Holy = set_combine(sets.MagicAttack, {
        ring1="Fenrir Ring +1",ring2="Fenrir Ring +1"})
    
	sets.midcast.Reprisal = {
        head="Baghere Salade",neck="Sanctity Necklace",ear1="Cryptic Earring",
        body="Souveran Cuirass",hands="Souveran Handschuhs",
        back="Aenotherus Mantle",waist="Creed Baudrier",legs="Souveran Diechlings",feet="Souveran Schuhs"}

    --==================================--
    -- Enhancing Magic
    --==================================--

    --sets.midcast['Enhancing Magic'] = {neck="Incanter's Torque",waist="Olympus Sash",legs="Reverence Breeches +1"}
    
    sets.midcast.Crusade = sets.midcast.EnhancingDuration

    sets.midcast.Phalanx = {hands="Souveran Handschuhs",back="Weard Mantle",feet="Souveran Schuhs"}
    sets.midcast.Protect = {ring2="Sheltered Ring"}
    sets.midcast.Shell = {ring2="Sheltered Ring"}

    --==================================--
    -- Healing Magic
    --==================================--
    
    sets.midcast['Healing Magic'] = sets.midcast.FastRecast

    sets.midcast.Cure = {
        ammo="Iron Gobbet",
        head="Yorium Barbuta",neck="Phalaina Locket",ear1="Mendicant's Earring",ear2="Nourishing Earring",
        body="Jumalik Mail",hands="Macabre Gauntlets +1",ring1="Rufescent Ring",ring2="Asklepian Ring",
        back="Solemnity Cape",waist="Asklepian Belt",legs="Souveran Diechlings",feet="Souveran Schuhs"}

    --==================================--
    -- Active Buffs
    --==================================--

    sets.buff.Doom = {waist="Gishdubar Sash"}
    --sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat +1"}

    --==================================--
    -- Miscellaneous Sets
    --==================================--

    sets.WSDayBonus = {head="Gavialis Helm"}
    sets.Kiting = {legs=gear.CarmineCuissesPlus1.D}
    sets.LugraEarrings = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
    sets.LugraMoonshade = {ear1="Lugra Earring +1",ear2="Moonshade Earring"}

    --------------------------------------
    -- Miscellaneous Defense Sets
    --------------------------------------

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Impassive Mantle"}
    --sets.MP = {neck="Creed Collar",waist="Flume Belt +1"}
    --sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt +1",back="Impassive Mantle"}

    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {sub="Ochain"}
    sets.MagicalShield = {sub="Beatific Shield +1"} --{sub="Aegis"}

    --==================================--
    -- Organizer Items
    --==================================--

    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
        tanmogayi="Tanmogayi +1",
        brilliance="Brilliance",
    
        fucho_no_obi="Fucho-no-Obi",
        
        echos="Echo Drops",
        sushi="Sublime Sushi"}
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
    if spell.type == 'WeaponSkill' then
        LugraWSList = S{'Wasp Sting','Viper Bite',
            'Fast Blade','Flat Blade','Circle Blade','Vorpal Blade','Swift Blade','Chant du Cygne'}
        LugraMoonshadeWSList = S{'Shadowstitch','Savage Blade'}
    
        if world.time >= (17*60) or world.time < (7*60) then
            if LugraWSList:contains(spell.english) then
                equip(sets.LugraEarrings)
            elseif LugraMoonshadeWSList:contains(spell.english) then
                equip(sets.LugraMoonshade)
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast choices.

    -- Precast is allowed through for fast cast on spells, but we want to return to def gear before there's time
    -- for anything to hit us.

    -- Exclude Job Abilities from this restriction, as we probably want the enhanced effect of whatever item of
    -- gear applies to them, and only one item should be swapped out.

    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
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
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)

    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.LatentRefresh)
    end

    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end

    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end

    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end

    return defenseSet
end


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
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end

    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end

    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    -- Relic shields and ilvl 119 shields without 'Shield' in the name.
    local one_word_shields = S{'Ochain','Aegis','Srivatsa','Priwen','Ajax','Ajax +1','Deliverance','Deliverance +1',
        'Evalach','Evalach +1','Forfend','Forfend +1'}

    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and not player.equipment.sub:contains('Ecu') and
           not one_word_shields:contains(player.equipment.sub) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    else
        state.CombatForm:reset()
    end
end

function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 4)
    end
end