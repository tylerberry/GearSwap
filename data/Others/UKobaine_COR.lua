
function get_sets()
include('organizer-lib')
	AccIndex = 2
	AccArray = {"LowACC","MidACC","HighACC"} -- 3 Levels Of Accuracy Sets For Shooting/QD/TP/WS. Default ACC Set Is LowACC. The First TP Set Of Your Main Weapon Is LowACC. Add More ACC Sets If Needed Then Create Your New ACC Below --
	IdleIndex = 1
	IdleArray = {'Movement', 'Regen'} -- Default Idle Set Is Movement --
	Armor = 'None'
	define_roll_values()
	warning = false
	Lock_Main = 'OFF' -- Set Default Lock Main Weapon ON or OFF Here --
	AutoGunWS = "Last Stand" -- Set Auto Gun WS Here --
	AutoMode = 'OFF' -- Set Default Auto RA/WS ON or OFF Here --
	Obi = 'ON' -- Turn Default Obi ON or OFF Here --
	ammo_warning_limit = 10 -- Set Ammo Limit Check Here --
	target_distance = 6 -- Set Default Distance Here --
	select_default_macro_book() -- Change Default Macro Book At The End --

	ACC_Shots = S{"Light Shot","Dark Shot"}

	Cure_Spells = {"Cure","Cure II","Cure III","Cure IV"} -- Cure Degradation --
	Curaga_Spells = {"Curaga","Curaga II"} -- Curaga Degradation --
	sc_map = {SC1="CoursersRoll", SC2="DiaII", SC3="LightShot"} -- 3 Additional Binds. Can Change Whatever JA/WS/Spells You Like Here. Remember Not To Use Spaces. --

	-- Idle/Town Sets --
	sets.Idle = {}
	sets.Idle.Regen = { head="Meghanada Visor +2",
                        neck="Wiglen Gorget",
                        ear2="Genmei Earring",
                        ear1="Infused Earring",
                        body="Lanun frac +2",                                                               
                        hands="Meg. Gloves +2",
                        ring1="Chirich Ring +1",
                        ring2="Paguroidea Ring",
                        back="Solemnity Cape",
                        waist="Flume Belt +1",
                        legs="Carmine cuisses +1",
						feet="Meg. Jam. +2"}
						
	sets.Idle.Movement = set_combine(sets.Idle.Regen,{
	                    head="Meghanada Visor +2",
                        neck="Wiglen Gorget",
                        ear2="Genmei Earring",
                        ear1="Infused Earring",
                        body="Meg. Cuirie +2",
                        hands="Meg. Gloves +2",
                        ring1="Chirich Ring +1",
                        ring2="Paguroidea Ring",
                        back="Moonlight cape",
                        waist="Flume Belt +1",
                        legs="Carmine cuisses +1",
                        feet="Meg. Jam. +2"})
						
	sets.Organizer = {
		   main="Naegling",
           sub="Kaja Knife",
           ammo="Chrono Bullet",
		   ammo="Chrono Bullet",
		   ammo="Chrono Bullet",
           ammo="Chrono Bullet"}					
					
	-- QD Sets --
	sets.QD = {
    ammo="Living Bullet",
    head={ name="Herculean Helm", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Weapon skill damage +4%','Mag. Acc.+3','"Mag.Atk.Bns."+14',}},
    neck="Commodore charm +1",
    ear1="Friomisi Earring",
    ear2="Hecate's Earring",
    body="Carmine Scail Mail +1",
    hands="Carmine finger gauntlets +1",
    ring1="Archon Ring",
    ring2="Dingir Ring",
    back="Camulus's Mantle", 
    waist="Hachirin-no-Obi",
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +4%','INT+2','Mag. Acc.+11',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Weapon skill damage +4%','INT+3','Mag. Acc.+9','"Mag.Atk.Bns."+15',}},}
	sets.QD.MidACC = set_combine(sets.QD,{})
