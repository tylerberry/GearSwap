function get_sets()

	send_command('bind f9 gs c toggle MTP set')
	send_command('bind f10 gs c toggle Idle set')
	send_command('bind f11 gs c toggle Shoha set')
	send_command('bind f12 gs c toggle Fudo set')
	send_command('bind ^f11 gs c toggle Apex set')
	send_command('bind ^f12 gs c toggle Kaiten set')
	
	function file_unload()
      
 
        send_command('unbind ^f9')
        send_command('unbind ^f10')
		send_command('unbind ^f11')
		send_command('unbind ^f12')
       
        send_command('unbind !f9')
        send_command('unbind !f10')
		send_command('unbind !f11')
        send_command('unbind !f12')
 
        send_command('unbind f9')
        send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')
 
       
 
	end
	

		--Idle Sets--
		sets.Idle = {}		

		sets.Idle.index = {'Standard', 'Town'}
		
		Idle_ind = 1
		
		sets.Idle.Standard = {
      ammo="Ginsen",
      head="Wakido Kabuto +2",
      body="Dagon Breastplate",
      hands="Wakido Kote +2",
      legs="Tatenashi Haidate +1",
      feet="Flamma Gambieras +2",
      neck="Wiglen Gorget",
      waist="Ioskeha Belt +1",
      left_ear="Telos Earring",
      right_ear="Genmei Earring",
      left_ring="Chirich Ring +1",
      right_ring="Paguroidea Ring",
      back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}
	
		
				
				
				
				
		--TP Sets--
		sets.TP = {}

		sets.TP.index = {'Standard', 'Accuracy', 'DT'}
		--1=Standard, 2=AccuracyLite, 3=AccuracyFull, 4=DT, 5=DTAccuracy--
		TP_ind = 1
	
		sets.TP.Standard = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Dagon Breastplate",
    hands="Wakido kote +2",
    legs="Tatenashi Haidate +1",
    feet="Flamma Gambieras +2",
    neck="Clotharius Torque",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Dignitary's Earring",
    left_ring="Chirich Ring +1",
    right_ring="Niqmaddu Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','Mag. Acc.+4','DEF+6',}},}
							
		sets.TP.Accuracy = { ammo="Ginsen",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands="Wakido Kote +2",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-ate +1",
    neck="Samurai's Nodowa +2",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
							
		sets.TP.DT = { 
		ammo="Staunch Tathlum +1",  -- 3% DT
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands="Wakido Kote +2",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-ate +1",
    neck="Loricate Torque +1", -- 6% DT
    waist="Flume Belt +1", -- 4% PDT
    left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Defending Ring", -- 10% DT
    right_ring="Gelatinous Ring +1", -- 7% PDT
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
				  
		
							  
							  
		sets.RangedTP = {}

		sets.RangedTP.index = {'Standard', 'AccuracyLite', 'AccuracyFull'}
		--1=Standard, 2=AccuracyLite, 3=AccuracyFull--
		TP_ind = 1
	
		sets.RangedTP.Standard = {range="Cibitshavore",ammo="Tulfaire arrow",
			  	          head="Otomi helm",neck="Iqabi necklace", ear1="Steelflash earring", ear2="Bladeborn earring", 			          
						  body="Sakonji domaru +1",hands="Umuthi gloves",ring1="K'ayres ring",ring2="Rajas ring",
				          back="Takaha mantle",waist="Cetl belt",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
							
		sets.RangedTP.AccuracyLite = {range="Cibitshavore",ammo="Tulfaire arrow",
					      head="Otomi helm",neck="Asperity necklace", ear1="Steelflash earring", ear2="Bladeborn earring",				      
						  body="Sakonji domaru +1",hands="Otronif gloves",ring1="K'ayres ring",ring2="Rajas ring",
					      back="Takaha mantle",waist="Dynamic belt +1",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
	
		sets.RangedTP.AccuracyFull = {range="Cibitshavore",ammo="Tulfaire arrow",
					      head="Yaoyotl helm",neck="Iqabi necklace", ear1="Steelflash earring", ear2="Bladeborn earring", 				      
						  body="Sakonji domaru +1",hands="Umuthi gloves",ring1="K'ayres ring",ring2="Rajas ring",
					      back="Takaha mantle",waist="Dynamic belt +1",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
							  
							  
							  
							  
							  
							  
		--Weaponskill Sets--
		sets.WS = {}
	
		sets.Shoha = {}
	
		sets.Shoha.index = {'Attack','Accuracy'}
		Shoha_ind = 1
	
		sets.Shoha.Attack = {
      ammo="Knobkierrie",
      head={ name="Valorous Mask", augments={'Attack+18','Weapon Skill Acc.+10','STR+14','Accuracy+12',}},
      body="Valorous Mail", augments={'Pet: Mag. Acc.+3','Crit.hit rate+3','Weapon skill damage +5%','Accuracy+15 Attack+15",}},
      hands="Valorous Mitts", augments={'Weapon skill damage +4%','CHR+8','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1",
      legs={ name="Valor. Hose", augments={'Weapon skill damage +5%','Accuracy+5',}},
      feet={ name="Valorous Greaves", augments={'STR+14','Accuracy+6','Weapon skill damage +6%','Accuracy+3 Attack+3','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Ishvara Earring",
      right_ear="Dignitary Earring",
      left_ring="Epaminondas's Ring",
      right_ring="Niqmaddu Ring",
      back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }

								  
		sets.Shoha.Accuracy = {
     ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body="Sakonji Domaru +3",
    hands="Valorous Mitts", augments={'Weapon skill damage +4%','CHR+8','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1",
    legs="Wakido Haidate +3",
    feet="Flam. Gambieras +2",
    neck="Samurai's Nodowa +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
							 
		sets.Fudo = {}
	
		sets.Fudo.index = {'Attack','Accuracy'}
		Fudo_ind = 1
	
		sets.Fudo.Attack = {
      ammo="Knobkierrie",
      head={ name="Valorous Mask", augments={'Attack+18','Weapon Skill Acc.+10','STR+14','Accuracy+12',}},
      body="Ken. Samue +1",
      hands="Valorous Mitts", augments={'Weapon skill damage +4%','CHR+8','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1",
      legs={ name="Valor. Hose", augments={'Weapon skill damage +5%','Accuracy+5',}},
      feet={ name="Valorous Greaves", augments={'STR+14','Accuracy+6','Weapon skill damage +6%','Accuracy+3 Attack+3','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
      neck="Sam. Nodowa +2",
      waist="Fotia Belt",
      left_ear="Ishvara Earring",
      right_ear="Moonshade Earring",
      left_ring="Epaminondas's Ring",
      right_ring="Regal ring",
      back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }

							   
		sets.Fudo.Accuracy = {
   ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Attack+18','Weapon Skill Acc.+10','STR+14','Accuracy+12',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Valorous Mitts", augments={'Weapon skill damage +4%','CHR+8','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1",
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'STR+14','Accuracy+6','Weapon skill damage +6%','Accuracy+3 Attack+3','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
    neck="Sam. Nodowa +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Telos Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

    sets.Kasha = {
      ammo="Knobkierrie",
      head={ name="Valorous Mask", augments={'Attack+18','Weapon Skill Acc.+10','STR+14','Accuracy+12',}},
      body="Ken. Samue +1",
      hands="Valorous Mitts", augments={'Weapon skill damage +4%','CHR+8','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1",
      legs={ name="Valor. Hose", augments={'Weapon skill damage +5%','Accuracy+5',}},
      feet={ name="Valorous Greaves", augments={'STR+14','Accuracy+6','Weapon skill damage +6%','Accuracy+3 Attack+3','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Ishvara Earring",
      right_ear="Telos Earring",
      left_ring="Epaminondas's Ring",
      right_ring="Regal Ring",
      back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
  }
							  
		sets.Kaiten = {}
		
		sets.Kaiten.index = {'Attack','Accuracy'}
		Kaiten_ind = 1
	
		sets.Kaiten.Attack = {
   ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Accuracy+17','Weapon skill damage +4%','Attack+2',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+6 Attack+6','Weapon skill damage +4%','Accuracy+15','Attack+8',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','Weapon skill damage +4%',}},
    neck="Sam. Nodowa +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
							   
		sets.Kaiten.Accuracy = {
   ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Accuracy+17','Weapon skill damage +4%','Attack+2',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+6 Attack+6','Weapon skill damage +4%','Accuracy+15','Attack+8',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+20 Attack+20','Weapon skill damage +4%',}},
    neck="Sam. Nodowa +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}		
		sets.Ageha = {
		ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Flam. Manopolas +1",
    legs="Flamma Dirs +1",
    feet="Flam. Gambieras +2",
    neck="Sam. Nodowa +1",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}
		
		sets.Jinpu = {
    main="Masamune",
    sub="Utu Grip",
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Attack+18','Weapon Skill Acc.+10','STR+14','Accuracy+12',}},
    body="Sakonji Domaru +3",
    hands={ name="Valorous Mitts", augments={'Weapon skill damage +3%','STR+9','Accuracy+10','Attack+5',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Accuracy+24','Weapon skill damage +5%',}},
    neck="Samurai's Nodowa +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Regal Ring",
right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

		sets.Apex = {}
	
		sets.Apex.index = {'Attack','Accuracy', 'Accuracy Max'}
		Apex_ind = 1
	
		sets.Apex.Attack = {range="Cibitshavore",ammo="Tulfaire arrow",
							head="Sakonji kabuto +1",neck="Light gorget",ear1="Matanki earring",ear2="Moonshade earring",
							body="Phorcys korazin",hands="Unkai kote +2",ring1="Stormsoul ring",ring2="Auster's ring",
							back="Buquwik cape",waist="Light belt",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
							
		sets.Apex.Accuracy = {range="Cibitshavore",ammo="Tulfaire arrow",
						  	  head="Sakonji kabuto +1",neck="Light gorget",ear1="Matanki earring",ear2="Moonshade earring",
						 	  body="Phorcys korazin",hands="Buremte gloves",ring1="Hajduk ring",ring2="Longshot ring",
							  back="Thall Mantle",waist="Light belt",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
							   
		sets.Apex.MaxAccuracy = {range="Cibitshavore",ammo="Tulfaire arrow",
					 	  	     head="Sakonji kabuto +1",neck="Light gorget",ear1="Matanki earring",ear2="Clearview earring",
						 	     body="Aetosaur Jerkin",hands="Buremte gloves",ring1="Hajduk ring",ring2="Longshot ring",
							     back="Thall Mantle",waist="Light belt",legs="Aeto. Trousers",feet="Waki. Sune-Ate +1"}

        sets.Namas = {}
	
		sets.Namas.index = {'Attack','Accuracy'}
		Namas_ind = 1
	
		sets.Namas.Attack = {range="Cibitshavore",ammo="Tulfaire arrow",
							 head="Otomi helm",neck="Flame gorget",ear1="Brutal earring",ear2="Moonshade earring",
							 body="Phorcys korazin",hands="Phorcys mitts",ring1="Vulcan's ring",ring2="Rajas ring",
							 back="Buquwik cape",waist="Light belt",legs="Wakido haidate",feet="Gor. sollerets +1"}
							   
		sets.Namas.Accuracy = {range="Cibitshavore",ammo="Tulfaire arrow",
							   head="Yaoyotl helm",neck="Flame gorget",ear1="Brutal earring",ear2="Moonshade earring",
							   body="Phorcys korazin",hands="Phorcys mitts",ring1="Vulcan's ring",ring2="Rajas ring",
							   back="Buquwik cape",waist="Light belt",legs="Wakido haidate",feet="Gor. sollerets +1"}								
									  
									  
									  
									  
									  
		--Utility Sets--
		sets.Utility = {}
		
		sets.Utility.PDT = {}
						
		sets.Utility.MDT = {}
							
				
				
				
				
				
		--Job Ability Sets--
		sets.JA = {}
	
		sets.JA.Meditate = {hands="Sakonji Kote +1", head="Wakido Kabuto +1", back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},}
							
		sets.JA.Hasso = {hands="Wakido Kote +3",}
end



		
		
		
function precast(spell)
	if spell.english == 'Meditate' then
		equip(sets.JA.Meditate)
	end
	
	if spell.english == 'Hasso' then
		equip(sets.JA.Hasso)
	end
		
	if spell.english == 'Tachi: Shoha' then
		equip(sets.Shoha[sets.Shoha.index[Shoha_ind]])
	end
	
	if spell.english == 'Tachi: Fudo' or spell.english == 'Tachi: Rana' or spell.english == 'Tachi: Gekko' or spell.english == 'Tachi: Yukikaze' or spell.english == 'Tachi: Kasha' or spell.english == 'Impulse Drive' then
        equip(sets.Fudo[sets.Fudo.index[Fudo_ind]])
    end
 
    if spell.english == 'Tachi: Kaiten' then
        equip(sets.Kaiten[sets.Kaiten.index[Kaiten_ind]])
    end
	
	 if spell.english == 'Tachi: Jinpu' then
        equip(sets.Jinpu)
    end
	
	if spell.english == 'Tachi: Ageha' then
        equip(sets.Ageha)
    end
	
	if spell.english == 'Apex Arrow' then
		equip(sets.Apex[sets.Apex.index[Apex_ind]])
	end

    if spell.english == 'Namas Arrow' then
		equip(sets.Namas[sets.Namas.index[Namas_ind]])
	end

    if spell.name == "Ranged" then
        equip(sets.Utility.Snapshot)
    end
	
	if spell.name == "Hasso" then
		equip(sets.TP[sets.TP.index[TP_ind]])
	end
end		

function midcast(spell,act)
    if spell.name == "Ranged" then
        equip(sets.RangedTP[sets.RangedTP.index[RangedTP_ind]])
    end
end

function aftercast(spell,act)
	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end

function status_change(new,old)
	if new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end

function self_command(command)
	if command == 'toggle MTP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'toggle RTP set' then
		RangedTP_ind = RangedTP_ind +1
		if RangedTP_ind > #sets.RangedTP.index then RangedTP_ind = 1 end
		send_command('@input /echo <----- Ranged TP Set changed to '..sets.RangedTP.index[RangedTP_ind]..' ----->')
		equip(sets.RangedTP[sets.RangedTP.index[RangedTP_ind]])
	elseif command == 'toggle Idle set' then
		Idle_ind = Idle_ind +1
		if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
		send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	elseif command == 'toggle Shoha set' then
		Shoha_ind = Shoha_ind +1
		if Shoha_ind > #sets.Shoha.index then Shoha_ind = 1 end
		send_command('@input /echo <----- Tachi: Shoha Set changed to '..sets.Shoha.index[Shoha_ind]..' ----->')
    elseif command == 'toggle Fudo set' then
		Fudo_ind = Fudo_ind +1
		if Fudo_ind > #sets.Fudo.index then Fudo_ind = 1 end
		send_command('@input /echo <----- Tachi: Fudo Set changed to '..sets.Fudo.index[Fudo_ind]..' ----->')
    elseif command == 'toggle Kaiten set' then
		Kaiten_ind = Kaiten_ind +1
		if Kaiten_ind > #sets.Kaiten.index then Kaiten_ind = 1 end
		send_command('@input /echo <----- Tachi: Kaiten Set changed to '..sets.Kaiten.index[Kaiten_ind]..' ----->')
    elseif command == 'toggle Apex set' then
		Apex_ind = Apex_ind +1
		if Apex_ind > #sets.Apex.index then Apex_ind = 1 end
		send_command('@input /echo <----- Apex Arrow Set changed to '..sets.Apex.index[Apex_ind]..' ----->')
    elseif command == 'toggle Namas set' then
		Namas_ind = Namas_ind +1
		if Namas_ind > #sets.Namas.index then Namas_ind = 1 end
		send_command('@input /echo <----- Namas Arrow Set changed to '..sets.Namas.index[Namas_ind]..' ----->')
	elseif command == 'equip TP set' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == 'equip Idle set' then
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end

function select_default_macro_book()
  -- Default macro set/book
if player.sub_job == 'WAR' then
  set_macro_page(1, 7)
elseif player.sub_job == 'DNC' then
  set_macro_page(1, 7)
else
  set_macro_page(1, 7)
end
end
