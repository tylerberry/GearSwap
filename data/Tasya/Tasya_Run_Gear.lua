function user_setup()
	state.OffenseMode:options('Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.HybridMode:options('Normal','DTLite','Tank')
	state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.CastingMode:options('Normal','MaxEnmity','SIRD','Resistant')
	state.PhysicalDefenseMode:options('PDT', 'PDT_HP')
	state.MagicalDefenseMode:options('MDT','MDT_HP','BDT','BDT_HP')
	state.ResistDefenseMode:options('MEVA','MEVA_HP','Death','Charm','DTCharm')
	state.IdleMode:options('Normal','Tank','KiteTank','Sphere')

	if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
		state.Weapons:options('Aettir','Montante','Zulfiqar','Naegling/Reikiko') -- 'Firangi/Reikiko'
	else
		state.Weapons:options('Aettir','Montante','Zulfiqar')
	end

	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
	send_command('bind ^\\\\ input /ma "Protect IV" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Crusade" <me>')
	send_command('bind ^backspace input /ja "Lunge" <t>')
	send_command('bind @backspace input /ja "Gambit" <t>')
	send_command('bind !backspace input /ja "Rayke" <t>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Zulfiqar;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	-- TODO:
	--
	-- - Determine HP thresholds for SIRD variants.
	-- - Fix panic button sets to make sense.
	-- - Look into HP changes on enhancing sets. (Probably largely unavoidable.)

  gear.EvasionistsCape = {}
  gear.EvasionistsCape.Embolden = {name="Evasionist's Cape", augments={'Enmity+6','"Embolden"+14','"Dbl.Atk."+2','Damage taken-3%'}}

  gear.OgmasCape = {}
  gear.OgmasCape.Enm = {name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10'}}
  gear.OgmasCape.FC = {name="Ogma's Cape", augments={'HP+60','HP+20','"Fast Cast"+10'}}

  sets.element.Dark = {head="Pixie Hairpin +1", ring2="Archon Ring"}
  sets.element.Earth = {neck="Quanpur Necklace"}

  --------------------------------------
	-- Base sets
	--------------------------------------

  -- Set priority is used to preserve Max HP. There are intentional 'gaps' in the priority numbers to allow
  -- derivative sets to slot in replacements at certain places. Specifically, 2, 6, and 8 are 'free'.

  sets.Enmity = {                                       -- +84 enmity.
    ammo={name="Aqreqaq Bomblet", priority=11},
    head={name="Halitus Helm", priority=4},
    neck="Moonlight Necklace",
    ear1={name="Cryptic Earring", priority=7},
    ear2={name="Odnowa Earring +1", priority=15},
    body={name="Emet Harness +1", priority=3},
    hands={name="Kurys Gloves", priority=5},
    ring1={name="Eihwaz Ring", priority=12},
    ring2={name="Moonlight Ring", priority=13},
    back={name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10'}, priority=9},
    waist={name="Kasiri Belt", priority=14},
    legs={name="Erilaz Leg Guards +1", priority=10},
    feet={name="Rager Ledelsens +1", priority=1}} -- feet="Ahosi Leggings"

  -- Identical to sets.Enmity, but with swap order prioritized to assume you're coming from an idle/engaged
	-- tanking set, rather than Fast Cast.

	sets.Enmity.JA = {                                    -- +84 enmity.
    ammo={name="Aqreqaq Bomblet", priority=11},
    head={name="Halitus Helm", priority=5},
    neck="Moonlight Necklace",
    ear1={name="Cryptic Earring", priority=7},
    ear2={name="Odnowa Earring +1", priority=15},
    body={name="Emet Harness +1", priority=4},
    hands={name="Kurys Gloves", priority=3},
    ring1={name="Eihwaz Ring", priority=12},
    ring2={name="Moonlight Ring", priority=13},
    back={name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10'}, priority=9},
    waist={name="Kasiri Belt", priority=14},
    legs={name="Erilaz Leg Guards +1", priority=10},
    feet={name="Rager Ledelsens +1", priority=1}} -- feet="Ahosi Leggings"

	sets.Enmity.MaxEnmity = set_combine(sets.Enmity, {    -- +91 enmity.
		ear2="Friomisi Earring", -- ear2="Trux Earring"
		ring2={name="Supershear Ring", priority=6}})

  -- Capped SIRD, assuming SIRD -10% merits. +50 enmity.
  sets.Enmity.SIRD = set_combine(sets.Enmity, {
    ammo="Staunch Tathlum +1",
    neck="Moonlight Necklace",
		ear1="Halasz Earring",
    hands={name="Rawhide Gloves", augments={'DEX+10','STR+7','INT+7'}, priority=5},
		ring1="Evanescence Ring",
    waist="Rumination Sash",
		legs={name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6'}, priority=2},
		feet={name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3'}, priority=1}})

  sets.MagicAttack = {
    ammo="Seething Bomblet +1",
    head=gear.HerculeanHelm.MAB, neck="Sanctity Necklace", ear1="Friomisi Earring", ear2="Novio Earring",
    body="Samnuha Coat", hands="Leyline Gloves", ring1="Fenrir Ring +1", ring2="Fenrir Ring +1",
    back=gear.EvasionistsCape.Enm, waist="Eschan Stone", legs="Limbo Trousers", feet=gear.HerculeanBoots.WSD}

  if player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH" or player.sub_job == "PLD" or player.sub_job == "BLU" then
    sets.Cure = set_combine(sets.Enmity, {
      neck="Phalaina Locket", ear1="Mendicant's Earring", ear2="Roundel Earring",
      body="Vrikodara Jupon", ring1="Menelaus's Ring", ring2="Stikini Ring +1",
      back="Tempered Cape +1", waist="Bishop's Sash", legs=gear.CarmineCuissesPlus1.D}) -- feet="Skaoi Boots"

    sets.Cure.DT = set_combine(sets.Enmity.DT, {
      neck="Phalaina Locket", ear1="Mendicant's Earring", ear2="Roundel Earring",
      body="Vrikodara Jupon", -- ring1="Menelaus's Ring"
      back="Tempered Cape +1", waist="Bishop's Sash", legs=gear.CarmineCuissesPlus1.D}) -- feet="Skaoi Boots"
  end

	--------------------------------------
	-- Idle
	--------------------------------------

  -- FIXME: this set is way too low on HP. Need to do some HP matching to make sure we don't lose HP all over.
  sets.idle = {
    ammo="Homiliary",
    head=gear.RawhideMask.A, neck="Bathy Choker +1", ear1="Infused Earring", ear2="Odnowa Earring +1",
    body="Runeist Coat +1", hands=gear.HerculeanGloves.Refresh, ring1="Stikini Ring +1", ring2="Moonlight Ring",
    back=gear.OgmasCape.Enm, waist=gear.IdleBelt, legs="Runeist Trousers +1", feet="Turms Leggings +1"}

  sets.idle.Sphere = set_combine(sets.idle, {body="Mekosuchinae Harness"})

	sets.idle.Tank = {
    ammo="Staunch Tathlum +1",
    head="Turms Cap +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Odnowa Earring +1",
    body="Erilaz Surcoat +1", hands="Turms Mittens +1", ring1="Defending Ring", ring2="Moonlight Ring",
    back=gear.OgmasCape.Enm, waist="Flume Belt +1", legs="Erilaz Leg Guards +1", feet="Erilaz Greaves +1"}

	sets.idle.KiteTank = set_combine(sets.idle.Tank, {
    legs=gear.CarmineCuissesPlus1.D, feet="Hippomenes Socks +1"})

	sets.idle.Weak = {
    ammo="Homiliary",
		head=gear.RawhideMask.A, neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Ethereal Earring",
		body="Runeist Coat +1", hands=gear.HerculeanGloves.Refresh, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
		back=gear.OgmasCape.Enm, waist="Flume Belt +1", legs="Runeist Trousers +1", feet="Erilaz Greaves +1"}

  --------------------------------------
	-- Defense
	--------------------------------------

  -- Extra defense sets.  Apply these on top of melee or defense sets.
  sets.Knockback = {}
  sets.MP = {ear2="Ethereal Earring", waist="Flume Belt +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
    head="Meghanada Visor +2", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Ethereal Earring",
    body="Futhark Coat +1", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Shadow Mantle", waist="Flume Belt +1", legs="Erilaz Leg Guards +1", feet="Erilaz Greaves +1"}

	sets.defense.PDT_HP = set_combine (sets.defense.PDT, {
    ammo="Staunch Tathlum +1",
    head="Futhark Bandeau +1", -- ear1="Odnowa Earring +1", ear2="Odnowa Earring"
    back="Moonlight Cape", body="Runeist Coat +1"})

	sets.defense.MDT = {
    ammo="Staunch Tathlum +1", --ammo="Yamarang",
    head="Erilaz Galea +1", neck="Warder's Charm +1", ear1="Genmei Earring", ear2="Ethereal Earring", -- ear1="Odnowa Earring +1", ear2="Sanare Earring"
    body="Runeist Coat +1", hands=gear.HerculeanGloves.PDT, ring1="Defending Ring", ring2="Shadow Ring",
    back="Moonlight Cape", waist="Engraved Belt", legs="Erilaz Leg Guards +1", feet="Erilaz Greaves +1"}

	sets.defense.MDT_HP = set_combine (sets.defense.MDT, {
    neck="Loricate Torque +1", -- ear2="Odnowa Earring"
    -- ring1="Moonbeam Ring", ring2="Moonbeam Ring",
    legs="Erilaz Leg Guards +1"})

	sets.defense.BDT = set_combine(sets.defense.MDT, {})
	sets.defense.BDT_HP = set_combine (sets.defense.MDT_HP, {})

  -- The whole Turms set is amazing for this.
  -- JSE neck or Moonbeam/Moonlight.
  -- I have Vengeful Ring on a mule. Worth? Shukuyu Ring could be inventory+1 if I get it.
  -- There are options for ear1, as well.
	sets.defense.MEVA = {
    ammo="Staunch Tathlum +1",
    head="Turms Cap +1", neck="Warder's Charm +1", ear2="Eabani Earring", -- ear1="Odnowa Earring +1"
    body="Erilaz Surcoat +1", hands="Turms Mittens +1", -- ring1="Purity Ring", ring2="Vengeful Ring"
    back=gear.OgmasCape.Enm, waist="Engraved Belt", legs="Runeist Trousers +1", feet="Turms Leggings +1"}

	sets.defense.MEVA_HP = set_combine (sets.defense.MEVA, {
    back="Moonlight Cape"}) --ring1="Moonbeam Ring", ring2="Moonbeam Ring"

	sets.defense.Death = set_combine (sets.defense.MEVA, {
    body="Samnuha Coat", ring1="Eihwaz Ring", ring2="Shadow Ring"})

	sets.defense.DTCharm = set_combine (sets.defense.MEVA, {
    neck="Unmoving Collar +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT})

	sets.defense.Charm = set_combine (sets.defense.MEVA, {
    neck="Unmoving Collar +1", back="Solemnity Cape"})

	--------------------------------------
	-- Resting
	--------------------------------------

  sets.resting = set_combine(sets.defense.PDT, {
    ammo="Homiliary",
    head=gear.RawhideMask.A, neck="Bathy Choker +1", ear1="Infused Earring", ear2="Dawn Earring",
    body="Vrikodara Jupon", hands="Turms Mittens +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    waist=gear.IdleBelt, legs="Erilaz Leg Guards +1", feet="Turms Leggings +1"}) -- back="Scuta Cape", legs="Turms Subligar +1",

  sets.resting.Sphere = set_combine(sets.resting, {body="Mekosuchinae Harness"})

  --------------------------------------
	-- Weapons
	--------------------------------------

	sets.weapons.Aettir = {main="Aettir", sub="Utu Grip"}
	sets.weapons.Montante = {main="Montante +1", sub="Utu Grip"}
	sets.weapons.Zulfiqar = {main=gear.Zulfiqar.DMG, sub="Utu Grip"}

	if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
    sets.weapons['Naegling/Reikiko'] = {main="Naegling", sub="Reikiko"}
	  --sets.weapons['Firangi/Reikiko'] = {main="Firangi", sub="Reikiko"}
	end

  --------------------------------------
	-- Engaged
	--------------------------------------

  sets.engaged = {
    ammo="Ginsen",
    head=gear.AdhemarBonnetPlus1.B, neck="Anu Torque", ear1="Brutal Earring", ear2="Sherida Earring",
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Petrov Ring", ring2="Epona's Ring", -- ring1="Niqmaddu Ring"
    back="Bleating Mantle", waist="Windbuffet Belt +1", legs=gear.TaeonTights.TA, feet=gear.HerculeanBoots.TA} -- back=gear.OgmasCape.STP, legs="Samnuha Tights"

  sets.engaged.SomeAcc = set_combine (sets.engaged, {
    ammo="Yamarang", head="Dampening Tam", neck="Combatant's Torque", body="Ayanmo Corazza +2"})

	sets.engaged.Acc = set_combine (sets.engaged.SomeAcc, {
    ammo="Falcon Eye", legs="Meghanada Chausses +2"})

	sets.engaged.HighAcc = set_combine (sets.engaged.Acc, {
    ear1="Telos Earring", ear2="Cessance Earring",
    hands="Meghanada Gloves +2", ring2="Ilabrat Ring",
    back="Grounded Mantle +1", waist="Grunfeld Rope"}) -- feet=gear.herculean_acc_feet

	sets.engaged.FullAcc = set_combine (sets.engaged.HighAcc, {
    head=gear.CarmineMaskPlus1.D, ear1="Mache Earring +1", ear2="Mache Earring +1",
    ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    waist="Olseni Belt", legs=gear.CarmineCuissesPlus1.D})

  sets.engaged.DTLite = {
    ammo="Yamarang",
    head=gear.AdhemarBonnetPlus1.B, neck="Loricate Torque +1", ear1="Telos Earring", ear2="Sherida Earring",
    body="Ayanmo Corazza +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Defending Ring", ring2="Moonlight Ring", --ring2="Niqmaddu Ring"
    back=gear.EvasionistsCape.Enm, waist="Windbuffet Belt +1", legs="Meghanada Chausses +2", feet=gear.HerculeanBoots.TA} -- belt="Iosheka Belt +1"

  sets.engaged.SomeAcc.DTLite = set_combine (sets.engaged.DTLite, {})
	sets.engaged.Acc.DTLite = set_combine (sets.engaged.SomeAcc.DTLite, {})
	sets.engaged.HighAcc.DTLite = set_combine (sets.engaged.Acc.DTLite, {waist="Olseni Belt",ear2="Mache Earring +1"})
	sets.engaged.FullAcc.DTLite = set_combine (sets.engaged.HighAcc.DTLite, {ear1="Mache Earring +1"})

  sets.engaged.Tank = {
    ammo="Staunch Tathlum +1",
    head="Turms Cap +1", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Odnowa Earring +1",
    body="Futhark Coat +1", hands="Turms Mittens +1", ring1="Defending Ring", ring2="Moonlight Ring",
    back=gear.OgmasCape.Enm, waist="Flume Belt +1", legs="Erilaz Leg Guards +1", feet="Turms Leggings +1"}

  sets.engaged.SomeAcc.Tank = set_combine(sets.engaged.Tank, {})
	sets.engaged.Acc.Tank = set_combine(sets.engaged.Tank, {})
	sets.engaged.HighAcc.Tank = set_combine(sets.engaged.Tank, {})
	sets.engaged.FullAcc.Tank = set_combine(sets.engaged.Tank, {})

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring"}
	sets.AccMaxTP = {ear1="Dignitary's Earring"} -- ear1="Telos Earring"

	sets.precast.WS = {
    ammo="Seething Bomblet +1",
    head=gear.AdhemarBonnetPlus1.B, neck="Caro Necklace", ear1="Brutal Earring", ear2="Sherida Earring",
    body=gear.AdhemarJacketPlus1.B, hands=gear.HerculeanGloves.TA, ring1="Shukuyu Ring", ring2="Ifrit Ring +1", -- ring1="Niqmaddu Ring", ring2="Regal Ring",
    back="Bleating Mantle", waist="Prosilio Belt +1", legs="Meghanada Chausses +2", feet=gear.LustratioLeggingsPlus1.D} -- back=gear.OgmasCape.DA

	sets.precast.WS.DEXWSD = {
    ammo="Knobkierrie",
    head="Lilitu Headpiece", neck="Caro Necklace", ear1="Ishvara Earring", ear2="Sherida Earring",
    body=gear.AdhemarJacketPlus1.B, hands="Meghanada Gloves +2", ring1="Ilabrat Ring", ring2="Ramuh Ring +1", -- ring2="Niqmaddu Ring"
    back="Bleating Mantle", waist="Grunfeld Rope", feet=gear.LustratioSubligarPlus1.B, feet=gear.HerculeanBoots.WSD} -- legs="Plunderer's Culottes +3"

  --[[
	sets.precast.WS.SomeAcc = set_combine (sets.precast.WS, {
    ammo="Seething Bomblet +1", body="Ayanmo Corazza +2", back="Grounded Mantle +1"})

	sets.precast.WS.Acc = set_combine (sets.precast.WS.SomeAcc, {head="Dampening Tam"})

	sets.precast.WS.HighAcc = {head="Meghanada Visor +2", ear1="Telos Earring"} -- feet=gear.herculean_acc_feet

	sets.precast.WS.FullAcc = {
    head=gear.CarmineMaskPlus1.D, neck="Combatant's Torque", ear1="Mache Earring +1", ear2="Mache Earring +1",
    body="Meghanada Cuirie +2", ring1="Ramuh Ring +1", ring2="Ramuh Ring +1"}  -- back=gear.OgmasCape.DA
	--]]

  --------------------------------------
  -- Precast: Great Sword WS
  --------------------------------------

  --[[

  -- Old sets. Need analysis. Should move Fotia, Moonshade off of the base sets.

  -- Hard Slash: physical 1-hit, 100% STR, 1.5/1.75/2.0 fTP.
  sets.precast.WS['Hard Slash'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget", ear2="Ishvara Earring", hands="Meghanada Gloves +1",waist="Fotia Gorget"})

  -- Power Slash: physical 1-hit, 60% STR 60% VIT, 1.0, TP affects chance to crit.
  sets.precast.WS['Power Slash'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget",ear2="Ishvara Earring",
    hands="Meghanada Gloves +1",
    back="Rancorous Mantle",waist="Fotia Gorget",feet="Thereoid Greaves"})

  -- Frostbite: magical, ice-ele., 40% STR 40% INT, 1.0/2.0/2.5 fTP.
  sets.precast.WS['Frostbite'] = set_combine (sets.MagicAttack, {})

  -- Freezebite: magical, ice-ele., 40% STR 40% INT, 1.0/1.5/3.0 fTP.
  sets.precast.WS['Freezebite'] = set_combine (sets.MagicAttack, {})

  -- Shockwave: physical AOE, 30% STR 30% MND, 1.0 fTP, TP affects duration of sleep.
  sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Gorget"})

  -- Crescent Moon: physical 1-hit, 80% STR, 1.5/1.75/2.75 fTP.
  sets.precast.WS['Crescent Moon'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget",ear2="Ishvara Earring",hands="Meghanada Gloves +1",waist="Fotia Gorget"})

  -- Sickle Moon: physical 2-hit, 40% STR 40% AGI, 1.5/2.0/2.75 fTP.
  sets.precast.WS['Sickle Moon'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Gorget"})

  -- Spinning Slash: physical 1-hit, 30% STR 30% INT, 2.5/3.0/3.5 fTP.
  sets.precast.WS['Spinning Slash'] = set_combine(sets.precast.WS, {
    hands="Meghanada Gloves +1",ear2="Ishvara Earring"})
  --]]

  -- Ground Strike: physical 1-hit, 50% STR 50% INT, 1.5/1.75/3.0 fTP.
  sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Ground Strike'].HighAcc = set_combine(sets.precast.WS.HighAcc, {})
	sets.precast.WS['Ground Strike'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})

  -- Herculean Slash: magical, ice-ele., 80% VIT, 3.5 fTP, TP affects duration of paralyze.
  sets.precast.WS['Herculean Slash'] = set_combine(sets.MagicAttack, {})

  -- Resolution: physical 5-hit, 73~85% STR, 0.71875/1.5/2.25 fTP.
  sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})
  sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {
		neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})
  sets.precast.WS['Resolution'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
		neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
		neck="Fotia Gorget", ear1="Moonshade Earring", waist="Fotia Belt"})

  -- Dimidiation: physical 2-hit, 80% DEX, 2.25/4.5/6.75 fTP.
  sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS.DEXWSD, {
    ear1="Moonshade Earring"})

  sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS.DEXWSD.Acc, {
    ear1="Moonshade Earring"})

	sets.precast.WS['Dimidiation'].HighAcc = set_combine(sets.precast.WS.DEXWSD.HighAcc, {
    ear1="Moonshade Earring"})

	sets.precast.WS['Dimidiation'].FullAcc = set_combine(sets.precast.WS.DEXWSD.FullAcc, {})

  --[[
  --------------------------------------
  -- Great Sword
  --------------------------------------

  -- Ground Strike: physical 1-hit, 50% STR 50% INT, 1.5/1.75/3.0 fTP.
  sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS, {
      neck="Fotia Gorget",ear2="Ishvara Earring",hands="Meghanada Gloves +1",waist="Fotia Gorget"})

  -- Resolution: physical 5-hit, 73~85% STR, 0.71875/1.5/2.25 fTP.
  sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
      neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Gorget"})

  -- Dimidiation: physical 2-hit, 80% DEX, 2.25/4.5/6.75 fTP.
  sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
      ear1="Ishvara Earring",ear2="Moonshade Earring",hands="Meghanada Gloves +1"})
  --]]

  --------------------------------------
  -- Precast: Sword WS
  --------------------------------------

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.MagicAttack, {})

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

  sets.precast.JA['Battuta'] = set_combine(sets.Enmity.JA, {head="Futhark Bandeau +1"})
  sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity.JA, {body="Futhark Coat +1"})
  sets.precast.JA['Embolden'] = set_combine(sets.Enmity.JA, {})
  sets.precast.JA['Gambit'] = set_combine(sets.Enmity.JA, {hands="Runeist Mitons +1"})
  sets.precast.JA['Liement'] = set_combine(sets.Enmity.JA, {body="Futhark Coat +1"})
  sets.precast.JA['One For All'] = set_combine(sets.Enmity.JA, {})
  sets.precast.JA['Pflug'] = set_combine(sets.Enmity.JA, {feet="Runeist Bottes +1"})
  sets.precast.JA['Rayke'] = set_combine(sets.Enmity.JA, {feet="Futhark Boots +1"})
  sets.precast.JA['Swordplay'] = set_combine(sets.Enmity.JA, {hands="Futhark Mitons +1"})
  sets.precast.JA['Valiance'] = set_combine(sets.Enmity.JA, {body="Runeist Coat +1", legs="Futhark Trousers +1"})
  sets.precast.JA['Vallation'] = set_combine (sets.precast.JA['Valiance'], {})

  sets.precast.JA['Lunge'] = set_combine(sets.MagicAttack, {})
	sets.precast.JA['Swipe'] = set_combine(sets.precast.JA['Lunge'], {})

  -- Turms Leggings +1 is just used to preserve Max HP. It would be silly for a 'heal' to lower HP.
  sets.precast.JA['Vivacious Pulse'] = set_combine(sets.Enmity.JA, {
    head={name="Erilaz Galea +1", priority=6},
		neck="Incanter's Torque",
		legs={name="Runeist Trousers +1", priority=2},
		feet={name="Turms Leggings +1", priority=8}})

  --[[
	-- Different stats for different rune modes, stat aligned.
  sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	--]]

  if player.sub_job == "WAR" then
	  sets.precast.JA['Aggressor'] = set_combine(sets.Enmity.JA, {})
	  sets.precast.JA['Berserk'] = set_combine(sets.Enmity.JA, {})
	  sets.precast.JA['Defender'] = set_combine(sets.Enmity.JA, {})
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity.JA, {})
    sets.precast.JA['Warcry'] = set_combine(sets.Enmity.JA, {})
  end

  if player.sub_job == "DRK" then
	  sets.precast.JA['Last Resort'] = set_combine(sets.Enmity.JA, {})
  end

  if player.sub_job == "DNC" then
	  sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity.JA, {})

    -- Waltz uses CHR as primary mod, and VIT as secondary. Modify this to have self.WaltzReceived as a separate set.
    sets.precast.Waltz = {
      -- ammo="Yamarang",
      head="Anwig Salade", neck="Unmoving Collar +1", ear1="Enchanter Earring +1", ear2="Roundel Earring",
      body="Passion Jacket", hands=gear.HerculeanGloves.Waltz, ring1="Asklepian Ring", ring2="Carbuncle Ring +1",-- ring2="Valseur's Ring"
      back="Laic Mantle", waist="Latria Sash", legs="Dashing Subligar", feet=gear.RawhideBoots.D}

    sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade"} -- Don't need potency gear for Healing Waltz.

    sets.precast.Step = {}

    sets.precast.JA['Violent Flourish'] = set_combine(sets.Enmity.JA, {})
  end

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

  -- Priority ordering is used to preserve max HP.
  sets.precast.FC = {
    range=empty,
    ammo="Sapience Orb",
    head=gear.CarmineMaskPlus1.D, -- head={name="Runeist's Bandeau +3", priority=3}
    neck="Orunmila's Torque",
    ear1={name="Etiolation Earring", priority=6},
    ear2={name="Odnowa Earring +1", priority=8},
    body={name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4'}, priority=5},
    hands={name="Leyline Gloves", priority=1},
    ring1="Kishar Ring",
    ring2="Prolix Ring",
    back={name="Ogma's Cape", augments={'HP+60','HP+20','"Fast Cast"+10'}, priority=7},
    waist={name="Kasiri Belt", priority=9},
    legs={name="Ayanmo Cosciales +2", priority=2},
    feet={name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4'}, priority=4}}

  if player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH" or player.sub_job == "PLD" then
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendicant's Earring", legs="Doyen Pants"})
  end

  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +1"})

  if player.sub_job == "NIN" then
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace", body="Passion Jacket"})
  end

	--------------------------------------
	-- Midcast: Fast Recast
	--------------------------------------

  sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

  --------------------------------------
  -- Midcast: Blue Magic
  --------------------------------------

  if player.sub_job == "BLU" then
    sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
		sets.midcast['Blue Magic'].MaxEnmity = set_combine(sets.Enmity.MaxEnmity, {})
    sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})

    -- Always use SIRD for Cocoon.
    sets.midcast['Cocoon'] = set_combine(sets.Enmity.SIRD, {})

    sets.midcast['Wild Carrot'] = set_combine(sets.Cure, {})
    sets.midcast['Healing Breeze'] = set_combine(sets.Cure, {})
  end

  --------------------------------------
  -- Midcast: Dark Magic
  --------------------------------------

  sets.midcast.Stun = set_combine(sets.Enmity, {})
  sets.midcast.Stun.MaxEnmity = set_combine(sets.Enmity.MaxEnmity, {})
  sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})

  --------------------------------------
  -- Midcast: Divine Magic
  --------------------------------------

  sets.midcast.Flash = set_combine(sets.Enmity, {})
  sets.midcast.Flash.MaxEnmity = set_combine(sets.Enmity.MaxEnmity, {})
  sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})

  --------------------------------------
  -- Midcast: Enfeebling Magic
  --------------------------------------

	sets.midcast.Poison = set_combine(sets.Enmity, {})
	sets.midcast.Poison.MaxEnmity = set_combine(sets.Enmity.MaxEnmity, {})
	sets.midcast.Poison.SIRD = set_combine(sets.Enmity.SIRD, {})

	sets.midcast.Poisonga = set_combine(sets.Enmity, {})
	sets.midcast.Poisonga.MaxEnmity = set_combine(sets.Enmity.MaxEnmity, {})
	sets.midcast.Poisonga.SIRD = set_combine(sets.Enmity.SIRD, {})

  --------------------------------------
  -- Midcast: Enhancing Magic
  --------------------------------------

  sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
    head=gear.CarmineMaskPlus1.D, neck="Incanter's Torque", ear1="Andoaa Earring", ear2="Augmenting Earring",
    body="Manasa Chasuble", hands="Runeist Mitons +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Merciful Cape", waist="Olympus Sash", legs=gear.CarmineCuissesPlus1.D})

  sets.midcast.EnhancingDuration = set_combine(sets.midcast.FastRecast, {
    head="Erilaz Galea +1", legs="Futhark Trousers +1"}) -- hands="Regal Gauntlets"

  -- Moderate SIRD for Aquaveil, without overwriting duration gear, in case I'm being hit and trying to ensure
	-- Phalanx will cast or similar.
  sets.midcast['Aquaveil'] = set_combine(sets.midcast.EnhancingDuration, {
    ammo="Staunch Tathlum +1",
    neck="Moonlight Necklace", ear1="Halasz Earring",
    hands=gear.RawhideGloves.A, ring1="Evanescence Ring",
    waist="Rumination Sash", feet=gear.TaeonBoots.PhalanxSIRD})

  sets.midcast['Blink'] = set_combine(sets.midcast.EnhancingDuration, {})
  sets.midcast['Crusade'] = set_combine(sets.midcast.EnhancingDuration, {})
  sets.midcast['Foil'] = set_combine(sets.Enmity, {head="Erilaz Galea +1", legs="Futhark Trousers +1"})

  sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
    head="Futhark Bandeau +1",
    body=gear.TaeonTabard.PhalanxFC, hands=gear.TaeonGloves.PhalanxFC,
    legs=gear.TaeonTights.PhalanxFC, feet=gear.TaeonBoots.PhalanxSIRD})

  sets.midcast['Protect'] = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
  sets.midcast['Protectra'] = set_combine(sets.midcast.Protect, {})
	sets.midcast['Refresh'] = set_combine(sets.midcast.EnhancingDuration, {head="Erilaz Galea +1"})
  sets.midcast['Regen'] = set_combine(sets.midcast.EnhancingDuration, {head="Runeist Bandeau +1"})

  sets.midcast['Shell'] = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
  sets.midcast['Shellra'] = set_combine(sets.midcast.Shell, {})

  sets.midcast['Stoneskin'] = set_combine(sets.midcast.EnhancingDuration, {
    neck="Stone Gorget", ear1="Earthcry Earring", waist="Siegel Sash"})

  --------------------------------------
  -- Midcast: Healing Magic
  --------------------------------------

  sets.midcast.Cure = set_combine(sets.Cure, {})

  --------------------------------------
  -- Midcast: Ninjutsu
  --------------------------------------

  if player.sub_job == "NIN" then
    sets.midcast['Ninjutsu'] = sets.midcast.FastRecast
  end

	--------------------------------------
	-- Active Buffs
	--------------------------------------

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Battuta = {}
	sets.buff.Embolden = {back=gear.EvasionistsCape.Embolden}

  --------------------------------------
	-- Sets Used By Gearswap Rules
	--------------------------------------

	sets.Self_Healing = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket", hands="Buremte Gloves", ring2="Kunaji Ring", waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.Kiting = {legs=gear.CarmineCuissesPlus1.D}

	sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == "DNC" then
		set_macro_page(4, 19)
	elseif player.sub_job == "RDM" then
		set_macro_page(5, 19)
	elseif player.sub_job == "SCH" then
		set_macro_page(5, 19)
	elseif player.sub_job == "BLU" then
		set_macro_page(6, 19)
	elseif player.sub_job == "WAR" then
		set_macro_page(7, 19)
	elseif player.sub_job == "SAM" then
		set_macro_page(8, 19)
	elseif player.sub_job == "DRK" then
		set_macro_page(9, 19)
	elseif player.sub_job == "NIN" then
		set_macro_page(10, 19)
	else
		set_macro_page(5, 19)
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
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
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
