-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal', 'Acc')
  state.RangedMode:options('Normal', 'Acc')
  state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'Proc')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.Weapons:options('Default', 'DualWeapons', 'DualSavageWeapons', 'DualLeadenRanged', 'DualLeadenMelee', 'DualLeadenMeleeAcc', 'DualKustawi', 'None')
	state.CompensatorMode:options('300', '1000', 'Never', 'Always')

  gear.Bullet = {}
  gear.Bullet.RA = "Chrono Bullet"
  gear.Bullet.PhysWS = "Chrono Bullet"
  gear.Bullet.MagicWS = "Orichalcum Bullet" -- WARNING: For MAB WS, DO NOT put single-use bullets here.
  gear.Bullet.QuickDraw = "Animikii Bullet"

  options.ammo_warning_limit = 15

  gear.CamulussMantle = {}
  gear.CamulussMantle.DA = {name="Camulus's Mantle", augments={'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10'}}

  -[[
	gear.tp_ranger_jse_back = {name="Camulus's Mantle", augments={'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'Rng.Acc.+10', '"Store TP"+10', }}
	gear.snapshot_jse_back = {name="Camulus's Mantle", augments={'"Snapshot"+10', }}
	gear.tp_jse_back = {name="Camulus's Mantle", augments={'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', }}
	gear.ranger_wsd_jse_back = {name="Camulus's Mantle", augments={'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', 'Weapon skill damage +10%', }}
	gear.magic_wsd_jse_back = {name="Camulus's Mantle", augments={'AGI+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'AGI+10', 'Weapon skill damage +10%', }}
	gear.str_wsd_jse_back = {name="Camulus's Mantle", augments={'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', }}
  -]]

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
	sets.DWMax = {ear1="Dudgeon Earring", ear2="Heartseeker Earring", body=gear.AdhemarJacketPlus1.B, hands="Floral Gauntlets", waist="Reiki Yotai"}

  --------------------------------------
  -- Base sets
  --------------------------------------

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
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.RawhideTrousers.A, feet=gear.herculean_dt_feet}

  --------------------------------------
  -- Defense
  --------------------------------------

  sets.defense.PDT = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands=gear.herculean_dt_hands, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet=gear.herculean_dt_feet}

  sets.defense.MDT = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands=gear.herculean_dt_hands, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Ahosi Leggings"}

  sets.defense.MEVA = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands=gear.herculean_dt_hands, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Ahosi Leggings"}

	--------------------------------------
	-- Resting
	--------------------------------------

  sets.resting = {}

  --------------------------------------
  -- Weapons
  --------------------------------------

	sets.weapons.Default = {main="Naegling", sub="Nusku Shield", range=gear.Holliday.MAB}
	sets.weapons.DualWeapons = {main="Naegling", sub="Blurred Knife +1", range=gear.Holliday.MAB}
	sets.weapons.DualSavageWeapons = {main="Naegling", sub="Blurred Knife +1", range="Anarchy"}
	sets.weapons.DualLeadenRanged = {main="Naegling", sub="Kaja Knife", range=gear.Holliday.MAB}
	sets.weapons.DualLeadenMelee = {main="Naegling", sub="Atoyac", range=gear.Holliday.MAB}
	sets.weapons.DualLeadenMeleeAcc = {main="Naegling", sub="Blurred Knife +1", range=gear.Holliday.MAB}
	sets.weapons.DualKustawi = {main="Kustawi +1", sub="Kustawi", range=gear.Holliday.MAB}

  --------------------------------------
  -- Engaged
  --------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Normal melee group
  sets.engaged = {
  	head=gear.AdhemarBonnetPlus1.B, neck="Iskur Gorget", ear1="Cessance Earring", ear2="Brutal Earring",
  	body="Meghanada Cuirie +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Epona's Ring", ring2="Petrov Ring",
  	back=gear.CamulussMantle.DA, waist="Windbuffet Belt +1", legs=gear.TaeonTights.TA, feet=gear.HerculeanBoots.TA}

  sets.engaged.Acc = {
  	head=gear.CarmineMaskPlus1.D, neck="Combatant's Torque", ear1="Cessance Earring", ear2="Telos Earring",
  	body="Meghanada Cuirie +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Epona's Ring", ring2="Petrov Ring",
  	back=gear.CamulussMantle.DA, waist="Olseni Belt", legs=gear.CarmineCuissesPlus1.D, feet=gear.HerculeanBoots.Acc}

  sets.engaged.DW = {
  	head=gear.AdhemarBonnetPlus1.B, neck="Asperity Necklace", ear1="Suppanomimi", ear2="Telos Earring", -- neck="Iskur Gorget"
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

  -- Default sets for weaponskills that aren't any more specifically defined. Focuses on STR.

  -- DEX-based weaponskills.

  sets.precast.WS = {
    head="Meghanada Visor +2", neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Telos Earring",
    body="Laksamana's Frac +3", hands="Meghanada Gloves +2", ring1="Regal Ring", ring2="Ifrit Ring +1",
    back=gear.CamulussMantle.DA, waist="Fotia Belt", legs="Meghanada Chausses +2", feet="Lanun Bottes +3"} -- gear.CamulussMantle.StrWSD

  sets.precast.WS.Acc = {
    head=gear.CarmineMaskPlus1.D, neck="Combatant's Torque", ear1="Dignitary's Earring", ear2="Telos Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Regal Ring", ring2="Ilabrat Ring",
    back=gear.CamulussMantle.DA, waist="Grunfeld Rope", legs=gear.CarmineCuissesPlus1.D, feet="Lanun Bottes +3"} -- gear.CamulussMantle.StrWSD

  sets.precast.WS.Proc = {
    head=gear.CarmineMaskPlus1.D, neck="Combatant's Torque", ear1="Dignitary's Earring", ear2="Zennaroi Earring",
    body="Mummu Jacket +2", hands="Floral Gauntlets", ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.CamulussMantle.DA, waist="Olseni Belt", legs=gear.CarmineCuissesPlus1.D, feet=gear.herculean_acc_feet}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

  --------------------------------------
  -- Precast: Dagger Weaponskills
  --------------------------------------



  --------------------------------------
  -- Precast: Marksmanship Weaponskills
  --------------------------------------

  sets.precast.WS['Last Stand'] = {
    ammo=gear.Bullet.PhysWS,
    head="Meghanada Visor +2", neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Telos Earring",
    body="Laksamana's Frac +3", hands="Meghanada Gloves +2", ring1="Regal Ring", ring2="Dingir Ring",
    back=gear.ranger_wsd_jse_back, waist="Fotia Belt", legs="Meghanada Chausses +2", feet="Lanun Bottes +3"}

  sets.precast.WS['Last Stand'].Acc = {
    ammo=gear.Bullet.PhysWS,
    head="Meghanada Visor +2", neck="Iskur Gorget", ear1="Moonshade Earring", ear2="Telos Earring",
    body="Laksamana's Frac +3", hands="Meghanada Gloves +2", ring1="Regal Ring", ring2="Dingir Ring",
    back=gear.ranger_wsd_jse_back, waist="Fotia Belt", legs="Meghanada Chausses +2", feet="Lanun Bottes +3"}

  sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
  sets.precast.WS['Detonator'].Acc = sets.precast.WS['Last Stand'].Acc
  sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
  sets.precast.WS['Slug Shot'].Acc = sets.precast.WS['Last Stand'].Acc
  sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
  sets.precast.WS['Numbing Shot'].Acc = sets.precast.WS['Last Stand'].Acc
  sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
  sets.precast.WS['Sniper Shot'].Acc = sets.precast.WS['Last Stand'].Acc
  sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']
  sets.precast.WS['Split Shot'].Acc = sets.precast.WS['Last Stand'].Acc

  sets.precast.WS['Leaden Salute'] = {
    ammo=gear.Bullet.MagicWS,
    head="Pixie Hairpin +1", neck="Baetyl Pendant", ear1="Moonshade Earring", ear2="Friomisi Earring",
    body="Laksamana's Frac +3", hands="Carmine Finger Gauntlets +1", ring1="Archon Ring", ring2="Dingir Ring",
    back=gear.magic_wsd_jse_back, waist="Eschan Stone", legs="Laksamana's Trews +3", feet="Lanun Bottes +3"}

  sets.precast.WS['Leaden Salute'].Acc = {
    ammo=gear.Bullet.MagicWS,
    head="Pixie Hairpin +1", neck="Sanctity Necklace", ear1="Moonshade Earring", ear2="Friomisi Earring",
    body="Laksamana's Frac +3", hands="Leyline Gloves", ring1="Archon Ring", ring2="Dingir Ring",
    back=gear.magic_wsd_jse_back, waist="Eschan Stone", legs="Laksamana's Trews +3", feet="Lanun Bottes +3"}

  sets.precast.WS['Wildfire'] = {
    ammo=gear.Bullet.MagicWS,
    head=gear.HerculeanHelm.MAB, neck="Baetyl Pendant", ear1="Crematio Earring", ear2="Friomisi Earring",
    body="Laksamana's Frac +3", hands="Carmine Finger Gauntlets +1", ring1="Regal Ring", ring2="Dingir Ring",
    back=gear.magic_wsd_jse_back, waist="Eschan Stone", legs="Laksamana's Trews +3", feet="Lanun Bottes +3"}

  sets.precast.WS['Wildfire'].Acc = {
    ammo=gear.Bullet.MagicWS,
    head=gear.HerculeanHelm.MAB, neck="Sanctity Necklace", ear1="Crematio Earring", ear2="Friomisi Earring",
    body="Laksamana's Frac +3", hands="Leyline Gloves", ring1="Regal Ring", ring2="Dingir Ring",
    back=gear.magic_wsd_jse_back, waist="Eschan Stone", legs="Laksamana's Trews +3", feet="Lanun Bottes +3"}

  sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
  sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc

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
    legs=gear.CarmineCuissesPlus1.D, feet=gear.CarmineGreavesPlus1.B})

  sets.precast.WS['Savage Blade'] = {
    ammo=gear.Bullet.PhysWS,
    head="Lilitu Headpiece", neck="Caro Necklace", ear1="Moonshade Earring", ear2="Ishvara Earring",
    body="Laksamana's Frac +3", hands="Meghanada Gloves +2", ring1="Regal Ring", ring2="Ifrit Ring +1",
    back=gear.str_wsd_jse_back, waist="Grunfeld Rope", legs=gear.herculean_wsd_legs, feet="Lanun Bottes +3"}

  sets.precast.WS['Savage Blade'].Acc = {
    ammo=gear.Bullet.PhysWS,
    head=gear.CarmineMaskPlus1.D, neck="Caro Necklace", ear1="Moonshade Earring", ear2="Telos Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Regal Ring", ring2="Rufescent Ring",
    back=gear.str_wsd_jse_back, waist="Grunfeld Rope", legs=gear.CarmineCuissesPlus1.D, feet="Lanun Bottes +3"}

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
  sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +1"}
  sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +1"}
  sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
  sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
    head=gear.CarmineMaskPlus1.D, neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body=gear.herculean_waltz_body, hands=gear.herculean_waltz_hands, ring1="Defending Ring", ring2="Valseur's Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs="Dashing Subligar", feet=gear.herculean_waltz_feet}

	sets.Self_Waltz = {head="Mummu Bonnet +1", body="Passion Jacket", ring1="Asklepian Ring"}

  -- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {}

--------------------------------------
-- Precast: Job Abilities: Phantom Roll
--------------------------------------

  sets.precast.CorsairRoll = {
    range="Compensator",
    head="Lanun Tricorne +1", neck="Regal Necklace", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Ly-we5[anun Frac +1", hands="Chasseur's Gants +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Camulus's Mantle", waist="Flume Belt +1", legs="Desultor Tassets", feet=gear.herculean_dt_feet}

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
    head=gear.HerculeanHelm.MAB, neck="Iskur Gorget", ear1="Dedition Earring", ear2="Telos Earring",
    body="Mummu Jacket +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Ilabrat Ring", ring2="Petrov Ring",
    back=gear.tp_ranger_jse_back, waist="Goading Belt", legs="Chasseur's Culottes +1", feet=gear.CarmineGreavesPlus1.D}

	sets.precast.CorsairShot.Damage = {
    ammo=gear.Bullet.QuickDraw,
    head=gear.HerculeanHelm.MAB, neck="Baetyl Pendant", ear1="Friomisi Earring", ear2="Novio Earring",
    body="Samnuha Coat", hands="Leyline Gloves", ring1="Fenrir Ring +1", ring2="Fenrir Ring +1", -- hands=CarmineFingerGauntletsPlus1.D, ring1="Dingir Ring"
    back=gear.ranger_wsd_jse_back, waist="Eschan Stone", legs="Mummu Kecks +2", feet="Lanun Bottes +1"}

  sets.precast.CorsairShot.Proc = {
    ammo=gear.Bullet.RA,
    head="White Rarab Cap +1", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Sanare Earring",
    body="Emet Harness +1", hands=gear.herculean_dt_hands, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.CarmineCuissesPlus1.D, feet="Chasseur's Bottes +1"}

  sets.precast.CorsairShot['Light Shot'] = {
    ammo=gear.Bullet.QuickDraw,
    head=gear.CarmineMaskPlus1.D, neck="Sanctity Necklace", ear1="Dignitary's Earring", ear2="Telos Earring",
    body="Mummu Jacket +2", hands="Leyline Gloves", ring1="Stikini Ring", ring2="Stikini Ring",
    back=gear.ranger_wsd_jse_back, waist="Eschan Stone", legs="Mummu Kecks +2", feet="Mummu Gamashes +2"}

  sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {feet="Chasseur's Bottes +1"})

  --------------------------------------
  -- Precast: Snapshot
  --------------------------------------

  -- Can improve this set with Commodore Charm +2.

  sets.precast.RA = {
    ammo=gear.Bullet.RA,
    head=gear.TaeonChapeau.Snapshot,
    hands="Lanun Gants +1", -- body="Oshosi Vest +1", hands=gear.CarmineFingerGauntletsPlus1.D
    waist="Impulse Belt", legs=gear.AdhemarKecks.C, feet="Meghanada Jambeaux +2"} -- back=gear.CamulussMantle.Snapshot, waist="Yemaya Belt" (when others upgraded)

  sets.precast.RA.Flurry = set_combine(sets.precast.RA, {
    })

  sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
    head="Chasseur's Tricorne +1"})

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

  sets.precast.FC = {
    head=gear.CarmineMaskPlus1.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body=gear.TaeonTabard.PhalanxFC, hands="Leyline Gloves", ring1="Kishar Ring", ring2="Prolix Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.RawhideTrousers.D, feet=gear.CarmineGreavesPlus1.D}

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace", body="Passion Jacket"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear2="Mendicant's Earring"})

  --------------------------------------
  -- Midcast: Ranged Attacks
  --------------------------------------

  sets.midcast.RA = {
    ammo=gear.Bullet.RA,
    head="Meghanada Visor +2", neck="Marked Gorget", ear1="Telos Earring", ear2="Enervating Earring", -- neck="Iskur Gorget",
    body="Mummu Jacket +2", hands="Meghanada Gloves +2", ring1="Petrov Ring", ring2="Apate Ring", -- body="Oshosi Vest +1", hands=gear.AdhemarWristbandsPlus1.C, ring1="Dingir Ring", ring2="Ilabrat Ring"
    back="Gunslinger's Cape", waist="Yemaya Belt", legs=gear.AdhemarKecks.C, feet="Meghanada Jambeaux +2"} -- back=gear.CamulussMantle.RangedTP, feet=gear.AdhemarGamashesPlus1.D

  sets.midcast.RA.Acc = set_conbine(sets.midcast.RA, {
    hands="Meghanada Gloves +2", -- body="Laksamana's Frac +3", ring1="Regal Ring"
    feet="Meghanada Jambeaux +2"}) -- legs="Laksamana's Trews +3"

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

  sets.midcast.FastRecast = {
    head=gear.CarmineMaskPlus1.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body=gear.TaeonTabard.PhalanxFC, hands="Leyline Gloves", ring1="Kishar Ring", ring2="Prolix Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.RawhideTrousers.D, feet=gear.CarmineGreavesPlus1.B}

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
	sets.buff['Triple Shot'] = {body="Chasseur's Frac +1"}
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
