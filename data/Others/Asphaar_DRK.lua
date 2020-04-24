
		-------------------------------------------------
		-- *** Asphaar Dark Knight Gearswap Lua File *** --
		-------------------------------------------------
				
			-- Commands --
				
				-- In Game: //gs c, Macro: /console gs c, Bind: gs c --
			
				-- gs c acc			Toggle accuracy tier for TP/WS
				-- gs c idle		Toggle idle sets
				
				-- gs c pdt			PDT on/off
				-- gs c mdt			MDT on/off
				-- gs c kiting		Kiting on/off
				-- gs c hybrid		Hybrid on/off
				
				-- gs c weapon 		Toggle Weapon

function get_sets()
	AccIndex = 1
	AccArray = {"LowACC","MidACC","HighACC"}	
	WeaponIndex = 1
	WeaponArray = {"Caladbolg","Ragnarok","Raetic","Anguta","Apocalypse","Liberator"}
	IdleIndex = 1
	IdleArray = {"Full","DT","Warp"}
	Armor = 'None'	
	Samurai_Roll = 'ON' -- Set Default SAM Roll ON or OFF Here --
	target_distance = 6 -- Set Default Distance Here --
	send_command('input /macro book 11;wait .1;input /macro set 1') -- Change Default Macro Book 
	add_to_chat(158,'-[Dark Knight Lua Loaded]-')
	add_to_chat(155,'Weapon: '..WeaponArray[WeaponIndex])
	add_to_chat(155,'Accuracy Level: ' .. AccArray[AccIndex])
	add_to_chat(155,'Idle Set: ' .. IdleArray[IdleIndex])
	add_to_chat(158,'-----[Weapon Skill Keybinds]-----')
	add_to_chat(155,'F10 - Scourge, F11 - Resolution, Delete - Torcleaver')
	add_to_chat(155,'F12 - Last Stand (mule), Alt+F12 - Leaden Salute (mule) Alt+Delete - Savage Blade (mule)')
	add_to_chat(155,'Ctrl+F9 - Insurgency, Ctrl+F10 - Entropy, Ctrl+F11 - Cross Reaper, Ctrl+F12 - Quietus, Ctrl+Delete - Catastrophe')
	
	-- Augments --
	OHead={}
	OHead.WSD={}
	OHands={}
	OHands.WSD={ name="Odyssean Gauntlets", augments={'Weapon skill damage +3%','VIT+13','Accuracy+12','Attack+13',}}
	OLegs={}
    OLegs.STP={}
	VFeet={}
	VFeet.STP={}
	
	-- Ankou's Mantle Augments --
	STRDAMantle={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	DEXDAMantle={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    INTDAMantle={ name="Ankou's Mantle", augments={'INT+20','Accuracy+20 Attack+20','INT+10','"Dbl.Atk."+10',}}
	DEXSTPMantle={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}	
	WSDMantle={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	VITWSDMantle={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
	FCMantle={ name="Ankou's Mantle", augments={'"Fast Cast"+10',}}

		--------------------
		-- Key Binds Load --
		--------------------
		
		-- Key Bind Toggles (The Same for all my job files) (Ctrl Key) --
		send_command('bind ^A input //gs c acc')
		send_command('bind ^D input //gs c pdt')
		send_command('bind ^H input //gs c hybrid')
		send_command('bind ^I input //gs c idle')
		send_command('bind ^K input //gs c kiting')
		send_command('bind ^W input //gs c weapon')

		-- Stuff to control both Mules (Ctrl Key) --
		send_command('bind ^X input /pcmd add ojomo;pause 5;input /pcmd add oeogo')
		send_command('bind ^3 input //send oeogo //ma Cure 3 Asphaar')
		send_command('bind ^4 input //send oeogo //ma Cure 4 Asphaar')
		send_command('bind ^5 input //send oeogo //ma Refresh Asphaar')
		send_command('bind ^7 input //send oeogo //ma haste ojomo')
		send_command('bind ^8 input //send oeogo //ma Dia 2 <t>;pause 2;input //send ojomo //ja Light Shot <t>')
		send_command('bind ^9 input //send ojomo //follow Asphaar;pause 0.1;input //send oeogo //follow Asphaar')
		send_command('bind ^0 input //send ojomo //assist Asphaar;pause 0.1;input //send oeogo //assist Asphaar')
		send_command('bind ^- input //send ojomo /attack <t>;pause 0.1;input //send oeogo /attack <t>')

		-- COR (Mule) Job Ability Key Binds (Alt Key) --
		send_command('bind !7 input //send ojomo //ja Crooked Cards <me>')
		send_command('bind !8 input //send ojomo //ja Snake Eye <me>')
		send_command('bind !9 input //send ojomo //ja Fold <me>')
		send_command('bind !0 input //send ojomo //ja Random Deal <me>')

		-- COR (mule) Phantom Roll Key Binds (Alt Key) --
		send_command('bind !A input //send ojomo //ja Allies\' Roll <me>')
		send_command('bind !B input //send ojomo //ja Bolter\'s Roll <me>')
		send_command('bind !C input //send ojomo //ja Chaos Roll <me>')
		send_command('bind !D input //send ojomo //ja Dancer\'s Roll <me>')
		send_command('bind !E input //send ojomo //ja Evoker\s Roll <me>')
		send_command('bind !F input //send ojomo //ja Fighter\'s Roll <me>')
		send_command('bind !G input //send ojomo //ja Gallant\'s Roll <me>')
		send_command('bind !H input //send ojomo //ja Hunter\'s Roll <me>')
		send_command('bind !Q input //send ojomo //ja Warlock\'s Roll <me>')		
		send_command('bind !R input //send ojomo //ja Rogue\'s Roll <me>')
		send_command('bind !S input //send ojomo //ja Samurai Roll <me>')
		send_command('bind !T input //send ojomo //ja Tactician\'s Roll <me>')
		send_command('bind !W input //send ojomo //ja Wizard\'s Roll <me>') 
		send_command('bind !X input //send ojomo //ja Corsair\'s Roll <me>')

		-- GEO (Mule) Job Ability Key Binds (Win Key) --
		send_command('bind @3 input //send oeogo //ja Radial Arcana <me>')
		send_command('bind @5 input //send oeogo //ma Refresh <me>')
		send_command('bind @7 input //send oeogo //ja Blaze of Glory <me>')
		send_command('bind @8 input //send oeogo //ja Ecliptic Attrition <me>')
		send_command('bind @9 input //send oeogo //ja Life Cycle <me>')
		send_command('bind @0 input //send oeogo //ja Lasting Emanation <me>')

		-- GEO (Mule) Nuke Key Binds (Win Key) --
		send_command('bind @F1 input //send oeogo /ma Aero V <t>;pause 0.5;input //send oeogo /ma Aero IV <t>;pause 0.5;input //send oeogo /ma Aero III <t>;')
		send_command('bind @F2 input //send oeogo /ma Fire V <t>;pause 0.5;input //send oeogo /ma Fire IV <t>;pause 0.5;input //send oeogo /ma Fire III <t>;')
		send_command('bind @F3 input //send oeogo /ma Thunder V <t>;pause 0.5;input //send oeogo /ma Thunder IV <t>;pause 0.5;input //send oeogo /ma Thunder III <t>;')
		send_command('bind @F4 input //send oeogo /ma Stone V <t>;pause 0.5;input //send oeogo /ma Stone IV <t>;pause 0.5;input //send oeogo /ma Stone III <t>;')
		send_command('bind @F5 input //send oeogo /ma Water V <t>;pause 0.5;input //send oeogo /ma Water IV <t>;pause 0.5;input //send oeogo /ma Water III <t>;')
		send_command('bind @F6 input //send oeogo /ma Blizzard V <t>;pause 0.5;input //send oeogo /ma Blizzard IV <t>;pause 0.5;input //send oeogo /ma Blizzard III <t>;')

		-- GEO (Mule) Indicolure Spells (Win Key) --
		send_command('bind @1 input //send oeogo /ma Indi-Regen <me>')
		send_command('bind @2 input //send oeogo /ma Indi-Refresh <me>')
		send_command('bind @D input //send oeogo /ma Indi-DEX <me>')
		send_command('bind @A input //send oeogo /ma Indi-Acumen <me>')
		send_command('bind @F input //send oeogo /ma Indi-Fury <me>')
		send_command('bind @H input //send oeogo /ma Indi-Haste <me>')
		send_command('bind @K input //send oeogo /ma Indi-Focus <me>')
		send_command('bind @P input //send oeogo /ma Indi-Precision <me>')
		send_command('bind @Q input //send oeogo /ma Indi-Barrier <me>')
		send_command('bind @S input //send oeogo /ma Indi-STR <me>')
		send_command('bind @V input //send oeogo /ma Indi-Attunement <me>')

		-- GEO (Mule) Geocolure Spells (Alt+Win Keys) --
		send_command('bind !@1 input //send oeogo /ma Geo-Regen <me>')
		send_command('bind !@2 input //send oeogo /ma Geo-Refresh <me>')
		send_command('bind !@A input //send oeogo /ma Geo-Malaise <t>')
		send_command('bind !@D input //send oeogo /ma Geo-DEX <me>')
		send_command('bind !@F input //send oeogo /ma Geo-Frailty <t>')
		send_command('bind !@H input //send oeogo /ma Geo-Haste <me>')
		send_command('bind !@K input //send oeogo /ma Geo-Languor <t>')
		send_command('bind !@P input //send oeogo /ma Geo-Torpor <t>') --
		send_command('bind !@Q input //send oeogo /ma Geo-Wilt <t>') --
		send_command('bind !@S input //send oeogo /ma Geo-STR <me>')
		send_command('bind !@V input //send oeogo /ma Geo-Vex <t>')

		-- GEO (Mule) Entrust Indicolure Spells (Ctrl+Win Keys) --
		send_command('bind ^@1 input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-Regen Asphaar')
		send_command('bind ^@2 input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-Refresh Asphaar')
		send_command('bind ^@A input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-Acumen Asphaar')
		send_command('bind ^@D input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-DEX Asphaar')
		send_command('bind ^@F input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-Fury Asphaar')
		send_command('bind ^@H input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-Haste Asphaar')
		send_command('bind ^@K input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-Focus Asphaar')
		send_command('bind ^@P input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-Precision Asphaar')
		send_command('bind ^@Q input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-Barrier Asphaar')
		send_command('bind ^@S input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-STR Asphaar')
		send_command('bind ^@V input //send oeogo //ja Entrust <me>;pause 2;input //send oeogo /ma Indi-Attunement Asphaar')
		
		-- Dark Knight Job Key Binds (Ctrl & Ctrl+Alt Keys) --
		send_command('bind ^L input //ma "Last Resort" <me>')

		-- Dark Knight Weapon Skill Key Binds --
		send_command('bind ^F7 input /ws "Infernal Scythe" <t>')
		send_command('bind ^F9 input /ws "Insurgency" <t>')
		send_command('bind F10 input /ws "Scourge" <t>')
		send_command('bind ^F10 input /ws "Entropy" <t>')
		send_command('bind F11 input /ws "Resolution" <t>')
		send_command('bind ^F11 input /ws "Cross Reaper" <t>')
		send_command('bind ^F12 input /ws "Quietus" <t>')
		send_command('bind Delete input /ws "Torcleaver" <t>')
		send_command('bind ^Delete input /ws "Catastrophe" <t>')
		send_command('bind Insert input /ws "Cross Reaper" <t>')
		
		-- COR (mule) Weapon Skill Key Binds --
		send_command('bind F12 input //send ojomo /ws "Last Stand" <t>')
		send_command('bind !F12 input //send ojomo "Leaden Salute" <t>')
		send_command('bind !Delete input //send ojomo /ws "Savage Blade" <t>')

		----------------------
		-- Key Binds Unload --
		----------------------

		function file_unload()
		-- Unbind Toggles --
		send_command('unbind ^A')
		send_command('unbind ^D')
		send_command('unbind ^H')
		send_command('unbind ^I')
		send_command('unbind ^K')
		send_command('unbind ^W')
		-- Unbind Stuff to control both Mules --
		send_command('unbind ^X')
		send_command('unbind ^3')
		send_command('unbind ^4')
		send_command('unbind ^4')
		send_command('unbind ^7')
		send_command('unbind ^8')
		send_command('unbind ^9')
		send_command('unbind ^0')
		send_command('unbind ^-')
		-- Unbind COR JA's --
		send_command('unbind !7')
		send_command('unbind !8')
		send_command('unbind !9')
		send_command('unbind !0')
		-- Unbind COR Rolls --
		send_command('unbind !A')
		send_command('unbind !B')
		send_command('unbind !C')
		send_command('unbind !D')
		send_command('unbind !E')
		send_command('unbind !F')
		send_command('unbind !G')
		send_command('unbind !H')
		send_command('unbind !Q')
		send_command('unbind !R')
		send_command('unbind !S')
		send_command('unbind !T')
		send_command('unbind !W')
		send_command('unbind !X')
		-- Unbind GEO JA's --
		send_command('unbind @3')
		send_command('unbind @5')
		send_command('unbind @7')
		send_command('unbind @8')
		send_command('unbind @9')
		send_command('unbind @0')
		-- Unbind GEO Nukes --
		send_command('unbind @F1')
		send_command('unbind @F2')
		send_command('unbind @F3')
		send_command('unbind @F4')
		send_command('unbind @F5')
		send_command('unbind @F6')
		-- Unbind GEO Indi Spells --
		send_command('unbind @1')
		send_command('unbind @2')
		send_command('unbind @A')
		send_command('unbind @D')
		send_command('unbind @F')
		send_command('unbind @H')
		send_command('unbind @K')
		send_command('unbind @P')
		send_command('unbind @Q')
		send_command('unbind @S')
		send_command('unbind @V')
		-- Unbind GEO Geocolure Spells --
		send_command('unbind !@1')
		send_command('unbind !@2')
		send_command('unbind !@A')
		send_command('unbind !@D')
		send_command('unbind !@F')
		send_command('unbind !@H')
		send_command('unbind !@K')
		send_command('unbind !@P')
		send_command('unbind !@Q')
		send_command('unbind !@S')
		send_command('unbind !@V')
		-- Unbind GEO Entrust Spells --
		send_command('unbind ^@1')
		send_command('unbind ^@2')
		send_command('unbind ^@A')
		send_command('unbind ^@D')
		send_command('unbind ^@F')
		send_command('unbind ^@H')
		send_command('unbind ^@K')
		send_command('unbind ^@P')
		send_command('unbind ^@Q')
		send_command('unbind ^@S')
		send_command('unbind ^@V')
		-- Unbind DRK Job Binds --
		send_command('unbind ^L')
		-- Unload Weapon Skill Key Binds --
		send_command('unbind ^F7')
		send_command('unbind ^F9')
		send_command('unbind F10')
		send_command('unbind ^F10')
		send_command('unbind F11')
		send_command('unbind !F11')
		send_command('unbind ^F11')
		send_command('unbind F12')
		send_command('unbind ^F12')
		send_command('unbind Delete')
		send_command('unbind !Delete')
		send_command('unbind ^Delete')
		send_command('unbind Insert')
	end

	-- Gavialis Helm --
	elements = {}
	elements.equip = {head="Gavialis Helm"}
	elements.Resolution = S{"Lightning","Wind","Earth"}
	elements.Scourge = S {"Light","Fire"}
	elements.Torcleaver = S {"Light","Water","Ice"}
	elements.Catastrophe = S {"Dark","Earth"}
	elements.Entropy = S{"Dark","Water","Earth"}
	elements.Insurgency = S{"Light","Dark","Fire"}
	elements.Quietus = S {"Light","Water","Ice"}
	elements["Cross Reaper"] = S {"Water","Ice"}

	-- Idle Sets --
	sets.Idle = {
             ammo="Staunch Tathlum",
    neck="Sanctity Necklace",
    ear1="Telos Earring",
    ear2="Cessance Earring",
    body="Sulevia's plate. +2",
	head="Sulevia's mask +2",
    hands="Sulev. Gauntlets +2",
    ring1="Paguroidea Ring",
    ring2="Sheltered Ring",
    back=DEXDAMantle,
    waist="Nierenschutz",
    legs="Carmine cuisses +1",
    feet="Sulev. Leggings +2"}
	
	-- Full Idle Set --
	sets.Idle.Full = set_combine(sets.Idle,{})
	sets.Idle.Full.Caladbolg = set_combine(sets.Idle.Full,{
			main="Caladbolg"})
	sets.Idle.Full.Caladbolg.SAM = set_combine(sets.Idle.Full,{
			main="Caladbolg"})
	sets.Idle.Full.Ragnarok = set_combine(sets.Idle.Full,{
			main="Ragnarok"})
	sets.Idle.Full.Ragnarok.SAM = set_combine(sets.Idle.Full,{
			main="Ragnarok"})
	sets.Idle.Full.Raetic = set_combine(sets.Idle.Full,{
			main="Raetic Algol +1"})
	sets.Idle.Full.Raetic.SAM = set_combine(sets.Idle.Full,{
			main="Raetic Algol +1"})
	sets.Idle.Full.Anguta = set_combine(sets.Idle.Full,{
			main="Anguta"})
	sets.Idle.Full.Anguta.SAM = set_combine(sets.Idle.Full,{
			main="Anguta"})
	sets.Idle.Full.Apocalypse = set_combine(sets.Idle.Full,{
			main="Apocalypse"})
	sets.Idle.Full.Apocalypse.SAM = set_combine(sets.Idle.Full,{
			main="Apocalypse"})
	sets.Idle.Full.Liberator = set_combine(sets.Idle.Full,{
			main="Liberator"})
	sets.Idle.Full.Liberator.SAM = set_combine(sets.Idle.Full,{
			main="Liberator"})

	-- Damage Taken Idle Set --
	sets.Idle.DT = set_combine(sets.Idle,{ammo="Ginsen",
    head="Sulevia's mask +2",
    neck="Loricate Torque +1",
    ear1="Brutal Earring",
	ear2="Cessance Earring",
    body="Hjarrandi Breastplate",
    hands="Sulev. Gauntlets +2",
    ring1="Defending Ring",
    ring2="Moonbeam Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','DEX+10','Phys. dmg. taken-10%',}},
    waist="Ioskeha Belt +1",
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2"})
	sets.Idle.DT.Caladbolg = set_combine(sets.Idle.DT,{
			main="Caladbolg"})
	sets.Idle.DT.Caladbolg.SAM = set_combine(sets.Idle.DT,{
			main="Caladbolg"})
	sets.Idle.DT.Ragnarok = set_combine(sets.Idle.DT,{
			main="Ragnarok"})
	sets.Idle.DT.Ragnarok.SAM = set_combine(sets.Idle.DT,{
			main="Ragnarok"})
	sets.Idle.DT.Raetic = set_combine(sets.Idle.DT,{
			main="Raetic Algol +1"})
	sets.Idle.DT.Raetic.SAM = set_combine(sets.Idle.DT,{
			main="Raetic Algol +1"})
	sets.Idle.DT.Anguta = set_combine(sets.Idle.DT,{
			main="Anguta"})
	sets.Idle.DT.Anguta.SAM = set_combine(sets.Idle.DT,{
			main="Anguta"})
	sets.Idle.DT.Apocalypse = set_combine(sets.Idle.DT,{
			main="Apocalypse"})
	sets.Idle.DT.Apocalypse.SAM = set_combine(sets.Idle.DT,{
			main="Apocalypse"})
	sets.Idle.DT.Liberator = set_combine(sets.Idle.DT,{
			main="Liberator"})
	sets.Idle.DT.Liberator.SAM = set_combine(sets.Idle.DT,{
			main="Liberator"})
			
	-- Warp Idle Set --
	sets.Idle.Warp = set_combine(sets.Idle,{
			ring2="Warp Ring"})
	sets.Idle.Warp.Caladbolg = set_combine(sets.Idle.Warp,{
			main="Caladbolg"})
	sets.Idle.Warp.Caladbolg.SAM = set_combine(sets.Idle.Warp,{
			main="Caladbolg"})
	sets.Idle.Warp.Ragnarok = set_combine(sets.Idle.Warp,{
			main="Ragnarok"})
	sets.Idle.Warp.Ragnarok.SAM = set_combine(sets.Idle.Warp,{
			main="Ragnarok"})
	sets.Idle.Warp.Raetic = set_combine(sets.Idle.Warp,{
			main="Raetic Algol +1"})
	sets.Idle.Warp.Raetic.SAM = set_combine(sets.Idle.Warp,{
			main="Raetic Algol +1"})
	sets.Idle.Warp.Anguta = set_combine(sets.Idle.Warp,{
			main="Anguta"})
	sets.Idle.Warp.Anguta.SAM = set_combine(sets.Idle.Warp,{
			main="Anguta"})
	sets.Idle.Warp.Apocalypse = set_combine(sets.Idle.Warp,{
			main="Apocalypse"})
	sets.Idle.Warp.Apocalypse.SAM = set_combine(sets.Idle.Warp,{
			main="Apocalypse"})
	sets.Idle.Warp.Liberator = set_combine(sets.Idle.Warp,{
			main="Liberator"})
	sets.Idle.Warp.Liberator.SAM = set_combine(sets.Idle.Warp,{
			main="Liberator"})

	------------------		
	-- Base TP Sets --		
	------------------		
	sets.TP = {
			ammo="Ginsen",
    head="Flamma Zucchetto +2",
    body="Valorous Mail",
    hands="Sulevia's Gauntlets +2",
    legs="Ignominy Flanchard +3",
    feet="Flamma Gambieras +2",
    neck="Abyssal Beads +2",
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    ring1="Niqmaddu Ring",
    ring2="Hetairoi Ring",
    back=DEXDAMantle,}
	sets.TP.MidACC = set_combine(sets.TP,{})
	sets.TP.HighACC = set_combine(sets.TP.MidACC,{})

	-- High Haste TP Base Set --
	sets.TP.HighHaste = set_combine(sets.TP,{})
	sets.TP.MidACC.HighHaste = set_combine(sets.TP.MidACC,{})
	sets.TP.HighACC.HighHaste = set_combine(sets.TP.HighACC,{})
	
	--------------
	-- Caladbolg --
	--------------
	
	-- Caladbolg TP Sets --
	sets.TP.Caladbolg = set_combine(sets.TP,{
			main="Caladbolg",})
	sets.TP.Caladbolg.MidACC = set_combine(sets.TP.MidACC,{
			main="Caladbolg",})
	sets.TP.Caladbolg.HighACC = set_combine(sets.TP.HighACC,{
			main="Caladbolg",
			body="Emicho Haubert +1",
			hands="Emicho gauntlets +1",
			ring1="Chirich ring +1",
			ring2="Regal Ring",
			ear1="Telos Earring",
			feet="Flamma Gambieras +2",})

	-- Caladbolg(High Haste) TP Sets --
	sets.TP.Caladbolg.HighHaste = set_combine(sets.TP.Caladbolg,{main="Caladbolg",})
	sets.TP.Caladbolg.MidACC.HighHaste = set_combine(sets.TP.Caladbolg.MidACC,{main="Caladbolg",})
	sets.TP.Caladbolg.HighACC.HighHaste = set_combine(sets.TP.Caladbolg.HighACC,{main="Caladbolg",
			body="Emicho Haubert +1",
			hands="Emicho gauntlets +1",
			ring1="Chirich ring +1",
			ring2="Regal Ring",
			ear1="Telos Earring",
			feet="Flamma Gambieras +2",})


	-- Caladbolg(SAM Roll) TP Sets --
	sets.TP.Caladbolg.STP = set_combine(sets.TP,{
			main="Caladbolg"})
	sets.TP.Caladbolg.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Caladbolg"})
	sets.TP.Caladbolg.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Caladbolg",
			body="Emicho Haubert +1",
			hands="Emicho gauntlets +1",
			ring1="Chirich ring +1",
			ring2="Regal Ring",
			ear1="Telos Earring",
			feet="Flamma Gambieras +2",})


	-- Caladbolg(High Haste + SAM Roll) TP Sets --
	sets.TP.Caladbolg.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Caladbolg"})
	sets.TP.Caladbolg.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Caladbolg"})
	sets.TP.Caladbolg.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Caladbolg",
			body="Emicho Haubert +1",
			hands="Emicho gauntlets +1",
			ring1="Chirich ring +1",
			ring2="Regal Ring",
			ear1="Telos Earring",
			feet="Flamma Gambieras +2",})


	-- Caladbolg /SAM TP Sets --
	sets.TP.Caladbolg.SAM = set_combine(sets.TP,{
			main="Caladbolg"})
	sets.TP.Caladbolg.SAM.MidACC = set_combine(sets.TP.MidACC,{
			main="Caladbolg"})
	sets.TP.Caladbolg.SAM.HighACC = set_combine(sets.TP.HighACC,{
		    main="Caladbolg",
			body="Emicho Haubert +1",
			hands="Emicho gauntlets +1",
			ring1="Chirich ring +1",
			ring2="Regal Ring",
			ear1="Telos Earring",
			feet="Flamma Gambieras +2",})

	-- Caladbolg(High Haste) /SAM TP Sets --
	sets.TP.Caladbolg.SAM.HighHaste = set_combine(sets.TP.Caladbolg.SAM,{main="Caladbolg",})
	sets.TP.Caladbolg.SAM.MidACC.HighHaste = set_combine(sets.TP.Caladbolg.SAM.MidACC,{main="Caladbolg",})
	sets.TP.Caladbolg.SAM.HighACC.HighHaste = set_combine(sets.TP.Caladbolg.SAM.HighACC,{main="Caladbolg",})


	-- Caladbolg(SAM Roll) /SAM TP Sets --
	sets.TP.Caladbolg.SAM.STP = set_combine(sets.TP,{main="Caladbolg",})

	sets.TP.Caladbolg.SAM.MidACC.STP = set_combine(sets.TP.MidACC,{main="Caladbolg",})
	sets.TP.Caladbolg.SAM.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Caladbolg",
			})


	-- Caladbolg(High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Caladbolg.SAM.HighHaste.STP = set_combine(sets.TP.HighHaste,{
	        main="Caladbolg",
		})
	sets.TP.Caladbolg.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Caladbolg",
			})

	sets.TP.Caladbolg.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Caladbolg",
			})

	
	--------------
	-- Ragnarok --
	--------------
	
	-- Ragnarok TP Sets --
	sets.TP.Ragnarok = set_combine(sets.TP,{
			main="Ragnarok",})
	sets.TP.Ragnarok.MidACC = set_combine(sets.TP.MidACC,{
			main="Ragnarok",})
	sets.TP.Ragnarok.HighACC = set_combine(sets.TP.HighACC,{
			main="Ragnarok"})

	-- Ragnarok(High Haste) TP Sets --
	sets.TP.Ragnarok.HighHaste = set_combine(sets.TP.Ragnarok,{})
	sets.TP.Ragnarok.MidACC.HighHaste = set_combine(sets.TP.Ragnarok.MidACC,{})
	sets.TP.Ragnarok.HighACC.HighHaste = set_combine(sets.TP.Ragnarok.HighACC,{})

	-- Ragnarok(SAM Roll) TP Sets --
	sets.TP.Ragnarok.STP = set_combine(sets.TP,{
			main="Ragnarok"})
	sets.TP.Ragnarok.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Ragnarok"})
	sets.TP.Ragnarok.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Ragnarok"})

	-- Ragnarok(High Haste + SAM Roll) TP Sets --
	sets.TP.Ragnarok.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Ragnarok"})
	sets.TP.Ragnarok.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Ragnarok"})
	sets.TP.Ragnarok.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Ragnarok"})

	-- Ragnarok /SAM TP Sets --
	sets.TP.Ragnarok.SAM = set_combine(sets.TP,{
			main="Ragnarok"})
	sets.TP.Ragnarok.SAM.MidACC = set_combine(sets.TP.MidACC,{
			main="Ragnarok"})
	sets.TP.Ragnarok.SAM.HighACC = set_combine(sets.TP.HighACC,{
			main="Ragnarok"})

	-- Ragnarok(High Haste) /SAM TP Sets --
	sets.TP.Ragnarok.SAM.HighHaste = set_combine(sets.TP.Ragnarok.SAM,{})
	sets.TP.Ragnarok.SAM.MidACC.HighHaste = set_combine(sets.TP.Ragnarok.SAM.MidACC,{})
	sets.TP.Ragnarok.SAM.HighACC.HighHaste = set_combine(sets.TP.Ragnarok.SAM.HighACC,{})

	-- Ragnarok(SAM Roll) /SAM TP Sets --
	sets.TP.Ragnarok.SAM.STP = set_combine(sets.TP,{
			main="Ragnarok"})
	sets.TP.Ragnarok.SAM.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Ragnarok"})
	sets.TP.Ragnarok.SAM.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Ragnarok"})

	-- Ragnarok(High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Ragnarok.SAM.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Ragnarok"})
	sets.TP.Ragnarok.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Ragnarok"})
	sets.TP.Ragnarok.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Ragnarok"})
	
	---------------------
	-- Raetic Algol +1 --
	---------------------
	
	-- Raetic TP Sets --
	sets.TP.Raetic = set_combine(sets.TP,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.MidACC = set_combine(sets.TP.MidACC,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.HighACC = set_combine(sets.TP.HighACC,{
			main="Raetic Algol +1"})

	-- Raetic (High Haste) TP Sets --
	sets.TP.Raetic.HighHaste = set_combine(sets.TP.Raetic,{})
	sets.TP.Raetic.MidACC.HighHaste = set_combine(sets.TP.Raetic.MidACC,{})
	sets.TP.Raetic.HighACC.HighHaste = set_combine(sets.TP.Raetic.HighACC,{})

	-- Raetic(SAM Roll) TP Sets --
	sets.TP.Raetic.STP = set_combine(sets.TP,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Raetic Algol +1"})

	-- Raetic(High Haste + SAM Roll) TP Sets --
	sets.TP.Raetic.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Raetic Algol +1"})

	-- Raetic /SAM TP Sets --
	sets.TP.Raetic.SAM = set_combine(sets.TP,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.SAM.MidACC = set_combine(sets.TP.MidACC,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.SAM.HighACC = set_combine(sets.TP.HighACC,{
			main="Raetic Algol +1"})

	-- Raetic(High Haste) /SAM TP Sets --
	sets.TP.Raetic.SAM.HighHaste = set_combine(sets.TP.Raetic.SAM,{})
	sets.TP.Raetic.SAM.MidACC.HighHaste = set_combine(sets.TP.Raetic.SAM.MidACC,{})
	sets.TP.Raetic.SAM.HighACC.HighHaste = set_combine(sets.TP.Raetic.SAM.HighACC,{})

	-- Raetic(SAM Roll) /SAM TP Sets --
	sets.TP.Raetic.SAM.STP = set_combine(sets.TP,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.SAM.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.SAM.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Raetic Algol +1"})

	-- Raetic(High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Raetic.SAM.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Raetic Algol +1"})
	sets.TP.Raetic.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Raetic Algol +1"})
	
	----------------
	-- Anguta --
	----------------
	
	-- Anguta TP Sets --
	sets.TP.Anguta = set_combine(sets.TP,{
			main="Anguta",
			legs=OLegs.STP})
	sets.TP.Anguta.MidACC = set_combine(sets.TP.MidACC,{
			main="Anguta",
			legs=OLegs.STP})
	sets.TP.Anguta.HighACC = set_combine(sets.TP.HighACC,{
			main="Anguta"})

	-- Anguta High Haste TP Sets --
	sets.TP.Anguta.HighHaste = set_combine(sets.TP.Anguta,{})
	sets.TP.Anguta.MidACC.HighHaste = set_combine(sets.TP.Anguta.MidACC,{})
	sets.TP.Anguta.HighACC.HighHaste = set_combine(sets.TP.Anguta.HighACC,{})

	-- Anguta SAM Roll TP Sets --
	sets.TP.Anguta.STP = set_combine(sets.TP,{
			main="Anguta"})
	sets.TP.Anguta.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Anguta"})
	sets.TP.Anguta.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Anguta"})

	-- Anguta High Haste + SAM Roll TP Sets --
	sets.TP.Anguta.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Anguta"})
	sets.TP.Anguta.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Anguta"})
	sets.TP.Anguta.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Anguta"})

	-- Anguta /SAM TP Sets --
	sets.TP.Anguta.SAM = set_combine(sets.TP,{
			main="Anguta"})
	sets.TP.Anguta.SAM.MidACC = set_combine(sets.TP.MidACC,{
			main="Anguta"})
	sets.TP.Anguta.SAM.HighACC = set_combine(sets.TP.HighACC,{
			main="Anguta"})

	-- Anguta High Haste /SAM TP Sets --
	sets.TP.Anguta.SAM.HighHaste = set_combine(sets.TP.Anguta.SAM,{})
	sets.TP.Anguta.SAM.MidACC.HighHaste = set_combine(sets.TP.Anguta.SAM.MidACC,{})
	sets.TP.Anguta.SAM.HighACC.HighHaste = set_combine(sets.TP.Anguta.SAM.HighACC,{})

	-- Anguta SAM Roll /SAM TP Sets --
	sets.TP.Anguta.SAM.STP = set_combine(sets.TP,{
			main="Anguta"})
	sets.TP.Anguta.SAM.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Anguta"})
	sets.TP.Anguta.SAM.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Anguta"})

	-- Anguta High Haste + SAM Roll /SAM TP Sets --
	sets.TP.Anguta.SAM.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Anguta"})
	sets.TP.Anguta.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Anguta"})
	sets.TP.Anguta.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Anguta"})	
	
	----------------
	-- Apocalypse --
	----------------
	
	-- Apocalypse TP Sets --
	sets.TP.Apocalypse = set_combine(sets.TP,{
			main="Apocalypse",
			ammo="Ginsen",
			ear2="Telos Earring",
			legs=OLegs.STP,
			feet=VFeet.STP})
	sets.TP.Apocalypse.MidACC = set_combine(sets.TP.MidACC,{
			main="Apocalypse",
			ammo="Ginsen",
			ear2="Telos Earring",
			legs=OLegs.STP,
			feet=VFeet.STP})
	sets.TP.Apocalypse.HighACC = set_combine(sets.TP.HighACC,{
			main="Apocalypse"})

	-- Apocalypse High Haste TP Sets --
	sets.TP.Apocalypse.HighHaste = set_combine(sets.TP.Apocalypse,{})
	sets.TP.Apocalypse.MidACC.HighHaste = set_combine(sets.TP.Apocalypse.MidACC,{})
	sets.TP.Apocalypse.HighACC.HighHaste = set_combine(sets.TP.Apocalypse.HighACC,{})

	-- Apocalypse SAM Roll TP Sets --
	sets.TP.Apocalypse.STP = set_combine(sets.TP,{
			main="Apocalypse"})
	sets.TP.Apocalypse.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Apocalypse"})
	sets.TP.Apocalypse.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Apocalypse"})

	-- Apocalypse High Haste + SAM Roll TP Sets --
	sets.TP.Apocalypse.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Apocalypse"})
	sets.TP.Apocalypse.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Apocalypse"})
	sets.TP.Apocalypse.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Apocalypse"})

	-- Apocalypse /SAM TP Sets --
	sets.TP.Apocalypse.SAM = set_combine(sets.TP,{
			main="Apocalypse",
			ammo="Ginsen",
			ear2="Telos Earring"})
	sets.TP.Apocalypse.SAM.MidACC = set_combine(sets.TP.MidACC,{
			main="Apocalypse",
			ammo="Ginsen",
			ear2="Telos Earring",})
	sets.TP.Apocalypse.SAM.HighACC = set_combine(sets.TP.HighACC,{
			main="Apocalypse"})

	-- Apocalypse High Haste /SAM TP Sets --
	sets.TP.Apocalypse.SAM.HighHaste = set_combine(sets.TP.Apocalypse.SAM,{})
	sets.TP.Apocalypse.SAM.MidACC.HighHaste = set_combine(sets.TP.Apocalypse.SAM.MidACC,{})
	sets.TP.Apocalypse.SAM.HighACC.HighHaste = set_combine(sets.TP.Apocalypse.SAM.HighACC,{})

	-- Apocalypse SAM Roll /SAM TP Sets --
	sets.TP.Apocalypse.SAM.STP = set_combine(sets.TP,{
			main="Apocalypse"})
	sets.TP.Apocalypse.SAM.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Apocalypse"})
	sets.TP.Apocalypse.SAM.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Apocalypse"})

	-- Apocalypse High Haste + SAM Roll /SAM TP Sets --
	sets.TP.Apocalypse.SAM.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Apocalypse"})
	sets.TP.Apocalypse.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Apocalypse"})
	sets.TP.Apocalypse.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Apocalypse"})

	----------------
	-- Liberator --
	----------------
	
	-- Liberator TP Sets --
	sets.TP.Liberator = set_combine(sets.TP,{
			main="Liberator",
			neck="Abyssal Beads +2",
			ring1="Petrov Ring",
			ring2="Niqmaddu Ring",})
	sets.TP.Liberator.MidACC = set_combine(sets.TP.MidACC,{
			main="Liberator",})
	sets.TP.Liberator.HighACC = set_combine(sets.TP.HighACC,{
			main="Liberator"})

	-- Liberator High Haste TP Sets --
	sets.TP.Liberator.HighHaste = set_combine(sets.TP.Liberator,{})
	sets.TP.Liberator.MidACC.HighHaste = set_combine(sets.TP.Liberator.MidACC,{})
	sets.TP.Liberator.HighACC.HighHaste = set_combine(sets.TP.Liberator.HighACC,{})

	-- Liberator SAM Roll TP Sets --
	sets.TP.Liberator.STP = set_combine(sets.TP,{
			main="Liberator"})
	sets.TP.Liberator.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Liberator"})
	sets.TP.Liberator.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Liberator"})

	-- Liberator High Haste + SAM Roll TP Sets --
	sets.TP.Liberator.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Liberator"})
	sets.TP.Liberator.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Liberator"})
	sets.TP.Liberator.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Liberator"})

	-- Liberator /SAM TP Sets --
	sets.TP.Liberator.SAM = set_combine(sets.TP,{
			main="Liberator",})
	sets.TP.Liberator.SAM.MidACC = set_combine(sets.TP.MidACC,{
			main="Liberator",})
	sets.TP.Liberator.SAM.HighACC = set_combine(sets.TP.HighACC,{
			main="Liberator"})

	-- Liberator High Haste /SAM TP Sets --
	sets.TP.Liberator.SAM.HighHaste = set_combine(sets.TP.Liberator.SAM,{})
	sets.TP.Liberator.SAM.MidACC.HighHaste = set_combine(sets.TP.Liberator.SAM.MidACC,{})
	sets.TP.Liberator.SAM.HighACC.HighHaste = set_combine(sets.TP.Liberator.SAM.HighACC,{})

	-- Liberator SAM Roll /SAM TP Sets --
	sets.TP.Liberator.SAM.STP = set_combine(sets.TP,{
			main="Liberator"})
	sets.TP.Liberator.SAM.MidACC.STP = set_combine(sets.TP.MidACC,{
			main="Liberator"})
	sets.TP.Liberator.SAM.HighACC.STP = set_combine(sets.TP.HighACC,{
			main="Liberator"})

	-- Liberator High Haste + SAM Roll /SAM TP Sets --
	sets.TP.Liberator.SAM.HighHaste.STP = set_combine(sets.TP.HighHaste,{
			main="Liberator"})
	sets.TP.Liberator.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.MidACC.HighHaste,{
			main="Liberator"})
	sets.TP.Liberator.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.HighACC.HighHaste,{
			main="Liberator"})
			
	-------------------
	-- Liberator AM3 --
	-------------------
	
	-- Liberator AM3 TP Sets --
	sets.TP.Liberator.AM3 = {
			main="Liberator",
			ammo="Ginsen",
			head="Flam. Zucchetto +2",
			neck="Abyssal Beads +2",
			ear1="Dedition Earring",
			ear2="Telos Earring",
			body="Flamma Korazin +2",
			hands="Emicho Gauntlets +1",
			ring1="Flamma Ring",
			ring2="Niqmaddu Ring",
			back=DEXSTPMantle,
			waist="Sailfi Belt +1",
			legs="Flamma Dirs +2",
			feet="Flamma Gambieras +2",}
	sets.TP.Liberator.MidACC.AM3 = set_combine(sets.TP.Liberator.AM3,{})
	sets.TP.Liberator.HighACC.AM3 = set_combine(sets.TP.Liberator.AM3.MidACC,{})
					
	-- Liberator High Haste TP Sets --
	sets.TP.Liberator.AM3.HighHaste = set_combine(sets.TP.Liberator.AM3,{waist="Windbuffet Belt +1"})
	sets.TP.Liberator.MidACC.AM3.HighHaste = set_combine(sets.TP.Liberator.MidACC.AM3,{waist="Windbuffet Belt +1"})
	sets.TP.Liberator.HighACC.AM3.HighHaste = set_combine(sets.TP.Liberator.HighACC.AM3,{})

	-- Liberator SAM Roll TP Sets --
	sets.TP.Liberator.AM3.STP = set_combine(sets.TP.Liberator.AM3,{})
	sets.TP.Liberator.MidACC.AM3.STP = set_combine(sets.TP.Liberator.MidACC.AM3,{})
	sets.TP.Liberator.HighACC.AM3.STP = set_combine(sets.TP.Liberator.HighACC.AM3,{})

	-- Liberator High Haste + SAM Roll TP Sets --
	sets.TP.Liberator.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.HighHaste.AM3,{waist="Windbuffet Belt +1"})
	sets.TP.Liberator.MidACC.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.MidACC.HighHaste.AM3,{waist="Windbuffet Belt +1"})
	sets.TP.Liberator.HighACC.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.HighACC.HighHaste.AM3,{})

	-- Liberator /SAM TP Sets --
	sets.TP.Liberator.SAM.AM3 = set_combine(sets.TP.Liberator.AM3,{})
	sets.TP.Liberator.SAM.MidACC.AM3 = set_combine(sets.TP.Liberator.MidACC.AM3,{})
	sets.TP.Liberator.SAM.HighACC.AM3 = set_combine(sets.TP.Liberator.HighACC.AM3,{})

	-- Liberator High Haste /SAM TP Sets --
	sets.TP.Liberator.SAM.AM3.HighHaste = set_combine(sets.TP.Liberator.AM3,{waist="Windbuffet Belt +1"})
	sets.TP.Liberator.SAM.MidACC.AM3.HighHaste = set_combine(sets.TP.Liberator.MidACC.AM3,{waist="Windbuffet Belt +1"})
	sets.TP.Liberator.SAM.HighACC.AM3.HighHaste = set_combine(sets.TP.Liberator.HighACC.AM3,{})

	-- Liberator SAM Roll /SAM TP Sets --
	sets.TP.Liberator.SAM.AM3.STP = set_combine(sets.TP.Liberator.AM3,{})
	sets.TP.Liberator.SAM.MidACC.AM3.STP = set_combine(sets.TP.Liberator.MidACC.AM3,{})
	sets.TP.Liberator.SAM.HighACC.AM3.STP = set_combine(sets.TP.Liberator.HighACC.AM3,{})

	-- Liberator High Haste + SAM Roll /SAM TP Sets --
	sets.TP.Liberator.SAM.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.AM3,{waist="Windbuffet Belt +1"})
	sets.TP.Liberator.SAM.MidACC.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.MidACC.AM3,{waist="Windbuffet Belt +1"})
	sets.TP.Liberator.SAM.HighACC.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.HighACC.AM3,{})


	-- PDT/MDT Sets --
	sets.PDT = {
			ammo="Staunch Tathlum",
			head="Sulevia's Mask +2",
			neck="Abyssal Beads +2",
			ear1="Genmei Earring",			
			ear2="Odnowa Earring +1",
			body="Hjarrandi Breastplate",
			hands="Sulev. Gauntlets +2",
			ring1="Moonbeam Ring",			
			ring2="Defending Ring",
			back=DEXDAMantle,
			waist="Ioskeha Belt +1",
			legs="Ignominy flanchard +3",
			feet="Carmine Greaves +1"}

	sets.MDT = set_combine(sets.PDT,{})

	-- Hybrid Set --
	sets.TP.Hybrid = set_combine(sets.PDT,{
			ear1="Cessance Earring",
			ear2="Brutal Earring",
			back=DEXDAMantle})
	sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{
			ear2="Telos Earring"})
	sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{})
	
	sets.TP.Hybrid.HighHaste = set_combine(sets.TP.Hybrid,{
			waist="Ioskeha Belt +1"})
	sets.TP.Hybrid.MidACC.HighHaste = set_combine(sets.TP.Hybrid.MidACC,{
			waist="Ioskeha Belt +1"})
	sets.TP.Hybrid.HighACC.HighHaste = set_combine(sets.TP.Hybrid.HighACC,{
			waist="Ioskeha Belt +1"})
			
	-- Kiting Set --
	sets.Kiting =  set_combine(sets.PDT,{
			legs="Carmine Cuisses +1",})

	-----------------------
	-- Weapon Skill Sets --
	-----------------------			
			
	-- WS Base Set (multi-attack) --
	sets.WS = {
            ammo="Seeth. Bomblet +1",
			head="Flam. Zucchetto +2",
            neck="Abyssal beads +2",
            ear1="Moonshade Earring",
            ear2="Brutal Earring",
			Body="Argosy Hauberk +1",
			hands="Argosy Mufflers +1",
            ring1="Regal Ring",
            ring2="Niqmaddu Ring",
            back=STRDAMantle,
            waist="Fotia Belt",
            legs="Ig. Flanchard +3",
			feet="Flam. Gambieras +2"}
	sets.WS.MidACC = set_combine(sets.WS,{
			ear2="Mache Earring +1",
			back=DEXDAMantle})
	sets.WS.HighACC = set_combine(sets.WS.MidACC,{
			head="Ig. Burgonet +3",
			body="Fall. Cuirass +3",})
			
	-- One Hit WS set--
	sets.WS.OneHit = {
			ammo="Knobkierrie",
			head="Odyssean Helm",
			neck="Abyssal Beads +2",
			ear1="Moonshade Earring",
			ear2="Thrud Earring",
			body="Ignominy Cuirass +3",
			hands="Odyssean gauntlets",
            ring1="Epaminondas's Ring",
            ring2="Niqmaddu Ring",
			back=WSDMantle,
			waist="Fotia Belt",
			legs="Fall. Flanchard +3",
			feet="Sulev. Leggings +2"}
	sets.WS.OneHit.MidACC = set_combine(sets.WS.OneHit,{
			ammo="Seeth. Bomblet +1",})
	sets.WS.OneHit.HighACC = set_combine(sets.WS.OneHit.MidACC,{
			head="Ig. Burgonet +3",
			body="Fall. Cuirass +3",
			legs="Ig. Flanchard +3"})
			
	-- Magic WS set --
	sets.WS.MABWS = {
			ammo="Knobkierrie",
			head="Pixie hairpin +1",
			neck="Fotia gorget",
			ear1="Friomisi Earring",
			ear2="Moonshade Earring",
			body="Fall. Cuirass +3",
			hands="Fall. Fin. Gaunt. +3",
			ring1="Archon Ring",
			ring2="Epaminondas's Ring",
			back=WSDMantle,
			waist="Eschan Stone",
			legs="Fall. Flanchard +3",
			feet="Founder's Greaves"}

	-- Resolution Sets (STR & Multi-Attack) --
	sets.WS.Resolution = {
            ammo="Seeth. Bomblet +1",
			head="Flam. Zucchetto +2",
            neck="Abysseal Beads +1",
            ear1="Moonshade Earring",
            ear2="Brutal Earring",
            body="Argosy Hauberk +1",
			hands="Argosy Mufflers +1",
            ring1="Regal Ring",
            ring2="Niqmaddu Ring",
            back=STRDAMantle,
            waist="Fotia Belt",
            legs="Ig. Flanchard +3",
			feet="Flam. Gambieras +2"}
	sets.WS.Resolution.MidACC = set_combine(sets.WS.Resolution,{
			ear2="Mache Earring +1",
			back=DEXDAMantle})
	sets.WS.Resolution.HighACC = set_combine(sets.WS.HighACC,{})

	-- Scourge Sets (STR/VIT & WSD+) --
	sets.WS.Scourge = set_combine(sets.WS.OneHit,{})
	sets.WS.Scourge.MidACC = set_combine(sets.WS.OneHit.MidACC,{})
	sets.WS.Scourge.HighACC = set_combine(sets.WS.OneHit.HighACC,{})
	
	-- Torcleaver Sets (VIT & WSD+) --
	sets.WS.Torcleaver = set_combine(sets.WS.OneHit,{
			back=VITWSDMantle})
	sets.WS.Torcleaver.MidACC = set_combine(sets.WS.OneHit.MidACC,{
			back=VITWSDMantle})
	sets.WS.Torcleaver.HighACC = set_combine(sets.WS.OneHit.HighACC,{
			back=VITWSDMantle})
		
	-- Herculean Slash Sets (MAB/Ice) -- 
	sets.WS["Herculean Slash"] = set_combine(sets.WS.MABWS,{})
	sets.WS["Herculean Slash"].MidACC = set_combine(sets.WS.MABWS,{})
	sets.WS["Herculean Slash"].HighACC = set_combine(sets.WS.MABWS,{})

	-- Catastrophe Sets (STR/INT & WSD+) --
	sets.WS.Catastrophe = set_combine(sets.WS.OneHit,{
			head="Ratri Sallet +1",
			hands="Rat. Gadlings +1",
			feet="Rat. Sollerets +1"})
	sets.WS.Catastrophe.MidACC = set_combine(sets.WS.OneHit.MidACC,{
			head="Ratri Sallet +1",
			hands="Rat. Gadlings +1",
			feet="Rat. Sollerets +1"})
	sets.WS.Catastrophe.HighACC = set_combine(sets.WS.OneHit.HighACC,{})

	-- Entropy Sets (INT & Gorget/Belt, four hits) --
	sets.WS.Entropy = set_combine(sets.WS,{
			ammo="Knobkierrie",
			head="Ratri Sallet +1",
			neck="Fotia Gorget",
			ear1="Ishvara Earring",
			ear2="Moonshade Earring",
			body="Fall. Cuirass +3",
			hands="Ratri Gadlings +1",
			ring1="Shiva Ring +1",
			ring2="Shiva Ring +1",
			legs="Fall. Flanchard +3",
			feet="Ratri Sollerets +1",
			back=WSDMantle})
	sets.WS.Entropy.MidACC = set_combine(sets.WS.MidACC,{})
	sets.WS.Entropy.HighACC = set_combine(sets.WS.HighACC,{})

	-- Insurgency Sets (STR/INT, four hits) --
	sets.WS.Insurgency = set_combine(sets.WS,{ammo="Knobkierrie",
    head="Ratri sallet +1",
    neck="Abyssal Beads +2",
    ear1="Moonshade Earring",
    ear2="Thrud Earring",
    body="Ignominy cuirass +3",
    hands="Ratri gadlings +1",
    ring1="Niqmaddu Ring",
    ring2="Regal Ring",
    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','STR+10',}},
    waist="Fotia Belt",
    legs="Ratri Cuisses +1",
    feet="Ratri sollerets +1"})
	sets.WS.Insurgency.MidACC = set_combine(sets.WS.MidACC,{})
	sets.WS.Insurgency.HighACC = set_combine(sets.WS.HighACC,{})
	
	-- Quietus Sets (STR/MND & WSD+) --
	sets.WS.Quietus = set_combine(sets.WS.OneHit,{
			head="Ratri Sallet +1",
			hands="Rat. Gadlings +1",
			feet="Rat. Sollerets +1"})
	sets.WS.Quietus.MidACC = set_combine(sets.WS.OneHit.MidACC,{
			head="Ratri Sallet +1",
			hands="Rat. Gadlings +1",
			feet="Rat. Sollerets +1"})
	sets.WS.Quietus.HighACC = set_combine(sets.WS.OneHit.HighACC,{})

	-- Cross Reaper Sets (STR/MND & WSD+) --
	sets.WS["Cross Reaper"] = set_combine(sets.WS.OneHit,{
			head="Ratri Sallet +1",
			hands="Rat. Gadlings +1",
			feet="Rat. Sollerets +1"})
	sets.WS["Cross Reaper"].MidACC = set_combine(sets.WS.OneHit.MidACC,{
			head="Ratri Sallet +1",
			hands="Rat. Gadlings +1",
			feet="Rat. Sollerets +1"})
	sets.WS["Cross Reaper"].HighACC = set_combine(sets.WS.OneHit.HighACC,{})

	-- Guillotine Sets (STR/MND) --
	sets.WS.Guillotine = set_combine(sets.WS,{
			head="Ig. Burgonet +3",
			body="Fall. Cuirass +3",
			hands="Fall. Fin. Gaunt. +3",
			feet="Rat. Sollerets +1"})
	sets.WS.Guillotine.MidACC = set_combine(sets.WS.MidACC,{
			head="Ig. Burgonet +3",
			body="Fall. Cuirass +3",
			hands="Fall. Fin. Gaunt. +3",
			feet="Rat. Sollerets +1"})
	sets.WS.Guillotine.HighACC = set_combine(sets.WS.HighACC,{})

	-- Infernal Scythe Sets (MAB/Dark) -- 
	sets.WS["Infernal Scythe"] = set_combine(sets.WS.MABWS,{
            head="Pixie Hairpin +1",
            ring1="Archon Ring"})
	sets.WS["Infernal Scythe"].MidACC = set_combine(sets.WS.MABWS,{
            head="Pixie Hairpin +1",
            ring1="Archon Ring"})
	sets.WS["Infernal Scythe"].HighACC = set_combine(sets.WS.MABWS,{
            head="Pixie Hairpin +1",
            ring1="Archon Ring"})
			
	-- Full Break WS set --
	sets.WS['Full Break'] = {
			ammo="Pemphredo Tathlum",
			head="Carmine Mask +1",
			neck="Erra Pendant",
			ear1="Digni. Earring",
			ear2="Gwati Earring",
			body="Flamma Korazin +2",
			hands="Flam. Manopolas +2",
			ring1="Ramuh Ring +1",
			ring2="Ramuh Ring +1",
			back=FCMantle,
			waist="Eschan Stone",
			legs="Flamma Dirs +2",
			feet="Flam. Gambieras +2"}
			
	-- Fell Cleave --
	sets.WS['Fell Cleave'] = set_combine(sets.WS.OneHit,{})
	sets.WS['Fell Cleave'].MidACC = set_combine(sets.WS.OneHit.MidACC,{})
	sets.WS['Fell Cleave'].HighACC = set_combine(sets.WS.OneHit.HighACC,{})
		
	-- Souleater WS Set --
	sets.SE_WS = {
			head="Ig. Burgonet +3"}
			
	-- Arcane Circle/Founders Breastplate WS Set --
	sets.AC_WS = {
			body="Found. Breastplate"}
	
	-------------
	-- JA Sets --
	-------------
	sets.JA = {}
	sets.JA["Blood Weapon"] = {body="Fall. Cuirass +3"}
	sets.JA["Diabolic Eye"] = {hands="Fall. Fin. Gaunt. +3"}
	sets.JA["Nether Void"] = {legs="Heath. Flanchard +1"}
	sets.JA["Arcane Circle"] = {feet="Igno. Sollerets +1"}
	sets.JA["Last Resort"] = {back="Ankou's Mantle"}
	sets.JA["Weapon Bash"] = {hands="Ig. Gauntlets +3"}

	-- Waltz Set --
	sets.Waltz = {}

	------------------
	-- Precast Sets --
	------------------
	sets.Precast = {
			ammo="Impatiens",
			head="Carmine Mask +1",
			neck="Orunmila's Torque",
			ear1="Loquac. Earring",
			ear2="Etiolation Earring",
			body="Fall. Cuirass +3",
			hands="Leyline Gloves",
			ring1="Lebeche Ring",
			ring2="Kishar Ring",
			back=FCMantle,
			waist="Ioskeha Belt +1",
			legs="Eschite Cuisses",
			feet="Carmine Greaves +1"}
			
	-- Precast Cure Set --
	sets.Precast.Cure = set_combine(sets.Precast,{
			ear2="Mendi. Earring",
			body="Jumalik Mail",
			waist="Acerbic Sash +1"})
	
	-- Precast Enhancing Magic --
	sets.Precast['Enhancing Magic'] = set_combine(sets.Precast.FastCast,{waist="Siegel Sash"})
	
	-- Fastcast Set --
	sets.Precast.FastCast = set_combine(sets.Precast,{})

	------------------
	-- Midcast Sets --
	------------------
	sets.Midcast = {
			ammo="Staunch Tathlum +1",
			head="Carmine Mask +1",
			neck="Orunmila's Torque",
			ear1="Loquac. Earring",
			ear2="Etiolation Earring",
			body="Fall. Cuirass +3",
			hands="Leyline Gloves",
			ring1="Defending Ring",
			ring2="Kishar Ring",
			back=FCMantle,
			waist="Flume Belt +1",
			legs="Carmine Cuisses +1",
			feet="Odyssean Greaves"}

	-- Magic Haste Set --
	sets.Midcast.Haste = set_combine(sets.Midcast,{})
	
	-- Magic Attack Bonus Set --
	sets.Midcast.MAB = {
			ammo="Pemphredo Tathlum",
			head="Jumalik Helm",
			neck="Sanctity Necklace",
			ear1="Friomisi Earring",
			ear2="Crematio Earring",
			body="Fall. Cuirass +3",
			hands="Fall. Fin. Gaunt. +3",
			ring1="Shiva Ring +1",
			ring2="Shiva Ring +1",
			back=FCMantle,
			waist="Eschan Stone",
			legs="Eschite Cuisses",
			feet="Founder's Greaves"}

	-- Magic Accuracy Set --
	sets.Midcast.MACC = {
			ammo="Pemphredo Tathlum",
			head="Carmine Mask +1",
			neck="Erra Pendant",
			ear1="Friomisi Earring",
			ear2="Gwati Earring",
			body="Flamma Korazin +2",
			hands="Flam. Manopolas +2",
			ring1="Stikini Ring",
			ring2="Stikini Ring",
			back=FCMantle,
			waist="Eschan Stone",
			legs="Flamma Dirs +2",
			feet="Flam. Gambieras +2"}

	-- Dark Magic Set --
	sets.Midcast['Dark Magic'] = set_combine(sets.Midcast.MACC,{ammo="Pemphredo Tathlum",
	head="Ignominy Burgonet +3",
	neck="Erra pendant",
	ear1="Dark Earring",
	ear2="Gwati Earring",
	body="Carmine scale mail +1",
	hands="Fall. Fin. Gaunt. +3",
	ring1="Stikini Ring",
	ring2="Evanescence Ring",
	back="Ankou Mantle",
	waist= "Casso Sash",
	legs="Eschite Cuisses",
	feet="Ratri sollerets +1",})

	-- Stun Sets --
	sets.Midcast.Stun = set_combine(sets.Midcast.MACC,{})
	sets.Midcast.Stun.MidACC = set_combine(sets.Midcast.Stun,{})
	sets.Midcast.Stun.HighACC = set_combine(sets.Midcast.Stun.MidACC,{})

	-- Endark Set --
	sets.Midcast.Endark = set_combine(sets.Midcast,{ammo="Pemphredo Tathlum",
	head="Ignominy Burgonet +3",
	neck="Erra pendant",
	ear1="Dark Earring",
	ear2="Gwati Earring",
	body="Carmine scale mail +1",
	hands="Fall. Fin. Gaunt. +3",
	ring1="Stikini Ring",
	ring2="Evanescence Ring",
	back="Ankou Mantle",
	waist= "Casso Sash",
	legs="Eschite Cuisses",
	feet="Ratri sollerets +1"})
	
	-- Absorb Set --
	sets.Midcast.Absorb = set_combine(sets.Midcast.MACC,{
			head="Ig. Burgonet +3",
			neck="Erra Pendant",
			body="Carm. Sc. Mail +1",
			hands="Pavor Gauntlets",
			ear1="Gwati Earring",
			ear2="Dark Earring",
			ring1="Archon Ring",
			ring2="Kishar Ring",
			back="Chuparrosa Mantle",
			legs="Eschite Cuisses",
			feet="Rat. Sollerets +1"})

	-- Drain & Aspir Sets --
	sets.Midcast.Drain = set_combine(sets.Midcast.MACC,{
			head="Fall. Burgeonet +3",
			neck="Erra Pendant",
			ear1="Gwati Earring",
			ear2="Hirudinea Earring",
			body="Carm. Sc. Mail +1",
			hands="Fall. Fin. Gaunt. +3",
			ring1="Archon Ring",
			ring2="Evanescence Ring",
			back="Niht Mantle",
			waist="Austerity Belt +1",
			legs="Eschite Cuisses",
			feet="Rat. Sollerets +1"})

	-- Enfeebling Magic Set --
	sets.Midcast['Enfeebling Magic'] = set_combine(sets.Midcast.MACC,{
			ring2="Kishar Ring"})

	-- Elemental Magic Set --
	sets.Midcast['Elemental Magic'] = set_combine(sets.Midcast.MAB,{})

	-- Dread Spikes Set --
	sets.Midcast['Dread Spikes'] = {
			ammo="Egoist's Tathlum",
			head="Ratri Sallet +1",
			neck="Dualism Collar +1",
			ear1="Odnowa Earring",
			ear2="Odnowa Earring +1",
			body="Heath. Cuirass +1",
			hands="Rat. Gadlings +1",
			ring1="Moonlight Ring",
			ring2="Moonbeam Ring",
			waist="Eschan Stone",
			back="MoonbeamCape",
			legs="Ratri Cuisses +1",
			feet="Rat. Sollerets +1"}
	
	-- Enhancing Magic --
	sets.Midcast['Enhancing Magic'] = {
			head="Carmine Mask +1",
			neck="Incanter's Torque",
			ear1="Andoaa Earring",
			ear2="Augment. Earring",
			body="Shabti Cuirass",
            ring1="Stikini Ring +1",
            ring2="Stikini Ring +1",
			back="Merciful Cape",
			waist="Olympus Sash",
			legs="Carmine Cuisses +1"}
		
	-- Stoneskin --
	sets.Midcast.Stoneskin =  set_combine(sets.Midcast['Enhancing Magic'],{
			waist="Siegel Sash"})	
	
