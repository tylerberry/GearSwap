-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal', 'Acc')
  state.RangedMode:options('Normal', 'Acc')
  state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'Proc')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.CompensatorMode:options('300', '1000', 'Never', 'Always')

  if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
	  state.Weapons:options(
      'Savage: Naegling/Blurred - Ataktos',
      'Savage/Last Stand: Naegling/Blurred - Molybdosis',
      'Last Stand: Kustawi/Nusku - Molybdosis',
      'Leaden: Naegling/Tauret - Molybdosis')
  else
	  state.Weapons:options(
      'Savage: Naegling - Ataktos',
      'Last Stand: Kustawi - Molybdosis',
      'Leaden: Naegling - Molybdosis')
  end

  gear.Bullet = {}
  gear.Bullet.RA = "Eminent Bullet"
  gear.Bullet.PhysWS = "Eminent Bullet"
  gear.Bullet.MagicWS = "Orichalcum Bullet" -- WARNING: For MAB WS, DO NOT put single-use bullets here.
  gear.Bullet.QuickDraw = "Animikii Bullet"

  options.ammo_warning_limit = 15

  gear.CamulussMantle = {}
  gear.CamulussMantle.DA = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}
  gear.CamulussMantle.AGIWSD = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%'}}
  gear.CamulussMantle.MagicWSD = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%'}}
  gear.CamulussMantle.STRWSD = {name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
  gear.CamulussMantle.Snapshot = {name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15'}}

  --[[
	gear.tp_ranger_jse_back = {name="Camulus's Mantle", augments={'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'Rng.Acc.+10', '"Store TP"+10', }}
	gear.snapshot_jse_back = {name="Camulus's Mantle", augments={'"Snapshot"+10', }}
	gear.tp_jse_back = {name="Camulus's Mantle", augments={'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', }}
	gear.ranger_wsd_jse_back = {name="Camulus's Mantle", augments={'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', 'Weapon skill damage +10%', }}
	gear.magic_wsd_jse_back = {name="Camulus's Mantle", augments={'AGI+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'AGI+10', 'Weapon skill damage +10%', }}
	gear.str_wsd_jse_back = {name="Camulus's Mantle", augments={'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', }}
  --]]

  -- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')

	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')

	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
  send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')

	send_command('bind !r gs c weapons DualSavageWeapons;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons DualKustawi;gs c update')
	send_command('bind !q gs c weapons DualLeadenRanged;gs c update')
	send_command('bind @pause roller roll')

  select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  --------------------------------------
  -- Sets required by rules
  --------------------------------------

	sets.Self_Healing = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.DayIdle = {}
	sets.NightIdle = {}

  sets.Kiting = {legs=gear.CarmineCuissesPlus1.D}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.DWMax = {ear1="Suppanomimi", ear2="Eabani Earring", body=gear.AdhemarJacketPlus1.B, hands="Floral Gauntlets", waist="Reiki Yotai"}

  --------------------------------------
  -- Elemental Affinity
  --------------------------------------

  sets.DarkAffinity = {head="Pixie Hairpin +1", ring1="Archon Ring"}

  --------------------------------------
  -- Base sets
  --------------------------------------

  sets.MagicAccuracy = {
    ammo=gear.Bullet.MagicWS,
    head=gear.CarmineMaskPlus1.D, neck="Sanctity Necklace", ear1="Dignitary's Earring", ear2="Gwati Earring",
    body="Malignance Tabard", hands="Mummu Wrists +2", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back=gear.CamulussMantle.MagicWSD, waist="Eschan Stone", legs="Malignance Tights", feet="Mummu Gamashes +2"}

  sets.MagicAttackNW = {
    ammo=gear.Bullet.MagicWS,
    head=gear.HerculeanHelm.MAB, neck="Baetyl Pendant", ear1="Novio Earring", ear2="Friomisi Earring",
    body="Samnuha Coat", hands=gear.CarmineFingerGauntletsPlus1.D, ring1="Fenrir Ring +1", ring2="Dingir Ring",
    back=gear.CamulussMantle.MagicWSD, waist="Eschan Stone", legs=gear.HerculeanTrousers.MagicWSD, feet="Lanun Bottes +1"}

	--------------------------------------
	-- Idle
	--------------------------------------

  sets.idle = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"}

  sets.idle.Refresh = {
    ammo=gear.Bullet.RA,
    head=gear.RawhideMask.A, neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Ethereal Earring",
    body="Mekosuchinae Harness", hands=gear.HerculeanGloves.Refresh, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.RawhideTrousers.D, feet=gear.herculean_dt_feet}

  --------------------------------------
  -- Defense
  --------------------------------------

  sets.defense.PDT = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"}

  sets.defense.MDT = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"}

  sets.defense.MEVA = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back=gear.CamulussMantle.Snapshot, waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"}

	--------------------------------------
	-- Resting
	--------------------------------------

  sets.resting = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Bathy Choker +1", ear1="Infused Earring", ear2="Dawn Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Defending Ring", ring2="Sheltered Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"}

  --------------------------------------
  -- Weapons
  --------------------------------------

  if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
    sets.weapons["Savage: Naegling/Blurred - Ataktos"] = {main="Naegling", sub="Blurred Knife +1", range="Ataktos"}
  	sets.weapons["Savage/Last Stand: Naegling/Blurred - Molybdosis"] = {main="Naegling", sub="Blurred Knife +1", range="Molybdosis"}
  	sets.weapons["Last Stand: Kustawi/Nusku - Molybdosis"] = {main="Kustawi +1", sub="Nusku Shield", range="Molybdosis"}
  	sets.weapons["Leaden: Naegling/Tauret - Molybdosis"] = {main="Naegling", sub="Kaja Knife", range="Molybdosis"}
  else
  	sets.weapons["Savage: Naegling - Ataktos"] = {main="Naegling", sub="Nusku Shield", range="Ataktos"}
  	sets.weapons["Last Stand: Kustawi - Molybdosis"] = {main="Kustawi +1", sub="Nusku Shield", range="Molybdosis"}
    sets.weapons["Leaden: Naegling - Molybdosis"] = {main="Naegling", sub="Nusku Shield", range="Molybdosis"}
  end

  --------------------------------------
  -- Engaged
  --------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
  	head=gear.AdhemarBonnetPlus1.B, neck="Iskur Gorget", ear1="Cessance Earring", ear2="Brutal Earring", -- neck="Iskur Gorget",
  	body="Meghanada Cuirie +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Epona's Ring", ring2="Petrov Ring",
  	back=gear.CamulussMantle.DA, waist="Windbuffet Belt +1", legs=gear.TaeonTights.TA, feet=gear.HerculeanBoots.TA}

  sets.engaged.Acc = {
  	head=gear.CarmineMaskPlus1.D, neck="Combatant's Torque", ear1="Cessance Earring", ear2="Telos Earring",
  	body="Meghanada Cuirie +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Epona's Ring", ring2="Petrov Ring",
  	back=gear.CamulussMantle.DA, waist="Olseni Belt", legs=gear.CarmineCuissesPlus1.D, feet=gear.HerculeanBoots.Acc}

  sets.engaged.DW = {
  	head=gear.AdhemarBonnetPlus1.B, neck="Iskur Gorget", ear1="Suppanomimi", ear2="Telos Earring",
  	body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Epona's Ring", ring2="Petrov Ring",
  	back=gear.CamulussMantle.DA, waist="Windbuffet Belt +1", legs=gear.TaeonTights.TA, feet=gear.HerculeanBoots.TA}

  sets.engaged.DW.Acc = {
  	head=gear.CarmineMaskPlus1.D, neck="Combatant's Torque", ear1="Dignitary's Earring", ear2="Telos Earring",
  	body="Meghanada Cuirie +2", hands="Floral Gauntlets", ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
  	back=gear.CamulussMantle.DA, waist="Olseni Belt", legs=gear.CarmineCuissesPlus1.D, feet=gear.HerculeanBoots.Acc}

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------

  -- Default sets for weaponskills that aren't any more specifically defined. Focuses on STR.

  sets.precast.WS = {
    head="Meghanada Visor +2", neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Telos Earring",
    body="Laksamana's Frac +3", hands="Meghanada Gloves +2", ring1="Regal Ring", ring2="Ifrit Ring +1",
    back=gear.CamulussMantle.STRWSD, waist="Fotia Belt", legs="Meghanada Chausses +2", feet="Lanun Bottes +3"}

  sets.precast.WS.Acc = {
    head=gear.CarmineMaskPlus1.D, neck="Combatant's Torque", ear1="Dignitary's Earring", ear2="Telos Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Regal Ring", ring2="Ilabrat Ring",
    back=gear.CamulussMantle.STRWSD, waist="Grunfeld Rope", legs=gear.CarmineCuissesPlus1.D, feet="Lanun Bottes +3"}

  sets.precast.WS.Proc = {
    head=gear.CarmineMaskPlus1.D, neck="Combatant's Torque", ear1="Dignitary's Earring", ear2="Zennaroi Earring",
    body="Mummu Jacket +2", hands="Floral Gauntlets", ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.CamulussMantle.STRWSD, waist="Olseni Belt", legs=gear.CarmineCuissesPlus1.D, feet=gear.herculean_acc_feet}

  -- STR-based weaponskills that benefit from Weapon Skill Damage.

  sets.precast.WS.WSD = set_combine(sets.precast.WS, {
    head="Lilitu Headpiece", ear2="Ishvara Earring",
    hands="Meghanada Gloves +2", ring1="Epaminondas's Ring", ring2="Regal Ring",
    back=gear.CamulussMantle.STRWSD, feet=gear.HerculeanBoots.WSD}) -- feet="Lanun Bottes +3"

  sets.precast.WS.WSD.Acc = set_combine(sets.precast.WS.WSD, {})
  sets.precast.WS.WSD.Proc = set_combine(sets.precast.WS.Proc, {})

  -- DEX-based weaponskills.

  sets.precast.WS.DEX = set_combine(sets.precast.WS, {})

  -- Magic melee weaponskills (INT and magic attack bonus).

  sets.precast.WS.Magic = set_combine(sets.MagicAttackNW, {back="Toro Cape"})
  sets.precast.WS.Magic.Acc = set_combine(sets.precast.WS.Magic, {})

  -- AGI-based ranged weaponskills.

  sets.precast.WS.Ranged = {
    ammo=gear.Bullet.PhysWS,
    head="Meghanada Visor +2", neck="Iskur Gorget", ear1="Moonshade Earring", ear2="Telos Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Regal Ring", ring2="Dingir Ring", -- body="Laksamana's Frac +3"
    back=gear.CamulussMantle.AGIWSD, waist="Yemaya Belt", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"} -- feet="Lanun Bottes +3"

  sets.precast.WS.Ranged.Acc = set_combine(sets.precast.WS.Ranged, {}) -- neck="Iskur Gorget"

  -- AGI-based ranged weaponskills that benefit from Weapon Skill Damage.

  sets.precast.WS.Ranged.WSD = set_combine(sets.precast.WS.Ranged, {
    ear2="Ishvara Earring", hands="Meghanada Gloves +2", ring2="Epaminondas's Ring"}) -- body="Laksamana's Frac +3", feet="Lanun Bottes +3

  sets.precast.WS.Ranged.WSD.Acc = set_combine(sets.precast.WS.Ranged, {}) -- neck="Iskur Gorget"

  -- AGI-based ranged weaponskills which can crit.

  sets.precast.WS.Ranged.Crit = set_combine(sets.precast.WS.Ranged, {body="Meghanada Cuirie +2"})
  sets.precast.WS.Ranged.Crit.Acc = set_combine(sets.precast.WS.Ranged.Acc, {})

  -- Magic ranged weaponskills (AGI and magic attack bonus).

  sets.precast.WS.Ranged.Magic = set_combine(sets.MagicAttackNW, {ring1="Epaminondas's Ring"})
  sets.precast.WS.Ranged.Magic.Acc = set_combine(sets.precast.WS.Ranged.Magic, {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

  --------------------------------------
  -- Precast: Dagger Weaponskills
  --------------------------------------



  --------------------------------------
  -- Precast: Marksmanship Weaponskills
  --------------------------------------

  -- Hot Shot: hybrid fire-ele., 70% AGI, 0.5/1.55/21 fTP.

  sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS.Ranged.Magic, {
    neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})
  sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS.Ranged.Magic.Acc, {
    neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})

  -- Split Shot: physical 1-hit, 70% AGI, 1.0 fTP, TP affects ignores defense ignored (0/35/50%)

  sets.precast.WS['Split Shot'] = set_combine(sets.precast.WS.Ranged.WSD, {
    neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})

  sets.precast.WS['Split Shot'].Acc = set_combine(sets.precast.WS.Ranged.WSD.Acc, {
    ear1="Moonshade Earring", waist="Fotia Belt"})

  -- Sniper Shot: physical 1-hit, 70% AGI, 1.0 fTP, TP affects chance to crit.

  sets.precast.WS['Sniper Shot'] = set_combine(sets.precast.WS.Ranged.Crit, {
    neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})

  sets.precast.WS['Sniper Shot'].Acc = set_combine(sets.precast.WS.Ranged.Crit.Acc, {
    ear1="Moonshade Earring", waist="Fotia Belt"})

  -- Slug Shot: physical 1-hit, 70% AGI, fTP 5.0, TP affects accuracy. Innately inaccurate.

  sets.precast.WS['Slug Shot'] = set_combine(sets.precast.WS.Ranged.Acc, {ear1="Moonshade Earring"})
  sets.precast.WS['Slug Shot'].Acc = set_combine(sets.precast.WS.Ranged.Acc, {ear1="Moonshade Earring"})

  -- Detonator: physical 1-hit, 70% AGI, fTP 1.5/2.5/5.0.

  sets.precast.WS['Detonator'] = set_combine(sets.precast.WS.Ranged.WSD, {ear1="Moonshade Earring"})
  sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS.Ranged.WSD.Acc, {ear1="Moonshade Earring"})

  -- Numbing Shot: physical 1-hit, 80% AGI, fTP 3.0, TP affects duration of paralyze.

  sets.precast.WS['Numbing Shot'] = set_combine(sets.precast.WS.Ranged.WSD, {ear1="Moonshade Earring"})
  sets.precast.WS['Numbing Shot'].Acc = set_combine(sets.precast.WS.Ranged.WSD.Acc, {ear1="Moonshade Earring"})

  -- Last Stand: physical 2-hit, 73~85% AGI, 2.0/3.0/4.0 fTP on all hits.

  sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS.Ranged.WSD, {
    neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})

  sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS.Ranged.WSD.Acc, {
    ear1="Moonshade Earring", waist="Fotia Belt"})

  -- Leaden Salute: magical dark-ele., 100% AGI, 4.0/6.7/10.0 fTP.

  sets.precast.WS['Leaden Salute'] = set_combine(set_combine(sets.precast.WS.Magic, sets.DarkAffinity), {ear1="Moonshade Earring"})
  sets.precast.WS['Leaden Salute'].Acc = set_combine(set_combine(sets.precast.WS.Magic.Acc, sets.DarkAffinity), {ear1="Moonshade Earring"})

  -- Wildfire: magical fire-ele., 60% AGI, 5.5 fTP, TP affects enmity reduction.

  sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS.Magic, {})
  sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS.Magic.Acc, {})

  --------------------------------------
  -- Precast: Sword Weaponskills
  --------------------------------------

  --Because omen skillchains.
  sets.precast.WS['Burning Blade'] = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"}

  sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
    head=gear.CarmineMaskPlus1.D,
    ring2="Rufescent Ring",
    legs=gear.CarmineCuissesPlus1.D, feet=gear.CarmineGreavesPlus1.D})

  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS.WSD, {ear1="Moonshade Earring"})
  sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.WSD.Acc, {ear1="Moonshade Earring"})

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
  sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +1"}
  sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +1"}
  sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
  sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}

  if player.sub_job == "DNC" then
    sets.precast.Waltz = {
      head=gear.CarmineMaskPlus1.D, neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
      body=gear.herculean_waltz_body, hands=gear.HerculeanGloves.Waltz, ring1="Defending Ring", ring2="Valseur's Ring",
      back="Moonlight Cape", waist="Flume Belt +1", legs="Dashing Subligar", feet=gear.herculean_waltz_feet}

  	sets.Self_Waltz = {head="Mummu Bonnet +1", body="Passion Jacket", ring1="Asklepian Ring"}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade"}
  end

