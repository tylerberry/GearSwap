function user_setup()
	-- Options: Override default values
  state.OffenseMode:options('Normal','Acc')
  state.CastingMode:options('Normal','Resistant','AoE')

  if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
	  state.Weapons:options('None', 'Aeneas/Sari', 'Aeneas/Odium', 'Aeneas/Blurred', 'Dual Vampirism', 'Dual Malevolence')
  else
	  state.Weapons:options('None', 'Aeneas', 'Vampirism', 'Malevolence')
  end

	gear.obi_cure_waist = "Ninurta's Sash"
	gear.obi_low_nuke_waist = "Refoccilation Stone" -- "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	-- How many extra songs we can keep from Daurdabla/Terpander/Linos/Blurred
  info.ExtraSongs = 2

  gear.IntarabussCape = {}
  gear.IntarabussCape.FC = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10'}}

	-- Set this to false if you don't want to use custom timers.
  state.UseCustomTimers = M(true, 'Use Custom Timers')

	-- Additional local binds
  send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

  --------------------------------------
  -- Sets required by rules
  --------------------------------------

  sets.Self_Healing = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
  sets.Cure_Received = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
  sets.Self_Refresh = {back="Grapevine Cape", waist="Gishdubar Sash"}

  sets.Kiting = {feet="Fili Cothurnes +1"}

  --------------------------------------
  -- Base sets
  --------------------------------------

  -- FIXME: Augment Chironic Body and Feet?

  sets.MagicAttackNW = {
    range=empty, ammo="Pemphredo Tathlum",
    head=gear.ChironicHat.Nuke, neck="Sanctity Necklace", ear1="Novio Earring", ear2="Friomisi Earring", -- ear1="Regal Earring"
    body="Chironic Doublet", hands=gear.ChironicGloves.Nuke, ring1="Shiva Ring +1", ring2="Shiva Ring +1",
    back="Toro Cape", waist=gear.ElementalObi, legs=gear.ChironicHose.Nuke, feet="Brioso Slippers +3"}

  sets.MagicAttack = set_combine(sets.MagicAttackNW, {
    main=gear.Grioavolr.MAB, sub="Enki Strap"})

	--------------------------------------
	-- Idle
	--------------------------------------

  sets.idle = {
    main="Mafic Cudgel", sub="Genmei Shield", range=gear.Linos.DT, ammo=empty,
		head="Inyanga Tiara +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
		body=gear.KaykausBliautPlus1.D, hands="Inyanga Dastanas +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
		back="Moonlight Cape", waist="Flume Belt +1", legs="Assiduity Pants +1", feet="Inyanga Crackows +1"}

	--------------------------------------
	-- Defense
	--------------------------------------

	sets.defense.PDT = {
    main="Terra's Staff", sub="Oneiros Grip", range=gear.Linos.DT, ammo=empty,
		head=empty, neck="Loricate Torque +1", ear1="Ethereal Earring", ear2="Etiolation Earring",
		body="Respite Cloak", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
		back="Moonlight Cape", waist="Flume Belt +1", legs="Assiduity Pants +1", feet="Gendewitha Galoshes +1"}

	sets.defense.MDT = {
    main="Terra's Staff", sub="Oneiros Grip", range=gear.Linos.DT, ammo=empty,
		head=empty, neck="Loricate Torque +1", ear1="Ethereal Earring", ear2="Etiolation Earring",
		body="Respite Cloak", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
		back="Moonlight Cape", waist="Flume Belt +1", legs="Assiduity Pants +1", feet="Gendewitha Galoshes +1"}

	--------------------------------------
	-- Resting
	--------------------------------------

	sets.resting = {
    main="Contemplator +1", sub="Oneiros Grip", range=gear.Linos.DT, ammo=empty,
		head=empty, neck="Bathy Choker +1", ear1="Infused Earring", ear2="Dawn Earring",
		body="Respite Cloak", hands="Serpentes Cuffs", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
		back="Kumbira Cape", waist="Flume Belt +1", legs="Assiduity Pants +1", feet="Chelona Boots +1"}

  --------------------------------------
  -- Weapons
  --------------------------------------

  if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
	  sets.weapons['Aeneas/Sari'] = {main="Aeneas", sub=gear.TamingSari.High}
  	sets.weapons['Aeneas/Odium'] = {main="Aeneas", sub="Odium"}
  	sets.weapons['Aeneas/Blurred'] = {main="Aeneas", sub="Blurred Knife +1"}
	  sets.weapons['Dual Vampirism'] = {main=gear.Vampirism.High1, sub=gear.Vampirism.High2}
	  sets.weapons['Dual Malevolence'] = {main=gear.Malevolence.Max, sub=gear.Malevolence.High}
  else
    sets.weapons['Aeneas']= {main="Aeneas", sub="Genmei Shield"}
    sets.weapons['Vampirism']= {main=gear.Vampirism.High1, sub="Genmei Shield"}
    sets.weapons['Malevolence']= {main=gear.Malevolence.Max, sub="Genmei Shield"}
  end

  --------------------------------------
  -- Engaged
  --------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.engaged = {
    main=gear.TamingSari.High, sub="Genmei Shield", range=gear.Linos.TP, ammo=empty,
		head="Ayanmo Zucchetto +2", neck="Asperity Necklace", ear1="Brutal Earring", ear2="Cessance Earring",
		body="Ayanmo Corazza +2", hands="Ayanmo Manopolas +2", ring1="Rajas Ring", ring2="Petrov Ring",
		back="Bleating Mantle", waist="Windbuffet Belt +1", legs="Ayanmo Cosciales +2", feet="Ayanmo Gambieras +2"}

	sets.engaged.Acc = {
    main=gear.TamingSari.High, sub="Genmei Shield", range=gear.Linos.TP, ammo=empty,
		head="Ayanmo Zucchetto +2", neck="Combatant's Torque", ear1="Mache Earring +1", ear2="Mache Earring +1",
		body="Ayanmo Corazza +2", hands="Ayanmo Manopolas +2", ring1="Rajas Ring", ring2="Petrov Ring",
		back="Letalis Mantle", waist="Kentarch Belt +1", legs="Ayanmo Cosciales +2", feet="Ayanmo Gambieras +2"}

  if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
  	sets.engaged.DW = {
      main=gear.TamingSari.High, sub="Odium", range=gear.Linos.TP, ammo=empty,
  		head="Ayanmo Zucchetto +2", neck="Asperity Necklace", ear1="Brutal Earring", ear2="Suppanomimi",
  		body="Ayanmo Corazza +2", hands="Ayanmo Manopolas +2", ring1="Rajas Ring", ring2="Petrov Ring",
  		back="Bleating Mantle", waist="Shetal Stone", legs="Ayanmo Cosciales +2", feet="Ayanmo Gambieras +2"} -- waist="Reiki Yotai"

  	sets.engaged.DW.Acc = {
      main=gear.TamingSari.High, sub="Odium", range=gear.Linos.TP, ammo=empty,
  		head="Ayanmo Zucchetto +2", neck="Combatant's Torque", ear1="Mache Earring +1", ear2="Suppanomimi",
  		body="Ayanmo Corazza +2", hands="Ayanmo Manopolas +2", ring1="Rajas Ring", ring2="Petrov Ring",
  		back="Letalis Mantle", waist="Shetal Stone", legs="Ayanmo Cosciales +2", feet="Ayanmo Gambieras +2"} -- waist="Reiki Yotai"
  end

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------

	sets.precast.WS = {
    range=gear.Linos.TP, ammo=empty,
		head=gear.ChironicHat.TP, neck="Caro Necklace", ear1="Ishvara Earring", ear2="Moonshade Earring",
		body="Bihu Justaucorps +3", hands=gear.ChironicGloves.WSD, ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
		back="Letalis Mantle", waist="Grunfeld Rope", legs=gear.LustratioSubligarPlus1.B, feet=gear.LustratioLeggingsPlus1.D}

  -- Magic weaponskills (INT and magic attack bonus).

  sets.precast.WS.Magic = set_combine(sets.MagicAttackNW, {})

  -- MND-based weaponskills, with no regard to damaging stats. (MND and TP Bonus only, used for Energy Drain and Energy Steal.)

  sets.precast.WS.MaxMND = {
    ammo="Quartz Tathlum +1",
    head=gear.ChironicHat.Nuke, neck="Phalaina Locket", ear1="Lifestorm Earring", ear2="Moonshade Earring", -- neck="Aife's Medal"
    body=gear.VanyaRobe.C, hands="Inyanga Dastanas +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Aurist's Cape +1", waist="Luminary Sash", legs="Inyanga Shalwar +2", feet="Inyanga Crackows +1"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring", ear2="Mache Earring +1"}
	sets.AccMaxTP = {ear1="Ishvara Earring", ear2="Mache Earring +1"}

  --------------------------------------
  -- Precast: Dagger Weaponskills
  --------------------------------------

  -- Wasp Sting: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.


  -- Gust Slash: magical, wind-ele., 40% DEX 40% INT, 1.0/2.0/3.5 fTP.

  sets.precast.WS['Gust Slash'] = set_combine(sets.precast.WS.Magic, {})

  -- Shadowstitch: physical 1-hit, 100% CHR, 1.0 fTP, TP affects chance to bind.


  -- Viper Bite: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.


  -- Cyclone: magical AOE, wind-ele., 40% DEX 40% INT, 1.0/2.375/2.875 fTP.

  sets.precast.WS['Cyclone'] = set_combine(sets.precast.WS.Magic, {})

  sets.precast.WS['Cyclone'].TH = set_combine(sets.precast.WS['Cyclone'], sets.TreasureHunter)

  -- Energy Steal: steals MP, affected by MND and TP.

  sets.precast.WS['Energy Steal'] = set_combine(sets.precast.WS.MaxMND, {})

  -- Energy Drain: steals MP, affected by MND and TP.

  sets.precast.WS['Energy Drain'] = set_combine(sets.precast.WS.MaxMND, {})

  -- Dancing Edge: physical 5-hit, 40% DEX 40% CHR, 1.1875 fTP, TP affects accuracy.
  sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", waist="Fotia Belt"})

  -- Shark Bite: physical 2-hit, 40% DEX 40% AGI, 4.5/6.8/8.5 fTP.
  sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})

  -- Evisceration: physical 5-hit, 50% DEX, 1.25 fTP, TP affects chance to crit.
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear2="Moonshade Earring",
    ring1="Ramuh Ring +1",
    waist="Fotia Belt"})

  -- Aeolian Edge: magical AOE, wind-ele., 40% DEX 40% INT, 2.0/3.0/4.5 fTP.
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.Magic, {})

  sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

  -- Exenterator: physical 4-hit, 73~85% AGI, 1.0 fTP, TP affects duration of accuracy down.
  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ring1="Petrov Ring", waist="Fotia Belt"})

  -- Mordant Rime: physical 2-hit, 30% DEX 70% CHR, 5.0 fTP, TP affects chance of decreasing movement speed.
  sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {})

  -- Rudra's Storm: physical 1-hit, 80% DEX, 5.0/10.19/13.0 fTP.
  sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
    ear1="Ishvara Earring", ear2="Moonshade Earring", ring1="Ramuh Ring +1"})

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

	sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	sets.precast.JA.Troubadour = {body="Bihu Justaucorps +3"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

	sets.precast.FC = {
    main=gear.Grioavolr.MAB, sub="Clerisy Strap +1", range=empty, ammo="Sapience Orb",                        --  4, 3,  -,  2
		head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",  -- 10, 5,  2,  2
		body="Inyanga Jubbah +2", hands="Leyline Gloves", ring1="Lebeche Ring", ring2="Kishar Ring",              -- 13, 8, QC,  4
		back=gear.IntarabussCape.FC, waist="Witful Belt", legs="Ayanmo Cosciales +2", feet="Chelona Boots +1"}    -- 10, 3,  6,  5

  if player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH" or player.sub_job == "PLD" then
  	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
      head=gear.VanyaHood.D, neck="Loricate Torque +1", ear1="Enchanter Earring +1", ear2="Mendicant's Earring",
      body="Inyanga Jubbah +2", hands="Leyline Gloves", ring1="Lebeche Ring", ring2="Kishar Ring",
      back=gear.IntarabussCape.FC, waist="Witful Belt", legs="Doyen Pants", feet=gear.VanyaClogs.D})
  end

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

  if player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH" then
    sets.precast.FC['Stoneskin'] = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Doyen Pants"})
  end

  -- These Telchine Pigaches have -7% song casting time augment.
	sets.precast.FC.BardSong = {
    main=gear.Kali.A, sub="Genmei Shield", range="Gjallarhorn", ammo=empty,
		head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
		body="Inyanga Jubbah +1", hands="Gendewitha Gages +1", ring1="Lebeche Ring", ring2="Kishar Ring",
		back=gear.IntarabussCape.FC, waist="Witful Belt", legs="Gendewitha Spats +1", feet=gear.TelchinePigaches.Enh}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong, {}) -- range="Marsyas"
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong, {range="Gjallarhorn", ammo=empty})

	sets.precast.FC.Lullaby = {} -- range="Marsyas"
	sets.precast.FC.Lullaby.Resistant = {range="Gjallarhorn", ammo=empty}

	sets.precast.FC['Horde Lullaby'] = {} -- range="Marsyas"
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Gjallarhorn", ammo=empty}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Daurdabla", ammo=empty}

	sets.precast.FC['Horde Lullaby II'] = {} -- range="Marsyas"
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Gjallarhorn", ammo=empty}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Daurdabla", ammo=empty}

	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong, {}) -- range="Marsyas"
	--sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, {range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range="Daurdabla", ammo=empty})
	sets.precast.DaurdablaDummy = set_combine(sets.precast.FC.Daurdabla, {})

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

	sets.midcast.FastRecast = {
    main=gear.Grioavolr.MAB, sub="Clerisy Strap +1", ammo="Hasty Pinion +1",
		head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
		body="Inyanga Jubbah +1", hands="Leyline Gloves", ring1="Defending Ring", ring2="Prolix Ring",
		back=gear.IntarabussCape.FC, waist="Witful Belt", legs="Ayanmo Cosciales +2", feet="Gendewitha Galoshes +1"}

  --------------------------------------
  -- Midcast: Bard Songs
  --------------------------------------

	sets.midcast.Ballad = {legs="Fili Rhingrave +1"}

	sets.midcast.Lullaby = {range="Gjallarhorn", ammo=empty} -- {range="Marsyas", ammo=empty}
	sets.midcast.Lullaby.Resistant = {range="Gjallarhorn", ammo=empty}

	sets.midcast['Horde Lullaby'] = {range="Gjallarhorn", ammo=empty} -- {range="Marsyas", ammo=empty}
	sets.midcast['Horde Lullaby'].Resistant = {range="Gjallarhorn", ammo=empty}
	sets.midcast['Horde Lullaby'].AoE = {range="Daurdabla", ammo=empty}

	sets.midcast['Horde Lullaby II'] = {range="Gjallarhorn", ammo=empty} -- {range="Marsyas", ammo=empty}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Gjallarhorn", ammo=empty}
	sets.midcast['Horde Lullaby II'].AoE = {range="Daurdabla", ammo=empty}

	sets.midcast.Madrigal = {head="Fili Calot +1"}
	sets.midcast.Paeon = {} -- head="Brioso Roundlet +3"

	sets.midcast.March = {hands="Fili Manchettes +1"}
	--sets.midcast['Honor March'] = set_combine(sets.midcast.March, {range="Marsyas", ammo=empty})

	--sets.midcast.Mazurka = {range="Marsyas", ammo=empty}
	sets.midcast.Minuet = {body="Fili Hongreline +1"}
	sets.midcast.Minne = {}
	sets.midcast.Carol = {}

	sets.midcast['Magic Finale'] = {range="Gjallarhorn", ammo=empty}
	sets.midcast["Sentinel's Scherzo"] = {} --feet="Fili Cothurnes +1", Brioso Slippers still provides more Duration

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
    main=gear.Kali.A, sub="Genmei Shield", range="Gjallarhorn", ammo=empty,
		head="Fili Calot +1", neck="Moonbow Whistle +1", ear1="Genmei Earring", ear2="Etiolation Earring",
		body="Fili Hongreline +1", hands="Fili Manchettes +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1", -- Defensive rings with job mastery.
		back=gear.IntarabussCape.FC, waist="Flume Belt +1", legs="Inyanga Shalwar +2", feet="Brioso Slippers +3"}

	sets.midcast.SongEffect.DW = set_combine(sets.midcast.SongEffect, {})

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
    main=gear.Kali.A, sub="Genmei Shield", range="Gjallarhorn", ammo=empty, -- sub="Ammurapi Shield", range="Marsyas"
		head="Brioso Roundlet +2", neck="Moonbow Whistle +1", ear1="Enchanter Earring +1", ear2="Dignitary's Earring",
		body="Fili Hongreline +1", hands="Brioso Cuffs +3", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
		back=gear.IntarabussCape.FC, waist="Luminary Sash", legs="Inyanga Shalwar +2", feet="Brioso Slippers +3"}

	sets.midcast.SongDebuff.DW = {}

	-- For song debuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {
    main=gear.Grioavolr.MAB, sub="Enki Strap", range="Gjallarhorn", ammo=empty, -- main="Kali", sub="Ammurapi Shield"
		head="Brioso Roundlet +2", neck="Moonbow Whistle +1", ear1="Enchanter Earring +1", ear2="Dignitary's Earring",
		body="Brioso Justaucorps +2", hands="Brioso Cuffs +3", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
		back=gear.IntarabussCape.FC, waist="Luminary Sash", legs="Brioso Cannions +2", feet="Brioso Slippers +3"}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {
    main=gear.Grioavolr.MAB, sub="Clerisy Strap +1", range="Gjallarhorn", ammo=empty,
		head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
		body="Inyanga Jubbah +2", hands="Gendewitha Gages +1", ring1="Kishar Ring", ring2="Prolix Ring",
		back=gear.IntarabussCape.FC, waist="Witful Belt", legs="Fili Rhingrave +1", feet="Ayanmo Gambieras +2"}

	-- Cast spell with normal gear, except using Daurdabla instead
  sets.midcast.Daurdabla = {range="Daurdabla", ammo=empty}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
  sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range="Daurdabla", ammo=empty})

  --------------------------------------
  -- Midcast: Elemental Magic
  --------------------------------------

  sets.midcast['Elemental Magic'] = set_combine(sets.MagicAttack, {})

  --------------------------------------
  -- Midcast: Enhancing Magic
  --------------------------------------

  if player.sub_job == "PLD" or player.sub_job == "RDM" or player.sub_job == "RUN" or player.sub_job == "SCH" or player.sub_job == "WHM" then
    sets.midcast['Enhancing Magic'] = {
      main="Serenity", sub="Fulcio Grip", range=empty, ammo="Hasty Pinion +1",
      head=gear.TelchineCap.Enh, neck="Incanter's Torque", ear1="Andoaa Earring", ear2="Gifted Earring",
      body=gear.TelchineChasuble.Enh, hands=gear.TelchineGloves.Enh, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
      back="Fi Follet Cape +1", waist="Witful Belt", legs=gear.TelchineBraconi.Enh, feet=gear.TelchinePigaches.Enh}
  end

  if player.sub_job == "RDM" or player.sub_job == "RUN" or player.sub_job == "SCH" or player.sub_job == "WHM" then
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
      neck="Stone Gorget", ear2="Earthcry Earring", waist="Siegel Sash", legs="Shedir Seraweels"})
  end

  --------------------------------------
  -- Midcast: Healing Magic
  --------------------------------------

  if player.sub_job == "PLD" or player.sub_job == "RDM" or player.sub_job == "SCH" or player.sub_job == "WHM" then
  	sets.midcast.Cure = {
      head=gear.KaykausMitraPlus1.B, neck="Incanter's Torque", ear1="Novia Earring", ear2="Mendicant's Earring",
      body="Inyanga Jubbah +1", hands=gear.KaykausCuffsPlus1.A, ring1="Kuchekula Ring", ring2="Menelaus's Ring",
      back="Thaumaturge's Cape", waist=gear.ElementalObi, legs="Gyve Trousers", feet=gear.KaykausBootsPlus1.B}
  end

  if player.sub_job == "SCH" or player.sub_job == "WHM" then
  	sets.midcast.Cursna =  set_combine(sets.midcast.FastRecast, {
      neck="Debilis Medallion", ear2="Beatific Earring", -- head=gear.KaykausMitraPlus1.B
      ring1="Haoma's Ring", ring2="Menelaus's Ring", -- hands="Hieros Mittens",
      back="Tempered Cape +1", waist="Bishop's Sash", feet=gear.VanyaClogs.D})

  	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
  end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(10, 10)
end
