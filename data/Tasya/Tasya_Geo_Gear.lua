function user_setup()

-- Options: Override default values
  state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
  state.IdleMode:options('Normal', 'PDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Idris')

  gear.LifestreamCape = {}
  gear.LifestreamCape.Indi = {name="Lifestream Cape", augments={'Geomancy Skill +4','Indi. eff. dur. +20','Pet: Damage taken -4%'}}

  gear.NantosueltasCape = {}
	gear.NantosueltasCape.Regen = {name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10'}}

	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = "Toro Cape"
	gear.obi_low_nuke_waist = "Refoccilation Stone" -- "Sekhmet Corset"

	gear.obi_high_nuke_back = "Toro Cape"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	autoindi = "Haste"
	autogeo = "Frailty"

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')

	indi_duration = 290

	select_default_macro_book()
end

function init_gear_sets()

  --------------------------------------
  -- Sets required by rules
  --------------------------------------

	sets.Kiting = {feet="Herald's Gaiters"}
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	sets.Self_Healing = {neck="Phalaina Locket", ring1="Kunaji Ring", ring2="Asklepian Ring", waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket", ring1="Kunaji Ring", ring2="Asklepian Ring", waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"}

  --[[
  sets.HPDown = {head="Pixie Hairpin +1", ear1="Mendicant's Earring", ear2="Evans Earring",
		body="Jhakri Robe +2", hands="Jhakri Cuffs +2", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
		back="Swith Cape +1", legs="Shedir Seraweels", feet="Jhakri Pigaches +2"}
  --]]

	-- Gear that converts elemental damage done to recover MP.
	sets.RecoverMP = {body="Seidr Cotehardie"}

	-- Gear for Magic Burst mode.
  sets.MagicBurst = {
    neck="Mizukage-no-Kubikazari",
    body=gear.HeliosJacket.MAB, hands=gear.AmalricGagesPlus1.A, ring1="Mujin Band", ring2="Locus Ring",
    legs=gear.MerlinicShalwar.MAB, feet=gear.HeliosBoots.MAB}

	sets.RecoverBurst = set_combine(sets.MagicBurst, {body="Seidr Cotehardie"})

  --------------------------------------
  -- Base sets
  --------------------------------------

  sets.ConserveMP = {
    main=gear.Grioavolr.MAB, sub="Enki Strap", range=empty, ammo="Pemphredo Tathlum", -- sub="Thrace Strap"
    head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Gifted Earring", ear2="Enchanter Earring +1",
    body=gear.AmalricDoubletPlus1.A, hands=gear.TelchineGloves.Enh, ring1="Defending Ring", ring2="Prolix Ring",
    back="Solemnity Cape", waist="Luminary Sash", legs=gear.VanyaSlops.C, feet=gear.MerlinicCrackows.MAB}

  sets.MagicAccuracy = {
    main=gear.Grioavolr.MAB, sub="Enki Strap", range="Dunna", ammo=empty,
    head=gear.MerlinicHood.MAB, neck="Erra Pendant", ear1="Dignitary's Earring", ear2="Gwati Earring", -- ear2="Regal Earring"
    body=gear.MerlinicJubbah.MAB, hands="Jhakri Cuffs +2", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Aurist's Cape +1",waist="Luminary Sash",legs=gear.MerlinicShalwar.Burst, feet="Jhakri Pigaches +1"}

  sets.MagicAttackNW = {
    range=empty, ammo="Pemphredo Tathlum",
    head=gear.MerlinicHood.MAB, neck="Saevus Pendant +1", ear1="Barkarole Earring", ear2="Friomisi Earring",
    body=gear.AmalricDoubletPlus1.A, hands=gear.AmalricGagesPlus1.A, ring1="Shiva Ring +1", ring2="Shiva Ring +1",
    back="Toro Cape", waist=gear.ElementalObi, legs=gear.AmalricSlopsPlus1.A, feet=gear.AmalricNailsPlus1.A}

  sets.MagicAttack = set_combine(sets.MagicAttackNW, {
    main=gear.Grioavolr.MAB, sub="Enki Strap"})

  --------------------------------------
  -- Elemental Affinity
  --------------------------------------

	-- Gear for specific elemental nukes.
	--sets.element.Wind = {main="Marin Staff +1"}
	--sets.element.Ice = {} -- main="Ngqoqwanb"
	--sets.element.Earth = {neck="Quanpur Necklace"}

  --------------------------------------
  -- Idle
  --------------------------------------

  sets.idle = {
    main="Contemplator +1", sub="Oneiros Grip", range="Dunna", ammo=empty,
    head="Befouled Crown", neck="Bathy Choker +1", ear1="Infused Earring", ear2="Dawn Earring",
    body=gear.AmalricDoubletPlus1.A, hands="Bagua Mitaines +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1", -- body="Jhakri Robe +2"
    back="Kumbira Cape", waist=gear.IdleBelt, legs="Assiduity Pants +1", feet="Serpentes Sabots"}

	sets.idle.PDT = {
    main="Terra's Staff", sub="Umbra Strap", range=empty, ammo="Staunch Tathlum +1",
		head="Hagondes Hat +1", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Ethereal Earring",
		body="Jhakri Robe +2", hands="Hagondes Cuffs +1", ring1="Defending Ring", ring2="Shadow Ring",
		back="Shadow Mantle", waist="Flax Sash", legs="Hagondes Pants +1", feet="Mallquis Clogs +2"}

	-- Pet sets are for when Luopan is present.
  sets.idle.Pet = {
    main="Idris", sub="Genmei Shield", range="Dunna", ammo=empty,
    head="Azimuth Hood +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Genmei Earring",
    body=gear.AmalricDoubletPlus1.A, hands=gear.TelchineGloves.Pet, ring1="Stikini Ring +1", ring2="Stikini Ring +1", -- body="Jhakri Robe +2"
    back=gear.NantosueltasCape.Regen, waist=gear.IdleBelt, legs=gear.TelchineBraconi.Pet, feet="Bagua Sandals +1"}

  sets.idle.PDT.Pet = {
    main="Idris", sub="Genmei Shield", range="Dunna", ammo=empty,
    head="Azimuth Hood +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Genmei Earring",
    body="Hagondes Coat +1", hands=gear.TelchineGloves.Pet, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back=gear.NantosueltasCape.Regen, waist="Slipor Sash", legs=gear.TelchineBraconi.Pet, feet="Bagua Sandals +1"}

	sets.idle.Weak = {
    main="Bolelabunga", sub="Genmei Shield", range=empty, ammo="Staunch Tathlum +1",
		head="Befouled Crown", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
		body="Jhakri Robe +2", hands=gear.merlinic_refresh_hands, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
		back="Moonlight Cape", waist="Flax Sash", legs="Assiduity Pants +1", feet="Azimuth Gaiters +1"}

  --------------------------------------
  -- Defense
  --------------------------------------

	sets.defense.PDT = {
    main="Terra's Staff", sub="Umbra Strap", ammo="Staunch Tathlum +1",
		head="Hagondes Hat +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Handler's Earring +1",
		body="Mallquis Saio +2", hands="Hagondes Cuffs +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
		back="Moonlight Cape", waist="Flax Sash", legs="Hagondes Pants +1", feet="Azimuth Gaiters +1"}

  sets.defense.NukeLock = sets.midcast['Elemental Magic']
  sets.defense.GeoLock = sets.midcast.Geomancy.Indi
	sets.defense.PetPDT = set_combine(sets.idle.PDT.Pet, {})

	sets.defense.MDT = {
    main="Terra's Staff", sub="Umbra Strap", ammo="Staunch Tathlum +1",
		head="Azimuth Hood +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Handler's Earring +1",
		body="Mallquis Saio +2", hands="Hagondes Cuffs +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
		back="Moonlight Cape", waist="Flax Sash", legs="Hagondes Pants +1", feet="Azimuth Gaiters +1"}

  sets.defense.MEVA = {
    main="Terra's Staff", sub="Enki Strap", ammo="Staunch Tathlum +1",
    head="Azimuth Hood +1", neck="Warder's Charm +1", ear1="Etiolation Earring", ear2="Sanare Earring",
		body=gear.MerlinicJubbah.MAB, hands="Telchine Gloves", ring1="Vengeful Ring", Ring2="Purity Ring",
    back=gear.NantosueltasCape.Regen, waist="Luminary Sash", legs="Telchine Braconi", feet="Azimuth Gaiters +1"}

  --------------------------------------
  -- Resting
  --------------------------------------

	sets.resting = {
    main="Chatoyant Staff", sub="Oneiros Grip", range=empty, ammo="Staunch Tathlum +1",
    head="Befouled Crown", neck="Eidolon Pendant +1", ear1="Infused Earring", ear2="Dawn Earring",
    body=gear.AmalricDoubletPlus1.A, hands="Bagua Mitaines +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Kumbira Cape", waist=gear.IdleBelt, legs="Assiduity Pants +1", feet="Chelona Boots +1"}

  --------------------------------------
	-- Weapons
	--------------------------------------

	sets.weapons.Idris = {main="Idris", sub="Genmei Shield"}
  --sets.weapons.Maxentius = {main="Maxentius", sub="Genmei Shield"}

	--------------------------------------
	-- Engaged
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.engaged = {
    range=empty, ammo="Hasty Pinion +1",
		head="Jhakri Coronal +2", neck="Asperity Necklace", ear1="Cessance Earring", ear2="Brutal Earring",
		body="Jhakri Robe +2", hands="Gazu Bracelet +1", ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
		back="Relucent Cape", waist="Witful Belt", legs="Jhakri Slops +2", feet="Battlecast Gaiters"}

	sets.engaged.DW = {
    range=empty, ammo="Hasty Pinion +1",
		head="Jhakri Coronal +2", neck="Asperity Necklace", ear1="Dudgeon Earring", ear2="Heartseeker Earring",
		body="Jhakri Robe +2", hands="Regal Cuffs", ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
		back="Relucent Cape", waist="Shetal Stone", legs="Jhakri Slops +2", feet="Battlecast Gaiters"}

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------
  sets.precast.WS = {
    range=empty, ammo="Hasty Pinion +1",
    head="Jhakri Coronal +2", neck="Combatant's Torque", ear1="Brutal Earring", ear2="Cessance Earring",
    body="Jhakri Robe +1", hands="Jhakri Cuffs +2", ring1="Ifrit Ring +1", ring2="Ifrit Ring +1",
    back="Aurist's Cape +1", waist="Windbuffet Belt +1", legs="Jhakri Slops +1", feet="Jhakri Pigaches +1"}

  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  sets.precast.WS.Magic = set_combine(sets.MagicAttackNW, {})

  --------------------------------------
  -- Precast: Club Weaponskills
  --------------------------------------

  -- Shining Strike: magic, light ele., 40% STR 40% MND, 1.625/3.0/4.625 fTP.
  sets.precast.WS['Shining Strike'] = set_combine(sets.precast.WS.Magic, {ear2="Moonshade Earring"})

  -- Seraph Strike: magic, light ele., 40% STR 40% MND, 2.125/3.675/6.125 fTP.
  sets.precast.WS['Shining Strike'] = set_combine(sets.precast.WS.Magic, {ear2="Moonshade Earring"})

  -- Brainshaker: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to stun.
  sets.precast.WS['Brainshaker'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Ishvara Earring", ear2="Moonshade Earring", waist="Fotia Belt"})

  -- Starlight: restores MP, only modified by TP.
  sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

  -- Moonlight: restores MP to party, only modified by TP.
  sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}

  -- Skullbreaker: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to apply -10 INT.
  sets.precast.WS['Skullbreaker'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear2="Ishvara Earring", belt="Fotia Belt"})

  -- True Strike: physical 1-hit, 100% STR, 1.0 fTP, guaranteed crit, TP affects accuracy.
  sets.precast.WS['True Strike'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Ishvara Earring", ear2="Moonshade Earring", belt="Fotia Belt"})

  -- Judgment: physical 1-hit, 50% STR 50% MND, 3.5/8.75/12.0 fTP.
  sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {
    ear1="Ishvara Earring", ear2="Moonshade Earring",
    ring1="Rufescent Ring"})

  -- Hexa Strike: physical 6-hit, 30% STR 30% MND, 1.125 fTP (all), TP affects chance to crit.
  sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear2="Moonshade Earring",
    ring1="Rufescent Ring",
    back="Rancorous Mantle", waist="Fotia Belt"})

  -- Black Halo: physical 2-hit, 30% STR 70% MND, 3.0/7.25/9.75 fTP.
  sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
    ear1="Ishvara Earring", ear2="Moonshade Earring",
    ring1="Rufescent Ring"})

  -- Flash Nova: magic, light ele., 50% STR 50% MND, 3.0 fTP, TP affects chance to flash.
  sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS.Magic, {})

  -- Realmrazer: physical 7-hit, 73~85% MND, 0.88 fTP (all), TP affects accuracy.
  sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Ishvara Earring", ear2="Moonshade Earring",
    ring1="Rufescent Ring", ring2="Stikini Ring +1",
    belt="Fotia Belt"})

  -- Exuviation: physical 1-hit, 50% INT 50% MND, 4.0 fTP?, TP affects attack.
  sets.precast.WS['Exudation'] = set_combine(sets.precast.WS, {
    ear1="Ishvara Earring", ear2="Moonshade Earring",
    ring1="Rufescent Ring", ring2="Stikini Ring +1"})

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

	sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
	sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +1", back=gear.NantosueltasCape.Regen}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1", hands="Bagua Mitaines +1"}

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

  -- Total: 7 QC, 66 FC.
  -- |  5 |     - |   - | 2QC |
  -- | 10 |     5 |   2 |   2 |
  -- | 10 |    4* | 2QC |   2 | Telchine gloves aren't perfect yet.
  -- |  7 | 3+3QC |  11 | 5~7 |

  sets.precast.FC = {
    main="Sucellus", sub="Genmei Shield", range=empty, ammo="Impatiens", -- main=gear.Grioavolr.FC, sub="Clerisy Strap +1"
    head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Loquacious Earring", ear2="Enchanter Earring +1", -- head="Amalric Coif +1"
    body="Anhur Robe", hands=gear.TelchineGloves.Enh, ring1="Lebeche Ring", ring2="Prolix Ring",
    back=gear.LifestreamCape.PetDT, waist="Witful Belt", legs="Geomancy Pants +1", feet="Regal Pumps +1"} -- legs="Geomancy Pants +3"

  sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
    ear1="Barkarole Earring", hands="Bagua Mitaines +1"})

	sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty, body="Twilight Cloak"})

  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

  sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

  -- FIXME: This is way, way over cap.
  sets.precast.FC.Cure = set_combine(sets.precast.FC, {
    main="Sucellus", sub="Genbu's Shield",
    ear1="Mendicant's Earring",
    body="Heka's Kalasiris",
    feet=gear.VanyaClogs.D})

	sets.precast.FC.Curaga = set_combine(sets.precast.FC.Cure, {})

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna", ammo=empty})

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

  sets.midcast.FastRecast = {
    main="Sucellus", sub="Genmei Shield", range=empty, ammo="Impatiens", -- main=gear.Grioavolr.FC, sub="Clerisy Strap +1"
    head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Loquacious Earring", ear2="Enchanter Earring +1", -- head="Amalric Coif +1"
    body=gear.MerlinicJubbah.MAB, hands=gear.TelchineGloves.Enh, ring1="Defending Ring", ring2="Prolix Ring",
    back=gear.LifestreamCape.PetDT, waist="Witful Belt", legs="Geomancy Pants +1", feet="Regal Pumps +1"}

  --------------------------------------
  -- Midcast: Dark Magic
  --------------------------------------

  sets.midcast['Dark Magic'] = set_combine(sets.MagicAccuracy, {
    -- main="Rubicundity", sub="Ammurapi Shield" (Not better until I have the shield)
    ring2="Evanescence Ring"}) -- body="Geomancy Tunic +3"

  sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], {
    main="Rubicundity", sub="Genmei Shield", -- sub="Ammurapi Shield"
    head="Pixie Hairpin +1", neck="Erra Pendant", ear2="Hirudinea Earring",
    body=gear.MerlinicJubbah.DrainAspir, ring1="Archon Ring", ring2="Evanescence Ring",
    waist="Fucho-no-obi", feet=gear.MerlinicCrackows.MAB})

  sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

  sets.midcast.Drain = set_combine(sets.midcast.Aspir, {})

	sets.midcast.Stun = set_combine(sets.MagicAccuracy, {})
	sets.midcast.Stun.Resistant = set_combine(sets.MagicAccuracy, {})

  --------------------------------------
  -- Midcast: Divine Magic
  --------------------------------------

	sets.midcast['Divine Magic'] = set_combine(sets.MagicAccuracy, {})

  --------------------------------------
  -- Midcast: Elemental Magic
  --------------------------------------

  -- Dosis? Zuuxowu? Thrace? Worth the inventory spaces?
  sets.midcast['Elemental Magic'] = set_combine(sets.MagicAttack, {})

  sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
    neck="Sanctity Necklace", waist="Eschan Stone"})

  sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})

  sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
  sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
  sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})

  sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.MagicAccuracy, {ring1="Shiva Ring +1", ring2="Shiva Ring +1"})
  sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast.ElementalEnfeeble, {})

	sets.midcast.Impact = set_combine(sets.MagicAccuracy, {head=empty, body="Twilight Cloak"})

  --------------------------------------
  -- Midcast: Enfeebling Magic
  --------------------------------------

  sets.midcast['Enfeebling Magic'] = set_combine(sets.MagicAccuracy, {
    range=empty, ammo="Quartz Tathlum +1",
    hands="Azimuth Gloves +1", -- ring1="Kishar Ring"
    waist="Rumination Sash", legs=gear.PsyclothLappas.D, feet="Uk'uxkaj Boots"})

  sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
    range="Dunna", ammo=empty,
    ring1="Stikini Ring +1",
    feet="Medium's Sabots"})

  sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
    body=gear.VanyaRobe.C})

  sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
    body=gear.VanyaRobe.C})

  sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
    range=empty, ammo="Pemphredo Tathlum",
    ear2="Barkarole Earring",
    ring2="Shiva Ring +1"})

	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
    ear2="Barkarole Earring"})

	sets.midcast.Dia = set_combine(sets.FastRecast, sets.TreasureHunter)

  --------------------------------------
  -- Midcast: Enhancing Magic
  --------------------------------------

  sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
    main=gear.Gada.Enh, sub="Genmei Shield",  -- sub="Ammurapi Shield"
    head="Befouled Crown", neck="Incanter's Torque", ear1="Andoaa Earring", ear2="Augmenting Earring",
    body=gear.TelchineChasuble.Enh, hands=gear.TelchineGloves.Enh, ring1="Stikini Ring +1", ring2="Stikini Ring +1", -- hands="Ayao's Gages"
    back="Fi Follet Cape +1", waist="Olympus Sash", legs="Shedir Seraweels", feet="Regal Pumps +1"})

  sets.midcast.EnhancingDuration = set_combine(sets.midcast.FastRecast, {
    head=gear.TelchineCap.Enh,
    body=gear.TelchineChasuble.Enh,hands=gear.TelchineGloves.Enh,
    legs=gear.TelchineBraconi.Enh,feet=gear.TelchinePigaches.Enh})

	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
    main="Vadose Rod", sub="Genmei Shield",
    -- head="Amalric Coif +1",
    --hands="Regal Cuffs",
    legs="Shedir Seraweels"}) -- waist="Emphatikos Rope"

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
  sets.midcast.Blink = set_combine(sets.midcast.EnhancingDuration, {})
  sets.midcast.Erase = set_combine(sets.midcast.FastRecast, {})
  sets.midcast.Haste = set_combine(sets.midcast.EnhancingDuration, {})
  sets.midcast.Klimaform = set_combine(sets.midcast.EnhancingDuration, {})
  sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
  sets.midcast.Protectra = set_combine(sets.midcast.Protect, {})
  sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {}) -- head="Amalric Coif +1",
  sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {main="Bolelabunga", sub="Genmei Shield"})

  sets.midcast.Shell = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
  sets.midcast.Shellra = set_combine(sets.midcast.Shell, {})

  -- Stoneskin: potency is Enhancing Magic Skill + 3xMND - 190, caps at 350. At 99, we reach the cap naked,
  -- so only items that specifically enhance Stoneskin (and break the cap) are useful.
  sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
    neck="Stone Gorget",ear1="Earthcry Earring",
    waist="Siegel Sash",legs="Shedir Seraweels"})

  sets.midcast.Storm = set_combine(sets.midcast.EnhancingDuration, {})

  --------------------------------------
  -- Midcast: Geomancy
  --------------------------------------

  sets.midcast.Geomancy = set_combine(sets.ConserveMP, {
    main="Idris", sub="Genmei Shield", range="Dunna", ammo=empty,
    head="Azimuth Hood +1", neck="Incanter's Torque",
    body="Azimuth Coat +1", hands="Azimuth Gloves +1",
    legs="Azimuth Tights +1", feet="Azimuth Gaiters +1"})

  sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
    main=gear.Solstice.B, sub="Genmei Shield",
    back=gear.LifestreamCape.Indi, legs="Bagua Pants +1", feet="Azimuth Gaiters +1"})

  --------------------------------------
  -- Midcast: Healing Magic
  --------------------------------------

  sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
    main="Divinity", sub="Genbu's Shield", range=empty, ammo="Esper Stone +1",
    head=gear.VanyaHood.A, neck="Incanter's Torque", ear1="Mendicant's Earring", ear2="Gifted Earring",
    body=gear.VanyaRobe.C, hands="Azimuth Gloves +1", ring1="Kuchekula Ring", ring2="Mephitas's Ring +1",
    back="Thaumaturge's Cape", waist="Ninurta's Sash", legs=gear.VanyaSlops.C, feet=gear.VanyaClogs.D})

  -- FIXME: not going to happen often but this is super wrong.
  sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {
    main="Chatoyant Staff", sub="Achaq Grip",
    hands=gear.TelchineGloves.Enh,
    back="Twilight Cape", waist="Hachirin-no-Obi")

  sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {back="Twilight Cape", waist="Hachirin-no-Obi"})

  sets.midcast.Curaga = sets.midcast.Cure
  sets.midcast.LightWeatherCuraga = sets.midcast.LightWeatherCure
  sets.midcast.LightDayCuraga = sets.midcast.LightDayCure

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion", ring1="Haoma's Ring", ring2="Menelaus's Ring"})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

  --------------------------------------
  -- Active buffs
  --------------------------------------

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
  -- (For high-JP GEOs, this should probably be blank.)
	sets.buff.Entrust = {}

	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(4, 10)
end