end

		---------------
		-- Functions --
		---------------
		
		----------------
		-- Pre-Target --
		----------------

function pretarget(spell,action)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
	elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
		cancel_spell()
		send_command('Aggressor')
	elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
		cancel_spell()
		send_command('ThirdEye')
	elseif spell.english == "Meditate" and player.tp > 2900 then -- Cancel Meditate If TP Is Above 2900 --
		cancel_spell()
		add_to_chat(123, spell.name .. ' Canceled: ['..player.tp..' TP]')
	elseif spell.type == "WeaponSkill" and spell.target.distance > target_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
		cancel_spell()
		add_to_chat(123, spell.name..' Canceled: [Out of Range]')
		return
	end
end

		--------------
		-- Pre-Cast --
		--------------

function precast(spell,action)
	if spell.type == "WeaponSkill" then
		if player.status ~= 'Engaged' then
		return
		else
			equipSet = sets.WS
			if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
			end
			if equipSet[AccArray[AccIndex]] then
				equipSet = equipSet[AccArray[AccIndex]]
			end
			if buffactive["Arcane Circle"] then -- Equip Founders Breastplate when you have Arcane Circle on --
				equipSet = set_combine(equipSet,sets.AC_WS)
			end
			if buffactive["Souleater"] then -- Equip Ignominy Burgonet when you have Souleater on --
				equipSet = set_combine(equipSet,sets.SE_WS)
			end
			if elements[spell.name] and elements[spell.name]:contains(world.day_element) then
				equipSet = set_combine(equipSet,elements.equip)
			end
			if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
				equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
			end
			if player.tp > 2750 or (player.equipment.main == 'Anguta' and player.tp > 2250) then
					equipSet = set_combine(equipSet,{ear1="Zwazo Earring"}) -- 3000 TP: Equip Zwazo Earring --
			end
			if world.time <= (7*60) or world.time >= (17*60) then
					equipSet = set_combine(equipSet,{ear2="Lugra Earring +1"}) -- Dusk til Dawn: Equip Lugra Earring +1 --
			end
			if spell.english == "Infernal Scythe" and (world.day == "Darksday" or world.weather_element == "Dark") then
				equipSet = set_combine(equipSet,{waist="Hachirin-no-Obi"})
			end
			equip(equipSet)
		end
	elseif spell.type == "JobAbility" then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
        elseif spell.english == 'Lunge' or spell.english == 'Swipe' then
				equip(sets.JA.Lunge)
