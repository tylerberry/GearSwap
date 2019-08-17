-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
	include('Mote-TreasureHunter.lua')
    include('Tasya-Lib.lua')
    
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Sange = buffactive.sange or false
    state.Buff.Innin = buffactive.innin or false

    state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
    state.UseRune = M(false, 'Use Rune')
    
    event_list = L{}

    LugraWSList = S{'Blade: Shun', 'Blade: Ku', 'Blade: Jin'}
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    
    wsList = S{'Blade: Hi'}

    state.warned = M(false)
    options.ammo_warning_limit = 25
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
    
    update_combat_form()
    select_ammo()
end

function job_file_unload()
    event_list:map(windower.unregister_event)
    event_list:clear()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    --state.CastingMode:options('Normal')
    --state.IdleMode:options('Normal')
	--state.RestingMode:options('Normal')
    --state.PhysicalDefenseMode:options('PDT')
    --state.MagicalDefenseMode:options('MDT')
    
    state.TreasureMode:set('Tag')
    
    event_list:append(windower.register_event('mp change',tas_select_tp_ring))

    select_default_macro_book()
end

-- Load job-specific keybinds.
function user_binds_on_load()
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c cycle HasteMode')
    send_command('bind @[ gs c cycle Runes')
    send_command('bind ^] gs c toggle UseRune')
end

-- Unload job-specific keybinds.
function user_binds_on_unload()
    send_command('unbind ^=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind !=')
    send_command('unbind @f9')
    send_command('unbind @[')
    send_command('unbind ^]')
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()

end

-- Define sets and vars used by this job file.
-- visualized at http://www.ffxiah.com/node/194 (not currently up to date 10/29/2015)
-- Happo
-- Hachiya
-- sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.HybridMode][classes.CustomMeleeGroups (any number)]

-- Ninjutsu tips
-- To stick Slow (Hojo) lower earth resist with Raiton: Ni
-- To stick poison (Dokumori) or Attack down (Aisha) lower resist with Katon: Ni
-- To stick paralyze (Jubaku) lower resistence with Huton: Ni