sets.QD.HighACC = set_combine(sets.QD.MidACC,{})

	-- PDT/MDT Sets --
	sets.PDT = {}

	sets.MDT = set_combine(sets.PDT,{})

	-- Roll Set --
	sets.Rolls = set_combine(sets.PDT,{
			head="Lanun Tricorne +1",
			range="Compensator",
			hands="Chasseur's Gants +1",
			body="Lanun Frac +3",
			ring1="Luzaf's Ring",
			back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
			legs="Desultor Tassets",
			feet="Lanun Bottes +3",
			neck="Regal Necklace"})

	-- Preshot --
	sets.Preshot = {    
	                    head="Chasseur's tricorne +1",
						neck="Commodore charm +1",
                        hands="Carmine Fin. Ga. +1",
                        waist="Impulse Belt",
						body="Oshosi Vest +1",
						back="Navarch's Mantle",
                        legs="Osh. Trousers +1",
                        feet="Meg. Jam. +2"}

	-- Shooting Base Set --
	sets.Midshot = {}

	-- Death Penalty Sets --
	sets.Midshot['Death Penalty'] = {
	ammo="Chrono Bullet",
    head="Meghanada Visor +2",
    neck="Commodore charm +1",
    ear1="Telos Earring",
    ear2="Enervating Earring",
    body="Laksa. Frac +3",
    hands="Meghanada gloves +2",
    ring1="Ilabrat ring",
    ring2="Regal Ring",
    back="Camulus's Mantle", 
    waist="Yemaya Belt",
	feet="Meghanada jambeaux +2",
    legs="Meghanada chausses +2"}
	sets.Midshot['Death Penalty'].MidACC = set_combine(sets.Midshot['Death Penalty'],{})
	sets.Midshot['Death Penalty'].HighACC = set_combine(sets.Midshot['Death Penalty'].MidACC,{})

	-- Armageddon Sets --
	sets.Midshot.Armageddon = {}
	sets.Midshot.Armageddon.MidACC = set_combine(sets.Midshot.Armageddon,{})
	sets.Midshot.Armageddon.HighACC = set_combine(sets.Midshot.Armageddon.MidACC,{})

	-- Fomalhaut Sets --
	sets.Midshot['Fomalhaut'] = {
    ammo="Chrono Bullet",
    head="Meghanada Visor +2",
    neck="Iskur gorget",
    ear1="Telos Earring",
    ear2="Enervating Earring",
    body="Meg. Cuirie +2",
    hands="Meghanada gloves +2",
    ring1="Ilabrat ring",
    ring2="Regal Ring",
    back="Camulus's Mantle", 
    waist="Yemaya Belt",
	feet="Meghanada jambeaux +2",
    legs="Meghanada chausses +2"}
	
	sets.Midshot['Fomalhaut'].MidACC = set_combine(sets.Midshot['Fomalhaut'],{
    ammo="Chrono Bullet",
    head="Meghanada Visor +2",
    neck="Iskur gorget",
    ear1="Telos Earring",
    ear2="Enervating Earring",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    ring1="Hajduk Ring",
    ring2="Cacoethic Ring +1",
    back="Camulus's Mantle", 
    waist="Yemaya Belt",
    legs="Meghanada chausses +2",
    feet="Meghanada jambeaux +2"})
	
	sets.Midshot['Fomalhaut'].HighACC = set_combine(sets.Midshot['Fomalhaut'].MidACC,{
		ammo="Chrono Bullet",
    head="Meghanada Visor +2",
    neck="Sanctity Necklace",
    ear1="Telos Earring",
    ear2="Digni. Earring",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    back="Camulus's Mantle", 
    waist="Eschan Stone",
    legs="Adhemar Kecks +1",
    feet="Meghanada jambeaux +2"})

	-- Melee Sets --
	sets.Melee = {
	ammo="Chrono Bullet",
    head="Meghanada Visor +2",
    body="Meg. Cuirie +2",
    hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+2','Attack+4',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Meg. Jam. +2",
    neck="Sanctity Necklace",
    back="Camulus's Mantle", 
    waist="Windbuffet Belt +1",
    ear1="Telos Earring",
    right_ear="Digni. Earring",
    ring1="Regal Ring",
    ring2="Epona's Ring",}
	
	sets.Melee.MidACC = set_combine(sets.Melee,{
    ammo="Chrono Bullet",
	head="Meghanada Visor +2",
    body="Meg. Cuirie +2",
    hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+2','Attack+4',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Meg. Jam. +2",
    neck="Combatant's Torque",
	back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}, 
    waist="Reiki Yotai",
    ear1="Telos Earring",
    right_ear="Digni. Earring",
    ring1="Regal Ring",
    ring2="Epona's Ring"})
	
	sets.Melee.HighACC = set_combine(sets.Melee.MidACC,{
	                    ammo="Chrono Bullet",
						head="Meghanada Visor +2",
                        neck="Combatant's Torque",
                        ear1="Telos Earring",
                        ear2="Dignitary's Earring",
                        body="Meg. Cuirie +2",
						hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+2','Attack+4',}},
                        ring1="Regal Ring",
                        ring2="Epona's Ring",
                        back="Camulus's Mantle", 
                        waist="Reiki Yotai",
                        feet="Meg. Jam. +2",
                        legs="Carmine Cuisses +1"})
	
	-- WS Base Set --
	sets.WS = {
	head="Meghanada visor +2",
    body="Laksa. Frac +3",
    hands="Meg. Gloves +2",
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Lanun Bottes +3",
    neck="Fotia gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Ishvara Earring",
    left_ring="Epaminondas's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}, 
	right_ring="Regal Ring"}
	
	-- Aeolian Edge Sets --
	sets.WS["Aeolian Edge"] = {
	ammo="Chrono Bullet",
    head={ name="Herculean Helm", augments={'Accuracy+7','Weapon skill damage +4%','AGI+14','Attack+1',}},
    body={ name="Herculean Vest", augments={'Rng.Acc.+14','Weapon skill damage +3%','STR+13','Accuracy+5','Attack+1',}},
    hands="Meg. Gloves +2",
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Meg. Jam. +2",
    neck="Caro Necklace",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Ishvara Earring",
    left_ring="Rufescent Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	right_ring="Rajas Ring"}
	
	-- Savage BladeSets --
	sets.WS["Savage Blade"] = {
	ammo="Chrono Bullet",
    head={ name="Herculean Helm", augments={'Accuracy+23 Attack+23','Weapon skill damage +4%','DEX+7','Accuracy+6','Attack+10',}},
    body="Laksa. Frac +3",
    hands="Meg. Gloves +2",
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Lanun Bottes +3",
    neck="Caro Necklace",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Ishvara Earring",
    left_ring="Epaminondas's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	right_ring="Regal Ring"}
	
	-- Last Stand Sets --
	sets.WS["Last Stand"] = {
	ammo="Chrono Bullet",
    head={ name="Herculean Helm", augments={'Accuracy+23 Attack+23','Weapon skill damage +4%','DEX+7','Accuracy+6','Attack+10',}},
    body="Laksa. Frac +3",
    hands="Meg. Gloves +2",
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Lanun Bottes +3",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Ishvara Earring",
    left_ring="Epaminondas's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	right_ring="Regal Ring"}
	
	sets.WS["Last Stand"].MidACC = set_combine(sets.WS["Last Stand"],{
	ammo="Chrono Bullet",
    head="Meghanada visor +2",
    body="Laksa. Frac +3",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Lanun Bottes +3",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Ishvara Earring",
    left_ring="Epaminondas's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	right_ring="Regal Ring"})
	
	sets.WS["Last Stand"].HighACC = set_combine(sets.WS["Last Stand"].MidACC,{
	ammo="Chrono Bullet",
    head={ name="Herculean Helm", augments={'Accuracy+23 Attack+23','Weapon skill damage +4%','DEX+7','Accuracy+6','Attack+10',}},
    body="Laksa. Frac +3",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Lanun Bottes +3",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Ishvara Earring",
    left_ring="Epaminondas's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	right_ring="Regal Ring"})

	-- Wildfire Sets --
	sets.WS.Wildfire = {
    ammo="Living Bullet",
    head="Pixie Hairpin +1",
    neck="Commodore charm +1",
    ear1="Friomisi Earring",
    ear2="Moonshade Earring",
    body="Lanun Frac +3",
    hands="Carmine Fin. Ga. +1",
    ring1="Epaminondas's Ring",
    ring2="Archon Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +4%','INT+2','Mag. Acc.+11',}},
    feet="Lanun Bottes +3",
	waist="Hachirin-no-Obi"}
	sets.WS.Wildfire.MidACC = set_combine(sets.WS.Wildfire,{})
	sets.WS.Wildfire.HighACC = set_combine(sets.WS.Wildfire.MidACC,{})

	-- Leaden Salute Sets --
	sets.WS['Leaden Salute'] = {
    ammo="Living Bullet",
    head="Pixie Hairpin +1",
    neck="Commodore charm +1",
    ear1="Friomisi Earring",
    ear2="Moonshade Earring",
    body="Lanun Frac +3",
    hands="Carmine Fin. Ga. +1",
    ring1="Epaminondas's Ring",
    ring2="Dingir Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}, 
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +4%','INT+2','Mag. Acc.+11',}},
    feet="Lanun Bottes +3",
	waist="Hachirin-no-Obi"}
	sets.WS['Leaden Salute'].MidACC = set_combine(sets.WS['Leaden Salute'],{})
	sets.WS['Leaden Salute'].HighACC = set_combine(sets.WS['Leaden Salute'].MidACC,{})

	-- Elemental Obi --
	sets.Obi = {}
	sets.Obi.Lightning = {waist="Hachirin-no-Obi"}
	sets.Obi.Water = {waist="Hachirin-no-Obi"}
	sets.Obi.Fire = {waist="Hachirin-no-Obi"}
	sets.Obi.Ice = {waist="Hachirin-no-Obi"}
	sets.Obi.Wind = {waist="Hachirin-no-Obi"}
	sets.Obi.Earth = {waist="Hachirin-no-Obi"}
	sets.Obi.Light = {waist="Hachirin-no-Obi"}
	sets.Obi.Dark = {waist="Hachirin-no-Obi"}

	-- JA Sets --
	sets.JA = {}
	sets.JA["Random Deal"] = {body="Lanun Frac +1"}
	sets.JA.Fold = {hands="Lanun   +1"}
	sets.JA["Snake Eye"] = {legs="Lanun Trews +1"}
	sets.JA["Wild Card"] = {feet="Lanun Bottes +3"}
	sets.JA["Triple Shot"] = set_combine(sets.Midshot['Death Penalty'] ,{hands="Oshosi Gloves +1",head="Oshosi mask +1",body="Chasseur's Frac +1",legs="Oshosi Trousers +1",feet="Oshosi leggings +1"})
	
	-- Waltz Set --
	sets.Waltz = {}

	sets.Precast = {}
	--Fastcast Set --
	sets.Precast.FastCast = {
	head="Carmine Mask",
    neck="Voltsurge Torque",
    ear1="Loquac. Earring",
    ear2="Etiolation Earring",
    body="Dread Jupon",
    hands="Leyline Gloves",
    ring1="Prolix Ring",
    ring2="Kishar Ring",
    legs="Blood Cuisses",
    feet="Carmine Greaves"}

	sets.Midcast = {}
	-- Magic Haste Set --
	sets.Midcast.Haste = set_combine(sets.PDT,{})

	-- Cure Set --
	sets.Midcast.Cure = {}
end

function pretarget(spell,action)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
	elseif spell.type == "CorsairRoll" and buffactive[spell.english] then -- Change Any Rolls To Double-Up When You Have A Roll Up --
		cancel_spell()
		send_command('doubleup')
	elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
		cancel_spell()
		send_command('ThirdEye')
	elseif spell.english == "Meditate" and player.tp > 2900 then -- Cancel Meditate If TP Is Above 2900 --
		cancel_spell()
		add_to_chat(123, spell.name .. ' Canceled: ' .. player.tp)
	elseif spell.action_type == 'Ranged Attack' then
		if spell.target.distance > 24.9 then -- Cancel Ranged Attack If You Are Out Of Range --
			cancel_spell()
			add_to_chat(123, spell.name..' Canceled: [Out of Range]')
			return
		else
			if AutoMode == 'ON' and not buffactive.amnesia then -- Auto WS/Triple Shot --
				if player.tp >= 1000 then
					cancel_spell()
					autoWS()
				elseif windower.ffxi.get_ability_recasts()[84] < 1 then
					cancel_spell()
					send_command('TripleShot')
				end
			end
		end
	elseif spell.type == 'WeaponSkill' and player.status == 'Engaged' then
		if spell.skill == 'Marksmanship' then
			if spell.target.distance > 16+target_distance then
				cancel_spell()
				add_to_chat(123, spell.name..' Canceled: [Out of Range]')
				return
			end
		else
			if spell.target.distance > target_distance then
				cancel_spell()
				add_to_chat(123, spell.name..' Canceled: [Out of Range]')
				return
			end
		end
	end
end

function precast(spell,action)
	if spell.action_type == 'Ranged Attack' or spell.type == "WeaponSkill" then
		if player.equipment.ammo == "" then -- Cancel Ranged Attack or WS If You Have Animikii Bullet Equipped --
			cancel_spell()
			add_to_chat(123, spell.name .. ' Canceled: [Animikii Bullet Equipped!]')
			return
		else
			local check_ammo
			local check_ammo_count = 1
			if spell.action_type == 'Ranged Attack' then
				check_ammo = player.equipment.ammo
				if player.equipment.ammo == 'empty' or player.inventory[check_ammo].count <= check_ammo_count then
					add_to_chat(123, spell.name..' Canceled: [Out of Ammo]')
					cancel_spell()
					return
				else
					if buffactive["Triple Shot"] then
					   equipSet = set_combine(sets.Midshot['Death Penalty'] ,{hands="Lanun Gants +1",head="Oshosi mask +1",body="Chasseur's Frac +1",legs="Oshosi Trousers +1",feet="Oshosi leggings +1"})
						end
					if player.inventory[check_ammo].count <= ammo_warning_limit and player.inventory[check_ammo].count > 1 and not warning then
						add_to_chat(8, '***** [Low Ammo Warning!] *****')
						warning = true
					elseif player.inventory[check_ammo].count > ammo_warning_limit and warning then
						warning = false
					end
				end
			elseif spell.type == "WeaponSkill" then
				if player.status ~= 'Engaged' then -- Cancel WS If You Are Not Engaged. Can Delete It If You Don't Need It --
					cancel_spell()
					add_to_chat(123,'Unable To Use WeaponSkill: [Disengaged]')
					return
				else
					equipSet = sets.WS
					if equipSet[spell.english] then
						equipSet = equipSet[spell.english]
					end
					if equipSet[AccArray[AccIndex]] then
						equipSet = equipSet[AccArray[AccIndex]]
					end
					if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
						equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
					end
					if spell.english == "Last Stand" and (player.tp > 2990 or buffactive.Sekkanoki) then -- Equip Altdorf's Earring and Wilhelm's Earring When You Have 3000 TP or Sekkanoki For Last Stand --
						equipSet = set_combine(equipSet,{})
					end
					equip(equipSet)
				end
			end
		end
	elseif spell.type == "JobAbility" then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
			if spell.english == "Snake Eye" then -- Auto Double-Up After You Use Snake Eye --
				send_command('@wait 1;input /ja Double-Up <me>')
			end
		end
	elseif spell.type == "CorsairRoll" or spell.english == "Double-Up" then
		equip(sets.Rolls)
		if spell.english == "Tactician's Roll" then -- Change Tactician's Roll Equipment Here --
			equip({body="Chasseur's Frac +1"})
		elseif spell.english == "Caster's Roll" then -- Change Caster's Roll Equipment Here --
			equip({legs="Chas. Culottes"})
		elseif spell.english == "Courser's Roll" then -- Change Courser's Roll Equipment Here --
			equip({feet="Chass. Bottes"})
		elseif spell.english == "Blitzer's Roll" then -- Change Blitzer's Roll Equipment Here --
			equip({head="Chass. Tricorne +1"})
		elseif spell.english == "Allies' Roll" then -- Change Allies' Roll Equipment Here --
			equip({hands="Chasseur's Gants +1"})
		end
	elseif spell.type == "CorsairShot" then
		equipSet = sets.QD
		if ACC_Shots:contains(spell.english) then
			equipSet = sets.QD.HighACC
		else
			if equipSet[AccArray[AccIndex]] then
				equipSet = equipSet[AccArray[AccIndex]]
			end
			if not ACC_Shots:contains(spell.english) and (world.day_element == spell.element or world.weather_element == spell.element) and sets.Obi[spell.element] and Obi == 'ON' then -- Use Obi Toggle To Unlock Elemental Obi --
				equipSet = set_combine(equipSet,sets.Obi[spell.element])
			end
		end
		equip(equipSet)
	elseif spell.action_type == 'Magic' then
		if spell.english == 'Utsusemi: Ni' then
			if buffactive['Copy Image (3)'] then
				cancel_spell()
				add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
				return
			else
				equip(sets.Precast.FastCast)
			end
		else
			equip(sets.Precast.FastCast)
		end
	elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
		cast_delay(0.2)
		send_command('cancel Sneak')
	end
end

function midcast(spell,action)
	if spell.action_type == 'Ranged Attack' then
		equipSet = sets.Midshot
		if equipSet[player.equipment.range] then
			equipSet = equipSet[player.equipment.range]
		end
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
		if buffactive["Triple Shot"] then
			equipSet = set_combine(equipSet,{hands="Lanun Gants +1",head="Oshosi mask +1",body="Chasseur's Frac +1",legs="Oshosi Trousers +1",feet="Oshosi leggings +1"})
		end
		equip(equipSet)
	elseif spell.action_type == 'Magic' then
		if spell.english:startswith('Cur') and spell.english ~= "Cursna" then
			equip(sets.Midcast.Cure)
		elseif spell.english == "Stoneskin" then
			if buffactive.Stoneskin then
				send_command('@wait 2.8;cancel stoneskin')
			end
			equip(sets.Midcast.Stoneskin)
		elseif spell.english == "Sneak" then
			if spell.target.name == player.name and buffactive['Sneak'] then
				send_command('cancel sneak')
			end
			equip(sets.Midcast.Haste)
		elseif spell.english:startswith('Utsusemi') then
			if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then
				send_command('@wait 1.7;cancel Copy Image*')
			end
			equip(sets.Midcast.Haste)
		elseif spell.english == 'Monomi: Ichi' then
			if buffactive['Sneak'] then
				send_command('@wait 1.7;cancel sneak')
			end
			equip(sets.Midcast.Haste)
		else
			equip(sets.Midcast.Haste)
		end
	end
end

function aftercast(spell,action)
	if spell.action_type == 'Ranged Attack' and AutoMode == 'ON' then
		autoRA()
	else
		status_change(player.status)
	end
	if not spell.interrupted then
		if spell.type == "WeaponSkill" then
			send_command('wait 0.2;gs c TP')
		elseif spell.type == 'CorsairRoll' then
			display_roll_info(spell)
		elseif spell.english == 'Light Shot' then -- Sleep Countdown --
			send_command('wait 50;input /echo '..spell.name..' Effect: [WEARING OFF IN 10 SEC.];wait 10;input /echo '..spell.name..' Effect: [OFF]')
		end
	end
end

function status_change(new,old)
	if Armor == 'PDT' then
		equip(sets.PDT)
	elseif Armor == 'MDT' then
		equip(sets.MDT)
	elseif new == 'Engaged' then
		equipSet = sets.Melee
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
		if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
			equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
		end
		if world.area:endswith('Adoulin') then
			equipSet = set_combine(equipSet,{body="Councilor's Garb",legs="Carmine Cuisses +1"})
		end
		if TH == 'ON' then -- Use TH Toggle To Lock Full TH Set --
                        equipSet = set_combine(equipSet,sets.TP.TH)
        end
		equip(equipSet)
	elseif new == 'Idle' then
		equip(sets.Idle[IdleArray[IdleIndex]])
	elseif new == 'Resting' then
		equip(sets.Resting)
	end
end

function buff_change(buff,gain)
	buff = string.lower(buff)
	if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
		if gain then
			send_command('timers create "Aftermath: Lv.3" 180 down;wait 150;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 15;input /echo Aftermath: Lv.3 [WEARING OFF IN 15 SEC.];wait 5;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
		else
			send_command('timers delete "Aftermath: Lv.3"')
			add_to_chat(123,'AM3: [OFF]')
		end
	elseif buff == 'weakness' then -- Weakness Timer --
		if gain then
			send_command('timers create "Weakness" 300 up')
		else
			send_command('timers delete "Weakness"')
		end
	end
	if not midaction() then
		status_change(player.status)
	end
end

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
	if command == 'C1' then -- Accuracy Level Toggle --
		AccIndex = (AccIndex % #AccArray) + 1
		status_change(player.status)
		add_to_chat(158,'Accuracy Level: ' .. AccArray[AccIndex])
	elseif command == 'C5' then -- Auto Update Gear Toggle --
		status_change(player.status)
		add_to_chat(158,'Auto Update Gear')
	elseif command == 'C3' then -- Obi Toggle --
		if Obi == 'ON' then
			Obi = 'OFF'
			add_to_chat(123,'Obi: [OFF]')
		else
			Obi = 'ON'
			add_to_chat(158,'Obi: [ON]')
		end
		status_change(player.status)
	elseif command == 'C7' then -- PDT Toggle --
		if Armor == 'PDT' then
			Armor = 'None'
			add_to_chat(123,'PDT Set: [Unlocked]')
		else
			Armor = 'PDT'
			add_to_chat(158,'PDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C15' then -- MDT Toggle --
		if Armor == 'MDT' then
			Armor = 'None'
			add_to_chat(123,'MDT Set: [Unlocked]')
		else
			Armor = 'MDT'
			add_to_chat(158,'MDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C17' then -- Lock Main Weapon Toggle --
		if Lock_Main == 'ON' then
			Lock_Main = 'OFF'
			add_to_chat(123,'Main Weapon: [Unlocked]')
		else
			Lock_Main = 'ON'
			add_to_chat(158,'Main Weapon: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C19' then -- Full Capacity TH Set Toggle --
                if TH == 'ON' then
                        TH = 'OFF'
                        add_to_chat(123,'Full Capacity+TH Set: [Unlocked]')
                else
                        TH = 'ON'
                        add_to_chat(158,'Full Capacity+TH Set: [Locked]')
                end
         status_change(player.status)	
	elseif command == 'C8' then -- Distance Toggle --
		if player.target.distance then
			target_distance = math.floor(player.target.distance*10)/10
			add_to_chat(158,'Distance: '..target_distance)
		else
			add_to_chat(123,'No Target Selected')
		end
	elseif command == 'C6' then -- Idle Toggle --
		IdleIndex = (IdleIndex % #IdleArray) + 1
		status_change(player.status)
		add_to_chat(158,'Idle Set: ' .. IdleArray[IdleIndex])
	elseif command == 'C2' then -- Auto RA/WS Toggle. *Don't Rely On This. It Isn't As Fast As Shooting Manually. It Is Mainly For AFK or When You Dualbox* --
		if AutoMode == 'ON' then
			AutoMode = 'OFF'
			add_to_chat(123,'Auto Mode: [OFF]')
		else
			AutoMode = 'ON'
			add_to_chat(158,'Auto Mode: [ON]')
		end
	elseif command == 'TP' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	elseif command:match('^SC%d$') then
		send_command('//' .. sc_map[command])
	end
end

function autoRA() -- Make Auto RA Delay Adjustment Here --
	local delay = '2.2'
	if spell.type == "WeaponSkill" then
		delay = '2.25'
	else
		if buffactive["Courser's Roll"] then
			delay = '0.7'
		elseif buffactive[581] then -- Flurry II --
			delay = '0.5'
		else
			delay = '1.05'
		end
	end
	send_command('@wait '..delay..'; input /ra <t>')
end

function autoWS()
	send_command('input /ws "'..AutoGunWS..'" <t>')
end

function define_roll_values()
	rolls = {
		CorsairsRoll	= {lucky=5, unlucky=9, bonus="Experience Points"},
		NinjaRoll		= {lucky=4, unlucky=8, bonus="Evasion"},
		HuntersRoll		= {lucky=4, unlucky=8, bonus="Accuracy"},
		ChaosRoll		= {lucky=4, unlucky=8, bonus="Attack"},
		MagussRoll		= {lucky=2, unlucky=6, bonus="Magic Defense"},
		HealersRoll		= {lucky=3, unlucky=7, bonus="Cure Potency Received"},
		PuppetRoll		= {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
		ChoralRoll		= {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
		MonksRoll		= {lucky=3, unlucky=7, bonus="Subtle Blow"},
		BeastRoll		= {lucky=4, unlucky=8, bonus="Pet Attack"},
		SamuraiRoll		= {lucky=2, unlucky=6, bonus="Store TP"},
		EvokersRoll		= {lucky=5, unlucky=9, bonus="Refresh"},
		RoguesRoll		= {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
		WarlocksRoll	= {lucky=4, unlucky=8, bonus="Magic Accuracy"},
		FightersRoll	= {lucky=5, unlucky=9, bonus="Double Attack Rate"},
		DrachenRoll		= {lucky=3, unlucky=7, bonus="Pet Accuracy"},
		GallantsRoll	= {lucky=3, unlucky=7, bonus="Defense"},
		WizardsRoll		= {lucky=5, unlucky=9, bonus="Magic Attack"},
		DancersRoll		= {lucky=3, unlucky=7, bonus="Regen"},
		ScholarsRoll	= {lucky=2, unlucky=6, bonus="Conserve MP"},
		BoltersRoll		= {lucky=3, unlucky=9, bonus="Movement Speed"},
		CastersRoll		= {lucky=2, unlucky=7, bonus="Fast Cast"},
		CoursersRoll	= {lucky=3, unlucky=9, bonus="Snapshot"},
		BlitzersRoll	= {lucky=4, unlucky=9, bonus="Attack Delay"},
		TacticiansRoll	= {lucky=5, unlucky=8, bonus="Regain"},
		AlliesRoll		= {lucky=3, unlucky=10, bonus="Skillchain Damage"},
		MisersRoll		= {lucky=5, unlucky=7, bonus="Save TP"},
		CompanionsRoll	= {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
		AvengersRoll	= {lucky=4, unlucky=8, bonus="Counter Rate"},
		RuneistsRoll	= {lucky=4,	unlucky=8, bonus="Magic Evasion"},
		NaturalistsRoll = {lucky=3, unlucky=7, bonus="Enhancing Duration"}
		}
end

function display_roll_info(spell)
	rollinfo = rolls[(string.gsub((string.gsub(spell.english, "%'+", "")), "%s+", ""))]
	if rollinfo then
		add_to_chat(158, spell.english..' = '..rollinfo.bonus..'. Lucky Roll is '..
		tostring(rollinfo.lucky)..', Unlucky Roll is '..tostring(rollinfo.unlucky)..'.')
	end
end

function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end

function set_macro_page(set,book)
	if not tonumber(set) then
		add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
		return
	end
	if set < 1 or set > 10 then
		add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
		return
	end

	if book then
		if not tonumber(book) then
			add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
			return
		end
		if book < 1 or book > 20 then
			add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
			return
		end
		send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
	else
		send_command('@input /macro set '..tostring(set))
	end
end

function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'COR' then
		set_macro_page(2, 15)
	elseif player.sub_job == 'WHM' then
		set_macro_page(2, 8)
	elseif player.sub_job == 'DNC' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 8)
	elseif player.sub_job == 'RDM' then
		set_macro_page(2, 8)
	elseif player.sub_job == 'WAR' then
		set_macro_page(2, 8)
	elseif player.sub_job == 'DRG' then
		set_macro_page(2, 8)
	else
		set_macro_page(2, 8)
	end
end