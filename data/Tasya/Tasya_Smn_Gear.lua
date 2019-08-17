-- Setup vars that are user-dependent.  Can override this function in a sidecar.
function user_setup()
  state.OffenseMode:options('Normal', 'Acc')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'DT')
	state.Weapons:options('None', 'Gridarvor')

  gear.ConveyanceCape = {}
  gear.ConveyanceCape.Skill = {name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+12','Blood Pact Dmg.+5'}}

  gear.CampestresCape = {}
	gear.CampestresCape.PhysBP = {name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20', 'Eva.+20 /Mag. Eva.+20', 'Pet: "Regen"+10'}}
	gear.CampestresCape.MagicBP = {name="Campestres's Cape"}}

  send_command('bind !` input /ja "Release" <me>')
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind ^` gs c toggle PactSpamMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode')

  select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  --------------------------------------
  -- Sets required by rules
  --------------------------------------

  sets.Self_Healing = {neck="Phalaina Locket", ring1="Kunaji Ring", ring2="Asklepian Ring", waist="Gishdubar Sash"}
  sets.Cure_Received = {neck="Phalaina Locket", ring1="Kunaji Ring", ring2="Asklepian Ring", waist="Gishdubar Sash"}
  sets.Self_Refresh = {back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"}

  sets.Kiting = {feet="Herald's Gaiters"}
  sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

  --[[
	sets.HPDown = {
    head="Apogee Crown +1", ear1="Mendicant's Earring", ear2="Evans Earring",
		body="Seidr Cotehardie", hands="Hieros Mittens", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
		back="Swith Cape +1", legs="Apogee Slacks +1", feet="Apogee Pumps +1"}
  --]]

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

  --------------------------------------
  -- Base sets
  --------------------------------------

  -- -52% PDT, -28% MDT.
  sets.BaseDT = {
    main="Mafic Cudgel", sub="Genmei Shield", ammo="Staunch Tathlum +1",
    head="Beckoner's Horn +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Hagondes Coat +1", hands="Asteria Mitts +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Slipor Sash", legs="Assiduity Pants +1", feet="Beckoner's Pigaches +1"}

  sets.MaxSummoningSkill = {
    main=gear.Espiritus.B, sub="Vox Grip", ammo="Sancus Sachet +1",
    head="Convoker's Horn +1", neck="Incanter's Torque", ear1="Andoaa Earring", ear2="Summoning Earring",
    body="Beckoner's Doublet +1", hands="Lamassu Mitts +1", ring1="Evoker's Ring", ring2="Stikini Ring +1",
    back=gear.ConveyanceCape.Skill, waist="Lucidity Sash", legs="Beckoner's Spats +1", feet="Beckoner's Pigaches +1"}

  --------------------------------------
  -- Idle
  --------------------------------------

  -- Idle sets
  sets.idle = {
    main="Contemplator +1", sub="Oneiros Shield", ammo="Staunch Tathlum +1",
    head="Beckoner's Horn +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body=gear.ApogeeDalmaticaPlus1.A, hands="Asteria Mitts +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Moonlight Cape", waist="Slipor Sash", legs="Assiduity Pants +1", feet="Serpentes Sabots"}

  sets.idle.DT = {
    main="Mafic Cudgel", sub="Genmei Shield", ammo="Staunch Tathlum +1",
    head="Beckoner's Horn +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Hagondes Coat +1", hands="Asteria Mitts +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Slipor Sash", legs="Assiduity Pants +1", feet="Beckoner's Pigaches +1"}

  -- Perpetuation costs at 99:

  -- Elemental spirits: 7
  -- Carbuncle: 11 (13 with Avatar's favor)
  -- Fenrir: 13 (15 with Avatar's Favor)
  -- All other avatars: 15 (18 with Avatar's Favor)

  -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
  -- Aim for -14 perp, and refresh in other slots.

  -- Available perpetuation cost gear, 119+ and accessories:

  -- Nirvana: -8
  -- Gridarvor: -5
  -- Was: -5
  -- Was +1: -7

  -- Hagondes set +1: -1~5 each (augment)

  -- Glyphic Horn +1/2/3: -4/4/5

  -- Caller's Pendant: -1 for matching weather

  -- Evans Earring: -2

  -- Beckoner's Doublet +1: -6
  -- Glyphic Doublet +1/2/3: -5/5/6

  -- Asteria Mitts +1: set Carbuncle's base perpetuation cost to 5
  -- Beckoner's Bracets: after all other perpetuation effects are applies, half perpetation cost (rounds favorably)

  -- Evoker's Ring: -1

  -- Lucidity Sash: -2

  -- Assiduity Pants +1: -3

  -- Apogee Pumps +1: -9
  -- Beckoner's Pigaches +1: -7
  -- Convoker's Pigaches +1/2/3: -4/5/6

  sets.idle.Avatar = {
    main="Gridarvor", sub="Oneiros Grip", ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1", neck="Caller's Pendant", ear1="Etiolation Earring", ear2="Evans Earring",
    body=gear.ApogeeDalmaticaPlus1.A, hands="Asteria Mitts +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Conveyance Cape", waist="Slipor Sash", legs="Assiduity Pants +1", feet="Beckoner's Pigaches +1"}

  sets.idle.DT.Avatar = {
    main="Mafic Cudgel", sub="Genmei Shield", ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Evans Earring",
    body="Hagondes Coat +1", hands="Asteria Mitts +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Slipor Sash", legs="Assiduity Pants +1", feet="Beckoner's Pigaches +1"}

  sets.idle.Spirit = {
    main="Gridarvor", sub="Oneiros Grip", ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1", neck="Caller's Pendant", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body=gear.ApogeeDalmaticaPlus1.A, hands="Asteria Mitts +1", ring1="Evoker's Ring", ring2="Sheltered Ring",
    back="Conveyance Cape", waist="Slipor Sash", legs="Assiduity Pants +1", feet="Beckoner's Pigaches +1"}

  sets.idle.DT.Spirit = {
    main="Terra's Staff", sub="Oneiros Grip", ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Etheral Earring",
    body="Hagondes Coat +1", hands="Asteria Mitts +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Slipor Sash", legs="Assiduity Pants +1", feet="Beckoner's Pigaches +1"}

	-- sets.idle.TPEat.Avatar = set_combine(sets.idle.Avatar, {neck="Chrys. Torque"})

	--Favor always up and head is best in slot idle so no specific items here at the moment.
  sets.idle.Avatar.Favor = {}
  sets.idle.Avatar.Engaged = {}

	sets.idle.Avatar.Engaged.Carbuncle = {}
	sets.idle.Avatar.Engaged['Cait Sith'] = {}

  sets.perp = {}
  -- Caller's Bracer's halve the perp cost after other costs are accounted for.
  -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
  -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
  -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
  sets.perp.Day = {}
  sets.perp.Weather = {}

	sets.perp.Carbuncle = {}
  sets.perp.Diabolos = {}
  sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

  -- Not really used anymore, was for the days of specific staves for specific avatars.
  sets.perp.staff_and_grip = {}

  --------------------------------------
  -- Defense
  --------------------------------------

  sets.defense.PDT = {
    main="Terra's Staff", sub="Umbra Strap", ammo="Sancus Sachet +1",
    head="Hagondes Hat +1", neck="Loricate Torque +1", ear1="Handler's Earring +1", ear2="Enmerkar Earring",
    body="Vrikodara Jupon", hands="Hagondes Cuffs +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Umbra Cape", waist="Regal Belt", legs="Hagondes Pants +1", feet="Battlecast Gaiters"}

  sets.defense.MDT = {
    main="Terra's Staff", sub="Umbra Strap", ammo="Sancus Sachet +1",
    head="Hagondes Hat +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Lugalbanda Earring",
    body="Vrikodara Jupon", hands="Hagondes Cuffs +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Umbra Cape", waist="Regal Belt", legs="Hagondes Pants +1", feet="Battlecast Gaiters"}

  sets.defense.MEVA = {
    main="Terra's Staff", sub="Enki Strap", ammo="Sancus Sachet +1",
    head="Inyanga Tiara +1", neck="Warder's Charm +1", ear1="Sanare Earring", ear2="Lugalbanda Earring",
  	body="Inyanga Jubbah +1", hands="Inyanga Dastanas +1", ring1="Vengeful Ring", Ring2="Purity Ring",
    back="Aurist's Cape +1", waist="Luminary Sash", legs="Inyanga Shalwar +2", feet="Inyanga Crackows +1"}

  --------------------------------------
  -- Resting
  --------------------------------------

  sets.resting = {
    main="Chatoyant Staff", sub="Oneiros Grip", ammo="Esper Stone +1",
    head="Beckoner's Horn +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Shomonjijoe +1", hands="Asteria Mitts +1", ring1="Defending Ring", ring2="Sheltered Ring",
    back="Umbra Cape", waist="Fucho-no-obi", legs="Assiduity Pants +1", feet="Baayami Sabots"}

  --------------------------------------
	-- Weapons
	--------------------------------------

	sets.weapons.Gridarvor = {main="Gridarvor", sub="Elan Strap +1"}

  --------------------------------------
  -- Engaged
  --------------------------------------

  sets.engaged = {
    main="Gridarvor", sub="Bloodrain Strap", ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1", neck="Shulmanu Collar", ear1="Digni. Earring", ear2="Telos Earring",
    body="Tali'ah Manteel +1", hands="Gazu Bracelet +1", ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.phys_jse_back, waist="Olseni Belt", legs="Assiduity Pants +1", feet="Convoker's Pigaches +3"}

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------

  sets.precast.WS = {}

  --------------------------------------
  -- Precast: Staff Weaponskills
  --------------------------------------

  sets.precast.WS['Myrkr'] = {
    ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1", neck="Sanctity Necklace", ear1="Etiolation Earring", ear2="Gifted Earring",
    body="Tali'ah Manteel +1", hands="Regal Cuffs", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
    back="Conveyance Cape", waist="Luminary Sash", legs="Psycloth Lappas", feet="Beck. Pigaches +1"}

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

  sets.precast.JA['Astral Flow'] = {head="Glyphic Horn +1"}
  sets.precast.JA['Elemental Siphon'] = set_combine(sets.MaxSummoningSkill, {ammo="Esper Stone +1"}
  sets.precast.JA['Mana Cede'] = {hands="Beckoner's Bracers +1"}

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

  sets.precast.FC = {
    main=gear.Grioavolr.MAB, sub="Clerisy Strap +1", ammo="Impatiens", -- sub="Clerisy Strap +1"
  	head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
  	body="Inyanga Jubbah +1", hands="Volte Gloves", ring1="Lebeche Ring", ring2="Kishar Ring",
  	back="Perimede Cape", waist="Witful Belt", legs=gear.PsyclothLappas.D, feet="Regal Pumps +1"}

  sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity", sub="Clerisy Strap +1"})

  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

  sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

  --------------------------------------
  -- Precast: Blood Pact Recast
  --------------------------------------

  sets.precast.BloodPactWard = set_combine(sets.MaxSummoningSkill, {
    main=gear.Espiritus.B, sub="Vox Grip", ammo="Sancus Sachet +1",
  	head="Beckoner's Horn +1", ear2="Evans Earring",
    body=gear.ApogeeDalmaticaPlus1.A, hands="Glyphic Bracers +1",
    legs="Glyphic Spats +1"}

  sets.precast.BloodPactRage = set_combine(sets.precast.BloodPactWard, {})

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

  sets.midcast.FastRecast = {
    main=gear.Grioavolr.MAB, sub="Clerisy Strap +1", ammo="Hasty Pinion +1",
  	head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
  	body="Inyanga Jubbah +1", hands="Volte Gloves", ring1="Defending Ring", ring2="Kishar Ring",
  	back="Swith Cape +1", waist="Witful Belt", legs=gear.PsyclothLappas.D, feet="Regal Pumps +1"}

  --------------------------------------
  -- Midcast: Dark Magic
  --------------------------------------

  sets.midcast['Dark Magic'] = {
    main="Rubicundity", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
    head=gear.merlinic_nuke_head, neck="Incanter's Torque", ear1="Digni. Earring", ear2="Gwati Earring",
    body=gear.merlinic_nuke_body, hands="Amalric Gages +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Aurist's Cape +1", waist="Yamabuki-no-Obi", legs="Merlinic Shalwar", feet=gear.merlinic_aspir_feet}

	sets.midcast.Aspir = {
    main="Rubicundity", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1", neck="Incanter's Torque", ear1="Digni. Earring", ear2="Gwati Earring",
    body=gear.merlinic_nuke_body, hands="Amalric Gages +1", ring1="Archon Ring", ring2="Evanescence Ring",
    back="Aurist's Cape +1", waist="Fucho-no-obi", legs="Merlinic Shalwar", feet=gear.merlinic_aspir_feet}

  sets.midcast.Drain = set_combine(sets.midcast.Aspir, {})

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	--sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

  sets.midcast.Stun = {
    ain="Oranyan", sub="Clerisy Strap +1", ammo="Hasty Pinion +1",
		head="Amalric Coif +1", neck="Voltsurge Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
		body="Inyanga Jubbah +1", hands="Volte Gloves", ring1="Kishar Ring", ring2="Stikini Ring +1",
		back="Swith Cape +1", waist="Witful Belt", legs="Psycloth Lappas", feet="Regal Pumps +1"}

  sets.midcast.Stun.Resistant = {
    main="Oranyan", sub="Clerisy Strap +1", ammo="Hasty Pinion +1",
		head="Amalric Coif +1", neck="Voltsurge Torque", ear1="Enchanter Earring +1", ear2="Gwati Earring",
		body="Inyanga Jubbah +1", hands="Volte Gloves", ring1="Kishar Ring", ring2="Stikini Ring +1",
		back="Aurist's Cape +1", waist="Witful Belt", legs="Psycloth Lappas", feet=gear.merlinic_aspir_feet}

  --------------------------------------
  -- Midcast: Divine Magic
  --------------------------------------

  sets.midcast['Divine Magic'] = {
    main="Oranyan", sub="Zuuxowu Grip", ammo="Dosis Tathlum",
    head=gear.merlinic_nuke_head, neck="Baetyl Pendant", ear1="Crematio Earring", ear2="Friomisi Earring",
    body=gear.merlinic_nuke_body, hands="Amalric Gages +1", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
	  back="Toro Cape", waist="Sekhmet Corset", legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  --------------------------------------
  -- Midcast: Elemental Magic
  --------------------------------------

	sets.midcast['Elemental Magic'] = {
    main=gear.grioavolr_nuke_staff, sub="Zuuxowu Grip", ammo="Dosis Tathlum",
    head=gear.merlinic_nuke_head, neck="Baetyl Pendant", ear1="Crematio Earring", ear2="Friomisi Earring",
    body=gear.merlinic_nuke_body, hands="Amalric Gages +1", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
		back="Toro Cape", waist="Sekhmet Corset", legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

	sets.midcast['Elemental Magic'].Resistant = {
    main=gear.grioavolr_nuke_staff, sub="Zuuxowu Grip", ammo="Dosis Tathlum",
    head=gear.merlinic_nuke_head, neck="Baetyl Pendant", ear1="Crematio Earring", ear2="Friomisi Earring",
    body=gear.merlinic_nuke_body, hands="Amalric Gages +1", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
		back="Toro Cape", waist="Sekhmet Corset", legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  sets.midcast['Elemental Magic'].OccultAcumen = {
    main="Khatvanga", sub="Bloodrain Strap", ammo="Seraphic Ampulla",
    head=gear.merlinic_nuke_head, neck="Combatant's Torque", ear1="Dedition Earring", ear2="Telos Earring",
    body=gear.merlinic_occult_body, hands=gear.merlinic_occult_hands, ring1="Rajas Ring", ring2="Petrov Ring",
    back="Toro Cape", waist="Oneiros Rope", legs="Perdition Slops", feet=gear.merlinic_occult_feet}

	sets.midcast.Impact = {
    main="Oranyan", sub="Enki Strap", ammo="Pemphredo Tathlum",
		head=empty, neck="Erra Pendant", ear1="Enchanter Earring +1", ear2="Gwati Earring",
		body="Twilight Cloak", hands="Regal Cuffs", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
		back="Toro Cape", waist="Acuity Belt +1", legs="Merlinic Shalwar", feet=gear.merlinic_aspir_feet}

	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})

  --------------------------------------
  -- Midcast: Enfeebling Magic
  --------------------------------------

	sets.midcast['Enfeebling Magic'] = {
    main="Oranyan", sub="Enki Strap", ammo="Pemphredo Tathlum",
		head="Befouled Crown", neck="Erra Pendant", ear1="Digni. Earring", ear2="Gwati Earring",
		body=gear.merlinic_nuke_body, hands="Regal Cuffs", ring1="Stikini Ring +1", ring2="Kishar Ring",
		back="Aurist's Cape +1", waist="Luminary Sash", legs="Psycloth Lappas", feet="Uk'uxkaj Boots"}

	sets.midcast['Enfeebling Magic'].Resistant = {
    main="Oranyan", sub="Clerisy Strap +1", ammo="Pemphredo Tathlum",
		head="Befouled Crown", neck="Erra Pendant", ear1="Digni. Earring", ear2="Gwati Earring",
		body=gear.merlinic_nuke_body, hands="Regal Cuffs", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
		back=gear.nuke_jse_back, waist="Luminary Sash", legs="Psycloth Lappas", feet="Skaoi Boots"}

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	--sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	--sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

--------------------------------------
-- Midcast: Enhancing Magic
--------------------------------------

	sets.midcast['Enhancing Magic'] = {
    main=gear.Gada.Enh, sub="Genmei Shield", ammo="Hasty Pinion +1", -- sub="Ammurapi Shield"
		head="Befouled Crown", neck="Incanter's Torque", ear1="Andoaa Earring", ear2="Augmenting Earring",
		body=gear.TelchineChasuble.Enh, hands=gear.TelchineGloves.Enh, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
		back="Fi Follet Cape +1", waist="Olympus Sash", legs="Shedir Seraweels", feet="Regal Pumps +1"}

	sets.midcast.EnhancingDuration = set_combine(sets.midcast.FastRecast, {
    main=gear.Gada.Enh, sub="Genmei Shield", -- sub="Ammurapi Shield"
		head=gear.TelchineCap.Enh,
		body=gear.TelchineChasuble.Enh, hands=gear.TelchineGloves.Enh,
		legs=gear.TelchineBraconi.Enh, feet=gear.TelchinePigaches.Enh})

	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
    main="Vadose Rod", sub="Genmei Shield", legs="Shedir Seraweels"}) -- head="Amalric Coif +1", hands="Regal Cuffs", waist="Emphatikos Rope"
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

  sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {}) -- head="Amalric Coif +1"
  sets.midcast.Stoneskin = set_combine(sets.midcast.FastRecast, {
    neck="Stone Gorget", ear2="Earthcry Earring", waist="Siegel Sash", legs="Shedir Seraweels"})

  --------------------------------------
  -- Midcast: Healing Magic
  --------------------------------------

  sets.midcast.Cure = {
    main=gear.gada_healing_club, sub="Sors Shield", ammo="Hasty Pinion +1",
    head="Vanya Hood", neck="Incanter's Torque", ear1="Mendicant's Earring", ear2="Gifted Earring",
    body="Vrikodara Jupon", hands="Telchine Gloves", ring1="Janniston Ring", ring2="Menelaus's Ring",
    back="Tempered Cape +1", waist="Austerity Belt +1", legs="Gyve Trousers", feet="Vanya Clogs"}

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {
    neck="Debilis Medallion",
		hands="Hieros Mittens", ring1="Haoma's Ring", ring2="Menelaus's Ring",
    back="Tempered Cape +1", waist="Witful Belt"})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan", sub="Clemency Grip"})

  --------------------------------------
  -- Midcast: Blood Pacts
  --------------------------------------

  sets.midcast.Pet.BloodPactWard = {
    main="Espiritus", sub="Vox Grip", ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1", neck="Incanter's Torque", ear1="Andoaa Earring", ear2="Gifted Earring",
    body="Beckoner's Doublet +1", hands="Baayami Cuffs", ring1="Evoker's Ring", ring2="Stikini Ring +1",
    back=gear.ConveyanceCape.Skill, waist="Kobo Obi", legs="Baayami Slops", feet="Baayami Sabots"}

  sets.midcast.Pet.DebuffBloodPactWard = {
    main=gear.Espiritus.B, sub="Vox Grip", ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1", neck="Adad Amulet", ear1="Andoaa Earring", ear2="Enmerkar Earring",
    body="Beckoner's Doublet +1", hands=gear.MerlinicDastanas.MagicBP, ring1="Evoker's Ring", ring2="Stikini Ring +1",
    back=gear.CampestresCape.MagicBP, waist="Incarnation Sash", legs="Tali'ah Seraweels +2", feet="Beckoner's Pigaches +1"}

  sets.midcast.Pet.DebuffBloodPactWard.Acc = set_combine(sets.midcast.Pet.DebuffBloodPactWard, {})

  sets.midcast.Pet.PhysicalBloodPactRage = {
    main="Gridarvor", sub="Elan Strap +1", ammo="Sancus Sachet +1",
    head=gear.HeliosBand.PhysBP, neck="Empath Necklace", ear1="Esper Earring", ear2="Lugalbanda Earring",
    body="Convoker's Doublet +1", hands=gear.MerlinicDastanas.PhysBP, ring1="Varar Ring +1", ring2="Varar Ring +1",
    back=gear.CampestresCape.PhysBP, waist="Incarnation Sash", legs=gear.ApogeeSlacksPlus1.D, feet=gear.HeliosBoots.PhysBP}

  sets.midcast.Pet.PhysicalBloodPactRage.Acc = {} -- feet="Convoker's Pigaches +3"

  sets.midcast.Pet.MagicalBloodPactRage = {
    main=gear.Grioavolr.MagicBP, sub="Elan Strap +1", ammo="Sancus Sachet +1",
    head=gear.ApogeeCrownPlus1.A, neck="Adad Amulet", ear1="Esper Earring", ear2="Lugalbanda Earring",
    body=gear.ApogeeDalmaticaPlus1.A, hands=gear.MerlinicDastanas.MagicBP, ring1="Varar Ring +1", ring2="Varar Ring +1",
    back=gear.CampestresCape.MagicBP, waist="Incarnation Sash", legs="Enticer's Pants", feet=gear.ApogeePumpsPlus1.A} -- waist="Regal Belt"

  sets.midcast.Pet.MagicalBloodPactRage.Acc = {}

	sets.midcast.Pet['Flaming Crush'] = {
    main=gear.Grioavolr.MagicBP, sub="Elan Strap +1", ammo="Sancus Sachet +1",
    head=gear.ApogeeCrownPlus1.A, neck="Adad Amulet", ear1="Esper Earring", ear2="Lugalbanda Earring",
    body="Convoker's Doublet +1", hands=gear.MerlinicDastanas.MagicBP, ring1="Varar Ring +1", ring2="Varar Ring +1",
    back=gear.CampestresCape.PhysBP, waist="Incarnation Sash", legs=gear.ApogeeSlacksPlus1.D, feet=gear.ApogeePumpsPlus1.A} -- waist="Regal Belt"

	sets.midcast.Pet['Flaming Crush'].Acc = {}

	sets.midcast.Pet['Mountain Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Mountain Buster'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Rock Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Rock Buster'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Crescent Fang'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Crescent Fang'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Eclipse Bite'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Eclipse Bite'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Blindside'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Blindside'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})

  --------------------------------------
  -- Midcast: Pet Magic
  --------------------------------------

  sets.midcast.Pet.WhiteMagic = {legs="Glyphic Spats +1"}

  sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {legs="Glyphic Spats +1"})

  sets.midcast.Pet['Elemental Magic'].Resistant = {}

  --------------------------------------
  -- Midcast: Active Buffs
  --------------------------------------

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Sacrifice Torque"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end

    -- Default macro set/book
    set_macro_page(4, 17)
end