function init_gear_sets()
	
    --==================================--
	-- Augmented gear and base sets
    --==================================--

    include('Tasya-Gear.lua')
    tas_shared_augmented_gear()
    
    gear.default.tp_ring = "Petrov Ring"
    
    gear.RegularAmmo = "Happo Shuriken +1"
    gear.SangeAmmo = "Happo Shuriken"
    
    --==================================--
	-- Idle
    --==================================--

    sets.idle.Field = {
        ammo="Vanir Battery",
        head="Rao Kabuto",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Hizamaru Haramaki +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2="Sheltered Ring",
    	back="Shadow Mantle",waist="Flume Belt +1",legs=gear.HerculeanTrousers.STR,feet="Amm Greaves"}
    
    sets.idle.Town = sets.idle.Field
    
    sets.idle.Weak = sets.idle.Field
    
    --==================================--
	-- Defense
    --==================================--
    
    sets.defense.PDT = {
        neck="Loricate Torque +1",
        body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
    	back="Iximulew Cape",waist="Flume Belt +1",legs=gear.HerculeanTrousers.STR,feet="Amm Greaves"}
    
    sets.defense.MDT = set_combine(sets.defense.PDT, {
        head="Dampening Tam",neck="Loricate Torque +1",back="Engulfer Cape +1"})

    --==================================--
	-- Engaged
    --==================================--

    sets.resting = set_combine(sets.defense.PDT, {
        head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Dawn Earring",
        body="Hizamaru Haramaki +1",ring1="Paguroidea Ring",ring2="Sheltered Ring"})
    
    --==================================--
	-- Engaged
    --==================================--
    
    sets.engaged = {
        ammo=gear.RegularAmmo,
        head=gear.AdhemarBonnet.A,neck="Asperity Necklace",ear1="Eabani Earring",ear2="Suppanomimi",
        body=gear.AdhemarJacket.B,hands=gear.HerculeanGloves.TA,ring1=gear.TPRing,ring2="Epona's Ring",
        back="Bleating Mantle",waist="Patentia Sash",legs=gear.TaeonTights.TA,feet=gear.TaeonBoots.TA}

    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        neck="Combatant's Torque",ring2="Ramuh Ring +1",back="Grounded Mantle +1",waist="Olseni Belt"})
    
    sets.engaged.Innin = set_combine(sets.engaged, {
        head="Hattori Zukin +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",waist="Windbuffet Belt +1"})
    
    sets.engaged.Innin.Acc = sets.engaged.Acc

    -- Defensive sets
    
    sets.engaged.PDT = set_combine(sets.engaged, {
        head="Lithelimb Cap",neck="Agitator's Collar",
        body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",
    	back="Solemnity Cape",legs="Otronif Brais +1",feet="Amm Greaves"})
        
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        head="Lithelimb Cap",neck="Agitator's Collar",
        body="Emet Harness +1",hands="Ryuo Tekko",ring1="Patricius Ring",ring2="Defending Ring",
        feet="Loyalist Sabatons"})

    sets.engaged.Innin.PDT = set_combine(sets.engaged.PDT, {head="Hattori Zukin +1"})
    sets.engaged.Innin.Acc.PDT = set_combine(sets.engaged.Acc.PDT, {head="Hattori Zukin +1"})
    
    --==================================--
	-- Engaged - Dual Wield
    --==================================--

    -- Ninja has Dual Wield V, which is DW+35.
    --
    -- Reasonable Dual Wield gear options:
    --
    -- Aizushintogo: +5
    --
    -- Suppanomimi: +5
    -- Eabani Earring: +4
    -- Green Delve earring set: +7
    --
    -- Hattori Zukin: +6
    -- Hattori Zukin +1: +7
    -- Ptica Headgear: +5
    -- Ryuo Somen: +8
    -- Ryuo Somen +1: +9
    --
    -- Adhemar Jacket: +5
    -- Adhemar Jacket +1: +6
    -- Hachiya Chainmail: +7
    -- Hachiya Chainmail +1: +8
    -- Mochizuki Chainmail: +6
    -- Mochizuki Chainmail +1: +7
    --
    -- Floral Gauntlets: +5
    --
    -- Haverton Ring: +5
    --
    -- Andartia's Mantle (DW augment): +10
    --
    -- Patentia Sash: +5
    -- Shetal Stone: +6
    -- Reiki Yotai: +7
    --
    -- Hachiya Hakama: +3
    -- Hachiya Hakama: +3
    -- Mochizuki Hakama: +7
    -- Mochizuki Hakama +1: +8
    -- Naga Hakama: +4
    --
    -- Hizamaru Sune-Ate: +5
    -- Hizamaru Sune-Ate +1: +7
    -- Taeon Boots (no DW augment): +4
    -- Rawhide Boots: +3
    
    --==================================--
	-- Job Abilities
    --==================================--
    
    sets.precast.JA['Futae'] = {hands="Iga Tekko +2"}
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama +1"}
    sets.precast.JA['Sange'] = {ammo=gear.SangeAmmo, body="Mochizuki Chainmail +1"}
    
    if player.sub_job == 'WAR' then
        sets.precast.JA['Provoke'] = { 
            ear1="Friomisi Earring",ear2="Trux Earring", 
            body="Emet Harness +1",ring1="Supershear Ring",
            feet="Mochizuki Kyahan +1"}
    end

    if player.sub_job == 'DNC' then
        -- Waltz (chr and vit)
        sets.precast.Waltz = {
            head="Anwig Salade",neck="Unmoving Collar +1",ear1="Enchanter Earring +1",ear2="Handler's Earring +1",
            hands=gear.TaeonGloves.Waltz,ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",
            waist="Chaac Belt",legs="Dashing Subligar",feet=gear.RawhideBoots.D}
    
        -- Don't need any special gear for Healing Waltz.
        sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade"}
    
        -- Set for acc on steps, since Yonin drops acc a fair bit
        sets.precast.Step = {
            head="Dampening Tam",neck="Sanctity Necklace",ear1="Zennaroi Earring",
            body=gear.AdhemarJacket.B,hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Cacoethic Ring +1",
            back="Yokaze Mantle",waist="Eschan Stone",legs=gear.TaeonTights.TA,feet=gear.HerculeanBoots.WSD}
    end

    --==================================--
	-- Weaponskills
    --==================================--
    
    --------------------------------------
    -- Utility Sets for rules below
    --------------------------------------
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    sets.WSDayBonus = {head="Gavialis Helm"}
    sets.LugraEarrings = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
    sets.LugraMoonshade = {ear1="Lugra Earring +1",ear2="Moonshade Earring"}

    sets.RegularAmmo = {ammo=gear.RegularAmmo}
    sets.SangeAmmo = {ammo=gear.SangeAmmo}
    
    sets.NightAccAmmo = {ammo="Ginsen"}
    sets.DayAccAmmo = {ammo="Tengu-no-Hane"}
    
    sets.precast.WS = {
        ammo="Seething Bomblet +1",
        head=gear.AdhemarBonnet.A,neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.AdhemarJacket.B,hands=gear.AdhemarWristbands.B,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Windbuffet Belt +1",legs="Hizamaru Hizayoroi +1",feet=gear.HerculeanBoots.WSD}
    
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        head="Gavialis Helm"})
        
    sets.precast.WS.Magic = {
        ammo="Seething Bomblet +1",
        head=gear.HerculeanHelm.MAB,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs="Gyve Trousers",feet=gear.HerculeanBoots.WSD}
    
    --------------------------------------
	-- Dagger
    --------------------------------------
    
    -- Wasp Sting: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.
    sets.precast.WS['Wasp Sting'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Belt"})
    
    -- Gust Slash: magical, wind-ele., 40% DEX 40% INT, 1.0/2.0/3.5 fTP.
    sets.precast.WS['Gust Slash'] = sets.precast.WS.Magic
    
    -- Shadowstitch: physical 1-hit, 100% CHR, 1.0 fTP, TP affects chance to bind.
    sets.precast.WS['Shadowstitch'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",waist="Fotia Belt"})
    
    -- Viper Bite: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.
    sets.precast.WS['Viper Bite'] = set_combine(sets.precast.WS.DEX, {
        neck="Fotia Gorget",ear2="Ishvara Earring",waist="Fotia Belt"})
    
    -- Cyclone: magical AOE, wind-ele., 40% DEX 40% INT, 1.0/2.375/2.875 fTP.
    sets.precast.WS['Cyclone'] = sets.precast.WS.Magic
    sets.precast.WS['Cyclone'].TH = set_combine(sets.precast.WS['Cyclone'], {waist="Chaac Belt"})
    
    -- Energy Steal: steals MP, affected by MND and TP.
    sets.precast.WS['Energy Steal'] = {ear2="Moonshade Earring"}
    
    -- Energy Drain: steals MP, affected by MND and TP.
    sets.precast.WS['Energy Drain'] = {ear2="Moonshade Earring"}
    
    -- Aeolian Edge: magical AOE, wind-ele., 40% DEX 40% INT, 2.0/3.0/4.5 fTP.
    sets.precast.WS['Aeolian Edge'] = sets.precast.WS.Magic

    --------------------------------------
    -- Katana
    --------------------------------------
    
    -- Blade: Rin: physical 1-hit, 60% STR 60% DEX, 1.0 fTP, TP affects chance to crit.
    -- Note: According to BGWiki, unlike most crit WS, Blade: Rin does not benefit from +crit hit rate equipment.
    sets.precast.WS['Blade: Rin'] = set_combine(sets.precast.WS, {
        ammo="Qirmiz Tathlum",
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Abnoba Kaftan",
        waist="Fotia Belt"})
    
    -- Blade: Retsu: physical 1-hit, 20% STR 60% DEX, 1.0 fTP, TP affects duration of paralysis.
    sets.precast.WS['Blade: Retsu'] = set_combine(sets.precast.WS, {ear1="Ishvara Earring"})
    
    -- Blade: Teki: magical water-ele., 30% STR 30% INT, 0.5/0.75/1.0 fTP.
    sets.precast.WS['Blade: Teki'] = sets.precast.WS.Magic
    
    -- Blade: To: magical ice-ele., 40% STR 40% INT, 0.5/0.75/1.0 fTP.
    sets.precast.WS['Blade: To'] = sets.precast.WS.Magic
    
    -- Blade: Chi: hybrid 2-hit earth-ele., 30% STR 30% INT, 0.5/0.75/1.0 fTP.
    sets.precast.WS['Blade: Chi'] = sets.precast.WS.Magic
    
    -- Blade: Ei: magical dark-ele., 40% STR 40% INT, 1.0/1.5/2.0 fTP.
    sets.precast.WS['Blade: Ei'] = set_combine(sets.precast.WS.Magic, {head="Pixie Hairpin +1"})
    
    -- Blade: Jin: physical 3-hit, 30% STR 30% DEX, 1.375 fTP, TP affects chance to crit.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {
        ammo="Qirmiz Tathlum",
        neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Abnoba Kaftan",hands=gear.RyuoTekko.A,
        back="Rancorous Mantle",waist="Fotia Belt",legs="Jokushu Haidate"})
    
    -- Blade: Ten: physical 1-hit, 30% STR 30% DEX, 4.5/11.5/15.5 fTP.
    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {ear1="Ishvara Earring",ear2="Moonshade Earring"})
    
    -- Blade: Ku: physical 5-hit, 30% STR 30% DEX, 1.25 fTP, TP affects accuracy. 
    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",waist="Fotia Belt"})
    
    -- Blade: Yu: magical water-ele., 40% DEX 40% INT, 3.0 fTP, TP affects duration of poison.
    sets.precast.WS['Blade: Yu'] = sets.precast.WS.Magic
    
    -- Blade: Shun: physical 5-hit, 73~85% DEX, 1.0 fTP, TP affects attack power.
    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Moonshade Earring",
        ring1="Ramuh Ring +1",
        waist="Fotia Belt",legs="Jokushu Haidate"})
    
    -- Blade: Kamu: physical 1-hit, 60% STR 60% INT, 1.0 fTP, TP affects duration of lowered accuracy.
    sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",ear2="Ishvara Earring",
        ring1="Ifrit Ring +1",ring2="Ifrit Ring +1",
        waist="Fotia Belt"})
    
    -- Blade: Hi: physical 1-hit, 80% AGI, 5.0 fTP, TP affects chance to crit.
    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
        ammo="Qirmiz Tathlum",
        neck="Houyi Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Abnoba Kaftan",hands=gear.RyuoTekko.A,ring1="Petrov Ring",
        waist="Chaac Belt",back="Rancorous Mantle"})

    --==================================--
	-- Snapshot
    --==================================--
    
    sets.precast.RA = {
        head="Aurore Beret +1",
        hands="Buremte Gloves",
        legs=gear.AdhemarKecks.C,feet="Wurrukatte Boots"}
    
    --==================================--
	-- Fast Cast
    --==================================--
    
    sets.precast.FC = {
	    ammo="Impatiens",
        head=gear.HerculeanHelm.MAB,neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.TaeonTabard.FC,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Lebeche Ring",
        legs="Gyve Trousers"} -- feet="Mochizuki Kyahan +1", special enhancement for casting ninjutsu III
    
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace", body="Mochizuki Chainmail +1"})
    
    --==================================--
	-- Midcast
    --==================================--
    
    sets.midcast.FastRecast = {
        ammo="Sapience Orb",
        head=gear.HerculeanHelm.MAB,ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body=gear.TaeonTabard.FC,hands="Leyline Gloves",ring1="Prolix Ring",
        back="Grounded Mantle +1",feet="Mochizuki Kyahan +1"}
    
    --==================================--
	-- Ninjutsu
    --==================================--
    
    sets.midcast.Ninjutsu = {
        head="Hachiya Hatsuburi +1",neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Sangoma Ring",ring2="Etana Ring",
        back="Astute Cape",waist="Ovate Rope",feet="Mochizuki Kyahan +1"}

    -- Nuking Ninjutsu (skill, magic accuracy, and magic attack)
    sets.midcast.ElementalNinjutsu = {
        ammo="Seething Bomblet +1",
        head=gear.HerculeanHelm.MAB,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Novio Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs="Gyve Trousers",feet=gear.HerculeanBoots.WSD}
    
    -- any ninjutsu cast on self
    sets.midcast.SelfNinjutsu = sets.midcast.Ninjutsu
    sets.midcast.Utsusemi = set_combine(sets.midcast.Ninjutsu, {hands="Mochizuki Tekko +1",back="Andartia's Mantle",feet="Iga Kyahan +2"})
    sets.midcast.Migawari = set_combine(sets.midcast.Ninjutsu, {body="Hattori Ningi +1",back="Andartia's Mantle"})
    
    --==================================--
	-- Ranged Attack
    --==================================--
    
    sets.midcast.RA = {
        head="Taeon Chapeau",neck="Iqabi Necklace",
        body="Mochizuki Chainmail +1",hands="Hachiya Tekko +1",ring2="Hajduk Ring",
        back="Yokaze Mantle",legs=gear.AdhemarKecks.C,feet="Taeon Boots"}
    
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {body="Mochizuki Chainmail +1"})
    sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)
    
    --==================================--
	-- Active Buffs
    --==================================--
    
    sets.buff.Migawari = {body="Hattori Ningi +1",back="Andartia's Mantle"}
    
    --==================================--
	-- Miscellaneous Sets
    --==================================--
    
    sets.DayMovement = {feet="Danzo Sune-ate"}
    sets.NightMovement = {feet="Danzo Sune-ate"} --{feet="Hachiya Kyahan +1"}
    sets.TreasureHunter = {waist="Chaac Belt"}
    
    sets.Ochu = {main="Ochu",sub="Ochu"}
    sets.Malevolence = {main=gear.Malevolence.Max,sub=gear.Malevolence.Mid}
    
    --==================================--
	-- Organizer
    --==================================--

    organizer_items = tas_permissive_set_combine(tas_global_organizer_items, {
        shihei="Shihei",
        inoshishinofuda="Inoshishinofuda",
        shikanofuda="Shikanofuda",
        chonofuda="Chonofuda"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    
    if spell.skill == "Ninjutsu" and spell.target.type:lower() == 'self' and spellMap ~= "Utsusemi" then
        if spell.english == "Migawari" then
            classes.CustomClass = "Migawari"
        else
            classes.CustomClass = "SelfNinjutsu"
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        -- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
            cancel_spell()
            eventArgs.cancel = true
            return
        end
    end

end

function job_post_precast(spell, action, spellMap, eventArgs)
    -- Ranged Attacks 
    if spell.action_type == 'Ranged Attack' and state.OffenseMode ~= 'Acc' then
        equip( sets.SangeAmmo )
    end
    -- protection for lag
    if spell.name == 'Sange' and player.equipment.ammo == gear.RegularAmmo then
        state.Buff.Sange = false
        eventArgs.cancel = true
    end
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
            equip(sets.TreasureHunter)
        end
        -- Mecistopins Mantle rule
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        -- Gavialis Helm rule
        if aw_is_sc_element_today(spell) then
            if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- do nothing
            else
              equip(sets.WSDayBonus)
            end
        end
        -- Swap in special ammo for WS in high Acc mode
        if state.OffenseMode.value == 'Acc' then
            equip(select_ws_ammo())
        end
        -- Lugra Earring for some WS
        if LugraWSList:contains(spell.english) then
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.LugraEarrings)
            end
        elseif spell.english == 'Blade: Hi' or spell.english == 'Blade: Ten' then
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.LugraEarrings)
            end
        end

    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        equip(sets.midcast.FastRecast)
    end
    if spell.english == "Monomi: Ichi" then
        if buffactive['Sneak'] then
            send_command('@wait 1.7;cancel sneak')
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    --if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
    --    equip(sets.TreasureHunter)
    --end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Aftermath timer creation
    aw_custom_aftermath_timers_aftercast(spell)
    --if spell.type == 'WeaponSkill' then
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.value == 'PDT' then
        if state.Buff.Migawari then
            idleSet = set_combine(idleSet, sets.buff.Migawari)
        else 
            idleSet = set_combine(idleSet, sets.defense.PDT)
        end
    else
        idleSet = set_combine(idleSet, select_movement())
    end
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if state.Buff.Migawari and state.HybridMode.value == 'PDT' then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    
    meleeSet = set_combine(meleeSet, select_ammo())
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
    if buff == 'Innin' and gain  or buffactive['Innin'] then
        state.CombatForm:set('Innin')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        state.CombatForm:reset()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        tas_determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        update_combat_form()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_ammo()
    tas_determine_haste_group()
    update_combat_form()
    --select_movement()
    th_update(cmdParams, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
            equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end

function select_movement()
    -- world.time is given in minutes into each day
    -- 7:00 AM would be 420 minutes
    -- 17:00 PM would be 1020 minutes
    if world.time >= (17*60) or world.time <= (7*60) then
        return sets.NightMovement
    else
        return sets.DayMovement
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Capacity Point Mantle' then
        gear.Back = newValue
    elseif stateField == 'Runes' then
        local msg = ''
        if newValue == 'Ignis' then
            msg = msg .. 'Increasing resistance against ICE and deals FIRE damage.'
        elseif newValue == 'Gelus' then
            msg = msg .. 'Increasing resistance against WIND and deals ICE damage.'
        elseif newValue == 'Flabra' then
            msg = msg .. 'Increasing resistance against EARTH and deals WIND damage.'
        elseif newValue == 'Tellus' then
            msg = msg .. 'Increasing resistance against LIGHTNING and deals EARTH damage.'
        elseif newValue == 'Sulpor' then
            msg = msg .. 'Increasing resistance against WATER and deals LIGHTNING damage.'
        elseif newValue == 'Unda' then
            msg = msg .. 'Increasing resistance against FIRE and deals WATER damage.'
        elseif newValue == 'Lux' then
            msg = msg .. 'Increasing resistance against DARK and deals LIGHT damage.'
        elseif newValue == 'Tenebrae' then
            msg = msg .. 'Increasing resistance against LIGHT and deals DARK damage.'
        end
        add_to_chat(123, msg)
    elseif stateField == 'Use Rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

--- Custom spell mapping.
--function job_get_spell_map(spell, default_spell_map)
--    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
--        return 'HighTierNuke'
--    end
--end
-- Creating a custom spellMap, since Mote capitalized absorbs incorrectly
function job_get_spell_map(spell, default_spell_map)
    if spell.type == 'Trust' then
        return 'Trust'
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.HasteMode.value ~= 'Normal' then
        msg = msg .. ', Haste: '..state.HasteMode.current
    end
    if state.RangedMode.value ~= 'Normal' then
        msg = msg .. ', Rng: '..state.RangedMode.current
    end
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(123, msg)
    eventArgs.handled = true
end

-- Call from job_precast() to setup aftermath information for custom timers.
function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}
        
        local empy_ws = "Blade: Hi"
        
        info.aftermath.weaponskill = empy_ws
        info.aftermath.duration = 0
        
        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end
        
        if spell.english == empy_ws and player.equipment.main == 'Kannagi' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end
            
            -- duration is based on aftermath level
            info.aftermath.duration = 30 * info.aftermath.level
        end
    end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
       info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

function select_ammo()
    if state.Buff.Sange then
        return sets.SangeAmmo
    else
        return sets.RegularAmmo
    end
end

function select_ws_ammo()
    if world.time >= (18*60) or world.time <= (6*60) then
        return sets.NightAccAmmo
    else
        return sets.DayAccAmmo
    end
end
function update_combat_form()
    if state.Buff.Innin then
        state.CombatForm:set('Innin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'RUN' then
        set_macro_page(2, 9)
    else
        set_macro_page(2, 2)
    end
end
