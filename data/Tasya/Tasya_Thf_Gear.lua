-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  -- Options: Override default values
  state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'MaxAcc', 'Fodder')
  state.HybridMode:options('Normal', 'PDT')
  state.RangedMode:options('Normal', 'Acc')
  state.WeaponskillMode:options('Match', 'Normal', 'SomeAcc', 'Acc', 'MaxAcc', 'Fodder')
	state.IdleMode:options('Normal', 'Sphere')
  state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')

  if player.sub_job == "WAR" then
	  state.Weapons:options('Aeneas/Sari', 'Aeneas/Odium', 'Aeneas/Blurred', 'Dual Malevolence',
      'Proc Dagger', 'Proc Sword', 'Proc Scythe', 'Proc Club', 'Proc Staff', 'Proc Polearm')
  else
    state.Weapons:options('Aeneas/Sari', 'Aeneas/Odium', 'Aeneas/Blurred', 'Dual Malevolence')
  end

  state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'Suppa', 'DWEarrings', 'DWMax'}
	state.AmbushMode = M(false, 'Ambush Mode')

  gear.CannyCape = {}
  gear.CannyCape.AGI = {name="Canny Cape", augments={'DEX+2','AGI+3','"Dual Wield"+4','Crit. hit damage +3%'}}

  gear.ToutatissCape = {}
  gear.ToutatissCape.Crit = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10'}}
	-- gear.ToutatissCape.STP = {name="Toutatis's Cape", augments={'DEX+20', 'Accuracy+20 Attack+20', '"Store TP"+10'}}
	-- gear.ToutatissCape.WSD = {name="Toutatis's Cape", augments={'DEX+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%'}}

  -- Additional local binds
  send_command('bind ^` input /ja "Flee" <me>')
  send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace gs c weapons Throwing;gs c update')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

  select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  --------------------------------------
  -- Sets required by rules
  --------------------------------------

	sets.TreasureHunter = {hands="Plunderer's Armlets +1", feet="Skulker's Poulaines +1"}
  sets.ExtraRegen = {}
  sets.Kiting = {feet="Skadi's Jambeaux +1"}

  -- Extra Melee sets.  Apply these on top of melee sets.
  sets.Knockback = {}
	sets.Suppa = {ear2="Suppanomimi"}
	sets.DWEarrings = {ear1="Suppanomimi", ear2="Eabani Earring"}
	sets.DWMax = {ear1="Suppanomimi", ear2="Eabani Earring", body=gear.AdhemarJacketPlus1.B, hands="Floral Gauntlets", waist="Patentia Sash"}
	sets.Ambush = {} --body="Plunderer's Vest +1"

  --------------------------------------
  -- Base sets
  --------------------------------------

	--------------------------------------
	-- Idle
	--------------------------------------

  sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Meghanada Visor +2", neck="Bathy Choker +1", ear1="Infused Earring", ear2="Dawn Earring", -- head="Turms Cap +1"
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Defending Ring", ring2="Sheltered Ring", -- hands="Turms Mittens +1"
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"} -- feet="Turms Leggings +1"

  sets.idle.Sphere = set_combine(sets.idle, {body="Mekosuchinae Harness"})
  sets.idle.Weak = set_combine(sets.idle, {})

  sets.DayIdle = {}
  sets.NightIdle = {}

  --------------------------------------
  -- Defense
  --------------------------------------

  sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Shadow Mantle", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet=gear.HerculeanBoots.TA}

  sets.defense.MDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands="Floral Gauntlets", ring1="Defending Ring", ring2="Shadow Ring",
    back="Engulfer Cape +1", waist="Engraved Belt", legs="Meghanada Chausses +2", feet=gear.HerculeanBoots.TA} -- feet="Turms Leggings +1"

	sets.defense.MEVA = {
    ammo="Staunch Tathlum +1",
	  head=gear.HerculeanHelm.MAB, neck="Warder's Charm +1", ear1="Etiolation Earring", ear2="Sanare Earring", -- head="Turms Cap +1"
		body=gear.AdhemarJacketPlus1.B, hands="Leyline Gloves", ring1="Vengeful Ring", ring2="Purity Ring", -- hands="Turms Mittens +1"
		back="Mujin Mantle", waist="Engraved Belt", legs="Mummu Kecks +2", feet="Skulker's Poulaines +1"} -- feet="Turms Leggings +1"

  --------------------------------------
  -- Resting
  --------------------------------------

  -- Full Meghanada +2 replaces Ocelomeh, Turms/+1 is even better.
  sets.resting = set_combine(sets.defense.PDT, {
    ammo="Tsar's Egg",
    head="Meghanada Visor +2", neck="Bathy Choker +1", ear1="Infused Earring", ear2="Dawn Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Paguroidea Ring", ring2="Sheltered Ring",
    legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"})

  --------------------------------------
	-- Weapons
	--------------------------------------

  sets.weapons['Aeneas/Sari'] = {main="Aeneas", sub=gear.TamingSari.High}
	sets.weapons['Aeneas/Odium'] = {main="Aeneas", sub="Odium"}
	sets.weapons['Aeneas/Blurred'] = {main="Aeneas", sub="Blurred Knife +1"}
	sets.weapons['Dual Malevolence'] = {main=gear.Malevolence.Max, sub=gear.Malevolence.High}
	--sets.weapons.Throwing = {main="Aeneas", sub="Taming Sari", range="Comet Tail", ammo=empty}

  if player.sub_job == "WAR" then
    sets.weapons['Proc Dagger'] = {main="Mercurial Kris", sub="Airy Buckler"}
    sets.weapons['Proc Sword'] = {main="Ridill", sub="Airy Buckler"}
    sets.weapons['Proc Scythe'] = {main="Hoe", sub="Airy Buckler"}
    sets.weapons['Proc Club'] = {main="Kitty Rod", sub="Airy Buckler"}
    sets.weapons['Proc Staff'] = {main="Terra Staff", sub="Airy Buckler"}
    sets.weapons['Proc Polearm'] = {main="Pitchfork +1", sub="Airy Buckler"}
  end

  --------------------------------------
  -- Engaged
  --------------------------------------

  sets.engaged = {
    ammo="Ginsen",
    head=gear.AdhemarBonnetPlus1.B, neck="Anu Torque", ear1="Sherida Earring", ear2="Suppanomimi", -- ear2="Dedition Earring" (with 550 job gift)
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Gere Ring", ring2="Hetairoi Ring",
    back=gear.ToutatissCape.Crit, waist="Windbuffet Belt +1", legs=gear.TaeonTights.TA, feet=gear.HerculeanBoots.TA}

  sets.engaged.SomeAcc = {
    ammo="Yamarang",
    neck="Combatant's Torque", ear1="Brutal Earring", waist="Reiki Yotai"}

  sets.engaged.Acc = {
    ear1="Telos Earring", ear2="Suppanomimi",
    body="Mummu Jacket +2",hands="Floral Gauntlets", ring2="Ilabrat Ring", -- ring2="Regal Ring",
    waist="Olseni Belt", legs="Meghanada Chausses +2", feet=gear.herculean_acc_feet}

  sets.engaged.MaxAcc = {
    ammo="Falcon Eye",
    ear2="Dignitary's Earring",
    hands=gear.AdhemarWristbandsPlus1.B, ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    legs="Mummu Kecks +2"}

  sets.engaged.Fodder = {
    neck="Ainia Collar", ear2="Brutal Earring", waist="Reiki Yotai"}

  sets.engaged.PDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Dudgeon Earring", ear2="Heartseeker Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Defending Ring", ring2="Moonbeam Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Ahosi Leggings"}

  sets.engaged.SomeAcc.PDT = {ring2="Patricius Ring"}

  sets.engaged.Acc.PDT = {}

  sets.engaged.MaxAcc.PDT = {waist="Olseni Belt"}

  sets.engaged.Fodder.PDT = {ring2="Dark Ring", feet=gear.herculean_dt_feet}

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------

  -- Default sets for weaponskills that aren't any more specifically defined. Focuses on STR.

  sets.precast.WS = {
    ammo="Seething Bomblet +1",
    head="Lilitu Headpiece", neck="Caro Necklace", ear1="Sherida Earring", ear2="Brutal Earring",
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Ilabrat Ring", ring2="Shukuyu Ring", -- ring2="Regal Ring",
    back=gear.ToutatissCape.Crit, waist="Grunfeld Rope", legs="Meghanada Chausses +2", feet=gear.LustratioLeggingsPlus1.D}

  sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {
    neck="Combatant's Torque"})

  sets.precast.WS.Acc = set_combine(sets.precast.WS.SomeAcc, {
    ear1="Telos Earring",
    body="Meghanada Cuirie +2",
    waist="Olseni Belt", legs="Meghanada Chausses +2", feet=gear.herculean_acc_feet})

  sets.precast.WS.MaxAcc = set_combine(sets.precast.WS.Acc, {})

  -- DEX-based weaponskills.

  sets.precast.WS.DEX = {
    ammo="Jukukik Feather",
    head=gear.AdhemarBonnetPlus1.B, neck="Caro Necklace", ear1="Sherida Earring", ear2="Mache Earring +1",
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Ilabrat Ring", ring2="Ramuh Ring +1", -- ring2="Regal Ring",
    back=gear.ToutatissCape.Crit, waist="Grunfeld Rope", feet=gear.LustratioSubligarPlus1.B, feet=gear.LustratioLeggingsPlus1.D}

  sets.precast.WS.DEX.SomeAcc = set_combine(sets.precast.WS, {
    ammo="Falcon Eye",
    neck="Combatant's Torque"})

  sets.precast.WS.DEX.Acc = set_combine(sets.precast.WS.DEX.SomeAcc, {
    ear1="Mache Earring +1",
    body="Meghanada Cuirie +2",
    legs="Meghanada Chausses +2", feet=gear.herculean_acc_feet})

  sets.precast.WS.DEX.MaxAcc = set_combine(sets.precast.WS.DEX.Acc, {waist="Olseni Belt"})

  sets.precast.WS.DEX.Fodder = set_combine(sets.precast.WS.DEX, {}) -- body=gear.HerculeanVest.WSD

  sets.precast.WS.DEX.SA = set_combine(sets.precast.WS.DEX, {
    ammo="Yetshila +1", head=gear.AdhemarBonnetPlus1.B, body="Meghanada Cuirie +2"})

  sets.precast.WS.DEX.TA = set_combine(sets.precast.WS.DEX.SA, {})
  sets.precast.WS.DEX.SATA = set_combine(sets.precast.WS.DEX.SA, {})

  -- DEX-based weaponskills that benefit from Weapon Skill Damage.

  sets.precast.WS.DEXWSD = {
    ammo="Jukukik Feather",
    head=gear.AdhemarBonnetPlus1.B, neck="Caro Necklace", ear1="Sherida Earring", ear2="Mache Earring +1", -- head="Pillager's Bonnet +3"
    body=gear.AdhemarJacketPlus1.B, hands="Meghanada Gloves +2", ring1="Ilabrat Ring", ring2="Epaminondas's Ring",
    back=gear.ToutatissCape.Crit, waist="Grunfeld Rope", feet=gear.LustratioSubligarPlus1.B, feet=gear.HerculeanBoots.WSD} -- legs="Plunderer's Culottes +3"

  sets.precast.WS.DEXWSD.SomeAcc = set_combine(sets.precast.WS.DEXWSD, {ammo="Falcon Eye"})

  sets.precast.WS.DEXWSD.Acc = set_combine(sets.precast.WS.DEXWSD.SomeAcc, {
    head="Dampening Tam", neck="Combatant's Torque",
    waist="Olseni Belt", legs="Meghanada Chausses +2", feet=gear.HerculeanBoots.Acc})

  sets.precast.WS.DEXWSD.MaxAcc = set_combine(sets.precast.WS.DEXWSD.Acc, {})

  sets.precast.WS.DEXWSD.Fodder = set_combine(sets.precast.WS.DEXWSD, {}) -- body=gear.HerculeanVest.WSD

  sets.precast.WS.DEXWSD.SA = set_combine(sets.precast.WS.DEXWSD, {
    ammo="Yetshila +1", head=gear.AdhemarBonnetPlus1.B, body="Meghanada Cuirie +2"})

  sets.precast.WS.DEXWSD.TA = set_combine(sets.precast.WS.DEXWSD.SA, {})
  sets.precast.WS.DEXWSD.SATA = set_combine(sets.precast.WS.DEXWSD.SA, {})

  -- DEX-based weaponskills that can critical hit.

  sets.precast.WS.DEXCrit = {
    ammo="Yetshila +1",
    head=gear.AdhemarBonnetPlus1.B, neck="Caro Necklace", ear1="Sherida Earring", ear2="Mache Earring +1",
    body="Abnoba Kaftan", hands=gear.AdhemarWristbandsPlus1.B, ring1="Ilabrat Ring", ring2="Begrudging Ring", -- body="Plunderer's Vest +3"
    back=gear.ToutatissCape.Crit, waist="Grunfeld Rope", legs="Mummu Kecks +2", feet=gear.LustratioLeggingsPlus1.D} -- legs="Pillager's Culottes +3"

  sets.precast.WS.DEXCrit.SomeAcc = set_combine(sets.precast.WS.DEXCrit, {
    ammo="Falcon Eye",
    neck="Combatant's Torque",
    -- hands="Mummu Wrists +2",
    waist="Olseni Belt", legs="Mummu Kecks +2"}) -- feet="Mummu Gamashes +2"

  sets.precast.WS.DEXCrit.Acc = set_combine(sets.precast.WS.DEXCrit.SomeAcc, {
    }) --head="Mummu Bonnet +2", ear2="Telos Earring", body="Sayadio's Kaftan"

  sets.precast.WS.DEXCrit.MaxAcc = set_combine(sets.precast.WS.DEXCrit.Acc, {
    body="Mummu Jacket +2", ring1="Ramuh Ring +1"})

  sets.precast.WS.DEXCrit.Fodder = set_combine(sets.precast.WS.DEXCrit, {ring1="Mummu Ring"})

  sets.precast.WS.DEXCrit.SA = set_combine(sets.precast.WS.DEXCrit, {
    body="Meghanada Cuirie +2", ring2="Ramuh Ring +1"}) -- ring2="Regal Ring", back=gear.ToutatissCape.WSD

  sets.precast.WS.DEXCrit.TA = set_combine(sets.precast.WS.DEXCrit.SA, {})
  sets.precast.WS.DEXCrit.SATA = set_combine(sets.precast.WS.DEXCrit.SA, {})

  -- AGI-based multihit weaponskills. (This is only Exenterator currently.)

  sets.precast.WS.AGI = {
    ammo="Seething Bomblet +1",
    head="Meghanada Visor +2", neck="Marked Gorget", ear1="Sherida Earring", ear2="Tati Earring +1", -- neck="Houyi's Gorget"
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Ilabrat Ring", ring2="Apate Ring", -- ring2="Regal Ring"
    back=gear.CannyCape.AGI, waist="Yemaya Belt", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"} -- waist="Elanid Belt"

  sets.precast.WS.AGI.SomeAcc = set_combine(sets.precast.WS.AGI, {
    ammo="Falcon Eye",
    neck="Combatant's Torque",
    -- hands="Mummu Wrists +2",
    waist="Olseni Belt"}) -- legs="Mummu Kecks +2", feet="Mummu Gamashes +2"

  sets.precast.WS.AGI.Acc = set_combine(sets.precast.WS.AGI.SomeAcc, {
    }) --head="Mummu Bonnet +2", ear2="Telos Earring", body="Sayadio's Kaftan"

  sets.precast.WS.AGI.MaxAcc = set_combine(sets.precast.WS.AGI.Acc, {
    body="Mummu Jacket +2", ring1="Ramuh Ring +1"})

  sets.precast.WS.AGI.Fodder = set_combine(sets.precast.WS.AGI, {})

  sets.precast.WS.AGI.SA = set_combine(sets.precast.WS.AGI, {
    ammo="Yetshila +1", head=gear.AdhemarBonnetPlus1.B, body="Meghanada Cuirie +2"})

  sets.precast.WS.AGI.TA = set_combine(sets.precast.WS.AGI.SA, {})
  sets.precast.WS.AGI.SATA = set_combine(sets.precast.WS.AGI.SA, {})

  -- Magic weaponskills (INT and magic attack bonus).

  sets.precast.WS.Magic = {
    ammo="Seething Bomblet +1",
    head=gear.HerculeanHelm.MAB, neck="Baetyl Pendant", ear1="Friomisi Earring", ear2="Novio Earring",
    body="Samnuha Coat", hands="Leyline Gloves", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
    back="Toro Cape", waist="Eschan Stone", legs="Limbo Trousers", feet=gear.HerculeanBoots.WSD}

  -- MND-based weaponskills, with no regard to damaging stats. (MND and TP Bonus only, used for Energy Drain and Energy Steal.)

  sets.precast.WS.MaxMND = {
    ammo="Quartz Tathlum +1",
    head=gear.HerculeanHelm.MAB, neck="Phalaina Locket", ear1="Lifestorm Earring", ear2="Moonshade Earring", -- neck="Aife's Medal"
    body="Samnuha Coat", hands="Leyline Gloves", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Tantalic Cape", waist="Engraved Belt", legs="Limbo Trousers", feet=gear.HerculeanBoots.WSD}

  -- Special sets for weaponskills.

  -- Swap to these on Moonshade using WS if at 3000 TP
  sets.MaxTP = {ear1="Sherida Earring", ear2="Ishvara Earring"}
  sets.AccMaxTP = {ear1="Sherida Earring", ear2="Mache Earring +1"}

  --------------------------------------
  -- Precast: Dagger Weaponskills
  --------------------------------------

  -- Wasp Sting: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.

  sets.precast.WS["Wasp Sting"] = set_combine(sets.precast.WS.DEXWSD, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Wasp Sting"].SomeAcc = set_combine(sets.precast.WS.DEXWSD.SomeAcc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Wasp Sting"].Acc = set_combine(sets.precast.WS.DEXWSD.Acc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Wasp Sting"].MaxAcc = set_combine(sets.precast.WS.DEXWSD.FullAcc, {})

  sets.precast.WS["Wasp Sting"].Fodder = set_combine(sets.precast.WS.DEXWSD.Fodder, {neck="Fotia Gorget", waist="Fotia Belt"})

  sets.precast.WS["Wasp Sting"].SA = set_combine(sets.precast.WS.DEXWSD.SA, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Wasp Sting"].TA = set_combine(sets.precast.WS.DEXWSD.TA, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Wasp Sting"].SATA = set_combine(sets.precast.WS.DEXWSD.WSD, {neck="Fotia Gorget", waist="Fotia Belt"})

  -- Gust Slash: magical, wind-ele., 40% DEX 40% INT, 1.0/2.0/3.5 fTP.

  sets.precast.WS['Gust Slash'] = set_combine(sets.precast.WS.Magic, {})

  -- Shadowstitch: physical 1-hit, 100% CHR, 1.0 fTP, TP affects chance to bind.

  sets.precast.WS["Shadowstitch"] = {
    ammo="Falcon Eye",
    head="Meghanada Visor +2", neck="Combatant's Torque", ear1="Mache Earring +1", ear2="Moonshade Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.ToutatissCape.Crit, waist="Olseni Belt", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"}

  -- Viper Bite: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.

  sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS.DEXWSD, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.DEXWSD.SomeAcc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.DEXWSD.Acc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Shark Bite"].MaxAcc = set_combine(sets.precast.WS.DEXWSD.FullAcc, {})

  sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS.DEXWSD.Fodder, {neck="Fotia Gorget", waist="Fotia Belt"})

  sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS.DEXWSD.SA, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS.DEXWSD.TA, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS.DEXWSD.WSD, {neck="Fotia Gorget", waist="Fotia Belt"})

  -- Cyclone: magical AOE, wind-ele., 40% DEX 40% INT, 1.0/2.375/2.875 fTP.

  sets.precast.WS['Cyclone'] = set_combine(sets.precast.WS.Magic, {})

  -- Energy Steal: steals MP, affected by MND and TP.

  sets.precast.WS['Energy Steal'] = set_combine(sets.precast.WS.MaxMND, {})

  -- Energy Drain: steals MP, affected by MND and TP.

  sets.precast.WS['Energy Drain'] = set_combine(sets.precast.WS.MaxMND, {})

  -- Dancing Edge: physical 5-hit, 40% DEX 40% CHR, 1.1875 fTP on all hits, TP affects accuracy.

  sets.precast.WS["Dancing Edge"] = set_combine(sets.precast.WS.DEXWSD, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Dancing Edge"].SomeAcc = set_combine(sets.precast.WS.DEXWSD.SomeAcc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Dancing Edge"].Acc = set_combine(sets.precast.WS.DEXWSD.Acc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Dancing Edge"].MaxAcc = set_combine(sets.precast.WS.DEXWSD.FullAcc, {})

  sets.precast.WS["Dancing Edge"].Fodder = set_combine(sets.precast.WS.DEXWSD.Fodder, {neck="Fotia Gorget", waist="Fotia Belt"})

  sets.precast.WS["Dancing Edge"].SA = set_combine(sets.precast.WS.DEXWSD.SA, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Dancing Edge"].TA = set_combine(sets.precast.WS.DEXWSD.TA, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Dancing Edge"].SATA = set_combine(sets.precast.WS.DEXWSD.WSD, {neck="Fotia Gorget", waist="Fotia Belt"})

  -- Shark Bite: physical 2-hit, 40% DEX 40% AGI, 4.5/6.8/8.5 fTP.

  sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS.DEXWSD, {ear2="Moonshade Earring"})
  sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.DEXWSD.SomeAcc, {ear2="Moonshade Earring"})
  sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.DEXWSD.Acc, {ear2="Moonshade Earring"})
  sets.precast.WS["Shark Bite"].MaxAcc = set_combine(sets.precast.WS.DEXWSD.FullAcc, {})

  sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS.DEXWSD.Fodder, {ear2="Moonshade Earring"})

  sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS.DEXWSD.SA, {ear2="Moonshade Earring"})
  sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS.DEXWSD.TA, {ear2="Moonshade Earring"})
  sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS.DEXWSD.WSD, {ear2="Moonshade Earring"})

  -- Evisceration: physical 5-hit, 50% DEX, 1.25 fTP on all hits, TP affects chance to crit.

  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS.DEXCrit, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})
  sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.DEXCrit.SomeAcc, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})
  sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.DEXCrit.Acc, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})
  sets.precast.WS['Evisceration'].MaxAcc = set_combine(sets.precast.WS.DEXCrit.FullAcc, {})

  sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS.DEXCrit.Fodder, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})

  sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS.DEXCrit.SA, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS.DEXCrit.TA, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS.DEXCrit.SATA, {neck="Fotia Gorget", waist="Fotia Belt"})

  -- Aeolian Edge: magical AOE, wind-ele., 40% DEX 40% INT, 2.0/3.0/4.5 fTP.

  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.Magic, {})

  -- Exenterator: physical 4-hit, 73~85% AGI, 1.0 fTP on all hits, TP affects duration of accuracy down.

  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS.AGI, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS['Exenterator'].SomeAcc = set_combine(sets.precast.WS.AGI.SomeAcc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS.AGI.Acc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS['Exenterator'].MaxAcc = set_combine(sets.precast.WS.AGI.FullAcc, {})

  sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS.AGI.Fodder, {})

  sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS.AGI.SA, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS.AGI.TA, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS.AGI.SATA, {neck="Fotia Gorget", waist="Fotia Belt"})

  -- Mandalic Stab: physical 1-hit, 60% DEX, 4.0/6.09/8.5 fTP.

  sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS.DEXWSD, {ear2="Moonshade Earring"})
  sets.precast.WS["Mandalic Stab"].SomeAcc = set_combine(sets.precast.WS.DEXWSD.SomeAcc, {ear2="Moonshade Earring"})
  sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS.DEXWSD.Acc, {ear2="Moonshade Earring"})
  sets.precast.WS["Mandalic Stab"].MaxAcc = set_combine(sets.precast.WS.DEXWSD.FullAcc, {})

  sets.precast.WS["Mandalic Stab"].Fodder = set_combine(sets.precast.WS.DEXWSD.Fodder, {ear2="Moonshade Earring"})

  sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS.DEXWSD.SA, {ear2="Moonshade Earring"})
  sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS.DEXWSD.TA, {ear2="Moonshade Earring"})
  sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS.DEXWSD.WSD, {ear2="Moonshade Earring"})

  -- Rudra's Storm: physical 1-hit, 80% DEX, 5.0/10.19/13.0 fTP.

  sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS.DEXWSD, {ear2="Moonshade Earring"})
  sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.DEXWSD.SomeAcc, {ear2="Moonshade Earring"})
  sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.DEXWSD.Acc, {ear2="Moonshade Earring"})
  sets.precast.WS["Rudra's Storm"].MaxAcc = set_combine(sets.precast.WS.DEXWSD.FullAcc, {})

  sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS.DEXWSD.Fodder, {ear2="Moonshade Earring"})

  sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS.DEXWSD.SA, {ear2="Moonshade Earring"})
  sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS.DEXWSD.TA, {ear2="Moonshade Earring"})
  sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS.DEXWSD.WSD, {ear2="Moonshade Earring"})

  --------------------------------------
  -- Precast: Marksmanship Weaponskills
  --------------------------------------

  -- Last Stand: physical 2-hit, 73~85% AGI, 2.0/3.0/4.0 fTP on all hits.

  sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS.Ranged, {
    head="Meghanada Visor +2", neck="Fotia Gorget", ear1="Ishvara Earring", ear2="Moonshade Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Apate Ring", -- ring2="Regal Ring",
    back="Sokolski Mantle", waist="Fotia Belt", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"})

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

  sets.precast.JA['Collaborator'] = {} --head="Skulker's Bonnet +1"
  sets.precast.JA['Accomplice'] = {} --head="Skulker's Bonnet +1"
  sets.precast.JA['Flee'] = {} --feet="Pillager's Poulaines +1"
  sets.precast.JA['Hide'] = {} --body="Pillager's Vest +1"
  sets.precast.JA['Conspirator'] = {} --body="Skulker's Vest +1"
  sets.precast.JA['Steal'] = {} -- hands="Pillager's Armlets +1"
	sets.precast.JA['Mug'] = {}
  sets.precast.JA['Despoil'] = {feet="Skulker's Poulaines +1"} -- legs="Skulker's Culottes +1"
  sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
  sets.precast.JA['Feint'] = {} -- {legs="Plunderer's Culottes +1"}

  sets.precast.JA['Sneak Attack'] = {}
  sets.precast.JA['Trick Attack'] = {}

  -- Actions we want to use to tag TH.
  sets.precast.Step = {
    ammo="Falcon Eye",
    head="Dampening Tam", neck="Combatant's Torque", ear1="Telos Earring", ear2="Digni. Earring",
    body="Mummu Jacket +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.da_jse_back, waist="Olseni Belt", legs="Mummu Kecks +2", feet=gear.herculean_acc_feet}

  sets.precast.JA['Violent Flourish'] = {
    ammo="Falcon Eye",
    head="Dampening Tam", neck="Combatant's Torque", ear1="Telos Earring", ear2="Digni. Earring",
    body="Mummu Jacket +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.da_jse_back, waist="Olseni Belt", legs="Mummu Kecks +2", feet=gear.herculean_acc_feet}

	sets.precast.JA['Animated Flourish'] = set_combine(sets.TreasureHunter, {})
	sets.precast.JA.Provoke = set_combine(sets.TreasureHunter, {})

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
    ammo="Yamarang",
    head="Anwig Salade", neck="Unmoving Collar +1", ear1="Enchntr. Earring +1", ear2="Handler's Earring +1",
    body=gear.herculean_waltz_body, hands=gear.HerculeanGloves.Waltz, ring1="Defending Ring", ring2="Valseur's Ring",
    back="Moonlight Cape", waist="Chaac Belt", legs="Dashing Subligar", feet=gear.RawhideBoots.D}

	sets.Self_Waltz = {body="Passion Jacket", ring1="Asklepian Ring"}

  -- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade"}

  --------------------------------------
  -- Precast: Snapshot
  --------------------------------------

  -- Ranged snapshot gear
  sets.precast.RA = {range="Comet Tail"} -- lol

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

  sets.precast.FC = {
    ammo="Impatiens",
  	head=gear.HerculeanHelm.MAB, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
  	body=gear.TaeonTabard.PhalanxFC, hands="Leyline Gloves", ring1="Lebeche Ring", ring2="Prolix Ring",
  	legs="Enif Cosciales"}

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace", body="Passion Jacket"})

  --------------------------------------
  -- Midcast: Ranged Attacks
  --------------------------------------

  sets.midcast.RA = {
    head="Mummu Bonnet +2", neck="Combatant's Torque", ear1="Telos Earring", ear2="Enervating Earring",
    body="Mummu Jacket +2", hands="Mummu Wrists +2", ring1="Apate Ring", ring2="Regal Ring",
    back=gear.da_jse_back, waist="Chaac Belt", legs="Mummu Kecks +2", feet="Mummu Gamashes +2"}

  sets.midcast.RA.Acc = {
    head="Mummu Bonnet +2", neck="Combatant's Torque", ear1="Telos Earring", ear2="Enervating Earring",
    body="Mummu Jacket +2", hands="Mummu Wrists +2", ring1="Apate Ring", ring2="Regal Ring",
    back=gear.da_jse_back, waist="Chaac Belt", legs="Mummu Kecks +2", feet="Mummu Gamashes +2"}

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

  sets.midcast.FastRecast = {
    head=gear.HerculeanHelm.MAB, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body=gear.TaeonTabard.PhalanxFC, hands="Leyline Gloves", ring1="Defending Ring", ring2="Prolix Ring",
    back="Moonlight Cape", waist="Tempus Fugit", legs="Enif Cosciales", feet=gear.HerculeanBoots.TA}

  --------------------------------------
  -- Midcast: Dark Magic
  --------------------------------------

  sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

  --------------------------------------
  -- Midcast: Enfeebling Magic
  --------------------------------------

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

  --------------------------------------
  -- Midcast: Ninjutsu
  --------------------------------------

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	--------------------------------------
	-- Active buffs
	--------------------------------------

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}

  sets.buff['Sneak Attack'] = set_combine(sets.precast.JA['Sneak Attack'], {})
  sets.buff['Trick Attack'] = set_combine(sets.precast.JA['Trick Attack'], {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(8, 5)
    elseif player.sub_job == 'WAR' then
        set_macro_page(7, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 5)
    else
        set_macro_page(6, 5)
    end
end
