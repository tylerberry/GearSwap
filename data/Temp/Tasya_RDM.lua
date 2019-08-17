-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
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
    include('Mote-TreasureHunter.lua')

    event_list = L{}
	event_list:append(windower.register_event('mpp change',tas_fucho_no_obi))
    
    state.Buff.Saboteur = buffactive.saboteur or false

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
    event_list:map(windower.unregister_event)
    event_list:clear()
end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')

    state.TreasureMode:set('Tag')
    
    gear.AlternateIdleBelt = "Flume Belt +1"

    Shields = S{"Genbu's Shield"}

    update_combat_form()
    select_default_macro_book()
end

-- Load job-specific keybinds.
function user_binds_on_load()
    send_command('bind @` gs c toggle MagicBurst')
end

-- Unload job-specific keybinds.
function user_binds_on_unload()
    send_command('unbind ^`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    --==================================--
    -- Augmented gear and base sets
    --==================================--

    include('Tasya-Gear.lua')
    tas_shared_augmented_gear()

    sets.MagicAccuracy = {
        main="Lehbrailg +2",sub="Mephitis Grip",range="Aureole",
        head=gear.CarmineMask1.D,neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Atrophy Tabard +1",hands=gear.ChironicGloves.MAB,ring1="Leviathan Ring +1",ring2="Sangoma Ring",
        back="Aurist's Cape +1",waist=gear.IdleBelt,legs=gear.ChironicHose.MAB,feet="Vitivation Boots +1"}

    --==================================--
    -- Idle
    --==================================--

    sets.idle.Field = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Homiliary",
        head="Vitivation Chapeau +1",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Witching Robe",hands="Serpentes Cuffs",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Lengo Pants",feet="Serpentes Sabots"}

    sets.idle.Town = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Homiliary",
        head="Vitivation Chapeau +1",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Witching Robe",hands="Serpentes Cuffs",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Lengo Pants",feet="Serpentes Sabots"}

    sets.idle.Weak = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Homiliary",
        head="Vitivation Chapeau +1",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Ethereal Earring",
        body="Hagondes Coat +1",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Lengo Pants",feet="Serpentes Sabots"}

    --==================================--
    -- Defense
    --==================================--

    sets.defense.PDT = {
        ammo="Homiliary",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Ethereal Earring",
        body="Hagondes Coat +1",hands="Umuthi Gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Shadow Mantle",waist="Flume Belt +1",legs="Hagondes Pants +1",feet="Hagondes Sabots +1"}

    sets.defense.MDT = {
        ammo="Homiliary",
        head="Atrophy Chapeau +1",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Ethereal Earring",
        body="Hagondes Coat +1",hands="Vitivation Gloves +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape +1",waist="Flume Belt +1",legs="Atrophy Tights +1",feet="Hagondes Sabots +1"}

    --==================================--
    -- Resting
    --==================================--

    sets.resting = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Homiliary",
        head="Vitivation Chapeau +1",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Witching Robe",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Shadow Ring",
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Lengo Pants",feet="Serpentes Sabots"}

    --==================================--
    -- Engaged - Single Weapon
    --==================================--

    sets.FrontlineWeapons = {main=gear.NibiruBlade.A, sub="Genbu's Shield"}

    sets.engaged = {
        ammo="Ginsen",
        head=gear.TaeonChapeau.TA,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.TaeonTabard.TA,hands=gear.TaeonGloves.TA,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs=gear.TaeonTights.TA,feet=gear.TaeonBoots.TA}

    sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Jukukik Feather",neck="Combatant's Torque",back="Letalis Mantle"})

    sets.engaged.DT = set_combine(sets.engaged, {
        neck="Loricate Torque +1",
        body="Emet Harness +1",hands="Umuthi Gloves",ring2="Defending Ring"})

    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, {
        neck="Loricate Torque +1",
        body="Emet Harness +1",hands="Umuthi Gloves",ring2="Defending Ring"})

    --==================================--
    -- Engaged - Dual Wield
    --==================================--
    
    sets.FrontlineWeapons.DW = {main="Buramenk'ah", sub=gear.NibiruBlade.A}

    sets.engaged.DW = set_combine(sets.engaged, {ear1="Brutal Earring",ear2="Suppanomimi"})

    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {ear1="Brutal Earring",ear2="Suppanomimi"})

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
        neck="Loricate Torque +1",
        body="Emet Harness +1",hands="Umuthi Gloves",ring2="Defending Ring"})

    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, {
        neck="Loricate Torque +1",
        body="Emet Harness +1",hands="Umuthi Gloves",ring2="Defending Ring"})

    --==================================--
    -- Job Abilities
    --==================================--

    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard +1"}

    if player.sub_job == 'DNC' then
        -- Waltz set (chr and vit)
        sets.precast.Waltz = {
            ammo="Tsar Egg",
            head="Atrophy Chapeau +1",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Ethereal Earring",
            body="Atrophy Tabard +1",hands="Vitivation Gloves +1",ring1="Aqua Ring",ring2="Asklepian Ring",
            back="Kumbira Cape",waist="Fucho-no-Obi",legs="Atrophy Tights +1",feet="Vitivation Boots +1"}

        sets.precast.Waltz['Healing Waltz'] = {}
    end

    --==================================--
    -- Weaponskills
    --==================================--

    sets.precast.WS = {
        ammo="Floestone",
        head=gear.TaeonChapeau.TA,neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.TaeonTabard.TA,hands=gear.ChironicGloves.WSD,ring1="Ifrit Ring +1",ring2="Ifrit Ring +1",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs=gear.TaeonTights.TA,feet=gear.TaeonBoots.TA}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="Jukukik Feather",
        head=gear.CarmineMask1.D,neck="Combatant's Torque",
        back="Letalis Mantle"})
        
    sets.precast.WS.Magic = {
        }

    --------------------------------------
    -- Sword weapon skills
    --------------------------------------

    -- Fast Blade: physical 2-hit, 40% STR 40% DEX, 1.0/1.5/2.0 fTP.
    sets.precast.WS['Fast Blade'] = set_combine(sets.precast.WS.DEX, {ear1="Ishvara Earring",ear2="Moonshade Earring"})

    -- Burning Blade: magical fire-ele., 40% STR 40% INT, 1.0/2.098/3.398 fTP.
    sets.precast.WS['Burning Blade'] = set_combine(sets.precast.WS.DEX, {ear2="Moonshade Earring"})

    -- Red Lotus Blade: magical fire-ele., 40% STR 40% INT, 1.0/2.383/3.75 fTP.
    sets.precast.WS['Red Lotus Blade'] = sets.precast.WS.Magic

    -- Flat Blade: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to stun.
    sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Belt"})

    -- Shining Blade: magical light-ele., 40% STR 40% MND, 1.125/2.223/3.523 fTP.
    sets.precast.WS['Shining Blade'] = set_combine(sets.precast.WS.Magic, {ear2="Moonshade Earring"})

    -- Seraph Blade: magical light-ele., 40% STR 40% MND, 1.125/2.625/4.125 fTP.
    sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS.Magic, {ear2="Moonshade Earring"})

    -- Circle Blade: physical 1-hit AOE, 100% STR, 1.0 fTP, TP affects AOE radius.
    sets.precast.WS['Circle Blade'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",waist="Fotia Belt"})

    -- Spirits Within: breath damage, no stat modifier, damage determined only by current HP and TP.
    sets.precast.WS['Spirits Within'] = {ear2="Moonshade Earring"}

    -- Vorpal Blade: physical 4-hit, 60% STR, 1.375 fTP, TP affects chance to crit.
    sets.precast.WS['Vorpal Blade'] = sets.precast.WS

    -- Savage Blade: physical 2-hit, 50% MND 50% STR, 4.0/10.25/13.75 fTP.
    sets.precast.WS['Savage Blade'] = sets.precast.WS

    -- Sanguine Blade: magical dark-ele., 50% MND 30% STR, 2.75 fTP, TP affects HP drain.
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.Magic, sets.DarkAffinity)

    -- Requiescat: physical 5-hit non-elemental, 73~85% MND, fTP 1.0, TP affects attack power.
    --sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Leviathan Ring",ring2="Aquasoul Ring"})
    --sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Leviathan Ring"})

    -- Chant du Cygne: physical 3-hit, 80% DEX, 2.25 fTP, TP affects chance to crit.
    --sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {hands="Buremte Gloves",waist="Zoran's Belt"})
    --sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {waist="Zoran's Belt"})

    -- Death Blossom: physical 3-hit, 30% STR 50% MND, 4.0 fTP, TP affects chance to lower magic evasion.
    sets.precast.WS['Death Blossom'] = sets.precast.WS

    --==================================--
    -- Fast Cast
    --==================================--

    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast. No other FC sets necessary.
    sets.precast.FC = {
        main="Emissary",sub="Genbu's Shield",ammo="Impatiens",
        head=gear.CarmineMask1.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Anhur Robe",hands="Gendewitha Gages +1",ring1="Lebeche Ring",ring2="Prolix Ring",
        back="Swith Cape",waist="Witful Belt",legs=gear.PsyclothLappas.D,feet="Chelona Boots +1"}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

    --==================================--
    -- Midcast
    --==================================--

    sets.midcast.FastRecast = {
        main="Emissary",sub="Genbu's Shield",ammo="Vanir Battery",
        head=gear.CarmineMask1.D,neck="Orunmila's Torque",ear1="Estoqueur's Earring",ear2="Ethereal Earring",
        body="Vitivation Tabard +1",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2="Prolix Ring",
        back="Shadow Mantle",waist="Witful Belt",legs=gear.PsyclothLappas.D,feet="Chelona Boots +1"}

    --==================================--
    -- Dark Magic
    --==================================--

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",sub="Genbu's Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Atrophy Tabard +1",hands="Hagondes Cuffs +1",ring1="Sangoma Ring",ring2="Shiva Ring +1",
        back="Aurist's Cape +1",waist="Eschan Stone",legs=gear.MerlinicShalwar.MAB,feet="Vitivation Boots +1"}

    sets.midcast.Aspir = set_combine(sets.midcast.DarkMagic, {belt="Fucho-no-Obi"})
    
    sets.midcast['Bio III'] = {legs="Vitivation Tights +1"}
    sets.midcast.Drain = sets.midcast.Aspir
    
    sets.midcast.Stun = {
        main=gear.Grioavolr.MAB,sub="Niobid Strap",ammo="Pemphredo Tathlum",
        head=gear.CarmineMask1.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Vitivation Tabard +1",hands=gear.ChironicGloves.MAB,ring1="Prolix Ring",ring2="Sangoma Ring",
        back="Swith Cape",waist="Witful Belt",legs=gear.MerlinicShalwar.MAB,feet=gear.MerlinicCrackows.MAB}
    
    if player.sub_job == 'SCH' then
        sets.midcast.Klimaform = sets.midcast.FastRecast
    end

    --==================================--
    -- Divine Magic
    --==================================--
    
    

    --==================================--
    -- Elemental Magic
    --==================================--
    
    gear.default.obi_waist = "Refocillation Stone"

    sets.midcast['Elemental Magic'] = {
	    main=gear.Grioavolr.MAB,sub="Niobid Strap",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Novio Earring",
        body=gear.AmalricDoublet.A,hands=gear.AmalricGages.D,ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist=gear.ElementalObi,legs=gear.MerlinicShalwar.MAB,feet=gear.MerlinicCrackows.MAB}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        neck="Sanctity Necklace",
        waist="Eschan Stone"})

    sets.midcast.ElementalEnfeeble = {
        main=gear.Grioavolr.MAB,sub="Niobid Strap",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body=gear.VanyaRobe.C,hands=gear.ChironicGloves.MAB,ring1="Sangoma Ring",ring2="Shiva Ring +1",
        back="Aurist's Cape +1",waist="Wanion Belt",legs=gear.MerlinicShalwar.MAB,feet=gear.MerlinicCrackows.MAB}

    sets.midcast.Impact = set_combine(sets.midcast['ElementalEnfeeble'], {head=empty,body="Twilight Cloak"})

    --==================================--
    -- Enfeebling Magic
    --==================================--

    sets.midcast['Enfeebling Magic'] = {
        main=gear.Grioavolr.MAB,sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head=gear.CarmineMask1.D,neck="Imbodla Necklace",ear1="Dignitary's Earring",ear2="Gwati Earring",
        body="Atrophy Tabard +1",hands="Hagondes Cuffs +1",ring1="Sangoma Ring",ring2="Leviathan Ring +1",
        back="Aurist's Cape +1",waist="Eschan Stone",legs=gear.ChironicHose.MAB,feet="Vitivation Boots +1"}

    sets.midcast['Dia III'] = {head="Vitivation Chapeau +1"}0

    sets.midcast['Diaga'] = set_combine(sets.midcast.EnfeeblingMagic, {waist="Chaac Belt"})

    sets.midcast.MNDAccuracy = {
        main=gear.Grioavolr.MAB,sub="Mephitis Grip",ammo="Quartz Tathlum +1",
        head=gear.CarmineMask1.D,neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body=gear.VanyaRobe.C,hands="Hagondes Cuffs +1",ring1="Leviathan Ring +1",ring2="Leviathan Ring +1",
        back="Aurist's Cape +1",waist="Eschan Stone",legs=gear.ChironicHose.MAB,feet="Vitivation Boots +1"}

    sets.midcast.MNDPotency = {
        main=gear.Grioavolr.MAB,sub="Mephitis Grip",ammo="Quartz Tathlum +1",
        head=gear.CarmineMask1.D,neck="Imbodla Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Estoqueur's Sayon +2",hands="Hagondes Cuffs +1",ring1="Leviathan Ring +1",ring2="Leviathan Ring +1",
        back="Aurist's Cape +1",waist="Eschan Stone",legs=gear.ChironicHose.MAB,feet="Uk'uxkaj Boots"}

    sets.midcast['Paralyze II'] = set_combine(sets.midcast.MNDPotency, {feet="Vitivation Boots +1"})
    sets.midcast['Slow II'] = set_combine(sets.midcast.MNDPotency, {head="Vitivation Chapeau +1"})
        
    sets.midcast.INTAccuracy = {
        main=gear.Grioavolr.MAB,sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head=gear.CarmineMask1.D,neck="Orunmila's Torque",ear1="Estoqueur's Earring",ear2="Enchntr. Earring +1",
        body=gear.VanyaRobe.C,hands="Gende. Gages +1",ring1="Prolix Ring",ring2="Shiva Ring +1",
        back="Aurist's Cape +1",waist="Eschan Stone",legs=gear.ChironicHose.MAB,feet="Vitivation Boots +1"}

    sets.midcast.INTPotency = {
        main=gear.Grioavolr.MAB,sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head=gear.CarmineMask1.D,neck="Imbodla Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Estoqueur's Sayon +2",hands="Hagondes Cuffs +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Aurist's Cape +1",waist="Eschan Stone",legs=gear.ChironicHose.MAB,feet="Uk'uxkaj Boots"}
        
    sets.midcast['Blind II'] = set_combine(sets.midcast.MNDPotency, {legs="Vitivation Tights +1"})

    --==================================--
    -- Enhancing Magic
    --==================================--

    sets.midcast.EnhancingDuration = set_combine(sets.midcast.FastRecast, {
        head=gear.TelchineCap.Enh,
        body=gear.TelchineChasuble.Enh,hands="Atrophy Gloves +1",
        back="Estoqueur's Cape",legs=gear.TelchineBraconi.Enh,feet=gear.TelchinePigaches.Enh})

    sets.midcast.EnhancingSkill = set_combine(sets.midcast.FastRecast, {
        head="Befouled Crown",neck="Incanter's Torque",ear1="Augmenting Earring",ear2="Andoaa Earring",
        body="Vitivation Tabard +1",hands="Atrophy Gloves +1",ring1="Prolix Ring",ring2="Defending Ring",
        back="Fi Follet Cape +1",waist="Olympus Sash",legs="Atrophy Tights +1",feet="Estoqueur's Houseaux +2"})

    -- Default set is duration, since most enhancing spells don't actually use skill.
    sets.midcast['Enhancing Magic'] = sets.midcast.EnhancingDuration

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.ChironicHat.MAB,legs="Shedir Seraweels"})

    sets.midcast.BarElement = sets.midcast.EnhancingSkill
    sets.midcast.Enspell = sets.midcast.EnhancingSkill
    sets.midcast.Gain = sets.midcast.EnhancingSkill
    
    sets.midcast.Phalanx = sets.midcast.EnhancingSkill
    sets.midcast['Phalanx II'] = set_combine(sets.midcast.EnhancingSkill, {hands="Vitivation Gloves +1"})

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {legs="Estoqueur's Fuseau +2"})

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",sub="Genbu's Shield"})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Stone Gorget",ear2="Earthcry Earring",
        hands="Stone Mufflers",
        waist="Siegel Sash",legs="Shedir Seraweels"})
    
    sets.midcast.Temper = sets.midcast.EnhancingSkill

    sets.ComposureOther = {
        head="Estoqueur's Chappel +2",
        body="Estoqueur's Sayon +2",hands="Atrophy Gloves +1",
        back="Estoqueur's Cape",legs="Estoqueur's Fuseau +2",feet="Estoqueur's Houseaux +2"}
    
    if player.sub_job == 'SCH' then
        sets.midcast.Storm = sets.midcast.EnhancingDuration
    end

    --==================================--
    -- Healing Magic
    --==================================--

    sets.midcast.FrontlineCure = {
        ammo="Esper Stone +1",
        head="Gendewitha Caubeen +1",neck="Incanter's Torque",ear1="Estoqueur's Earring",ear2="Ethereal Earring",
        body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Prolix Ring",ring2="Asklepian Ring",
        back="Fi Follet Cape +1",waist="Ninurta's Sash",legs="Atrophy Tights +1",feet="Estoqueur's Houseaux +2"}

    sets.midcast.BacklineCure = {
        main="Tamaxchi",sub="Genbu's Shield",ammo="Esper Stone +1",
        head="Gendewitha Caubeen +1",neck="Incanter's Torque",ear1="Estoqueur's Earring",ear2="Novia Earring",
        body="Heka's Kalasiris",hands="Gendewitha Gages +1",ring1="Prolix Ring",ring2="Sirona's Ring",
        back="Fi Follet Cape +1",waist="Ninurta's Sash",legs="Atrophy Tights +1",feet="Estoqueur's Houseaux +2"}

    sets.midcast.StatusRemoval = sets.midcast.FastRecast
    
    sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {
        ring1="Haoma's Ring",ring2="Haoma's Ring",feet="Gendewitha Galoshes +1"})

    --==================================--
    -- Active Buffs
    --==================================--

    sets.buff.Saboteur = {hands="Estoqueur's Gantherots +2"}

    --==================================--
    -- Miscellaneous Sets
    --==================================--

    sets.Kiting = {legs="Carmine Cuisses +1"}
