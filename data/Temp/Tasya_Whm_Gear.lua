-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal','Acc')
  state.CastingMode:options('Normal','Resistant')
  state.IdleMode:options('Normal','PDT') -- 'TPEat'
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Sindri')

  gear.AlaunussCape = {}
  gear.AlaunussCape.FC = {name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10'}}

  gear.MendingCape = {}
  gear.MendingCape.Healing = {name="Mending Cape", augments={'Healing magic skill +10','"Cure" potency +4%'}}

  gear.QuellerRod = {}
  gear.QuellerRod.C = {name="Queller Rod", augments={'"Mag.Atk.Bns."+15','Mag. Acc.+15','"Cure" potency +15%'}}

	gear.obi_cure_waist = "Ninurta's Sash"
	gear.obi_cure_back = gear.AlaunussCape.FC

  -- TODO: Different belt for
	gear.obi_nuke_waist = "Yamabuki-no-Obi" -- "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Yamabuki-no-Obi"
	gear.obi_nuke_back = "Toro Cape"

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  --------------------------------------
  -- Sets required by rules
  --------------------------------------

  sets.Kiting = {feet="Crier's Gaiters"}
  sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})

	sets.Self_Healing = {neck="Phalaina Locket", ring1="Kunaji Ring", ring2="Asklepian Ring", waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket", ring1="Kunaji Ring", ring2="Asklepian Ring", waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"}

  --[[
  sets.HPCure = {
    main="Queller Rod", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
    head="Blistering Sallet +1", neck="Nodens Gorget", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Kaykaus Bliaut", hands="Kaykaus Cuffs", ring1="Kunaji Ring", ring2="Meridian Ring",
    back="Alaunus's Cape", waist="Eschan Stone", legs="Ebers Pant. +1", feet="Kaykaus Boots"}

  sets.HPDown = {
    head="Pixie Hairpin +1", ear1="Mendicant's Earring", ear2="Evans Earring",
    body="Zendik Robe", hands="Hieros Mittens", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
    back="Swith Cape +1", waist="Flax Sash", legs="Shedir Seraweels"}
  --]]

  sets.MagicBurst = {
    neck="Mizukage-no-Kubikazari",
    body=gear.HeliosJacket.MAB, ring1="Mujin Band", ring2="Locus Ring", -- Maybe Wretched Coat, when Helios goes away? Maybe nothing? Is it worth keeping this?
    back="Seshaw Cape"}

  --------------------------------------
  -- Base sets
  --------------------------------------

  sets.ConserveMP = {
    main="Rubicundity", sub="Thuellaic Ecu +1", ammo="Pemphredo Tathlum",
    head=gear.VanyaHood.D, neck="Incanter's Torque", ear1="Mendicant's Earring", ear2="Gifted Earring",
    body=gear.VanyaRobe.C, hands="Fanatic Gloves", ring1="Defending Ring", ring2="Prolix Ring",
    back="Solemnity Cape", waist="Luminary Sash", legs=gear.VanyaSlops.C, feet="Medium's Sabots"}

  sets.MagicAccuracy = {
    main=gear.Grioavolr.MAB, sub="Enki Strap", ammo="Pemphredo Tathlum",
    head="Inyanga Tiara +1", neck="Erra Pendant", ear1="Dignitary's Earring", ear2="Gwati Earring",
    body="Inyanga Jubbah +2", hands=gear.KaykausCuffsPlus1.A, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back=gear.AlaunussCape.FC, waist="Luminary Sash", legs=gear.ChironicHose.MAB, feet="Inyanga Crackows +1"}

  sets.MagicAttack = {
    ammo="Pemphredo Tathlum",
    head=gear.ChironicHat.MAB, neck="Saevus Pendant +1", ear1="Friomisi Earring", ear2="Novio Earring",
    body="Witching Robe", hands=gear.ChironicGloves.MAB, ring1="Fenrir Ring +1", ring2="Fenrir Ring +1",
    back="Toro Cape", waist=gear.ElementalObi, legs=gear.ChironicHose.MAB, feet=gear.HeliosBoots.MAB}

  sets.MagicAttackWeapons = set_combine (sets.MagicAttack, {
    main=gear.Grioavolr.MAB, sub="Enki Strap"})

  sets.MinusEnmity = {
    main="Terra's Staff", sub="Achaq Grip", ammo="Esper Stone +1",                                              --  -,  4,  -,  5
    head="Gendewitha Caubeen +1", neck="Orunmila's Torque", ear1="Genmei Earring", ear2="Novia Earring",        --  8,  3,  -,  7
    body="Inyanga Jubbah +2", hands="Ebers Mitts +1", ring1="Defending Ring", ring2="Kuchekula Ring",           --  -,  10, -,  7
    back=gear.MendingCape.Healing, waist="Slipor Sash", legs="Inyanga Shalwar +2", feet="Inyanga Crackows +1"}  --  6,  -,  -,  -

  --------------------------------------
  -- Elemental Affinity
  --------------------------------------

  sets.element.Dark = {head="Pixie Hairpin +1", ring2="Archon Ring"}
  --sets.element.Wind = {main="Marin Staff +1"}
  --sets.element.Ice = {main="Ngqoqwanb"}
  --sets.element.Earth = {neck="Quanpur Necklace"}

  --------------------------------------
  -- Idle
  --------------------------------------

  sets.idle = {
    main="Contemplator +1", sub="Oneiros Grip", ammo="Homiliary",
    head="Befouled Crown", neck="Bathy Choker +1", ear1="Infused Earring", ear2="Dawn Earring",
    body=gear.KaykausBliautPlus1.D, hands="Serpentes Cuffs", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Kumbira Cape", waist="Slipor Sash", legs="Assiduity Pants +1", feet="Serpentes Sabots"}

  sets.idle.PDT = {
    main="Bolelabunga", sub="Genmei Shield", ammo="Staunch Tathlum +1",
    head="Gendewitha Caubeen +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Vrikodara Jupon", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Slipor Sash", legs="Assiduity Pants +1", feet=gear.chironic_refresh_feet}

  --sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})

  sets.idle.Weak = set_combine(sets.idle.PDT, {})

  --------------------------------------
  -- Defense
  --------------------------------------

  sets.defense.PDT = {
    main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum +1",
    head="Gendewitha Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
    body="Vrikodara Jupon", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape",waist="Slipor Sash",legs="Assiduity Pants +1",feet="Inyanga Crackows +1"}

  sets.defense.MDT = {
    main="Mafic Cudgel",sub="Genmei Shield",ammo="Staunch Tathlum +1",
    head="Gendewitha Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
    body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Defending Ring",ring2="Shadow Ring",
    back="Moonlight Cape",waist="Slipor Sash",legs="Inyanga Shalwar +2",feet="Gendewitha Galoshes +1"}

  sets.defense.MEVA = {
    ammo="Staunch Tathlum +1",
    head="Inyanga Tiara +1",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
    body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Vengeful Ring",Ring2="Purity Ring",
    back="Aurist's Cape +1",waist="Luminary Sash",legs="Inyanga Shalwar +2",feet="Inyanga Crackows +1"}

  --------------------------------------
  -- Resting
  --------------------------------------

  sets.resting = {
    main="Chatoyant Staff", sub="Oneiros Grip", ammo="Homiliary",
    head="Befouled Crown", neck="Eidolon Pendant +1", ear1="Infused Earring", ear2="Dawn Earring", -- neck="Chrysopoeia Torque"
    body="Witching Robe", hands="Serpentes Cuffs", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Kumbira Cape", waist="Fucho-no-Obi", legs="Assiduity Pants +1", feet="Chelona Boots +1"} -- waist=gear.IdleBelt

  --------------------------------------
	-- Weapons
	--------------------------------------

	sets.weapons.Sindri = {main="Sindri", sub="Genmei Shield"}

  --------------------------------------
	-- Engaged
	--------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    ammo="Jukukik Feather",
    head="Ayanmo Zucchetto +2", neck="Asperity Necklace", ear1="Brutal Earring", ear2="Cessance Earring",
	  body="Ayanmo Corazza +2", hands="Ayanmo Manopolas +2", ring1="Rajas Ring", ring2="Petrov Ring", -- ring1="Ilabrat Ring"
    back="Relucent Cape", waist="Windbuffet Belt +1", legs="Ayanmo Cosciales +2", feet="Ayanmo Gambieras +2"}

  sets.engaged.Acc = {
    ammo="Jukukik Feather",
    head="Ayanmo Zucchetto +2", neck="Combatant's Torque", ear1="Mache Earring +1", ear2="Mache Earring +1",
	  body="Ayanmo Corazza +2", hands="Ayanmo Manopolas +2", ring1="Rajas Ring", ring2="Petrov Ring", -- ring1="Ilabrat Ring"
    back="Relucent Cape", waist="Olseni Belt", legs="Ayanmo Cosciales +2", feet="Ayanmo Gambieras +2"}

  sets.engaged.DW = {
    ammo="Jukukik Feather",
    head="Ayanmo Zucchetto +2", neck="Asperity Necklace", ear1="Brutal Earring", ear2="Cessance Earring",
  	body="Ayanmo Corazza +2", hands="Ayanmo Manopolas +2", ring1="Rajas Ring", ring2="Petrov Ring", -- ring1="Ilabrat Ring"
    back="Relucent Cape", waist="Shetal Stone", legs="Ayanmo Cosciales +2", feet="Ayanmo Gambieras +2"}

  sets.engaged.DW.Acc = {
    ammo="Jukukik Feather",
    head="Ayanmo Zucchetto +2", neck="Combatant's Torque", ear1="Mache Earring +1", ear2="Suppanomimi",
	  body="Ayanmo Corazza +2", hands="Ayanmo Manopolas +2", ring1="Rajas Ring", ring2="Petrov Ring", -- ring1="Ilabrat Ring"
    back="Relucent Cape", waist="Shetal Stone", legs="Ayanmo Cosciales +2", feet="Ayanmo Gambieras +2"}

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------

  -- Default, STR weaponskills

  sets.precast.WS = {
    ammo="Jukukik Feather",
    head="Ayanmo Zucchetto +2", neck="Caro Necklace", ear1="Brutal Earring", ear2="Vulcan's Pearl",
	  body="Ayanmo Corazza +2", hands="Ayanmo Manopolas +2", ring1="Rajas Ring", ring2="Ifrit Ring +1", -- ring1="Ilabrat Ring"
    back="Relucent Cape", waist="Grunfeld Rope", legs="Ayanmo Cosciales +2", feet="Ayanmo Gambieras +2"}

	sets.MaxTP = {ear1="Brutal Earring", ear2="Vulcan's Pearl"}
	sets.MaxTP.Dagan = {ear1="Etiolation Earring", ear2="Evans Earring"}

  --------------------------------------
  -- Precast: Club Weaponskills
  --------------------------------------

  sets.precast.WS.Dagan = {}
  
  --[[
    {ammo="Hasty Pinion +1",
    head="Befouled Crown", neck="Asperity Necklace", ear1="Etiolation Earring", ear2="Moonshade Earring",
    body="Kaykaus Bliaut", hands="Telchine Gloves", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back="Buquwik Cape", waist="Fotia Belt", legs="Assiduity Pants +1", feet="Gendewitha Galoshes +1"}
  --]]

  --sets.precast.WS['Flash Nova'] = {}

  --sets.precast.WS['Mystic Boon'] = {}

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

  sets.precast.JA.Benediction = {body="Piety Briault +1"}

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
  	head=gear.VanyaHood.D, ear1="Roundel Earring",
  	body="Piety Briault +1", hands="Telchine Gloves",
  	waist="Chaac Belt", back="Aurist's Cape +1"}

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

  -- Total casting time reduction caps at 80%.
  sets.precast.FC = {                                                                                           -- Current total: QC+10, FC+62~64
    main=gear.Grioavolr.MAB, sub="Clerisy Strap +1", ammo="Impatiens",                                          --  +4,  +3,  -,  QC
    head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",    --  +10, +5, +2, +2
    body="Inyanga Jubbah +2", hands="Gendewitha Gages +1", ring1="Lebeche Ring", ring2="Prolix Ring",           --  +14, +7, QC, +2
    back="Perimede Cape", waist="Witful Belt", legs="Ayanmo Cosciales +2", feet="Regal Pumps +1"}               --  QC,  +3, +6, +5~7

  sets.precast.FC['Enhancing Magic'] = sets.precast.FC -- {waist="Siegel Sash"}                                 -- Currently prefer maxing QC.

  sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {                                 -- Delta from precast.FC['Enhancing Magic']:
    head="Umuthi Hat", legs="Doyen Pants"})                                                                     -- +5, +5 = Total: FC+72-74

  -- WHM gets healing magic spellcasting time -8% from gifts.                     .                             -- Delta from precast.FC:
  sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +1"})                 -- +8, +8 JP = Total: FC+78~80
  sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

  sets.precast.FC.CurePlain = set_combine(sets.precast.FC['Healing Magic'], {                                   -- Delta from precast.FC['Healing Magic']:
    sub="Genbu's Shield"})                                                                                      -- +7 = capped

  sets.precast.FC.CureWeather = sets.precast.FC.CurePlain
  sets.precast.FC.CureSolace = sets.precast.FC.CurePlain
  sets.precast.FC.CureSolaceWeather = sets.precast.FC.CurePlain
  sets.precast.FC.CuragaPlain = sets.precast.FC.CurePlain
  sets.precast.FC.CuragaWeather = sets.precast.FC.CurePlain

  sets.precast.FC.CureMelee = sets.precast.FC.CurePlain
  sets.precast.FC.CureMeleeWeather = sets.precast.FC.CurePlain
  sets.precast.FC.CureMeleeSolace = sets.precast.FC.CurePlain
  sets.precast.FC.CureMeleeSolaceWeather = sets.precast.FC.CurePlain
  sets.precast.FC.CuragaMelee = sets.precast.FC.CurePlain
  sets.precast.FC.CuragaMeleeWeather = sets.precast.FC.CurePlain

	--sets.precast.FC.Cure.DT = {
	--	neck="Loricate Torque +1",ear2="Genmei Earring",
	--	body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Defending Ring"}

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

  -- Fast recast: fast cast and haste both contribute to this.
  -- Defending ring is filler.
  sets.midcast.FastRecast = {
    main=gear.Grioavolr.MAB, sub="Clerisy Strap +1", ammo="Sapience Orb",
    head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body="Inyanga Jubbah +2", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2="Prolix Ring",
    back=gear.AlaunussCape.FC, waist="Witful Belt", legs="Ayanmo Cosciales +2", feet="Regal Pumps +1"}

  --------------------------------------
  -- Midcast: Dark Magic
  --------------------------------------

  sets.midcast['Dark Magic'] = set_combine(sets.MagicAccuracy, {
    neck="Erra Pendant"})

  sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], {
    main="Rubicundity", sub="Thuellaic Ecu +1",
    head="Pixie Hairpin +1", neck="Erra Pendant",
    hands=gear.ChironicGloves.MAB, ring1="Archon Ring", ring2="Evanescence Ring",
    waist="Fucho-no-Obi"})

  sets.midcast.Aspir.Resistant = set_combine(sets.midcast.Aspir, {
    head="Befouled Crown", ring1="Stikini Ring +1", ring2="Stikini Ring +1"})

  sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
  --sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

  sets.midcast.Drain = set_combine(sets.midcast.Aspir, {})
  sets.midcast.Drain.Resistant = set_combine(sets.midcast.Aspir.Resistant, {})

  sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
    ammo="Hasty Pinion +1", -- sub="Clerisy Strap +1"
    head=gear.VanyaHood.D, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    hands="Fanatic Gloves", ring2="Prolix Ring",
    waist="Witful Belt", legs="Lengo Pants", feet="Regal Pumps +1"})

  sets.midcast.Stun.Resistant = set_combine(sets.midcast['Dark Magic'], {
    head=gear.VanyaHood.D, hands="Fanatic Gloves"})

  if player.sub_job == 'SCH' then
      sets.midcast.Klimaform = sets.midcast.FastRecast  -- Skill has no effect on Klimaform.
  end

  --------------------------------------
  -- Midcast: Divine Magic
  --------------------------------------

  sets.midcast['Divine Magic'] = set_combine(sets.MagicAccuracy, {
    main=gear.Gada.MAB, sub="Thuellaic Ecu +1", feet="Medium's Sabots"}) -- feet="Inyanga Sabots +2", i.e. remove the feet

  -- Banish and Holy spells are low base damage, so +magic damage is preferred over +MAB.

  sets.midcast.Banish = set_combine(sets.MagicAttack, {
    main=gear.Grioavolr.MAB, sub="Enki Strap", ammo="Ghastly Tathlum +1"})
  sets.midcast.Holy = set_combine(sets.MagicAttack, {
    main=gear.Grioavolr.MAB, sub="Enki Strap", ammo="Ghastly Tathlum +1"})

  sets.midcast.Banish.Resistant = set_combine(sets.MagicAttack, {
    main=gear.Grioavolr.MAB, sub="Enki Strap", neck="Sanctity Necklace", waist="Eschan Stone"})
  sets.midcast.Holy.Resistant = set_combine(sets.MagicAttack, {
    main=gear.Grioavolr.MAB, sub="Enki Strap", neck="Sanctity Necklace", waist="Eschan Stone"})

  --------------------------------------
  -- Midcast: Elemental Magic
  --------------------------------------

  -- The only nukes we have access to as WHM are low level, so +magic damage is preferred over +MAB.

  sets.midcast['Elemental Magic'] = set_combine(sets.MagicAttack, {
    main=gear.Grioavolr.MAB, sub="Enki Strap", ammo="Ghastly Tathlum +1"})

  sets.midcast['Elemental Magic'].Resistant = set_combine(sets.MagicAttackWeapons, {
    neck="Sanctity Necklace", waist="Eschan Stone"})

  sets.midcast.ElementalEnfeeble = set_combine(sets.MagicAccuracy, {})
  sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.MagicAccuracy, {})

  if player.sub_job == 'SCH' then
    sets.midcast.Helix = set_combine(sets.MagicAttackWeapons, {})
  end

  sets.midcast.Impact = set_combine(sets.MagicAccuracy, {head=empty, body="Twilight Cloak"})

  --------------------------------------
  -- Midcast: Enfeebling Magic
  --------------------------------------

  -- This commented out stuff relies on rules that aren't present in Sel's WHM.lua yet.

  --[[
  sets.midcast.EnfPotency = set_combine(sets.midcast['Enfeebling Magic'], {
      ammo="Quartz Tathlum +1",
      head="Befouled Crown",neck="Incanter's Torque",
      hands="Inyanga Dastanas +1",ring1="Shiva Ring +1",ring2="Globidonta Ring",
      feet="Medium's Sabots"})

  sets.midcast.INTAccuracy = sets.midcast['Enfeebling Magic']

  sets.midcast.INTPotency = set_combine(sets.midcast['Enfeebling Magic'], {
      ammo="Ombre Tathlum +1",
      neck="Imbodla Necklace",ear1="Psystorm Earring",ear2="Lifestorm Earring",
      ring1="Shiva Ring +1",ring2="Shiva Ring +1",
      back="Aurist's Cape +1",feet="Uk'uxkaj Boots"})

  sets.midcast.INTPotency.Resistant = set_combine(sets.midcast.INTPotency, {feet="Medium's Sabots"})

  sets.midcast.MNDAccuracy = set_combine(sets.midcast['Enfeebling Magic'], {
      body=gear.VanyaRobe.C,ring1="Sangoma Ring",ring2="Globidonta Ring",feet="Medium's Sabots"})

  sets.midcast.MNDPotency = set_combine(sets.midcast['Enfeebling Magic'], {
      ammo="Quartz Tathlum +1",
      neck="Imbodla Necklace",ear1="Psystorm Earring",ear2="Lifestorm Earring",
      body=gear.VanyaRobe.C,ring1="Leviathan Ring +1",ring2="Leviathan Ring +1",feet="Uk'uxkaj Boots"})

  sets.midcast.MNDPotency.Resistant = set_combine(sets.midcast.MNDPotency, {feet="Medium's Sabots"})
  --]]

  -- Review this for max MND. Also, Uk'uxkaj Boots should specifically be in potency sets.
  sets.midcast['Enfeebling Magic'] = set_combine(sets.MagicAccuracy, {
    main=gear.Gada.MAB, sub="Thuellaic Ecu +1",
    body="Theophany Briault +3", hands=gear.KaykausCuffsPlus1.A, -- hands="Regal Cuffs"
    legs=gear.ChironicHose.MAB, feet="Uk'uxkaj Boots"})

  -- Magic accuracy upgrades:
  --   Hands: Piety +2/3 > Kaykaus +1 > Theophany +3 > Inyanga +2
  --   Feet: Theophany +3 > Piety +3 > Skaoi > Inyanga +2
  sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
    feet="Medium's Sabots"}) -- feet="Theophany Duckbills +3"

  sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
  sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
  --sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

  sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
  sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

  sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
  sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

  --------------------------------------
  -- Midcast: Enhancing Magic
  --------------------------------------

  -- WHM has 378 enhancing skill, plus 16 from merits. 104 needed to cap.
  sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
    main=gear.Gada.MAB, sub="Thuellaic Ecu +1", -- sub="Ammurapi Shield"
    head="Befouled Crown", neck="Incanter's Torque",
    body=gear.TelchineChasuble.Enh, hands=gear.TelchineGloves.Enh,
    back="Fi Follet Cape +1", waist="Olympus Sash", legs="Piety Pantaloons +1", feet="Ebers Duckbills +1"})

  -- In Light Arts, this goes up to 404 enhancing, plus 16 from merits. 80 needed to cap.
  sets.midcast.EnhancingLightArts = set_combine(sets.midcast.FastRecast, {
    main=gear.Gada.MAB, sub="Thuellaic Ecu +1",
    head=gear.TelchineCap.Enh, neck="Incanter's Torque",
    body=gear.TelchineChasuble.Enh, hands=gear.TelchineGloves.Enh, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    legs="Piety Pantaloons +1", feet="Ebers Duckbills +1"})

  sets.midcast.EnhancingDuration = set_combine(sets.midcast.FastRecast, {
    head=gear.TelchineCap.Enh, neck="Incanter's Torque",
    body=gear.TelchineChasuble.Enh, hands=gear.TelchineGloves.Enh,
    legs=gear.TelchineBraconi.Enh, feet=gear.TelchinePigaches.Enh})

  sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
    head=gear.ChironicHat.MAB, legs="Shedir Seraweels"}) -- main="Vadose Rod", sub="Ammurapi Shield", hands="Regal Cuffs", waist="Emphatikos Rope"

  -- Auspice: static +10 Subtle Blow, only enhanced by Ebers Duckbills +1.
  sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {feet="Ebers Duckbills +1"})

  -- Bar-element spells: potency caps at 500 enhancing.
  sets.midcast.BarElement = set_combine(sets.ConserveMP, {
    main="Beneficus", sub="Genmei Shield", -- sub="Ammurapi Shield"
    head="Ebers Cap +1", neck="Incanter's Torque", ear1="Andoaa Earring",
    body="Ebers Bliaud +1", hands="Ebers Mitts +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    waist="Fi Follet Cape +1", waist="Olympus Sash", legs="Piety Pantaloons +1", feet="Ebers Duckbills +1"})

  sets.midcast.BarElementLightArts = {
    main="Beneficus", sub="Genmei Shield", -- sub="Ammurapi Shield"
    head="Ebers Cap +1", neck="Incanter's Torque", ear1="Andoaa Earring",
    body="Ebers Bliaud +1", hands="Ebers Mitts +1", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    waist="Fi Follet Cape +1", waist="Olympus Sash", legs="Piety Pantaloons +1", feet="Ebers Duckbills +1"}

  sets.midcast.Blink = set_combine(sets.midcast.EnhancingDuration, {})

  sets.midcast.Erase = set_combine(sets.midcast.FastRecast, {
      main=gear.Grioavolr.MAB, sub="Clemency Grip", head="Ebers Cap +1", neck="Cleric's Torque"})

  sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
  sets.midcast.Protectra = set_combine(sets.midcast.Protect, {})

  sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {})

  sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
    main="Bolelabunga", sub="Genbu's Shield",
    head="Inyanga Tiara +1",
    body="Piety Briault +1", hands="Ebers Mitts +1",
    legs="Theophany Pantaloons +1", feet=gear.TelchinePigaches.Enh})

  sets.midcast.Shell = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
  sets.midcast.Shellra = set_combine(sets.midcast.Shell, {})

  -- Stoneskin: potency is Enhancing Magic Skill + 3xMND - 190, caps at 350. At 99, we reach the cap naked,
  -- so only items that specifically enhance Stoneskin (and break the cap) are useful.
  sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
    neck="Stone Gorget", ear1="Earthcry Earring",
    waist="Siegel Sash", legs="Shedir Seraweels"})

  if player.sub_job == 'SCH' then
    sets.midcast.Storm = set_combine(sets.midcast.EnhancingDuration, {})
  end

	sets.midcast.Teleport = set_combine(sets.ConserveMP, {})

  --------------------------------------
  -- Midcast: Healing Magic
  --------------------------------------

  sets.midcast['Healing Magic'] = set_combine(sets.midcast.FastRecast, {})

  --------------------------------------
  -- Midcast: Healing Magic: Cure
  --------------------------------------

  -- The "Cure Power" formula is floor(MND/2) + floor(VIT/4) + healing magic skill.
  -- This soft caps at 700 for all cures except Cure 1, which soft caps at 600.

  -- A naked master WHM with maxed merits has 476 healing magic skill, plus ~75 additional cure power from MND and VIT,
  -- varying a bit with race. An arbitrary ilvl 119 set will usually put you around 660 cure power, so it doesn't take
  -- much to hit the soft cap.

  -- Sets with Solace should prioritize Ebers Bliaud +1 and Alaunus's Cape. Neither does anything of note for
  -- non-Solace sets.

  sets.midcast['Full Cure'] = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Cure = {
    main=gear.QuellerRod.C, sub="Genbu's Shield", ammo="Esper Stone +1",
    head=gear.KaykausMitraPlus1.B, neck="Incanter's Torque", ear1="Nourishing Earring +1", ear2="Glorious Earring",
    body=gear.KaykausBliautPlus1.D, hands="Theophany Mitts +3", ring1="Lebeche Ring", ring2="Kuchekula Ring",
    back=gear.AlaunussCape.FC, waist="Ninurta's Sash", legs="Ebers Pantaloons +1", feet=gear.KaykausBootsPlus1.B}

	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {body="Ebers Bliaud +1"})

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {
    main="Chatoyant Staff", sub="Achaq Grip", -- sub="Khonsu" or sub="Kaja Grip"
    ear1="Mendicant's Earring",
    hands=gear.KaykausCuffsPlus1.A,
		back="Twilight Cape", waist="Hachirin-no-Obi"})

	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.LightWeatherCure, {
		body="Ebers Bliaud +1"})

	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {
		back="Twilight Cape", waist="Hachirin-no-Obi"})

	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.Cure, {
    body="Ebers Bliaud +1", waist="Hachirin-no-Obi"})

  sets.midcast.Cure.DT = {
    main="Queller Rod", sub="Genmei Shield", ammo="Staunch Tathlum +1",
    head="Gendewitha Caubeen +1", neck="Loricate Torque +1", ear1="Nourishing Earring +1", ear2="Glorious Earring",
    body="Ayanmo Corazza +2", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back=gear.AlaunussCape.FC, waist="Ninurta's Sash", legs="Ebers Pantaloons +1",feet="Gendewitha Galoshes +1"}

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1", waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1", waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	-- MeleeCure and related sets are used whenever your Weapons state is set to anything but None.

	sets.midcast.MeleeCure = {
    ammo="Esper Stone +1",
    head="Gendewitha Caubeen +1", neck="Incanter's Torque", ear1="Mendicant's Earring", ear2="Glorious Earring",
    body="Theophany Briault +3", hands=gear.TelchineGloves.Enh, ring1="Lebeche Ring", ring2="Menelaus's Ring",
    back=gear.AlaunussCape.FC, waist="Ninurta's Sash", legs="Ebers Pantaloons +1", feet="Piety Duckbills +1"}

	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1", waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1", waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {
    ammo="Staunch Tathlum +1",
    head="Gendewitha Caubeen +1", neck="Loricate Torque +1", ear1="Nourishing Earring +1", ear2="Glorious Earring",
    body="Ayanmo Corazza +2", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back=gear.AlaunussCape.FC, waist="Ninurta's Sash", legs="Ebers Pantaloons +1",feet="Gendewitha Galoshes +1"})

	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

  --------------------------------------
  -- Midcast: Healing Magic: Curaga
  --------------------------------------

  -- The "Cure Power" formula for Curaga spells is  (3 x MND) + VIT + (3 x floor(healing magic skill / 5)).

  -- Solace does not affect Curaga.

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Cure, {
    main="Chatoyant Staff", sub="Achaq Grip", -- sub="Khonsu" or sub="Kaja Grip"
    ear1="Nourishing Earring +1",
		back="Twilight Cape", waist="Hachirin-no-Obi"})

	sets.midcast.LightDayCuraga = set_combine(sets.midcast.Cure, {
		back="Twilight Cape", waist="Hachirin-no-Obi"})

	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

  --------------------------------------
  -- Midcast: Healing Magic: Status Removal
  --------------------------------------

  -- Cursna: Healing magic up to 500, "Enhances Cursna" items, Divine Veil, Divine Benison, and fast cast.
  sets.midcast.Cursna = {
    main="Yagrush", sub="Genmei Shield", ammo="Hasty Pinion +1",
    head="Ebers Cap +1", neck="Debilis Medallion", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body="Inyanga Jubbah +2", hands="Fanatic Gloves", ring1="Haoma's Ring", ring2="Menelaus's Ring",
    back=gear.AlaunussCape.FC, waist="Witful Belt", legs="Theophany Pantaloons +1", feet="Gendewitha Galoshes +1"}

  -- Most status cures: Divine Veil, Divine Benison, and general recast time.
  sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {
    main="Yagrush", sub="Genmei Shield",
    head="Ebers Cap +1", legs="Ebers Pantaloons +1"})

	--------------------------------------
	-- Active buffs
	--------------------------------------

  sets.buff['Divine Caress'] = {hands="Ebers Mitts +1", back=gear.MendingCape.Healing}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 6)
end