elseif spell.type:endswith('Magic') or spell.type == "Ninjutsu" or spell.type == "Trust" then
		if buffactive.silence or spell.target.distance > 16+target_distance then -- Cancel Magic or Ninjutsu If You Are Silenced or Out of Range --
			cancel_spell()
			add_to_chat(123, spell.name..' Canceled: [Silenced or Out of Casting Range]')
			return
		else
			if spell.english == "Stun" or spell.english == "Drain III" or spell.english == "Drain II" or spell.english == "Dread Spikes" then
				if buffactive.Hasso or buffactive.Seigan then -- Cancel Hasso or Seigan When You Use Stun/Drain/Dread Spikes --
					cast_delay(0.2)
					send_command('cancel Hasso,Seigan')
					add_to_chat(155,'Hasso/Seigan Canceled for Magic')
				end
				equip(sets.Precast.FastCast)
			elseif spell.english == 'Utsusemi: Ni' then
				if buffactive['Copy Image (3)'] then
					cancel_spell()
					add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
					return
				else
					equip(sets.Precast.FastCast)
				end
			elseif sets.Precast[spell.skill] then
				equip(sets.Precast[spell.skill])
			else
				equip(sets.Precast.FastCast)
			end
		end
	elseif spell.type == "Waltz" then
		equip(sets.Waltz)
	elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
		cast_delay(0.2)
		send_command('cancel Sneak')
	end