5
    --==================================--
    -- Organizer Items
    --==================================--

    organizer_items = {
        buramenkah="Buramenk'ah",
        
        hachirin_no_obi="Hachirin-no-Obi",
        refocillation_stone="Refocillation Stone",
    
        echos="Echo Drops"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        -- Default base equipment layer of fast recast.
        equip(sets.midcast.FastRecast)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        if buffactive.composure and spell.target.type ~= 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = true
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    MNDPotencySpells = S{'Paralyze', 'Paralyze II', 'Slow', 'Slow II', 'Addle', 'Addle II'}
    INTAccuracySpells = S{'Sleep', 'Sleep II', 'Sleepga', 'Break', 'Bind', 'Dispel', 'Gravity', 'Gravity II'}
    EnfPotencySpells = S{'Poison', 'Poison II', 'Poisonga', 'Distract', 'Distract II', 'Distract III', 'Frazzle', 'Frazzle II', 'Frazzle III'}
    
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') then
            if state.OffenseMode == 'None' then
                return "BacklineCure"
            else
                return "FrontlineCure"
            end
        elseif MNDPotencySpells:contains(spell.english) then
            return 'MNDPotency'
        elseif spell.english == 'Silence' then
            return 'MNDAccuracy'
        elseif spell.english:startswith('Blind') then
            return 'INTPotency'
        elseif INTAccuracySpells:contains(spell.english) then
            return 'INTAccuracy'
        elseif EnfPotencySpells:contains(spell.english) then
            return 'EnfPotency'
        elseif spell.english:startswith('Dia')
            return 'Dia'
        elseif spell.english:startswith('En') then
            return 'Enspell'
        elseif spell.english:startswith('Gain') then
            return 'Gain'
        elseif IceSpells:contains(spell.english) then
            return 'Blizzard'
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    th_update(cmdParams, eventArgs)
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.FrontlineWeapons.DW)
            else
                equip(sets.FrontlineWeapons)
            end
            disable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select DW combat form as appropriate
function update_combat_form()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub == 'empty' or Shields:contains(player.equipment.sub) then
            state.CombatForm:reset()
        else
            state.CombatForm:set('DW')
        end
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'BLM' then
        set_macro_page(2, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 5)
    elseif player.sub_job == 'DNC' then
        set_macro_page(5, 5)
    elseif player.sub_job == 'DRK' then
        set_macro_page(7, 5)
    elseif player.sub_job == 'PLD' then
        set_macro_page(8, 5)
    else
        set_macro_page(1, 5)
    end
end
