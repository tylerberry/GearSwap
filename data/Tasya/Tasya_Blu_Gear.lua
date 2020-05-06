function user_setup()
	-- Options: Override default values
  state.OffenseMode:options('Fodder','Normal','MinAcc','SomeAcc','Acc','HighAcc','FullAcc')
	state.HybridMode:options('Normal','DTLite','PDT','MDT')
  state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','HighAcc','FullAcc','Fodder')
  state.CastingMode:options('Normal','Resistant','Fodder','Proc')
  state.IdleMode:options('Normal','Sphere','PDT','DTHippo')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Naegling/Thibron','Naegling/Colada','None','Naegling/Maxentius','Vampirisms')

  state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','MP','SuppaBrutal','DWEarrings','DWMax'}

  gear.RosmertasCape = {}
  gear.RosmertasCape.Crit = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10'}}
  gear.RosmertasCape.WSD = {name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}

	gear.obi_cure_waist = "Luminary Sash"
	gear.obi_nuke_waist = "Yamabuki-no-Obi"

	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind @` input /ja "Efflux" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	--send_command('bind @backspace input /ja "Convergence" <me>')
	--send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	send_command('bind !r gs c weapons Nibirus;gs c update')
	--send_command('bind @q gs c weapons MaccWeapons;gs c update')
	--send_command('bind ^q gs c weapons Almace;gs c update')
	send_command('bind !q gs c weapons Vampirism;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

  --------------------------------------
  -- Sets required by rules
  --------------------------------------

	sets.Assault = {ring1="Balrahn's Ring"}
  sets.DayIdle = {}

	sets.DWEarrings = {ear1="Eabani Earring", ear2="Suppanomimi"}
	sets.DWMax = {
    ear1="Eabani Earring", ear2="Suppanomimi",
    body=gear.AdhemarJacketPlus1.B,
    waist="Reiki Yotai", legs=gear.CarmineCuissesPlus1.D}

  sets.HPDown = {
    head="Pixie Hairpin +1", ear1="Mendicant's Earring", -- ear2="Evans Earring",
    body="Jhakri Robe +2", hands="Jhakri Cuffs +2", -- ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
    back="Swith Cape +1", legs="Shedir Seraweels", feet="Jhakri Pigaches +1"}

	sets.Kiting = {legs=gear.CarmineCuissesPlus1.D}

  sets.latent_refresh = {waist="Fucho-no-Obi"}

  -- Gear for learning spells: +skill and AF hands.
  --     ammo="Mavi Tathlum",
  --     head="Luhlaza Keffiyeh +1", neck="Incanter's Torque",
  --     body="Assimilator's Jubbah +1", hands="Assimilator's Bazubands +1",
  --     back="Cornflower Cape", legs="Hashishin Tayt +1", feet="Luhlaza Charuqs +1"
  sets.Learning = {hands="Assimilator's Bazubands +1"}

  sets.NightIdle = {}

	sets.SuppaBrutal = {ear1="Brutal Earring", ear2="Suppanomimi"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

  -- Extra Melee sets.  Apply these on top of melee sets.
  sets.Knockback = {}
  sets.MP = {waist="Flume Belt +1", ear2="Ethereal Earring"}
  sets.MP_Knockback = {}

	sets.Self_Healing = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
	sets.Self_Healing_Club = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
	sets.Self_Healing_DWClub = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
	sets.Healing_Club = {}
	sets.Healing_DWClub = {}
	sets.Cure_Received = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash", back="Grapevine Cape"}

  --------------------------------------
  -- Base sets
  --------------------------------------

  sets.Healing = {
    main="Naegling", sub="Kaja Rod", ammo="Hasty Pinion +1",
    head=gear.CarmineMaskPlus1.D, neck="Phalaina Locket", ear1="Mendicant's Earring", ear2="Loquacious Earring",
    body="Vrikodara Jupon", hands="Leyline Gloves", ring1="Prolix Ring", ring2="Stikini Ring +1",
    back="Solemnity Cape", waist=gear.ElementalObi, legs="Gyve Trousers", feet="Medium's Sabots"}

  sets.MagicAccuracy = {
    ammo="Pemphredo Tathlum",
    head=gear.CarmineMaskPlus1.D, neck="Sanctity Necklace", ear1="Dignitary's Earring", ear2="Gwati Earring",
    body=gear.AmalricDoubletPlus1.A, hands="Ayanmo Manopolas +2", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Cornflower Cape", waist="Luminary Sash", legs="Malignance Tights", feet="Ayanmo Gambieras +2"}

  sets.HybridAccuracy = set_combine(sets.MagicAccuracy, {
    ammo="Falcon Eye", body="Malignance Tabard", waist="Eschan Stone"})

  sets.MagicAttack = {
    ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2", neck="Baetyl Pendant", ear1="Novio Earring", ear2="Friomisi Earring",
    body=gear.AmalricDoubletPlus1.A, hands=gear.AmalricGagesPlus1.A, ring1="Shiva Ring +1", ring2="Shiva Ring +1",
    back="Cornflower Cape", waist=gear.ElementalObi, legs=gear.AmalricSlopsPlus1.A, feet=gear.AmalricNailsPlus1.A}

  sets.MagicAttackWeapons = set_combine(sets.MagicAttack, {main="Naegling", sub="Kaja Rod"})

	sets.PlusEnmity = {
		ammo="Sapience Orb",
		head="Rabid Visor", neck="Unmoving Collar +1", ear1="Friomisi Earring", ear2="Cryptic Earring",
		body="Emet Harness +1", hands="Enif Manopolas", ring1="Eihwaz Ring", ring2="Supershear Ring",
		back="Agema Cape", waist="Kasiri Belt", legs="Zoar Subligar +1"} -- feet="Ahosi Leggings"

  --------------------------------------
  -- Elemental Affinity
  --------------------------------------

	sets.element.Dark = {head="Pixie Hairpin +1", ring2="Archon Ring"}
	sets.element.Earth = {neck="Quanpur Necklace"}
	sets.element.Light = {} --ring2="Weatherspoon Ring +1"

  --------------------------------------
  -- Idle
  --------------------------------------

  sets.idle = {
    main="Medeina Kilij", sub="Bolelabunga", ammo="Staunch Tathlum +1",
    head=gear.RawhideMask.A, neck="Bathy Choker +1", ear1="Infused Earring", ear2="Dawn Earring",
    body="Jhakri Robe +2", hands=gear.HerculeanGloves.Refresh, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Kumbira Cape", waist="Flume Belt +1", legs="Lengo Pants", feet="Serpentes Sabots"}

	sets.idle.Sphere = set_combine(sets.idle, {body="Mekosuchinae Harness"})

  -- Lots of possible better options for this set.
  --   Ayanmo pieces, Ahosi Leggings, AF+3 hands...
  sets.idle.PDT = {
    main="Medeina Kilij", sub="Bolelabunga", ammo="Staunch Tathlum +1",
    head=gear.RawhideMask.A, neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Ethereal Earring",
    body="Hagondes Coat +1", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs="Lengo Pants", feet="Hagondes Sabots +1"}

  sets.idle.DTHippo = set_combine(sets.idle.PDT, {legs=gear.CarmineCuissesPlus1.D, feet="Hippomenes Socks +1"})

  --------------------------------------
  -- Defense
  --------------------------------------

  -- Avoid relying on weapons for DT in these sets, because they could be locked depends on weapons toggle.

  -- Currently this is at PDT-49.
  sets.defense.PDT = {
    main="Medeina Kilij", sub="Bolelabunga", ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Brutal Earring", ear2="Suppanomimi",
    body="Ayanmo Corazza +2", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Shetal Stone", legs=gear.HerculeanTrousers.HybridWhy, feet=gear.HerculeanBoots.TA}

  -- Assumes trust Shell V, MDT-24.
  sets.defense.MDT = {
    main="Medeina Kilij", sub="Bolelabunga", ammo="Staunch Tathlum +1",
    head="Dampening Tam",
    body="Ayanmo Corazza +2", ring1="Defending Ring", ring2="Shadow Ring",
    back="Engulfer Cape +1"}

  -- Augmented telchine with MEVA+25 would win across the board here.
  sets.defense.MEVA = {
    main="Medeina Kilij", sub="Bolelabunga", ammo="Staunch Tathlum +1",
    head="Gendewitha Caubeen +1", neck="Warder's Charm +1", ear2="Genmei Earring", ear2="Etiolation Earring", -- head=gear.AmalricCoifPlus1.D, ear1="Sanare Earring"
    body=gear.AmalricDoubletPlus1.A, hands="Leyline Gloves", ring1="Defending Ring", ring2=gear.DarkRing.PDT, -- ring1="Vengeful Ring", ring2="Purity Ring",
    back="Engulfer Cape +1", waist="Flume Belt +1", legs=gear.AmalricSlopsPlus1.A, feet=gear.AmalricNailsPlus1.A} -- back=gear.RosmertasCape.MAB

  --------------------------------------
  -- Resting
  --------------------------------------

  sets.resting = {
    main="Medeina Kilij", sub="Bolelabunga", ammo="Tsar's Egg",
    head=gear.RawhideMask.A, neck="Bathy Choker +1", ear1="Infused Earring", ear2="Dawn Earring",
    body="Jhakri Robe +2", hands=gear.HerculeanGloves.Refresh, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Kumbira Cape", waist="Flume Belt +1", legs="Lengo Pants", feet="Chelona Boots +1"}

  --------------------------------------
	-- Weapons
	--------------------------------------

  sets.weapons['Naegling/Thibron'] = {main="Naegling", sub="Thibron"}
  sets.weapons['Naegling/Colada'] = {main="Naegling", sub=gear.Colada.DA}
  sets.weapons['Naegling/Maxentius'] = {main="Naegling", sub="Kaja Rod"}
  sets.weapons['Vampirisms'] = {main=gear.Vampirism.High1, sub=gear.Vampirism.High2}
  -- sets.weapons.MaccWeapons = {main="Iris", sub="Iris"}

  --------------------------------------
	-- Engaged
	--------------------------------------

  sets.engaged = {
    main="Naegling", sub="Thibron", ammo="Aurgelmir Orb",
    head=gear.AdhemarBonnetPlus1.B, neck="Asperity Necklace", ear1="Brutal Earring", ear2="Cessance Earring",
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Epona's Ring", ring2="Petrov Ring",
    back=gear.RosmertasCape.Crit, waist="Windbuffet Belt +1", legs=gear.TaeonTights.TA, feet=gear.HerculeanBoots.TA}

	sets.engaged.MinAcc = set_combine(sets.engaged, {head="Dampening Tam", neck="Combatant's Torque"})

	sets.engaged.SomeAcc = set_combine(sets.engaged.MinAcc, {ammo="Falcon Eye"}) -- ear2="Telos Earring", feet=gear.herculean_acc_feet

	sets.engaged.Acc = set_combine(sets.engaged.SomeAcc, {body="Ayanmo Corazza +2", legs=gear.CarmineCuissesPlus1.D})

	sets.engaged.HighAcc = set_combine(sets.engaged.Acc, {
    head=gear.CarmineMaskPlus1.D, -- ear1="Regal Earring"
    ring1="Ramuh Ring +1", ring2="Ilabrat Ring"}) -- body="Assimilator's Jubbah +3", hands="Assimilator's Bazubands +3"

  sets.engaged.FullAcc = set_combine(sets.engaged.HighAcc, {ring2="Ramuh Ring +1", waist="Olseni Belt"})

  sets.engaged.Fodder = set_combine(sets.engaged, {}) -- neck="Ainia Collar",ear2="Dedition Earring"

  -- DTLite hybrid

  sets.engaged.DTLite = set_combine(sets.engaged, {
    head="Dampening Tam", neck="Loricate Torque +1",
    body="Ayanmo Corazza +2", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2="Patricius Ring", -- hands="Assimilator's Bazubands +3"
    waist="Shetal Stone", legs="Ayanmo Cosciales +2"}) -- waist="Reiki Yotai", feet="Ahosi Leggings"

  sets.engaged.MinAcc.DTLite = set_combine(sets.engaged.DTLite, {}) -- ear2="Telos Earring"

  sets.engaged.SomeAcc.DTLite = set_combine(sets.engaged.MinAcc.DTLite, {})

  sets.engaged.Acc.DTLite = set_combine(sets.engaged.SomeAcc.DTLite, {ammo="Falcon Eye", ear1="Dignitary's Earring"})

  sets.engaged.HighAcc.DTLite = set_combine(sets.engaged.Acc.DTLite, {head=gear.CarmineMaskPlus1.D})

  sets.engaged.FullAcc.DTLite = set_combine(sets.engaged.HighAcc.DTLite, {}) -- ear2="Regal Earring", feet=gear.herculean_acc_feet

  sets.engaged.Fodder.DTLite = set_combine(sets.engaged.DTLite, {ear2="Suppanomimi", waist="Windbuffet Belt +1"})

  -- PDT hybrid

  sets.engaged.PDT = set_combine(sets.engaged, {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Dignitary's Earring", ear2="Suppanomimi",
    body="Ayanmo Corazza +2", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2="Patricius Ring", -- hands="Assimilator's Bazubands +3"
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.HerculeanTrousers.HybridWhy, feet=gear.HerculeanBoots.TA}) -- feet="Ahosi Leggings"

  sets.engaged.MinAcc.PDT = set_combine(sets.engaged.PDT, {ammo="Aurgelmir Orb"}) -- ear2="Telos Earring"

  sets.engaged.SomeAcc.PDT = set_combine(sets.engaged.MinAcc.PDT, {ammo="Falcon Eye"})

  sets.engaged.Acc.PDT = set_combine(sets.engaged.SomeAcc.PDT, {legs="Ayanmo Cosciales +2"})

  sets.engaged.HighAcc.PDT = set_combine(sets.engaged.Acc.PDT, {head=gear.CarmineMaskPlus1.D, legs=gear.CarmineCuissesPlus1.D})

  sets.engaged.FullAcc.PDT = set_combine(sets.engaged.HighAcc.PDT, {
    back=gear.RosmertasCape.Crit, waist="Olseni Belt"}) -- DA cape?, ear2="Regal Earring", feet=gear.herculean_acc_feet

  sets.engaged.Fodder.PDT = set_combine(sets.engaged.PDT, {waist="Windbuffet Belt +1"})

  -- MDT hybrid

  sets.engaged.MDT = set_combine(sets.engaged, {
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Dignitary's Earring", ear2="Suppanomimi", -- Telos Earring?
    ring1="Defending Ring", -- hands="Assimilator's Bazubands +3"
    back="Engulfer Cape +1", legs="Ayanmo Cosciales +2"}) -- feet="Ahosi Leggings"

  sets.engaged.MinAcc.MDT = set_combine(sets.engaged.MDT, {ammo="Falcon Eye", ear2="Cessance Earring"})

  sets.engaged.SomeAcc.MDT = set_combine(sets.engaged.MinAcc.MDT, {ear2="Suppanomimi"}) -- legs="Samnuha Tights"

  sets.engaged.Acc.MDT = set_combine(sets.engaged.SomeAcc.MDT, {waist="Olseni Belt"})

  sets.engaged.HighAcc.MDT = set_combine(sets.engaged.Acc.MDT, {legs=gear.CarmineCuissesPlus1.D})

  sets.engaged.FullAcc.MDT = set_combine(sets.engaged.HighAcc.MDT, {
    back=gear.RosmertasCape.Crit}) -- feet=gear.herculean_acc_feet

  sets.engaged.Fodder.MDT = set_combine(sets.engaged.MDT, {})

  --[[
  -- Tizona AM3

	sets.engaged.AM = set_combine(sets.engaged, {
    ear1="Telos Earring", back=gear.RosmertasCape.STP, feet=gear.CarmineGreavesPlus1.B})

	sets.engaged.MinAcc.AM = set_combine(sets.engaged.AM, {head="Dampening Tam", neck="Combatant's Torque"})

	sets.engaged.SomeAcc.AM = set_combine(sets.engaged.MinAcc.AM, {ring2="Ilabrat Ring"})

	sets.engaged.Acc.AM = set_combine(sets.engaged.SomeAcc.AM, {
    ammo="Falcon Eye", ear2="Dignitary's Earring",
    body="Ayanmo Corazza +2",
    legs=gear.CarmineCuissesPlus1.D, feet=gear.herculean_acc_feet})

	sets.engaged.HighAcc.AM = set_combine(sets.engaged.Acc.AM, {
    head=gear.CarmineMaskPlus1.D, ear2="Regal Earring",
    body="Assimilator's Jubbah +3", hands="Assimilator's Bazubands +3", ring1="Ramuh Ring +1"})

  sets.engaged.FullAcc.AM = set_combine(sets.engaged.HighAcc.AM, {ring2="Ramuh Ring +1", waist="Olseni Belt"})

  sets.engaged.Fodder.AM = set_combine(sets.engaged.AM, {neck="Ainia Collar",ear1="Dedition Earring"})

  sets.engaged.DTLite.AM = set_combine(sets.engaged.AM, {
    head="Dampening Tam", neck="Loricate Torque +1",
    body="Ayanmo Corazza +2", hands="Assimilator's Bazubands +3", ring1="Defending Ring", ring2="Patricius Ring",
    waist="Reiki Yotai", legs="Ayanmo Cosciales +2", feet="Ahosi Leggings"})

  sets.engaged.Fodder.DTLite.AM = set_combine(sets.engaged.AM, {
    head="Dampening Tam", neck="Loricate Torque +1", ear2="Suppanomimi",
    body="Ayanmo Corazza +2", hands="Assimilator's Bazubands +3", ring1="Defending Ring", ring2="Patricius Ring",
    legs="Ayanmo Cosciales +2", feet="Ahosi Leggings"})
  --]]

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------

  -- Default, STR weaponskills

  sets.precast.WS = {
    ammo="Aurgelmir Orb",
    head="Lilitu Headpiece", neck="Caro Necklace", ear1="Brutal Earring", ear2="Cessance Earring",
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Epona's Ring", ring2="Ifrit Ring +1",
    back=gear.RosmertasCape.WSD, waist="Prosilio Belt +1", legs=gear.TaeonTights.TA, feet=gear.HerculeanBoots.WSD}

  sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {
    ammo="Mantoptera Eye", head="Dampening Tam"})

  sets.precast.WS.Acc = set_combine(sets.precast.WS.SomeAcc, {
    head=gear.CarmineMaskPlus1.D, ear1="Dignitary's Earring", -- ear1="Telos Earring", ear2="Regal Earring"
    ring2="Ilabrat Ring", -- body="Assimilator's Jubbah +2", hands="Assimilator's Bazubands +3"
    legs=gear.CarmineCuissesPlus1.D})

  sets.precast.WS.HighAcc = set_combine(sets.precast.WS.Acc, {
    ammo="Falcon Eye",
    ring1="Ramuh Ring +1"}) -- feet=gear.herculean_acc_feet

  sets.precast.WS.FullAcc = set_combine(sets.precast.WS.HighAcc, {
    neck="Combatant's Torque", ring2="Ramuh Ring +1", waist="Olseni Belt"})

  sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

  -- DEX weaponskills

  sets.precast.WS.DEX = {
    ammo="Aurgelmir Orb",
    head="Lilitu Headpiece", neck="Caro Necklace", ear1="Mache Earring +1", ear2="Mache Earring +1",
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Epona's Ring", ring1="Ramuh Ring +1",
    back=gear.RosmertasCape.Crit, waist="Windbuffet Belt +1", legs=gear.TaeonTights.TA, feet=gear.HerculeanBoots.WSD}

  sets.precast.WS.DEX.SomeAcc = set_combine(sets.precast.WS.DEX, {ammo="Falcon Eye", head="Dampening Tam"})

  sets.precast.WS.DEX.Acc = set_combine(sets.precast.WS.DEX.SomeAcc, {
    head=gear.CarmineMaskPlus1.D,
    ring2="Ilabrat Ring", -- body="Assimilator's Jubbah +3", hands="Assimilator's Bazubands +3"
    legs=gear.CarmineCuissesPlus1.D})

  sets.precast.WS.DEX.HighAcc = set_combine(sets.precast.WS.DEX.Acc, {
    ring1="Ramuh Ring +1"}) -- feet=gear.herculean_acc_feet

  sets.precast.WS.DEX.FullAcc = set_combine(sets.precast.WS.DEX.HighAcc, {
    neck="Combatant's Torque", waist="Olseni Belt"})

  sets.precast.WS.DEX.Fodder = set_combine(sets.precast.WS.DEX, {})

  -- Crit-focused DEX weaponskills

  sets.precast.WS.DEX.Crit = set_combine(sets.precast.WS.DEX, {
    head=gear.AdhemarBonnetPlus1.B,
    body="Abnoba Kaftan", hands=gear.AdhemarWristbandsPlus1.B, ring2="Begrudging Ring",
    back=gear.RosmertasCape.Crit, legs="Ta'lab Trousers", feet="Thereoid Greaves"})

  sets.precast.WS.DEX.Crit.SomeAcc = set_combine(sets.precast.WS.DEX.Crit, {
    ammo="Falcon Eye", head="Dampening Tam"})

  sets.precast.WS.DEX.Crit.Acc = set_combine(sets.precast.WS.DEX.Crit.SomeAcc, {
    head=gear.CarmineMaskPlus1.D,
    ring2="Ilabrat Ring", -- body="Assimilator's Jubbah +3", hands="Assimilator's Bazubands +3"
    legs=gear.CarmineCuissesPlus1.D})

  sets.precast.WS.DEX.Crit.HighAcc = set_combine(sets.precast.WS.DEX.Crit.Acc, {
    ring1="Ramuh Ring +1"}) -- feet=gear.herculean_acc_feet

  sets.precast.WS.DEX.Crit.FullAcc = set_combine(sets.precast.WS.DEX.Crit.HighAcc, {
    neck="Combatant's Torque", waist="Olseni Belt"})

  sets.precast.WS.DEX.Crit.Fodder = set_combine(sets.precast.WS.DEX.Crit, {})

  -- Magic weaponskill sets.

  sets.precast.WS.Magic = set_combine(sets.MagicAttack, {})

  -- Swap to these on Moonshade using WS if at 3000 TP
  sets.MaxTP = {ear1="Brutal Earring", ear2="Cessance Earring"}
  sets.AccMaxTP = {ear1="Mache Earring +1", ear2="Mache Earring +1"} -- {ear1="Telos Earring", ear2="Regal Earring"}

  --------------------------------------
  -- Precast: Club Weaponskills
  --------------------------------------

  -- Shining Strike: magic, light ele., 40% STR 40% MND, 1.625/3.0/4.625 fTP.
	sets.precast.WS['Shining Strike'] = set_combine(sets.precast.MagicWS, {ear2="Moonshade Earring"})

  -- Seraph Strike: magic, light ele., 40% STR 40% MND, 2.125/3.675/6.125 fTP.
	sets.precast.WS['Shining Strike'] = set_combine(sets.precast.MagicWS, {ear2="Moonshade Earring"})

	-- Brainshaker: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to stun.
	sets.precast.WS['Brainshaker'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", waist="Fotia Belt"})

	-- Starlight: restores MP, only modified by TP.
	sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

	-- Moonlight: restores MP to party, only modified by TP.
	sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}

	-- Skullbreaker: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to apply -10 INT.
	sets.precast.WS['Skullbreaker'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget",belt="Fotia Belt"})

	-- True Strike: physical 1-hit, 100% STR, 1.0 fTP, guaranteed crit, TP affects accuracy.
	sets.precast.WS['True Strike'] = set_combine(sets.precast.WS, {
    head=gear.AdhemarBonnetPlus1.B, neck="Fotia Gorget", ear2="Moonshade Earring",
    body="Abnoba Kaftan",
    belt="Fotia Belt"})

	-- Judgment: physical 1-hit, 50% STR 50% MND, 3.5/8.75/12.0 fTP.
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})

	-- Black Halo: physical 2-hit, 30% STR 70% MND, 3.0/7.25/9.75 fTP.
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
    ear2="Moonshade Earring",ring1="Stikini Ring +1",ring2="Stikini Ring +1"})

	-- Flash Nova: magic, light ele., 50% STR 50% MND, 3.0 fTP, TP affects chance to flash.

  sets.precast.WS['Flash Nova'] = set_combine(sets.precast.MagicWS, sets.element.Light)

	-- Realmrazer: physical 7-hit, 73~85% MND, 0.88 fTP on all hits, TP affects accuracy.

  sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {
    head="Jhakri Coronal +2", -- ear1="Regal Earring",
    body="Jhakri Robe +2", ring2="Rufescent Ring",
    legs="Jhakri Slops +1", feet="Jhakri Pigaches +1"})

  sets.precast.WS['Realmrazer'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {
    head="Jhakri Coronal +2", -- ear1="Regal Earring", ear2="Telos Earring",
    body="Jhakri Robe +2", ring2="Rufescent Ring",
    legs="Jhakri Slops +1", feet="Jhakri Pigaches +1"})

  sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc, {
    head="Jhakri Coronal +2", -- ear1="Regal Earring", ear2="Telos Earring",
    ring1="Rufescent Ring",
    legs="Jhakri Slops +1", feet="Jhakri Pigaches +1"})

  sets.precast.WS['Realmrazer'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
    ring1="Rufescent Ring",feet="Jhakri Pigaches +1"})

  sets.precast.WS['Realmrazer'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
  sets.precast.WS['Realmrazer'].Fodder = set_combine(sets.precast.WS['Realmrazer'], {})

  --------------------------------------
  -- Precast: Sword Weaponskills
  --------------------------------------

  -- Fast Blade: physical 2-hit, 40% STR 40% DEX, 1.0/1.5/2.0 fTP.

  sets.precast.WS['Fast Blade'] = set_combine(sets.precast.WS.DEX, {
    ear1="Ishvara Earring", ear2="Moonshade Earring"})

  -- Burning Blade: magical fire-ele., 40% STR 40% INT, 1.0/2.098/3.398 fTP.

  sets.precast.WS['Burning Blade'] = set_combine(sets.precast.MagicWS, {ear2="Moonshade Earring"})

  -- Red Lotus Blade: magical fire-ele., 40% STR 40% INT, 1.0/2.383/3.75 fTP.

  sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.MagicWS, {ear2="Moonshade Earring"})

  -- Flat Blade: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to stun.

  sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Ishvara Earring", ear2="Moonshade Earring", waist="Fotia Belt"})

  -- Shining Blade: magical light-ele., 40% STR 40% MND, 1.125/2.223/3.523 fTP.

  sets.precast.WS['Shining Blade'] = set_combine(sets.precast.MagicWS, {
    ear2="Moonshade Earring", ring1="Fenrir Ring +1", ring2="Fenrir Ring +1"})

  -- Seraph Blade: magical light-ele., 40% STR 40% MND, 1.125/2.625/4.125 fTP.

  sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.MagicWS, {
    ear2="Moonshade Earring", ring1="Fenrir Ring +1", ring2="Fenrir Ring +1"})

  -- Circle Blade: physical 1-hit AOE, 100% STR, 1.0 fTP, TP affects AOE radius.

  sets.precast.WS['Circle Blade'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Ishvara Earring", ear2="Vulcan's Pearl", waist="Fotia Belt"})

  -- Spirits Within: breath damage, no stat modifier, damage determined only by current HP and TP.

  sets.precast.WS['Spirits Within'] = {ear2="Moonshade Earring"}

  -- Vorpal Blade: physical 4-hit, 60% STR, 1.375 fTP on all hits, TP affects chance to crit.

  sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {
    head=gear.AdhemarBonnetPlus1.B, ear1="Cessance Earring", ear2="Brutal Earring",
    ring2="Begrudging Ring",
    back=gear.RosmertasCape.Crit, feet="Thereoid Greaves"})

  sets.precast.WS['Vorpal Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {
    head=gear.AdhemarBonnetPlus1.B, ring2="Begrudging Ring", back=gear.RosmertasCape.Crit})

  sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {back=gear.RosmertasCape.Crit})
  sets.precast.WS['Vorpal Blade'].HighAcc = set_combine(sets.precast.WS.HighAcc, {})
  sets.precast.WS['Vorpal Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
  sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS['Vorpal Blade'], {})

  -- Savage Blade: physical 2-hit, 50% MND 50% STR, 4.0/10.25/13.75 fTP.

  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    ear1="Ishvara Earring", ear2="Moonshade Earring",
    body="Assimilator's Jubbah +2", hands="Jhakri Cuffs +2", ring1="Rufescent Ring", ring2="Epaminondas's Ring",
    legs=gear.HerculeanTrousers.HybridWhy, feet=gear.HerculeanBoots.WSD}) -- back=gear.RosmertasCape.WSD

  sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {
    head=gear.CarmineMaskPlus1.D, ear1="Moonshade Earring", ear2="Ishvara Earring",
    body="Assimilator's Jubbah +2", hands="Jhakri Cuffs +2", ring1="Rufescent Ring", ring2="Epaminondas's Ring",
    back="Bleating Mantle", waist="Grunfeld Rope", legs=gear.HerculeanTrousers.HybridWhy, feet=gear.HerculeanBoots.WSD}) -- back=gear.RosmertasCape.WSD

  sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {
    ear2="Moonshade Earring",
    hands="Jhakri Cuffs +2",
    back="Bleating Mantle", waist="Grunfeld Rope", legs=gear.CarmineCuissesPlus1.D, feet=gear.HerculeanBoots.WSD}) -- back=gear.RosmertasCape.WSD

  sets.precast.WS['Savage Blade'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
    ear2="Moonshade Earring",
    hands="Jhakri Cuffs +2", ring1="Rufescent Ring", ring2="Ilabrat Ring",
    back="Bleating Mantle", waist="Grunfeld Rope", feet=gear.HerculeanBoots.WSD}) -- back=gear.RosmertasCape.WSD

  sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
  sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})

  -- Sanguine Blade: magical dark-ele., 50% MND 30% STR, 2.75 fTP, TP affects HP drain.

  sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.MagicWS, sets.element.Dark)

  -- Requiescat: physical 5-hit non-elemental, 73~85% MND, fTP 1.0 on all hits, TP affects attack power.

  sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
    head="Jhakri Coronal +2", -- ear1="Regal Earring"
    body="Jhakri Robe +2", ring2="Rufescent Ring",
    legs="Jhakri Slops +1", feet="Jhakri Pigaches +1"})

  sets.precast.WS['Requiescat'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {
    head="Jhakri Coronal +2", -- ear1="Regal Earring", ear2="Telos Earring"
    body="Jhakri Robe +2", ring2="Rufescent Ring",
    legs="Jhakri Slops +1", feet="Jhakri Pigaches +1"})

  sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {
    head="Jhakri Coronal +2", -- ear1="Regal Earring", ear2="Telos Earring"
    ring1="Rufescent Ring",
    legs="Jhakri Slops +1", feet="Jhakri Pigaches +1"})

  sets.precast.WS['Requiescat'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
    ring1="Rufescent Ring", feet="Jhakri Pigaches +1"})

  sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
  sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})

  -- Chant du Cygne: physical 3-hit, 80% DEX, 2.25 fTP on all hits, TP affects chance to crit.

  sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS.DEX.Crit, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})

  sets.precast.WS['Chant du Cygne'].SomeAcc = set_combine(sets.precast.WS.DEX.Crit.SomeAcc, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})

  sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.DEX.Crit.Acc, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})

  sets.precast.WS['Chant du Cygne'].HighAcc = set_combine(sets.precast.WS.DEX.Crit.HighAcc, {
    neck="Fotia Gorget", waist="Fotia Belt"})

  sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS.DEX.Crit.FullAcc, {})
  sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})

  -- Expiacion: physical 2-hit, 30% STR 30% INT 20% DEX, 3.75/10.25/12.5 fTP.

  sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {
    head="Lilitu Headpiece", neck="Caro Necklace", ear1="Moonshade Earring", ear2="Ishvara Earring",
    body="Assimilator's Jubbah +2", hands="Jhakri Cuffs +2", ring1="Ifrit Ring +1", ring2="Rufescent Ring",
    back=gear.wsd_jse_back, waist="Grunfeld Rope", legs=gear.HerculeanTrousers.HybridWhy, feet=gear.HerculeanBoots.WSD})

  sets.precast.WS['Expiacion'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {
    ear1="Moonshade Earring", ear2="Ishvara Earring",
    body="Assimilator's Jubbah +2", hands="Jhakri Cuffs +2", ring1="Ifrit Ring +1", ring2="Rufescent Ring",
    back=gear.wsd_jse_back, waist="Grunfeld Rope", legs=gear.HerculeanTrousers.HybridWhy, feet=gear.HerculeanBoots.WSD})

  sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS.Acc, {
    ear2="Moonshade Earring",
    body="Assimilator's Jubbah +2", hands="Jhakri Cuffs +2",
    back=gear.wsd_jse_back, legs=gear.CarmineCuissesPlus1.D, feet=gear.HerculeanBoots.WSD})

  sets.precast.WS['Expiacion'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
    ear2="Moonshade Earring",
    body="Assimilator's Jubbah +2", hands="Jhakri Cuffs +2",
    back=gear.wsd_jse_back, legs=gear.CarmineCuissesPlus1.D, feet=gear.HerculeanBoots.WSD})

  sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
    body="Assimilator's Jubbah +2", hands="Jhakri Cuffs +2"})

  sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

	sets.precast.JA['Azure Lore'] = {hands="Luhlaza Bazubands +1"}

  if player.sub_job == "DNC" then
  	-- Waltz set (chr and vit)
    sets.precast.Waltz = {
      --ammo="Sonia's Plectrum",
      head="Anwig Salade", ear1="Enchanter Earring +1",
      body="Passion Jacket", hands=gear.HerculeanGloves.Waltz, ring1="Defending Ring", ring2="Stikini Ring +1",
      back="Kumbira Cape", waist="Flume Belt +1", legs="Dashing Subligar", feet=gear.RawhideBoots.A}

  	-- Don't need any potency gear for Healing Waltz.
  	sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade"}

  	sets.precast.Step = {
      ammo="Falcon Eye",
      head=gear.CarmineMaskPlus1.D, neck="Sanctity Necklace", ear1="Mache Earring +1", ear2="Mache Earring +1", -- neck="Combatant's Torque" ? Does this work?
      body="Jhakri Robe +2", hands="Jhakri Cuffs +2", ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
      back=gear.RosmertasCape.Crit, waist="Olseni Belt", legs=gear.CarmineCuissesPlus1.D, feet="Jhakri Pigaches +1"}

  	sets.precast.Flourish1 = {
      ammo="Pemphredo Tathlum",
      head=gear.CarmineMaskPlus1.D, neck="Sanctity Necklace", ear1="Dignitary's Earring", ear2="Mache Earring +1",
      body="Jhakri Robe +2", hands="Jhakri Cuffs +2", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
      back="Cornflower Cape", waist="Eschan Stone", legs="Jhakri Slops +1", feet="Jhakri Pigaches +1"}

    sets.precast.Flourish1['Animated Flourish'] = set_combine(sets.PlusEnmity, {})
  end

  if player.sub_job == "WAR" then
    sets.precast.JA.Provoke = set_combine(sets.PlusEnmity, {})
  end

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

  -- Assuming Erratic Flutter, and no other FC spells set, which is probably usually true, a 1200+ JP BLU will have
  -- FC+15 as a job trait.

	sets.precast.FC = {                                                                                                 -- Current total: QC+7, FC+65
    main=gear.Vampirism.High1, sub=gear.Vampirism.High2, ammo="Sapience Orb",                                         -- -,   -,    -,  +2
    head=gear.CarmineMaskPlus1.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",   -- +14, +5,   +2, +2
    body=gear.AdhemarJacketPlus1.D, hands="Leyline Gloves", ring1="Kishar Ring", ring2="Prolix Ring",                 -- +10, +8,   +4, +2
    back="Perimede Cape", waist="Witful Belt", legs="Enif Cosciales", feet=gear.CarmineGreavesPlus1.D}                -- 4QC, 3+QC, +8, +5

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})

  if player.sub_job == "NIN" then
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})
  end

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

	sets.midcast.FastRecast = {
    main=gear.Vampirism.High1, sub=gear.Vampirism.High2, ammo="Hasty Pinion +1",
		head=gear.CarmineMaskPlus1.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
		body=gear.AdhemarJacketPlus1.D, hands="Leyline Gloves", ring1="Kishar Ring", ring2="Prolix Ring",
		back="Swith Cape +1", waist="Witful Belt", legs=gear.PsyclothLappas.D, feet=gear.CarmineGreavesPlus1.D}

  --------------------------------------
  -- Midcast: Blue Magic
  --------------------------------------

	sets.midcast['Blue Magic'] = set_combine(sets.midcast.FastRecast, {}) -- hands="Hashishin Bazubands +1"

  sets.midcast['Blue Magic'].Enmity = set_combine(sets.PlusEnmity, {})

  -- Physical Spells

  -- Lots of upgrades available here, including AF2+3
  sets.midcast['Blue Magic'].Physical = {
    main="Vampirism", sub=gear.Colada.DA, ammo="Aurgelmir Orb",
    head=gear.AdhemarBonnetPlus1.B, neck="Caro Necklace", ear1="Tati Earring +1", ear2="Vulcan's Pearl", -- ear2="Tati Earring +1"
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ing1="Ifrit Ring +1", ring2="Ifrit Ring +1",
    back=gear.RosmertasCape.WSD, waist="Prosilio Belt +1", legs="Jhakri Slops +1", feet="Jhakri Pigaches +1"}

	sets.midcast['Blue Magic'].Physical.Resistant = set_combine(sets.midcast['Blue Magic'].Physical, { -- Add a 269 skill weapon MH when I get one.
    ammo="Mantoptera Eye",
		head="Jhakri Coronal +2", neck="Combatant's Torque", ear1="Mache Earring +1", ear2="Mache Earring +1", -- ear1="Regal Earring", ear2="Telos Earring"
    ring1="Ramuh Ring +1", ring2="Ramuh Ring +1", -- body="Assimilator's Jubbah +3", hands="Assimilator's Bazubands +3" ???
    back=gear.RosmertasCape.Crit}) -- back=gear.RosmertasCape.WSD

	sets.midcast['Blue Magic'].Physical.Fodder = set_combine(sets.midcast['Blue Magic'].Physical, { -- Why? WTF is this, you need pDIF -less- on Fodder, Sel you confuse me
    ear1="Vulcan's Pearl", -- ear2="Vulcan's Pearl"
    --main="Iris", sub="Iris", -- ?????????
		--head="Luhlaza Keffiyeh +1",
		--body="Assimilator's Jubbah +3",
		--back="Cornflower Cape", legs="Hashishin Tayt +1", feet="Luhlaza Charuqs +1"
  })

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {
    ammo="Falcon Eye", ear1="Mache Earring +1", ear2="Mache Earring +1", legs=gear.CarmineCuissesPlus1.D})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = sets.midcast['Blue Magic'].Fodder

  -- Rework the criteria for these set to -require- 30% or more stat mod and no STR mod before using.
	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalDex.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalVit.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalInt.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalInt.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalChr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalHP.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalHP.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	-- Magical Spells --

	sets.midcast['Blue Magic'].Magical = set_combine(sets.MagicAttackWeapons, {})

  -- Magic accuracy without magic damage.
	sets.midcast['Blue Magic'].Magical.Proc = set_combine(sets.midcast['Blue Magic'], {
    ammo="Hasty Pinion +1",
		head=gear.CarmineMaskPlus1.D, neck="Incanter's Torque", ear1="Dignitary's Earring", ear2="Gwati Earring",
    ring1="Stikini Ring +1", ring2="Stikini Ring +1",
		body="Helios Jacket", hands="Leyline Gloves"})

  -- Magic accuracy with magic damage.
	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
    neck="Sanctity Necklace",
    hands="Jhakri Cuffs +2", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    waist="Yamabuki-no-Obi"})

	sets.midcast['Blue Magic'].Magical.Fodder = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
    ring1="Stikini Ring +1", ring2="Stikini Ring +1"})

	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

  -- Spells with added effects or that need unusual magic accuracy levels.
	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.MagicAccuracy, {
    main="Naegling", sub="Kaja Rod"})

	-- Breath spells, which scale based on current HP. Use relic head, magic accuracy, and +HP to avoid losing HP in the
  -- swap. Note that Jhakri is a suboptimal set here - all pieces of it have no +HP.
  -- TODO: make this swap +HP in first.
	sets.midcast['Blue Magic'].Breath = {
    main="Naegling", sub="Kaja Rod", ammo="Pemphredo Tathlum",
		head="Luhlaza Keffiyeh +1", neck="Sanctity Necklace", ear1="Dignitary's Earring", ear2="Etiolation Earring", -- ear2="Regal Earring"?
		body=gear.AmalricDoubletPlus1.A, hands="Leyline Gloves", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
		back="Cornflower Cape", waist="Eschan Stone", legs=gear.PsyclothLappas.D, feet="Hashishin Basmak +1"}

	-- Physical "added effect" spells, most notably "Stun" spells. Physical and magical accuracy both needed.
	sets.midcast['Blue Magic'].Stun = set_combine(sets.HybridAccuracy, {})

  -- Better set probably possible with Menelaus Ring, etc.
	sets.midcast['Blue Magic'].Healing = set_combine(sets.Healing, {})
  sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.Healing, {})
	sets.midcast['Blue Magic']['Healing Breeze'] = set_combine(sets.midcast['Blue Magic']['White Wind'], {})

  sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(sets.midcast['Blue Magic'], {
    ammo="Mavi Tathlum",
    head="Luhlaza Keffiyeh +1", neck="Incanter's Torque",
    body="Assimilator's Jubbah +2", hands=gear.RawhideGloves.A, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Cornflower Cape", legs="Hashishin Tayt +1", feet="Luhlaza Charuqs +1"})

	sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast['Blue Magic'], {})

	-- Other Specific Spells --

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {
    waist="Gishdubar Sash"}) -- head="Amalric Coif +1", back="Grapevine Cape"

	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {
    legs="Shedir Seraweels"}) -- head="Amalric Coif +1", hands="Regal Cuffs", waist="Emphatikos Rope"

  --------------------------------------
  -- Midcast: Dark Magic
  --------------------------------------

  -- Over Iris, Iris, Regal, Cornflower (Why?)
	sets.midcast['Dark Magic'] = set_combine(sets.MagicAccuracy, {
    main="Naegling", sub="Kaja Rod"}) -- hands="Jhakri Cuffs +2", back=gear.mab_jse_back

  --------------------------------------
  -- Midcast: Divine Magic
  --------------------------------------

  -- Over Erra's, Regal, Cornflower (Why?)
	sets.midcast['Divine Magic'] = set_combine(sets.MagicAccuracy, {neck="Incanter's Torque"}) -- hands="Jhakri Cuffs +2", back=gear.mab_jse_back

  sets.midcast.Flash = set_combine(sets.PlusEnmity, {})

  --------------------------------------
  -- Midcast: Elemental Magic
  --------------------------------------

	sets.midcast['Elemental Magic'] = set_combine(sets.MagicAttackWeapons, {ammo="Ghastly Tathlum +1"})

  -- Might want more Jhakri +2 here.
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
    ammo="Pemphredo Tathlum", neck="Sanctity Necklace", waist="Eschan Stone"})

	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant

	sets.MagicBurst = {
    body="Samnuha Coat", hands=gear.AmalricGagesPlus1.A, ring1="Mujin Band", ring2="Locus Ring",
    back="Seshaw Cape", feet="Jhakri Pigaches +1"} -- legs="Assimilator's Shalwar +3"

  --------------------------------------
  -- Midcast: Enfeebling Magic
  --------------------------------------

  -- Over Iris, Iris, Cornflower, Jhakri, Jhakri
	sets.midcast['Enfeebling Magic'] = set_combine(sets.MagicAccuracy, {
    main="Naegling", sub="Kaja Rod", legs=gear.PsyclothLappas.D}) -- back=gear.mab_jse_back, feet="Skaoi Boots"

  --------------------------------------
  -- Midcast: Enhancing Magic
  --------------------------------------

	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
		head=gear.CarmineMaskPlus1.D, neck="Incanter's Torque", ear1="Andoaa Earring", ear2="Mimir Earring",
		body=gear.TelchineChasuble.Enh, hands=gear.TelchineGloves.Enh, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
		back="Fi Follet Cape +1", waist="Olympus Sash", legs=gear.CarmineCuissesPlus1.D, feet=gear.TelchinePigaches.Enh})

  -- We don't care about recast if we're casting for duration, so prefer Conserve MP.
  sets.midcast.EnhancingDuration = set_combine(sets.midcast.FastRecast, {
    ammo="Pemphredo Tathlum",
    head=gear.TelchineCap.Enh, neck="Incanter's Torque", ear1="Mendicant's Earring", ear2="Gifted Earring",
    body=gear.TelchineChasuble.Enh, hands=gear.TelchineGloves.Enh,
    back="Fi Follet Cape +1", waist="Luminary Sash", legs=gear.TelchineBraconi.Enh, feet=gear.TelchinePigaches.Enh}) -- waist="Austerity Belt +1"

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
    legs="Shedir Seraweels"}) --head="Amalric Coif +1", hands="Regal Cuffs", waist="Emphatikos Rope"

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

  sets.midcast.Haste = set_combine(sets.midcast.EnhancingDuration, {})

  sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
    head=gear.TaeonChapeau.PhalanxFC,
    body=gear.TaeonTabard.PhalanxFC, hands=gear.TaeonGloves.PhalanxFC,
    legs=gear.TaeonTights.PhalanxFC, feet=gear.TaeonBoots.PhalanxSIRD})

	sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast.Protect, {})

	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {}) -- head="Amalric Coif +1"

	sets.midcast.Shell = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast.Shell, {})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
    neck="Stone Gorget", ear2="Earthcry Earring", waist="Siegel Sash", legs="Shedir Seraweels"}) -- hands="Stone Mufflers"

  --------------------------------------
  -- Midcast: Healing Magic
  --------------------------------------

	sets.midcast.Cure = set_combine(sets.Healing, {})

	--Overwrite certain spells with these pieces even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = {back="Tempered Cape +1", waist="Luminary Sash"}

	--------------------------------------
	-- Active buffs
	--------------------------------------

  sets.buff['Burst Affinity'] = {feet="Hashishin Basmak +1"} -- legs="Assimilator's Shalwar +3"
  sets.buff['Chain Affinity'] = {feet="Assimilator's Charuqs +1"} -- head="Hashishin Kavuk +1"
  --sets.buff.Convergence = {head="Luhlaza Keffiyeh +1"} -- Not currently merited
  sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
  sets.buff.Efflux = {back=gear.RosmertasCape.Crit, legs="Hashishin Tayt +1"}
  --sets.buff.Enchainment = {body="Luhlaza Jubbah +1"} -- Not currently merited

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Consumables etc.
	--------------------------------------

  organizer_items = {
    echos="Echo Drops"}

  -- FIXME: why does this need to be here? Why is it at bottom?
  sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(5, 2)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 2)
	elseif player.sub_job == 'RUN' then
		set_macro_page(3, 2)
	elseif player.sub_job == 'THF' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 2)
	else
		set_macro_page(6, 2)
	end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

        if spell_recasts[955] < spell_latency and not have_trust("Apururu") then
					windower.send_command('input /ma "Apururu (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.chat.input('/ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.chat.input('/ma "Selh\'teus" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end