end

		--------------
		-- Mid-Cast --
		--------------

function midcast(spell,action)
				equipSet = {}
        if spell.type:endswith('Magic') or spell.type == 'Ninjutsu' or spell.type == 'Trust' then 
                equipSet = sets.Midcast
		if spell.english:startswith('Absorb') then
			equipSet = equipSet.Absorb 
		elseif spell.english:startswith('Drain') or spell.english:startswith('Aspir') then
			equipSet = equipSet.Drain
		elseif spell.english:startswith('Haste') or spell.english:startswith('Flurry') or spell.english:startswith('Blink') or spell.english:startswith('Regen') or spell.english:startswith('Reraise') then
			equipSet = sets.Haste
		elseif spell.english == "Stoneskin" then
			if buffactive.Stoneskin then
				send_command('@wait 1.7;cancel stoneskin')
			end
			equipSet = equipSet.Stoneskin
		elseif spell.english == "Sneak" then
			if spell.target.name == player.name and buffactive['Sneak'] then
				send_command('cancel sneak')
			end
			equipSet = equipSet.Haste
		elseif spell.english:startswith('Utsusemi') then
			if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then
				send_command('@wait 1.7;cancel Copy Image*')
			end
			equipSet = equipSet.Haste
		elseif spell.english == 'Monomi: Ichi' then
			if buffactive['Sneak'] then
				send_command('@wait 1.7;cancel sneak')
			end
			equipSet = equipSet.Haste
		else
			if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
			end
			if equipSet[spell.skill] then
				equipSet = equipSet[spell.skill]
			end
			if equipSet[spell.type] then
				equipSet = equipSet[spell.type]
			end
		end
		if spell.english:startswith('Cur') and spell.english ~= "Cursna" then
		if (world.day_element == spell.element or world.weather_element == spell.element) then
				equipSet = set_combine(equipSet,{waist="Hachirin-no-Obi"})
				end
				end
		if spell.skill == 'Elemental Magic' or spell.english:startswith('Aspir') or spell.english:startswith('Drain') then
		if (world.day_element == spell.element or world.weather_element == spell.element) then
				equipSet = set_combine(equipSet,{waist="Hachirin-no-Obi"})
				end
				end
		if spell.skill == 'Dark Magic' and buffactive["Nether Void"] then
				equipSet = set_combine(equipSet,{legs="Heath. Flanchard +1"})
				end
		if spell.skill == 'Dark Magic' and buffactive["Dark Seal"] then
				equipSet = set_combine(equipSet,{head="Fall. Burgeonet +3"})
				end
	elseif equipSet[spell.english] then
		equipSet = equipSet[spell.english]
	end
	equip(equipSet)
