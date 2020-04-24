-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
  state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
  state.WeaponskillMode:options('Match', 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
  state.HybridMode:options('Normal')
  state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
  state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT', 'Refresh', 'Reraise')
  state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}
	state.Weapons:options('Lembing', 'Shining One')
	state.Passive = M{['description'] = 'Passive Mode', 'None', 'MP', 'Twilight'}

  select_default_macro_book()

  gear.BrigantiasMantle = {}
  gear.BrigantiasMantle.WSD = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10'}}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind @f7 gs c toggle AutoJumpMode')
	send_command('bind @` gs c cycle SkillchainMode')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  --------------------------------------
  -- Sets required by rules
  --------------------------------------

	sets.Self_Healing = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.Kiting = {legs=gear.CarmineCuissesPlus1.D}
	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}

  -- Extra defense sets.  Apply these on top of melee or defense sets.
  sets.passive.MP = {ear2="Ethereal Earring", waist="Flume Belt +1"}
  sets.passive.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Put HP+ gear and the AF head to make healing breath trigger more easily with this set.
	sets.midcast.HB_Trigger = set_combine(sets.midcast.FastRecast, {head="Vishap Armet +1"})

  --------------------------------------
  -- Base sets
  --------------------------------------

  --------------------------------------
  -- Idle
  --------------------------------------

	sets.idle = {
    ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm", neck="Bathy Choker +1", ear1="Genmei Earring", ear2="Ethereal Earring",
		body="Hjarrandi Breastplate", hands="Sulevia's Gauntlets +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT, -- body="Sacro Breastplate"
		back="Shadow Mantle", waist="Flume Belt +1", legs=gear.CarmineCuissesPlus1.D, feet="Amm Greaves"}

	sets.idle.Refresh = set_combine(sets.idle, {head="Jumalik Helm", body="Jumalik Mail"})
	sets.idle.Weak = set_combine(sets.idle, sets.passive.Twilight)
	sets.idle.Reraise = set_combine(sets.idle, sets.passive.Twilight)

  --------------------------------------
  -- Defense
  --------------------------------------

	sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Ethereal Earring",
		body="Tartarus Platemail", hands="Sulevia's Gauntlets +1", ring1="Moonbeam Ring", ring2="Moonbeam Ring",
		back="Shadow Mantle", waist="Flume Belt +1", legs="Arke Cosciales", feet="Amm Greaves"}

	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm", body="Twilight Mail"})

	sets.defense.MDT = {
    ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1", neck="Warder's Charm +1", ear1="Genmei Earring", ear2="Ethereal Earring",
		body="Tartarus Platemail", hands="Sulevia's Gauntlets +1", ring1="Moonbeam Ring", ring2="Moonbeam Ring",
		back="Moonlight Cape", waist="Flume Belt +1", legs="Arke Cosciales", feet="Amm Greaves"}

	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.passive.Twilight)

	sets.defense.MEVA = {
    ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1", neck="Warder's Charm +1", ear1="Genmei Earring", ear2="Ethereal Earring",
		body="Tartarus Platemail", hands="Leyline Gloves", ring1="Moonbeam Ring", ring2="Moonbeam Ring",
		back="Moonlight Cape", waist="Flume Belt +1", legs="Arke Cosciales", feet="Amm Greaves"}

  --------------------------------------
  -- Resting
  --------------------------------------

  sets.resting = {}

  --------------------------------------
  -- Weapons
  --------------------------------------

  sets.weapons['Lembing'] = {main="Lembing", sub="Utu Grip"}
  sets.weapons['Shining One'] = {main="Shining One", sub="Utu Grip"}

  --------------------------------------
  -- Engaged
  --------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    ammo="Aurgelmir Orb",
    head="Flamma Zucchetto +2", neck="Anu Torque", ear1="Brutal Earring", ear2="Sherida Earring",
    body="Hjarrandi Breastplate", hands="Sulevia's Gauntlets +1", ring1="Petrov Ring", ring2="Flamma Ring", -- ring2="Niqmaddu Ring",
    back=gear.BrigantiasMantle.WSD, waist="Ioskeha Belt +1", legs=gear.ValorousHose.DA, feet="Flamma Gambieras +2"}

  sets.engaged.SomeAcc = {
    ring1="Regal Ring"}

  sets.engaged.Acc = {
    ear1="Dignitary's Earring", ear2="Telos Earring",
    ring1="Ramuh Ring +1"}

  sets.engaged.FullAcc = {
    ring2="Ramuh Ring +1"} -- ear1="Zennaroi Earring"

  sets.engaged.Fodder = {neck="Ganesha's Mala"}

  sets.engaged.PDT = {
    ammo="Staunch Tathlum +1",
    head="Hjarrandi Helm", neck="Anu Torque", ear1="Brutal Earring", ear2="Sherida Earring",
    body="Hjarrandi Breastplate", hands="Sulevia's Gauntlets +1", ring1="Defending Ring", ring2="Flamma Ring", -- ring2="Niqmaddu Ring",
    back=gear.BrigantiasMantle.WSD, waist="Ioskeha Belt +1", legs=gear.ValorousHose.DA, feet="Flamma Gambieras +2"}

  sets.engaged.SomeAcc.PDT = {}
  sets.engaged.Acc.PDT = {}
  sets.engaged.FullAcc.PDT = {}
  sets.engaged.Fodder.PDT = {}

  --[[

  sets.engaged.AM = {}
  sets.engaged.AM.SomeAcc = {}
  sets.engaged.AM.Acc = {}
  sets.engaged.AM.FullAcc = {}
  sets.engaged.AM.Fodder = {}

  sets.engaged.PDT = {}
  sets.engaged.SomeAcc.PDT = {}
  sets.engaged.Acc.PDT = {}
  sets.engaged.FullAcc.PDT = {}
  sets.engaged.Fodder.PDT = {}

  sets.engaged.AM.PDT = {}
  sets.engaged.AM.SomeAcc.PDT = {}
  sets.engaged.AM.Acc.PDT = {}
  sets.engaged.AM.FullAcc.PDT = {}
  sets.engaged.AM.Fodder.PDT = {}

  -- Melee sets for in Adoulin, which has an extra 2% Haste from Ionis.

  sets.engaged.Adoulin = {}
  sets.engaged.Adoulin.SomeAcc = {}
  sets.engaged.Adoulin.Acc = {}
  sets.engaged.Adoulin.FullAcc = {}
  sets.engaged.Adoulin.Fodder = {}

  sets.engaged.Adoulin.AM = {}
  sets.engaged.Adoulin.AM.SomeAcc = {}
  sets.engaged.Adoulin.AM.Acc = {}
  sets.engaged.Adoulin.AM.FullAcc = {}
  sets.engaged.Adoulin.AM.Fodder = {}

  sets.engaged.Adoulin.PDT = {}
  sets.engaged.Adoulin.SomeAcc.PDT = {}
  sets.engaged.Adoulin.Acc.PDT = {}
  sets.engaged.Adoulin.FullAcc.PDT = {}
  sets.engaged.Adoulin.Fodder.PDT = {}

  sets.engaged.Adoulin.AM.PDT = {}
  sets.engaged.Adoulin.AM.SomeAcc.PDT = {}
  sets.engaged.Adoulin.AM.Acc.PDT = {}
  sets.engaged.Adoulin.AM.FullAcc.PDT = {}
  sets.engaged.Adoulin.AM.Fodder.PDT = {}
  --]]

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------

  -- Default sets for weaponskills that aren't any more specifically defined. Focuses on STR.

	sets.precast.WS = {
    ammo="Knobkierrie",
		head="Flamma Zucchetto +2", neck="Caro Necklace", ear1="Moonshade Earring", ear2="Sherida Earring",
		body="Sulevia's Platemail +1", hands="Sulevia's Gauntlets +1", ring1="Regal Ring", ring2="Shukuyu Ring", -- ring2="Niqmaddu Ring",
		back=gear.BrigantiasMantle.WSD, waist="Prosilio Belt +1", legs="Sulevia's Cuisses +1", feet="Flamma Gambieras +2"}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {}) -- neck="Shulmanu Collar"
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {}) -- neck="Shulmanu Collar"
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

  -- STR-based weaponskills that benefit from Weapon Skill Damage.

	sets.precast.WS.WSD = {
    ammo="Knobkierrie",
		head="Flamma Zucchetto +2", neck="Caro Necklace", ear1="Ishvara Earring", ear2="Sherida Earring",
		body="Sulevia's Platemail +1", hands="Sulevia's Gauntlets +1", ring1="Epaminondas's Ring", ring2="Shukuyu Ring", -- ring2="Niqmaddu Ring",
		back=gear.BrigantiasMantle.WSD, waist="Prosilio Belt +1", legs="Sulevia's Cuisses +1", feet="Sulevia's Leggings +1"}

	sets.precast.WS.WSD.SomeAcc = set_combine(sets.precast.WS.WSD, {})
	sets.precast.WS.WSD.Acc = set_combine(sets.precast.WS.WSD, {neck="Shulmanu Collar"})
	sets.precast.WS.WSD.FullAcc = set_combine(sets.precast.WS.WSD, {neck="Shulmanu Collar"})
	sets.precast.WS.WSD.Fodder = set_combine(sets.precast.WS.WSD, {})

  -- STR-based weaponskills that can critically hit.

	sets.precast.WS.Crit = {
    ammo="Knobkierrie",
		head="Flamma Zucchetto +2", neck="Caro Necklace", ear1="Brutal Earring", ear2="Sherida Earring",
		body="Hjarrandi Breastplate", hands="Sulevia's Gauntlets +1", ring1="Begrudging Ring", ring2="Shukuyu Ring", -- ring2="Niqmaddu Ring",
		back=gear.BrigantiasMantle.WSD, waist="Prosilio Belt +1", legs="Sulevia's Cuisses +1", feet="Sulevia's Leggings +1"}

	sets.precast.WS.Crit.SomeAcc = set_combine(sets.precast.WS.Crit, {})
	sets.precast.WS.Crit.Acc = set_combine(sets.precast.WS.Crit, {}) -- neck="Shulmanu Collar"
	sets.precast.WS.Crit.FullAcc = set_combine(sets.precast.WS.Crit, {}) -- neck="Shulmanu Collar"
	sets.precast.WS.Crit.Fodder = set_combine(sets.precast.WS.Crit, {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1", ear2="Sherida Earring"}
	sets.AccMaxTP = {ear1="Zennaroi Earring", ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Zennaroi Earring", ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Brutal Earring", ear2="Sherida Earring"}
	sets.AccDayWSEars = {ear1="Zennaroi Earring", ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Moonshade Earring", ear2="Sherida Earring"}

  --------------------------------------
  -- Precast: Polearm Weaponskills
  --------------------------------------

  -- Double Thrust: physical 2-hit, 30% STR 30% DEX, 1.0/1.5/2.0 fTP.

  sets.precast.WS['Double Thrust'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Ishvara Earring", waist="Fotia Belt"})

  -- Thunder Thrust: magical, lightning-ele., 40% STR 40% INT, 1.5/2.0/2.5 fTP.

  sets.precast.WS['Thunder Thrust'] = set_combine(sets.precast.WS, {ear1="Moonshade Earring"})

  -- Raiden Thrust: magical, lightning-ele., 40% STR 40% INT, 1.0/2.0/3.0 fTP.

  sets.precast.WS['Raiden Thrust'] = set_combine(sets.precast.WS.Magic, {ear1="Moonshade Earring"})

  -- Leg Sweep: physical 1-hit, 100% STR, 1.0 fTP, TP affects chance to stun.

  sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS.WSD, {
    neck="Fotia Gorget", waist="Fotia Belt"})

  -- Penta Thrust: physical 5-hit, 20% STR 20% DEX, 1.0 fTP, TP affects accuracy.

  sets.precast.WS['Penta Thrust'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})

  -- Vorpal Thrust: physical 1-hit, 50% STR 50% AGI, 1.0 fTP, TP affects chance to crit.

  sets.precast.WS['Vorpal Thrust'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Ishvara Earring", ring1="Begrudging Ring", waist="Fotia Belt"})

  -- Skewer: physical 3-hit, 50% STR, 1.0 fTP, TP affects chance to crit.

  sets.precast.WS['Skewer'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Moonshade Earring", ring1="Begrudging Ring", waist="Fotia Belt"})

  -- Wheeling Thrust: physical 1-hit, 80% STR, 1.75 fTP, TP affects amount of defense ignored.

  sets.precast.WS['Wheeling Thrust'] = set_combine(sets.precast.WS.WSD, {
    neck="Fotia Gorget", ear1="Ishvara Earring", ear2="Moonshade Earring", waist="Fotia Belt"})

  -- Impulse Drive: physical 2-hit, 100% STR, 1.0/3.0/5.5 fTP.

  sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS.WSD, {
    neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Ishvara Earring", waist="Fotia Belt"})

  -- Drakesbane: physical 4-hit, 50% STR, 1.0 fTP, TP affects chance to crit.

  sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Moonshade Earring", ring1="Begrudging Ring", waist="Fotia Belt"})

	sets.precast.WS['Drakesbane'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Drakesbane'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Drakesbane'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  -- Sonic Thrust: physical 1-hit AOE, 40% STR 40% DEX, 3.0/3.7/4.5 fTP.

  sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS.WSD, {
    ear1="Moonshade Earring", ear2="Ishvara Earring"})

  -- Camlann's Torment: physical 3-hit, 60% STR 60% VIT, 3.0 fTP, TP affects amount of defense ignored.

  sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS.WSD, {ear1="Moonshade Earring"})

  -- Stardiver: physical 4-hit, 73~85% STR, 0.75/1.25/1.75 fTP.

  sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})

	sets.precast.WS['Stardiver'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Stardiver'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Stardiver'].Fodder = set_combine(sets.precast.WS.Fodder, {})

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

  sets.precast.JA['Ancient Circle'] = {} --legs="Vishap Brais"
	sets.precast.JA['Angon'] = {ammo="Angon"} --hands="Ptero. Fin. G. +1"

	sets.precast.JA['Jump'] = {
    ammo="Aurgelmir Orb",
		head="Flamma Zucchetto +2", neck="Ganesha's Mala", ear1="Brutal Earring", ear2="Sherida Earring",
		body="Hjarrandi Breastplate", hands="Sulevia's Gauntlets +1", ring1="Petrov Ring", ring2="Niqmaddu Ring",
		back=gear.BrigantiasMantle.WSD, waist="Windbuffet Belt +1", legs="Sulevia's Cuisses +1", feet="Flamma Gambieras +2"}

	sets.precast.JA['High Jump'] = {
    ammo="Aurgelmir Orb",
		head="Flamma Zucchetto +2", neck="Ganesha's Mala", ear1="Brutal Earring", ear2="Sherida Earring",
		body="Hjarrandi Breastplate", hands="Sulevia's Gauntlets +1", ring1="Petrov Ring", ring2="Niqmaddu Ring",
		back=gear.BrigantiasMantle.WSD, waist="Windbuffet Belt +1", legs="Sulevia's Cuisses +1", feet="Flamma Gambieras +2"}

	sets.precast.JA['Soul Jump'] = {
    ammo="Aurgelmir Orb",
		head="Flamma Zucchetto +2", neck="Ganesha's Mala", ear1="Brutal Earring", ear2="Sherida Earring",
		body="Hjarrandi Breastplate", hands="Sulevia's Gauntlets +1", ring1="Petrov Ring", ring2="Niqmaddu Ring",
		back=gear.BrigantiasMantle.WSD, waist="Windbuffet Belt +1", legs="Sulevia's Cuisses +1", feet="Flamma Gambieras +2"}

	sets.precast.JA['Spirit Jump'] = {
    ammo="Aurgelmir Orb",
		head="Flamma Zucchetto +2", neck="Ganesha's Mala", ear1="Brutal Earring", ear2="Sherida Earring",
		body="Hjarrandi Breastplate", hands="Sulevia's Gauntlets +1", ring1="Petrov Ring", ring2="Niqmaddu Ring",
		back=gear.BrigantiasMantle.WSD, waist="Windbuffet Belt +1", legs="Sulevia's Cuisses +1", feet="Flamma Gambieras +2"}

	sets.precast.JA['Super Jump'] = {}
	sets.precast.JA['Spirit Link'] = {} -- head="Vishap Armet +1", hands="Lnc. Vmbrc. +2"
	sets.precast.JA['Call Wyvern'] = {} -- body="Ptero. Mail +1"
	sets.precast.JA['Deep Breathing'] = {} -- hands="Ptero. Armet +1"
	sets.precast.JA['Spirit Surge'] = {} -- body="Ptero. Mail +1"
	sets.precast.JA['Steady Wing'] = {}

	-- Breath sets
	sets.precast.JA['Restoring Breath'] = {back=gear.BrigantiasMantle.WSD}
	sets.precast.JA['Smiting Breath'] = {back=gear.BrigantiasMantle.WSD}
	sets.HealingBreath = {back=gear.BrigantiasMantle.WSD}
	sets.SmitingBreath = {back=gear.BrigantiasMantle.WSD}

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {}

  -- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {}

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

	sets.precast.FC = {
    ammo="Sapience Orb",
		head=gear.CarmineMaskPlus1.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
		body=gear.TaeonTabard.PhalanxFC, hands="Leyline Gloves", ring1="Lebeche Ring", ring2="Prolix Ring", -- body="Sacro Breastplate"
		back="Moonlight Cape", waist="Flume Belt +1", legs="Enif Cosciales", feet=gear.CarmineGreavesPlus1.D}

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

	sets.midcast.FastRecast = {
    ammo="Sapience Orb",
		head=gear.CarmineMaskPlus1.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
		body=gear.TaeonTabard.PhalanxFC, hands="Leyline Gloves", ring1="Defending Ring", ring2="Prolix Ring", -- body="Sacro Breastplate"
		back="Moonlight Cape", waist="Tempus Fugit", legs="Enif Cosciales", feet=gear.CarmineGreavesPlus1.D}

  --------------------------------------
  -- Midcast: Healing Magic
  --------------------------------------

	sets.midcast.Cure = {}

	--------------------------------------
	-- Active buffs
	--------------------------------------

  sets.buff.Doom = set_combine(sets.buff.Doom, {})
  sets.buff.Sleep = {head="Frenzy Sallet"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(5, 13)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 13)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 13)
    else
        set_macro_page(5, 13)
    end
end
