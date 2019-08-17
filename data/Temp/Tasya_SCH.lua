-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
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
	include('Tasya-Timers.lua')
    
    state.MagicBurst = M(false, 'Magic Burst')

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
    
	event_list = L{}
    
	tas_reset_timers()
    update_active_strategems()
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
    state.OffenseMode:options('None', 'Locked')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT')
    
    event_list:append(windower.register_event('mpp change', tas_fucho_no_obi))

    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

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
	gear.default.obi_waist = "Refoccilation Stone"
    
    gear.BookwormsCape = {}
    gear.BookwormsCape.Regen = {name="Bookworm's Cape", augments={'INT+1','MND+3','Helix eff. dur. +14','"Regen" potency+10'}}

    gear.LughsCape = {}
    gear.LughsCape.MAB = {name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
    
    gear.Akademos = {}
    gear.Akademos.C = {name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15'}}
    gear.Akademos.D = {name="Akademos", augments={'Mag. Acc.+20','Enha.mag. skill +15','Enfb.mag. skill +15'}}
    
    sets.DarkAffinity = {head="Pixie Hairpin +1",ring1="Archon Ring"}
	
	sets.MagicAccuracy = {
        main=gear.Grioavolr.MAB,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Erra Pendant",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body=gear.MerlinicJubbah.MAB,hands=gear.ChironicGloves.MAB,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.LughsCape.MAB,waist="Rumination Sash",legs=gear.ChironicHose.MAB,feet="Medium's Sabots"}
    
    sets.MagicAttack = {
	    main=gear.Akademos.C,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Saevus Pendant +1",ear1="Friomisi Earring",ear2="Barkarole Earring",
        body=gear.AmalricDoubletPlus1.A,hands=gear.AmalricGagesPlus1.A,ring1="Shiva Ring +1",ring2="Freke Ring",
        back=gear.LughsCape.MAB,waist=gear.ElementalObi,legs=gear.AmalricSlopsPlus1.A,feet=gear.AmalricNailsPlus1.A}
    
    --==================================--
	-- Idle
    --==================================--

    sets.idle.Field = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Homiliary",
        head="Befouled Crown",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body=gear.AmalricDoubletPlus1.A,hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Assiduity Pants +1",feet="Serpentes Sabots"}

    sets.idle.Field.PDT = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Homiliary",
        head="Befouled Crown",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Hagondes Coat +1",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    sets.idle.Town = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Homiliary",
        head="Befouled Crown",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Witching Robe",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist=gear.IdleBelt,legs="Assiduity Pants +1",feet="Serpentes Sabots"}

    sets.idle.Weak = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Homiliary",
        head="Befouled Crown",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Hagondes Coat +1",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight Cape",waist=gear.IdleBelt,legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    --==================================--
	-- Defense
    --==================================--

    sets.defense.PDT = {
	    main=gear.Akademos.C,sub="Oneiros Grip",ammo="Homiliary",
        head="Gendewitha Caubeen +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Moonlight Cape",waist=gear.IdleBelt,legs="Hagondes Pants +1",feet="Gendewitha Galoshes +1"}

    sets.defense.MDT = {
	    main=gear.Akademos.C,sub="Oneiros Grip",ammo="Homiliary",
        head="Gendewitha Caubeen +1",neck="Warder's Charm +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Moonlight Cape",waist="Slipor Sash",legs="Hagondes Pants +1",feet="Gendewitha Galoshes +1"}
		
    sets.defense.Stun = {
	    main=gear.Akademos.C,sub="Oneiros Grip",ammo="Homiliary",
        head="Befouled Crown",neck="Warder's Charm +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Onca Suit",hands=empty,ring1="Defending Ring",ring2="Shadow Ring",
        back="Moonlight Cape",waist="Slipor Sash",legs=empty,feet=empty}
    
    --==================================--
	-- Resting
    --==================================--
	
	sets.resting = {
        main="Contemplator +1",sub="Oneiros Grip",ammo="Homiliary",
        head="Befouled Crown",neck="Eidolon Pendant +1",ear1="Dawn Earring",ear2="Ethereal Earring",
        body="Witching Robe",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
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

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants +1"}
	
    --==================================--
	-- Weaponskills
    --==================================--
    
    sets.precast.WS = {
        head=gear.ChironicHat.DA,neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Onca Suit",hands=empty,ring1="Ifrit Ring +1",ring2="Ifrit Ring +1",
        back="Aurist's Cape +1",waist="Windbuffet Belt +1",legs=empty,feet=empty}
        
    sets.precast.WS.Magic = sets.MagicAttack

    --------------------------------------
	-- Staff
    --------------------------------------
    
    -- Heavy Swing:
    
    -- Rock Crusher:
    
    -- Earth Crusher:
    
    -- Starburst:
    
    -- Sunburst:
    
    -- Shell Crusher:
    
    -- Full Swing:
    
    -- Spirit Taker:
    
    -- Retribution:
    
    -- Cataclysm:
    
    -- Shattersoul:
    
    -- Omniscience: magic, dark-ele., 80% MND, 2.0 fTP, duration of -ATK varies with TP.
    sets.precast.WS['Omniscience'] = set_combine(sets.precast.WS.Magic, sets.DarkAffinity)
    
    -- Myrkr: restores MP and removes status effects. MP restoration scales with max MP and TP.
	sets.precast.WS['Myrkr'] = {
	    ammo="Ghastly Tathlum +1",
	    head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Moonshade Earring",
		body=gear.AmalricDoubletPlus1.A,hands=gear.TelchineGloves.FCandEnh,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs=gear.AmalricSlopsPlus1.A,feet="Arbatel Loafers +1"}

    --==================================--
	-- Fast Cast
    --==================================--

    sets.precast.FC = {
	    main=gear.Grioavolr.MAB,sub="Clerisy Strap +1",ammo="Impatiens",
        head=gear.VanyaHood.A,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Anhur Robe",hands="Gendewitha Gages +1",ring1="Prolix Ring",ring2="Lebeche Ring",
        back="Perimede Cape",waist="Witful Belt",legs=gear.PsyclothLappas.D,feet="Regal Pumps +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris",feet=gear.VanyaClogs.D})
    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    --==================================--
	-- Midcast
    --==================================--

    sets.midcast.FastRecast = {
        main=gear.Grioavolr.MAB,sub="Clerisy Strap +1",ammo="Sapience Orb",
        head=gear.VanyaHood.D,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.MerlinicJubbah.MAB,hands="Gendewitha Gages +1",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs=gear.PsyclothLappas.D,feet="Regal Pumps +1"}

	--==================================--
	-- Dark Magic
    --==================================--
	
    sets.midcast['Dark Magic'] = {
        main="Rubicundity",sub="Genbu's Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body=gear.MerlinicJubbah.MAB,hands=gear.ChironicGloves.MAB,ring1="Archon Ring",ring2="Evanescence Ring",
        back=gear.LughsCape.MAB,waist="Ninurta's Sash",legs=gear.ChironicHose.MAB,feet="Medium's Sabots"}

    sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], {
        ear1="Dignitary's Earring",ear2="Hirudinea Earring",
        body=gear.MerlinicJubbah.DrainAspir,
        waist="Fucho-no-Obi",feet=gear.MerlinicCrackows.MAB})
        
    sets.midcast.Drain = sets.midcast.Aspir
	
    sets.midcast.Kaustra = set_combine(sets.MagicAttack, {
        head="Pixie Hairpin +1",neck="Baetyl Pendant",
        ring1="Archon Ring"})
        
    sets.midcast.Klimaform = sets.midcast.FastRecast

    sets.midcast.Stun = {
        main=gear.Grioavolr.MAB,sub="Enki Strap",ammo="Pemphredo Tathlum", -- main="Apamajas II"
        head=gear.VanyaHood.D,neck="Incanter's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body=gear.MerlinicJubbah.MAB,hands=gear.ChironicGloves.MAB,ring1="Stikini Ring +1",ring2="Evanescence Ring",
        back="Aurist's Cape +1",waist="Witful Belt",legs=gear.ChironicHose.MAB,feet="Medium's Sabots"}

    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {main=gear.Grioavolr.MAB})

	--==================================--
	-- Elemental Magic
    --==================================--
	
    sets.midcast['Elemental Magic'] = sets.MagicAttack

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
	    main=gear.Grioavolr.MAB,sub="Enki Strap",neck="Sanctity Necklace",back=gear.BookwormsCape.Regen,waist="Eschan Stone"})

    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {
        main="Terra's Staff",sub="Mephitis Grip",ammo="Ombre Tathlum +1",
        head="Befouled Crown",neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body=gear.VanyaRobe.C,hands="Hagondes Cuffs +1",ring1="Stikini Ring +1",ring2="Defending Ring",
        back="Kumbira Cape",waist="Rumination Sash",legs=gear.PsyclothLappas.D,feet="Medium's Sabots"}

    sets.midcast['Elemental Magic'].HighTierNuke = sets.midcast['Elemental Magic']
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = sets.midcast['Elemental Magic'].Resistant

    sets.midcast.ElementalEnfeeble = {
        main=gear.Akademos.D,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Imbodla Necklace",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body=gear.MerlinicJubbah.MAB,hands=gear.ChironicGloves.MAB,ring1="Shiva Ring +1",ring2="Freke Ring",
        back=gear.LughsCape.MAB,waist="Rumination Sash",gear.MerlinicShalwar.MAB,feet="Medium's Sabots"}

	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {
        sub="Enki Strap",waist="Refoccilation Stone"})
    
    sets.midcast.Noctohelix =  set_combine(sets.midcast.Helix, sets.DarkAffinity)
	
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, {
        head=empty,ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Twilight Cloak",hands=gear.ChironicGloves.MAB,ring1="Stikini Ring +1"})

	--==================================--
	-- Enfeebling Magic
    --==================================--
	
    sets.midcast['Enfeebling Magic'] = {
        main=gear.Akademos.D,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Imbodla Necklace",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body=gear.VanyaRobe.C,hands=gear.ChironicGloves.MAB,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.LughsCape.MAB,waist="Rumination Sash",legs=gear.ChironicHose.MAB,feet="Medium's Sabots"}
    
    sets.midcast.MndEnfeebles = {
        main=gear.Akademos.D,sub="Enki Strap",ammo="Quartz Tathlum +1",
        head=gear.MerlinicHood.MAB,neck="Imbodla Necklace",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body=gear.VanyaRobe.C,hands=gear.ChironicGloves.MAB,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Aurist's Cape +1",waist="Rumination Sash",legs=gear.ChironicHose.MAB,feet="Medium's Sabots"}

    sets.midcast.IntEnfeebles = {
        main=gear.Akademos.D,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Imbodla Necklace",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body=gear.MerlinicJubbah.MAB,hands=gear.ChironicGloves.MAB,ring1="Shiva Ring +1",ring2="Freke Ring",
        back=gear.LughsCape.MAB,waist="Rumination Sash",legs=gear.ChironicHose.MAB,feet="Medium's Sabots"}
        
	--==================================--
	-- Enhancing Magic
    --==================================--
		
    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
	    main=gear.Akademos.D,sub="Oneiros Grip",ammo="Savant's Treatise",
        head="Arbatel Bonnet +1",neck="Incanter's Torque",ear1="Augmenting Earring",
        body=gear.TelchineChasuble.Enh,hands=gear.TelchineGloves.FCandEnh,
        back="Fi Follet Cape +1",waist="Olympus Sash",legs="Shedir Seraweels",feet=gear.TelchinePigaches.Enh})
		
	sets.midcast.EnhancingDuration = set_combine(sets.midcast.FastRecast, {
		head=gear.TelchineCap.Enh,body=gear.TelchineChasuble.Enh,hands=gear.TelchineGloves.FCandEnh,legs=gear.TelchineBraconi.Enh,feet=gear.TelchinePigaches.Enh})
        
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {head=gear.ChironicHat.MAB,legs="Shedir Seraweels"})
	sets.midcast.Blink = sets.midcast.EnhancingDuration
    sets.midcast.Erase = sets.midcast.FastRecast
	sets.midcast.Haste = sets.midcast.EnhancingDuration
		
    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
		
	sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",sub="Genbu's Shield",
        head="Arbatel Bonnet +1",
        body=gear.TelchineChasuble.Enh,
        back=gear.BookwormsCape.Regen})

    sets.midcast.Shell = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Shellra = sets.midcast.Shell

    -- Stoneskin: potency is Enhancing Magic Skill + 3xMND - 190, caps at 350. At 99, we reach the cap naked,
	-- so only items that specifically enhance Stoneskin (and break the cap) are useful.
    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Stone Gorget",ear1="Earthcry Earring",
		waist="Siegel Sash",legs="Shedir Seraweels"})

    sets.midcast.Storm = set_combine(sets.midcast.EnhancingDuration, {feet="Pedagogy Loafers +1"})

	--==================================--
	-- Healing Magic
    --==================================--
		
    sets.midcast.Cure = {
        main="Tamaxchi",sub="Genbu's Shield",ammo="Sapience Orb",
        head="Gendewitha Caubeen +1",neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
        body="Gendewitha Bliaut +1",hands=gear.TelchineGloves.FCandEnh,ring1="Haoma's Ring",ring2="Kuchekula Ring",
        back="Swith Cape +1",waist="Ninurta's Sash",legs=gear.ChironicHose.MAB,feet="Academic's Loafers"}

    sets.midcast.CureWeather = {
        main="Chatoyant Staff",sub="Achaq Grip",ammo="Sapience Orb",
        head="Gendewitha Caubeen +1",neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
        body="Gendewitha Bliaut +1",hands=gear.TelchineGloves.FCandEnh,ring1="Haoma's Ring",ring2="Kuchekula Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs=gear.ChironicHose.MAB,feet="Academic's Loafers"}

    sets.midcast.Curaga = sets.midcast.Cure
	sets.midcast.CuragaWeather = sets.midcast.CureWeather

    sets.midcast.Cursna = {
        neck="Debilis Medallion",
        ring1="Haoma's Ring",ring2="Menelaus's Ring", --hands="Hieros Mittens"
        feet="Gendewitha Galoshes +1"}

    --==================================--
	-- Active Buffs 
    --==================================--

    sets.buff['Alacrity'] = {feet="Pedagogy Loafers +1"}
    sets.buff['Celerity'] = {feet="Pedagogy Loafers +1"}
    --sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    --sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}

    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}
    
    sets.buff.FullSublimation = {head="Academic's Mortarboard",ear1="Savant's Earring",body="Pedagogy Gown +1"}
    sets.buff.PDTSublimation = {head="Academic's Mortarboard",ear1="Savant's Earring"}

    --==================================--
	-- Miscellaneous Sets
    --==================================--
    
    sets.Kiting = {feet="Herald's Gaiters"}
    
    -- SCH magic burst set only needs 30% + 5% + 5%, because Akademos has +10%.
    sets.MagicBurst = {
		neck="Mizukage-no-Kubikazari",
		hands=gear.AmalricGagesPlus1.A,ring1="Locus Ring",ring2="Mujin Band",
		back=gear.LughsCape.MAB,legs=gear.MerlinicShalwar.MAB}

	--==================================--
	-- Organizer Items
    --==================================--
	
    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
	    echo="Echo Drops",
        
        slipor_sash="Slipor Sash",
		refoccilation_stone="Refoccilation Stone",
        hachirin_no_obi="Hachirin-no-Obi"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enhancing Magic' then
        tas_adjust_timers(spell, spellMap)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
        
        if state.MagicBurst.value and (spell.skill == 'Elemental Magic' or spell.english == 'Kaustra') then
            equip(sets.MagicBurst)
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
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
		if state.Buff['Aurorastorm'] or world.day_element == 'Light' or world.weather_element == 'Light' then
			if default_spell_map == 'Cure' then
                return 'CureWeather'
			elseif default_spell_map == 'Curaga' then
				return 'CuragaWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 17)
end