end

		----------------
		-- After-Cast --
		----------------

function aftercast(spell,action)
	if not spell.interrupted then
		if spell.type == "WeaponSkill" then
			send_command('wait 0.2;gs c TP')
		elseif spell.english == "Sleep II" then -- Sleep II Countdown --
			send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep Countdown --
			send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		end
	end
	status_change(player.status)
end

		-------------------
		-- Status Change --
		-------------------

function status_change(new,old)
	if Armor == 'PDT' or buffactive.Terror or buffactive.Stun or buffactive.Petrification or buffactive.Sleep then
		equip(sets.PDT)
	elseif Armor == 'MDT' then
		equip(sets.MDT)
	elseif Armor == 'Kiting' then
        equip(sets.Kiting)
	elseif new == 'Engaged' then
		equipSet = sets.TP
		if Armor == 'Hybrid' and equipSet["Hybrid"] then
			equipSet = equipSet["Hybrid"]
		end
		if equipSet[WeaponArray[WeaponIndex]] then
			equipSet = equipSet[WeaponArray[WeaponIndex]]
		end
		if equipSet[player.sub_job] then
			equipSet = equipSet[player.sub_job]
		end
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
		if buffactive["Aftermath: Lv.3"] and player.equipment.main == 'Liberator' and equipSet["AM3"] then -- AM3 Set Equip (Mythic Only) --
			equipSet = equipSet["AM3"]
		end
		if buffactive["Last Resort"] and ((buffactive.Haste and buffactive.March == 2) or (buffactive.Embrava and (buffactive.March == 2 or (buffactive.March and buffactive.Haste))) or (buffactive[580] and (buffactive.March or buffactive.Haste or buffactive.Embrava))) and equipSet["HighHaste"] then
			equipSet = equipSet["HighHaste"]
		end
		if buffactive["Samurai Roll"] and equipSet["STP"] and Samurai_Roll == 'ON' then
			equipSet = equipSet["STP"]
		end
		equip(equipSet)
	else
		equipSet = sets.Idle
		if equipSet[IdleArray[IdleIndex]] then
			equipSet = equipSet[IdleArray[IdleIndex]]
		end
		if equipSet[WeaponArray[WeaponIndex]] then
			equipSet = equipSet[WeaponArray[WeaponIndex]]
		end
		if equipSet[player.sub_job] then
			equipSet = equipSet[player.sub_job]
		end
		if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
			equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
		end
		equip(equipSet)
	end