--------------------------------------
-- Precast: Job Abilities: Phantom Roll
--------------------------------------

  sets.precast.CorsairRoll = {
    range=gear.Compensator.D,
    head="Lanun Tricorne +1", neck="Regal Necklace", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Lanun Frac +1", hands="Chasseur's Gants +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back=gear.CamulussMantle.Snapshot, waist="Flume Belt +1", legs="Desultor Tassets", feet=gear.herculean_dt_feet}

  sets.precast.LuzafRing = {ring2="Luzaf's Ring"}

  --sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +1"})
  --sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +1"})
  sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +1"})
  sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
  sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

--------------------------------------
-- Precast: Job Abilities: Quick Draw
--------------------------------------

  sets.precast.CorsairShot = {
    ammo=gear.Bullet.QuickDraw,
    head="Mummu Bonnet +2", neck="Iskur Gorget", ear1="Dedition Earring", ear2="Telos Earring", -- head="Laksamana Tricorne +3"
    body="Mummu Jacket +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Ilabrat Ring", ring2="Petrov Ring",
    back=gear.CamulussMantle.MagicWSD, waist="Eschan Stone", legs="Chasseur's Culottes +1", feet="Mummu Gamashes +2"} -- feet="Laksamana Boots +3"

	sets.precast.CorsairShot.Damage = {
    ammo=gear.Bullet.QuickDraw,
    head=gear.HerculeanHelm.MAB, neck="Baetyl Pendant", ear1="Novio Earring", ear2="Friomisi Earring",
    body="Mirke Wardecors", hands=gear.CarmineFingerGauntletsPlus1.D, ring1="Fenrir Ring +1", ring2="Dingir Ring",
    back=gear.CamulussMantle.MagicWSD, waist="Eschan Stone", legs="Mummu Kecks +2", feet="Lanun Bottes +1"}

  sets.precast.CorsairShot.Proc = {
    ammo=gear.Bullet.RA,
    head="White Rarab Cap +1", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Sanare Earring",
    body="Emet Harness +1", hands=gear.herculean_dt_hands, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.CarmineCuissesPlus1.D, feet="Chasseur's Bottes +1"}

  sets.precast.CorsairShot['Light Shot'] = set_combine(sets.MagicAccuracy, {ammo=gear.Bullet.QuickDraw})
  sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {}) -- feet="Chasseur's Bottes +1"

  --------------------------------------
  -- Precast: Snapshot
  --------------------------------------

  -- Can improve these sets with Commodore Charm +2.
  sets.precast.RA = {
    ammo=gear.Bullet.RA,
    head=gear.TaeonChapeau.Snapshot,
    hands=gear.CarmineFingerGauntletsPlus1.D, -- body="Oshosi Vest +1"
    back=gear.CamulussMantle.Snapshot, waist="Impulse Belt", legs=gear.AdhemarKecksPlus1.D, feet="Meghanada Jambeaux +2"} -- waist="Yemaya Belt" (when others upgraded)

  sets.precast.RA.Flurry = set_combine(sets.precast.RA, {}) -- body="Laksamana Frac +1"

  sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
    head="Chasseur's Tricorne +1", waist="Impulse Belt", gear.PursuersGaiters.D})

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

  sets.precast.FC = {                                                                                                -- Total: 60 FC.
    head=gear.CarmineMaskPlus1.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",  -- 14, 5, 2, 2
    body=gear.AdhemarJacketPlus1.D, hands="Leyline Gloves", ring1="Kishar Ring", ring2="Prolix Ring",                -- 10, 8, 4, 2
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.TaeonTights.PhalanxFC, feet=gear.CarmineGreavesPlus1.D}  -- -,  -, 5, 8

  if player.sub_job == "NIN" then
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace"})                         -- Total: 66 FC.
  end

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear2="Mendicant's Earring"})

  --------------------------------------
  -- Midcast: Ranged Attacks
  --------------------------------------

  sets.midcast.RA = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Iskur Gorget", ear1="Telos Earring", ear2="Enervating Earring",
    body="Malignance Tabard", hands=gear.CarmineFingerGauntletsPlus1.D, ring1="Dingir Ring", ring2="Ilabrat Ring",
    back=gear.CamulussMantle.AGIWSD, waist="Yemaya Belt", legs="Malignance Tights", feet="Meghanada Jambeaux +2"} -- back=gear.CamulussMantle.RangedTP

  sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
    hands="Meghanada Gloves +2", -- body="Laksamana's Frac +3", ring1="Regal Ring"
    feet="Meghanada Jambeaux +2"}) -- legs="Laksamana's Trews +3"

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

  sets.midcast.FastRecast = {
    head=gear.CarmineMaskPlus1.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body=gear.AdhemarJacketPlus1.D, hands="Leyline Gloves", ring1="Kishar Ring", ring2="Prolix Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.RawhideTrousers.D, feet=gear.CarmineGreavesPlus1.D}

  --------------------------------------
  -- Midcast: Healing Magic
  --------------------------------------

	sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
    neck="Phalaina Locket", ear2="Mendicant's Earring",
    ring1="Lebeche Ring", ring2="Menelaus's Ring",
    back="Solemnity Cape"})

  --------------------------------------
  -- Midcast: Ninjutsu
  --------------------------------------

  sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	--------------------------------------
	-- Active buffs
	--------------------------------------

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff['Triple Shot'] = {body="Chasseur's Frac +1"} -- Oshosi
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  if player.sub_job == 'NIN' then
    set_macro_page(2, 11)
  elseif player.sub_job == 'DNC' then
	  set_macro_page(1, 11)
  elseif player.sub_job == 'RNG' then
    set_macro_page(9, 11)
  else
    set_macro_page(10, 11)
  end
end
