function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc')
    state.WeaponskillMode:options('Normal','SomeAcc','MS')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	state.Weapons:options('Chango','Greatsword','Sword','Polearm','Club')

	gear.da_jse_back = {name="Cichol's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10'}}
	gear.crit_jse_back = {name="Cichol's Mantle",augments={'STR+20','Accuracy+20 Attack+20','Crit.hit rate+10'}}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f1 gs c weapons Greatsword')
	send_command('bind @f2 gs c weapons Sword')
	send_command('bind @f3 gs c weapons Polearm')
	send_command('bind @f4 gs c weapons Club')
	send_command('bind @f5 gs c weapons Chango')
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	
    sets.Enmity = {}
	sets.Knockback = {}
	sets.passive.Twilight = {head="Twilight Helm",body="Twilight Mail"}
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = {}
	sets.precast.JA['Warcry'] = {}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {}
	sets.precast.JA['Mighty Strikes'] = {}
	sets.precast.JA["Warrior's Charge"] = {}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk"}
	sets.precast.JA['Retaliation'] = {}
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})
                   
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
                   
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
           
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}
		   
	-- Fast cast sets for spells

	sets.precast.FC = {}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Midcast Sets
	sets.midcast.FastRecast = {}
	
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
                   
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.MS = set_combine(sets.precast.WS, {})


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS['Savage Blade'], {})
    sets.precast.WS['Savage Blade'].MS = set_combine(sets.precast.WS['Savage Blade'], {})

    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Upheaval'].SomeAcc = set_combine(sets.precast.WS['Upheaval'], {})
    sets.precast.WS['Upheaval'].MS = set_combine(sets.precast.WS['Upheaval'], {})
     
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS['Resolution'], {})
    sets.precast.WS['Resolution'].MS = set_combine(sets.precast.WS['Resolution'], {})
	
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Black Halo'].SomeAcc = set_combine(sets.precast.WS['Black Halo'], {})
    sets.precast.WS['Black Halo'].MS = set_combine(sets.precast.WS['Black Halo'], {})
	
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Stardiver'].SomeAcc = set_combine(sets.precast.WS['Stardiver'], {})
    sets.precast.WS['Stardiver'].MS = set_combine(sets.precast.WS['Stardiver'], {})
	
    sets.precast.WS['Raging Rush'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Raging Rush'].SomeAcc = set_combine(sets.precast.WS['Raging Rush'], {})
    sets.precast.WS['Raging Rush'].MS = set_combine(sets.precast.WS['Raging Rush'], {})
	
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Ukko's Fury"].SomeAcc = set_combine(sets.precast.WS["Ukko's Fury"], {})
    sets.precast.WS["Ukko's Fury"].MS = set_combine(sets.precast.WS["Ukko's Fury"], {})
	
    sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["King's Justice"].SomeAcc = set_combine(sets.precast.WS["King's Justice"], {})
    sets.precast.WS["King's Justice"].MS = set_combine(sets.precast.WS["King's Justice"], {})
    

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring",ear2="Moonshade Earring"}
	sets.AccMaxTP = {ear1="Brutal Earring",ear2="Moonshade Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Brutal Earring",ear2="Moonshade Earring"}
	sets.DayMaxTPWSEars = {ear1="Brutal Earring",ear2="Moonshade Earring"}
	sets.AccDayWSEars = {ear1="Brutal Earring",ear2="Moonshade Earring"}
	sets.DayWSEars = {ear1="Brutal Earring",ear2="Moonshade Earring"}

     -- Sets to return to when not performing an action.
           
     -- Resting sets
     sets.resting = {}
           
	-- Idle sets
	sets.idle = {}
		
	sets.idle.Weak = set_combine(sets.idle, {})
		
	sets.idle.Reraise = set_combine(sets.idle, {})
	
	-- Defense sets
	sets.defense.PDT = {}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {})

	sets.defense.MDT = {}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {})
		
	sets.defense.MEVA = {}

	sets.Kiting = {}
	sets.Reraise = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
     
            -- Engaged sets
	sets.engaged = {}
    sets.engaged.SomeAcc = {}

	
    
	
    
	
	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Chango = {main="Chango",
    sub="Utu Grip",}
	sets.weapons.Sword = {main="Naegling",
    sub="Blurred Shield +1",}
	sets.weapons.Club = {main="Beryllium Mace +1",
    sub="Blurred Shield +1",}
	sets.weapons.Polearm = {main="Shining One",
	sub="Utu Grip",}
	sets.weapons.Greatsword = {main="Raetic Algol +1",
    sub="Utu Grip",}
	

end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(3, 3)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 3)
    else
        set_macro_page(5, 3)
    end
end