end

		-----------------
        -- Buff Change --
        -----------------

function buff_change(buff,gain,buff_table)
        buff = string.lower(buff)
        if buff_table['id'] == 273 and player.equipment.main == 'Ragnarok' then -- Ragnarok AM3 Timer/Countdown --
        if gain then
				add_to_chat(158,'Ragnarok Aftermath: [ON]')
        else
				add_to_chat(123,'Relic Aftermath: [OFF]')
				end
        elseif buff_table['id'] == 273 and player.equipment.main == 'Apocalypse' then -- Apocalypse AM3 Timer/Countdown --
        if gain then
				add_to_chat(158,'Apocalypse Aftermath: [ON]')
        else
				add_to_chat(123,'Relic Aftermath: [OFF]')
				end
		        elseif buff_table['id'] == 272 and player.equipment.main == 'Liberator' then -- Liberator AM3 Timer/Countdown --
        if gain then
                send_command('timers create "Mythic Aftermath: Lv.3" 180 down')
				add_to_chat(158,'Liberator AM3: [ON]')
                else
                send_command('timers delete "Mythic Aftermath: Lv.3"')
                add_to_chat(123,'Liberator AM3: [OFF]')
                end	
        elseif buff_table['id'] == 272 and player.equipment.main == 'Caladbolg' then -- Caladbolg AM3 Timer/Countdown --
        if gain then
                send_command('timers create "Empy Aftermath: Lv.3" 180 down')
				add_to_chat(158,'Caladbolg AM3: [ON]')
                else
                send_command('timers delete "Empy Aftermath: Lv.3"')
                add_to_chat(123,'Caladbolg AM3: [OFF]')
                end	
        elseif buff_table['id'] == 271 and player.equipment.main == 'Caladbolg' then -- Caladbolg AM2 Timer/Countdown --
        if gain then
                send_command('timers create "Empy Aftermath: Lv.2" 120 down')
				add_to_chat(158,'Caladbolg AM2: [ON]')
        else
                send_command('timers delete "Empy Aftermath: Lv.2"')
                add_to_chat(123,'Caladbolg AM2: [OFF]')
                end		
        elseif buff_table['id'] == 270 and player.equipment.main == 'Caladbolg' then -- Caladbolg AM1 Timer/Countdown --
        if gain then
				add_to_chat(158,'Caladbolg AM1: [ON]')
        else
                send_command('timers delete "Empy Aftermath: Lv.2"')
                add_to_chat(123,'Caladbolg AM1: [OFF]')
                end		
        elseif buff_table['id'] == 272 and player.equipment.main == 'Anguta' then -- Anguta AM3 Timer/Countdown --
        if gain then
                send_command('timers create "Aeonic Aftermath: Lv.3" 180 down')
				add_to_chat(158,'Anguta AM3: [ON]')
                else
                send_command('timers delete "Aeonic Aftermath: Lv.3"')
                add_to_chat(123,'Anguta AM3: [OFF]')
                end	
        elseif buff_table['id'] == 271 and player.equipment.main == 'Anguta' then -- Anguta AM2 Timer/Countdown --
        if gain then
                send_command('timers create "Aeonic Aftermath: Lv.2" 180 down')
				add_to_chat(158,'Anguta AM2: [ON]')
        else
                send_command('timers delete "Aeonic Aftermath: Lv.2"')
                add_to_chat(123,'Anguta AM2: [OFF]')
                end		
        elseif buff_table['id'] == 270 and player.equipment.main == 'Anguta' then -- Anguta AM1 Timer/Countdown --
        if gain then
				add_to_chat(158,'Anguta AM1: [ON]')
        else
                add_to_chat(123,'Anguta AM1: [OFF]')
                end	
		elseif buff_table['id'] == 51 then -- Blood Weapon Timer --
        if gain then
                send_command('timers create "Blood Weapon" 40 down')
        else
                send_command('timers delete "Blood Weapon"')
                end     
        elseif buff_table['id'] == 497 then -- Soul Enslavement Timer --
        if gain then
                send_command('timers create "Soul Enslavement" 30 down')
        else
                send_command('timers delete "Soul Enslavement"')
                end         
        elseif buff_table['id'] == 434 then -- Brew Timer --
        if gain then
                send_command('timers create "Transcendency" 180 down')
        else
                send_command('timers delete "Transcendency"')
                add_to_chat(123,'Transcendency: [OFF]')
                end             
        elseif buff_table['id'] == 1 then -- Weakness Timer --
        if gain then
                send_command('timers create "Weakness" 300 up')
        else
                send_command('timers delete "Weakness"')
				add_to_chat(158,'Weakness: [OFF]')
                end
        elseif buff_table['id'] == 15 then -- Doom Party Chat --
        if gain then
                send_command('input /party Doom')
        else
                send_command('input /party Doom off')
                add_to_chat(158,'Doom: [OFF]')
                end
        elseif buff_table['id'] == 9 then -- Curse Party Chat --
        if gain then
                send_command('input /party Curse')
        else
                add_to_chat(158,'Curse: [OFF]')
                end
        elseif buff_table['id'] == 14 or buff_table['id'] == 17 then -- Charm Party Chat --
        if gain then
                send_command('input /party Charmed')
        else
                send_command('input /party Charm off')
                add_to_chat(158,'Charm: [OFF]')
                end
        elseif buff_table['id'] == 4 then -- Paralysis --
        if gain then
                add_to_chat(123,'Paralyzed!')
        else
                add_to_chat(158,'Paralysis: [OFF]')
                end				
		elseif buff_table['id'] == 64 then -- Last Resort --
        if not gain then 
				add_to_chat(123,'Last Resort: [OFF]')
				end
		elseif buff_table['id'] == 75 then -- Arcane Circle --
        if not gain then 
				add_to_chat(123,'Arcane Circle: [OFF]')
				end
        elseif buff_table['id'] == 63 then -- Souleater --
        if not gain then 
                add_to_chat(123,'Souleater: [OFF]')
                end     
		elseif buff_table['id'] == 346 then -- Diabolic Eye --
        if not gain then 
				add_to_chat(123,'Diabolic Eye: [OFF]')
				end
        elseif buff_table['id'] == 353 then -- Hasso --
        if not gain then 
                add_to_chat(123,'Hasso: [OFF]')
                end 						
		elseif buff_table['id'] == 56 then -- Berserk --
        if not gain then 
				add_to_chat(123,'Berserk: [OFF]')
				end
        elseif buff_table['id'] == 58 then -- Aggressor --
        if not gain then 
                add_to_chat(123,'Aggressor: [OFF]')
                end 
		elseif buff_table['id'] == 68 then -- Warcry --
        if not gain then 
				add_to_chat(123,'Warcry: [OFF]')
				end				
        elseif buff_table['id'] == 33 then -- Haste --
        if not gain then 
                add_to_chat(123,'Haste: [OFF]')
                end    
        elseif buff_table['id'] == 288 then -- EnDark --
        if not gain then 
                add_to_chat(123,'EnDark: [OFF]')
                end   				
		elseif buff_table['id'] == 173 then -- Dread Spikes --
        if not gain then 
                add_to_chat(123,'Dread Spikes: [OFF]')
                end   
		elseif buff_table['id'] == 88 then -- Max HP Boost (Drain II & III) --
        if not gain then 
                add_to_chat(123,'Max HP Boost: [OFF]')
                end   
        elseif buff_table['id'] == 13  then    -- Slow --
        if gain then
                add_to_chat(123,'Slowed!')
                else
                add_to_chat(158,'Slow: [OFF]')
                end 
        elseif buff_table['id'] == 251 then -- Food --
        if not gain then 
                add_to_chat(123,'Food: [OFF]')
                end 
        elseif buff_table['id'] == 28 then -- Terror --
        if not gain then 
                add_to_chat(158,'Terror: [OFF]')
                end 
        elseif buff_table['id'] == 10 then -- Stun --
        if not gain then 
                add_to_chat(158,'Stun: [OFF]')
                end     
        elseif buff_table['id'] == 16 then -- Amnesia --
        if not gain then 
                add_to_chat(158,'Amnesia: [OFF]')
                end               				
        elseif buff_table['id'] == 2 or buff_table['id'] == 19 then -- Sleep --
        if gain then
				send_command('input /party ZZZ')
        else
                add_to_chat(158,'Sleep: [OFF]')
                end         
        end
        if not midaction() then
                status_change(player.status)
        end
end

		-------------------------------------------------------------------------------------
		-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
		-------------------------------------------------------------------------------------

		function self_command(command)
	if command == 'acc' then -- Accuracy Level Toggle --
		AccIndex = (AccIndex % #AccArray) + 1
		status_change(player.status)
		add_to_chat(155,'Accuracy Level: '..AccArray[AccIndex])
	elseif command == 'weapon' then -- Main Weapon Toggle --
		WeaponIndex = (WeaponIndex % #WeaponArray) + 1
		add_to_chat(155,'Main Weapon: '..WeaponArray[WeaponIndex])
		status_change(player.status)
	elseif command == 'update' then -- Auto Update Gear Toggle --
		status_change(player.status)
		add_to_chat(155,'-[Gear Update]-')
		add_to_chat(155,'Weapon: '..WeaponArray[WeaponIndex])
		add_to_chat(155,'Accuracy Level: ' .. AccArray[AccIndex])
		add_to_chat(155,'Idle Set: ' .. IdleArray[IdleIndex])
	elseif command == 'hybrid' then -- Hybrid Toggle --
		if Armor == 'Hybrid' then
			Armor = 'None'
			add_to_chat(123,'Hybrid Set: [Unlocked]')
		else
			Armor = 'Hybrid'
			add_to_chat(158,'Hybrid Set: '..AccArray[AccIndex])
		end
		status_change(player.status)
	elseif command == 'pdt' then -- PDT Toggle --
		if Armor == 'PDT' then
			Armor = 'None'
			add_to_chat(123,'PDT Set: [Unlocked]')
		else
			Armor = 'PDT'
			add_to_chat(158,'PDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'mdt' then -- MDT Toggle --
		if Armor == 'MDT' then
			Armor = 'None'
			add_to_chat(123,'MDT Set: [Unlocked]')
		else
			Armor = 'MDT'
			add_to_chat(158,'MDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'kiting' then -- Kiting Toggle --
        if Armor == 'Kiting' then
            Armor = 'None'
            add_to_chat(123,'Kiting Set: [Unlocked]')
        else
            Armor = 'Kiting'
            add_to_chat(158,'Kiting Set: [Locked]')
        end
        status_change(player.status)
	elseif command == 'distance' then -- Distance Toggle --
		if player.target.distance then
			target_distance = math.floor(player.target.distance*10)/10
			add_to_chat(155,'Distance: '..target_distance)
		else
			add_to_chat(123,'No Target Selected')
		end
	elseif command == 'idle' then -- Idle Toggle --
		IdleIndex = (IdleIndex % #IdleArray) + 1
		status_change(player.status)
		add_to_chat(155,'Idle Set: '..IdleArray[IdleIndex])
	elseif command == 'TP' then
		add_to_chat(155,'TP Return: ['..tostring(player.tp)..']')
	elseif command:match('^SC%d$') then
		send_command('//' .. sc_map[command])
	end
end
	-----------
	-- Misc. --
	-----------
	
	
function find_player_in_alliance(name)
	for i,v in ipairs(alliance) do
		for k,p in ipairs(v) do
			if p.name == name then
				return p
			end
		end
	end
end