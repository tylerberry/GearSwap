-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+H ]           Toggle Charm Defense Mods
--              [ WIN+D ]           Toggle Death Defense Mods
--              [ WIN+K ]           Toggle Knockback Defense Mods
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Use current Rune
--              [ CTRL+- ]          Rune element cycle forward.
--              [ CTRL+= ]          Rune element cycle backward.
--              [ CTRL+` ]          Use current Rune
--
--              [ CTRL+Numpad/ ]    Berserk/Meditate/Souleater
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki/Arcane Circle
--              [ CTRL+Numpad- ]    Aggressor/Third Eye/Weapon Bash
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+G ]          Cycles between available greatswords
--              [ CTRL+W ]          Toggle Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Resolution
--              [ CTRL+Numpad8 ]    Upheaval
--              [ CTRL+Numpad9 ]    Dimidiation
--              [ CTRL+Numpad5 ]    Ground Strike
--              [ CTRL+Numpad6 ]    Full Break
--              [ CTRL+Numpad1 ]    Herculean Slash
--              [ CTRL+Numpad2 ]    Shockwave
--              [ CTRL+Numpad3 ]    Armor Break
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------


--  gs c rune                       Uses current rune
--  gs c cycle Runes                Cycles forward through rune elements
--  gs c cycleback Runes            Cycles backward through rune elements


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.    
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Sheep Song', 'Chaotic Eye', 'Stinking Gas', 'Grand Slam', 'Battle Dance', ''}
    blue_magic_maps.Cure = S{'Pollen'}
    blue_magic_maps.Buffs = S{'Cocoon'}

    rayke_duration = 35
    gambit_duration = 96

    lockstyleset = 80

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'HP')
    state.MagicalDefenseMode:options('MDT', 'Status')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.Greatsword = M{['description']='Current Weapon', 'Epeolatry', 'Aettir'}
    state.Charm = M(false, 'Charm Resistance')
    state.Knockback = M(false, 'Knockback')
    state.Death = M(false, "Death Resistance")
    state.CP = M(false, "Capacity Points Mode")

    state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}


    gear.ogma_tp = { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.ogma_enmtiy= { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}}
    gear.ogma_resist = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}}
    gear.ogma_fc    = { name="Ogma's cape", augments={'HP+60','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
    gear.ogma_wsd  = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.ogma_dimid = { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    send_command('bind ^` input //gs c rune')
    send_command('bind !` input /ja "Vivacious Pulse" <me>')
    send_command('bind ^- gs c cycleback Runes')
    send_command('bind ^= gs c cycle Runes')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @c gs c toggle CP')
    send_command('bind !g gs c cycle Greatsword')
    send_command('bind @h gs c toggle Charm')
    send_command('bind @k gs c toggle Knockback')
    send_command('bind @d gs c toggle Death')
    send_command('bind !q input /ma "Temper" <me>')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')

    select_default_macro_book()

end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind ^f11')
    send_command('unbind @c')
    send_command('unbind @h')
    send_command('unbind @e')
    send_command('unbind @k')
    send_command('unbind @d')
    send_command('unbind !q')
    send_command('unbind !w')
    send_command('unbind !o')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind @w')

    send_command('unbind @g')

end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enmity sets
    sets.enmity = {
        ammo="Aqreaqa Bomblet", --2
        head="Halitus Helm",
        body="Emet Harness +1",
        hands="Futhark Mitons +3",
        legs="Erilaz Leg Guards +1", --7
        feet="Erilaz Greaves +1",--6
        neck="Moonlight Necklace", --15
        ear2="Cryptic Earring", --4
        ring1="Eihwaz Ring", --5
        waist="Kasiri Belt",
        back=gear.ogma_enmtiy, --10
        }

    sets.enmity.HP = {ammo="Staunch Tathlum +1",
        head="Fu. Bandeau +3",
        body="Runeist's Coat +2",
        hands="Regal Gauntlets",
        legs="Carmine Cuisses +1",
        feet={ name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3',}},
        neck="Moonlight Necklace",
        waist="Rumination Sash",
        left_ear="Halasz Earring",
        right_ear="Magnetic Earring",
        left_ring="Moonlight Ring",
        right_ring="Evanescence Ring",}

    sets.precast.JA['Vallation'] = set_combine(sets.enmity, {body="Runeist's Coat +2", legs="Futhark Trousers +3", back=gear.ogma_enmtiy})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.enmity, {feet="Runeist's Boots +2"})
    sets.precast.JA['Battuta'] = set_combine(sets.enmity, {head="Futhark Bandeau +3"})
    sets.precast.JA['Liement'] = set_combine(sets.enmity, {body="Futhark Coat +1"})

    sets.precast.JA['Lunge'] = {
        ammo="Seething Bomblet +1",
        head={ name="Herculean Helm", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Crit.hit rate+1','INT+3','Mag. Acc.+7','"Mag.Atk.Bns."+14',}},
        body="Carm. Sc. Mail +1",
        hands="Carmine Finger Gauntlets +1",
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Weapon skill damage +4%','MND+3','"Mag.Atk.Bns."+15',}},
        feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+20','Weapon skill damage +4%','AGI+3',}},
        neck="Baetyl Pendant",
        ear2="Friomisi Earring",
        back="Izdubar Mantle",
        waist="Eschan Stone",
        }

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots +1"}
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.enmity, {body="Futhark Coat +1"})
    sets.precast.JA['Swordplay'] = set_combine(sets.enmity, {hands="Futhark Mitons +3"})

    sets.precast.JA['Vivacious Pulse'] = set_combine(sets.enmity, {
        head="Erilaz Galea +1",
        legs="Runeist Trousers +1",
        neck="Incanter's Torque",
        waist="Bishop's Sash",
        })

    sets.precast.JA['One For All'] = set_combine(sets.enmity, {})
    sets.precast.JA['Provoke'] = sets.enmity
    sets.precast.JA['Last Resort'] = sets.enmity

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head="Carmine Mask +1",    --14
        body={ name="Taeon Tabard", augments={'"Fast Cast"+5','Phalanx +3',}},          --9
        hands="Leyline Gloves",         --8
        legs="Ayanmo Cosciales +2",     --6
        feet="Carmine Greaves +1",      --8
        neck="Baetyl Pendant",          --4
        ear1="Etiolation Earring",      --1
        ear2="Loquacious Earring",      --2
        ring2="Kishar Ring",            --4
        ring1="Moonlight Ring",             
        back=gear.ogma_fc,          --10
        waist="Oneiros Belt",
        }

    sets.precast.FC.HP = set_combine(sets.precast.FC, {
        body="Runeist's Coat +2",
        ear2="Odnowa Earring +1",
        })

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        legs="Futhark Trousers +3",
        waist="Siegel Sash",
        })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear2="Mendicant's Earring"})

    sets.precast.FC.Utsusemi = sets.precast.FC


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Meghanada Visor +2",
        body="Meghanada Cuirie +2",
        hands="Meghanada Gloves +2",
        legs="Meghanada Chausses +2",
        feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+4','DEX+9',}},
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=gear.ogma_wsd,
        waist="Fotia Belt",
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="Seething Bomblet +1",
        body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
        ear1="Telos Earring",
        })

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
        ammo="Seething Bomblet +1",
        head="Adhemar Bonnet +1",
        body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
        })

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
        hands="Adhemar Wristbands +1",
        })

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
        ear1="Ishvara Earring",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
        legs="Lustr. Subligar +1",
        back=gear.ogma_dimid,
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {
        ammo="Seething Bomblet +1",
        ear1="Telos Earring",
        })

    sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']

    


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --10
        legs="Carmine Cuisses +1", --20
        neck="Moonlight Necklace",
        hands="Regal Gauntlets",
        ring2="Evanescence Ring", --5
        waist="Rumination Sash", --10
        }

    sets.midcast.Cure = {
        }

    sets.midcast['Enhancing Magic'] = {
        ammo="Staunch Tathlum +1",
        head="Carmine Mask +1",
        body="Futhark Coat +1",
        hands="Runeist Mitons +1",
        legs="Carmine Cuisses +1",
        neck="Incanter's Torque",
        ear1="Augment. Earring",
        ear2="Andoaa Earring",
        ring1="Stikini Ring",
        ring2="Stikini Ring",
        waist="Olympus Sash",
        back="Moonlight Cape"
        }

    sets.midcast.EnhancingDuration = set_combine(sets.idle.DT, {
        head="Erilaz Galea +1",
        hands="Regal Gauntlets",
        legs="Futhark Trousers +3",
        })

    sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'], {
        })

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        ammo="Staunch Tathlum +1", --(11)
        head="Futhark Bandeau +3", --5
        body={ name="Taeon Tabard", augments={'"Fast Cast"+5','Phalanx +3',}}, --3(10)
        hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}}, --3(8)
        legs={ name="Taeon Tights", augments={'Spell interruption rate down -10%','Phalanx +3',}}, --3(8)
        feet={ name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3',}}, --3(10)
        ear1="Etiolation Earring", --(5)
        ring1="Stikini Ring", --(5)
        ring2="Stikini Ring",
        waist="Olympus Sash", --(10)
        back="Moonlight Cape",
        })

    sets.midcast['Regen'] = set_combine(sets.midcast.EnhancingDuration, {head="Runeist Bandeau +1"})
    sets.midcast.Refresh = sets.midcast.EnhancingDuration
    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {waist="Siegel Sash"})
    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Shell = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {
        legs="Runeist Trousers +1",
        neck="Incanter's Torque",
        ring1="Stikini Ring",
        ring2="Stikini Ring",
        waist="Bishop's Sash",
        }

    sets.midcast.Flash = sets.enmity
    sets.midcast.Foil = sets.enmity
    sets.midcast.Stun = sets.enmity
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {}
    sets.midcast['Blue Magic'].Enmity = sets.enmity
    sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
    sets.midcast['Blue Magic'].Buff = sets.midcast.EnhancingDuration


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Homiliary",
        head="Turms Cap +1",
        body="Runeist's Coat +2",
        hands="Turms Mittens +1",
        legs="Carmine Cuisses +1",
        feet="Turms Leggings +1",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        back=gear.ogma_enmtiy,
        waist="Flume Belt +1",
        }

    sets.idle.DT = {
        ammo="Staunch Tathlum +1",
        head="Turms Cap +1",
        body="Runeist's Coat +2",
        hands="Turms Mittens +1",
        legs="Erilaz Leg Guards +1",
        feet="Turms Leggings +1",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        back=gear.ogma_enmtiy,
        waist="Flume Belt +1",
        }

    sets.idle.Town = {
        sub="Mensch Strap +1",
        ammo="Homiliary",
        head="Turms Cap +1",
        body="Runeist's Coat +2",
        hands="Turms Mittens +1",
        legs="Carmine Cuisses +1",
        feet="Turms Leggings +1",
        neck="Moonlight Necklace",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        back=gear.ogma_enmtiy,
        waist="Flume Belt +1",}

    sets.idle.Weak = sets.idle.DT
    sets.Kiting = {legs="Carmine Cuisses +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.Charm = {
        }

    sets.defense.Knockback = {}
    sets.defense.Death = {body="Samnuha Coat", ring1="Warden's Ring", ring2="Eihwaz Ring"}

    sets.defense.PDT = {
        sub="Mensch Strap +1",
        ammo="Staunch Tathlum +1",
        head="Turms Cap +1",
        body="Runeist's Coat +2",
        hands="Turms Mittens +1",
        legs="Erilaz Leg Guards +1",
        feet="Turms Leggings +1",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        back=gear.ogma_enmtiy,
        waist="Flume Belt +1",
        }

    sets.defense.MDT = {
        sub="Mensch Strap +1",
        ammo="Staunch Tathlum +1",
        head="Turms Cap +1",
        body="Runeist's Coat +2",
        hands="Turms Mittens +1",
        legs="Erilaz Leg Guards +1",
        feet="Turms Leggings +1",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        back=gear.ogma_enmtiy,
        waist="Flume Belt +1",
        }

    sets.defense.Status = {
        sub="Mensch Strap +1",
        ammo="Staunch Tathlum +1",
        head="Turms Cap +1",
        body="Runeist's Coat +2",
        hands="Turms Mittens +1",
        legs="Erilaz Leg Guards +1",
        feet="Turms Leggings +1",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        back=gear.ogma_enmtiy,
        waist="Flume Belt +1",
        }

    sets.defense.HP = {
        sub="Mensch Strap +1",
        ammo="Staunch Tathlum +1",
        head="Turms Cap +1",
        body="Runeist's Coat +2",
        hands="Turms Mittens +1",
        legs="Erilaz Leg Guards +1",
        feet="Turms Leggings +1",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        back=gear.ogma_enmtiy,
        waist="Flume Belt +1",
        }

    sets.defense.Parry = {
        sub="Mensch Strap +1",
        ammo="Staunch Tathlum +1",
        head="Turms Cap +1",
        body="Runeist's Coat +2",
        hands="Turms Mittens +1",
        legs="Erilaz Leg Guards +1",
        feet="Turms Leggings +1",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        back=gear.ogma_enmtiy,
        waist="Flume Belt +1",
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        sub="Utu Grip",
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
        hands="Adhemar Wristbands +1",
        legs="Samnuha Tights",
        feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+4','DEX+9',}},
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Epona's Ring",
        ring2="Niqmaddu Ring",
        back=gear.ogma_tp,
        waist="Windbuffet Belt +1",
        }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        })

    sets.engaged.MidAcc = set_combine(sets.engaged, {
        })

    sets.engaged.HighAcc = set_combine(sets.engaged, {
        })

    sets.engaged.Aftermath = set_combine(sets.engaged, {ear2="Dedition Earring", ring1="Chirich Ring +1",})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Hybrid = set_combine(sets.engaged, {
        head="Turms Cap +1",
        body="Ayanmo Corazza +2",
        legs="Meghanada Chausses +2",
        ring1="Moonlight Ring",
        ear2="Cessance Earring",
        waist="Ioskeha Belt +1",
    })

    sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.Hybrid)
    
    sets.engaged.Aftermath.DT = sets.engaged.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {neck="Nicander's Necklace"}

    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back="Evasionist's Cape"})
    sets.EmboldenPhalanx = set_combine(sets.midcast['Phalanx'], {back="Evasionist's Cape"})
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if state.PhysicalDefenseMode.value == 'HP' then
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            if spell.English == 'Flash' or spell.English == 'Foil' or spell.English == 'Stun'
                or blue_magic_maps.Enmity:contains(spell.english) then
                equip(sets.enmity.HP)
            else
                equip(sets.precast.FC.HP)
            end
        elseif spell.action_type == 'Ability' then
            equip(sets.enmity.HP)
        end
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.PhysicalDefenseMode.value == 'HP' and spell.action_type == 'Magic' then
        eventArgs.handled = true
        equip(sets.enmity.HP)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.english == 'Phalanx' and buffactive['Embolden'] then
            equip(sets.EmboldenPhalanx)
    end
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    --if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
    --    handle_equipping_gear(player.status)
    --    eventArgs.handled = true
    --end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        --send_command('wait '..rayke_duration..';input /p Rayke: OFF <call21>;')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        --send_command('wait '..gambit_duration..';input /p Gambit: OFF <call21>;')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.Charm.current)
    classes.CustomDefenseGroups:append(state.Knockback.current)
    classes.CustomDefenseGroups:append(state.Death.current)

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.Charm.current)
    classes.CustomMeleeGroups:append(state.Knockback.current)
    classes.CustomMeleeGroups:append(state.Death.current)
end

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('neck')
        else
            enable('neck')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('head','legs','back')
        else
            enable('head','legs','back')
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Charm.value == true then
        idleSet = set_combine(idleSet, sets.defense.Charm)
    end
    if state.Knockback.value == true then
        idleSet = set_combine(idleSet, sets.defense.Knockback)
    end
    if state.Death.value == true then
        idleSet = set_combine(idleSet, sets.defense.Death)
    end

    if state.Greatsword.current == 'Epeolatry' then
        equip({main="Epeolatry"})
    elseif state.Greatsword.current == 'Aettir' then
        equip({main="Aettir"})
    end

    --if state.CP.current == 'on' then
    --    equip(sets.CP)
    --    disable('back')
    --else
    --    enable('back')
    --end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
     if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry"
        and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end
    if state.Charm.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Charm)
    end
    if state.Knockback.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Knockback)
    end
    if state.Death.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Death)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end
    if state.Charm.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Charm)
    end
    if state.Knockback.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Knockback)
    end
    if state.Death.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Death)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = '[ Melee'

    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    msg = msg .. ': '

    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end

    if state.Charm.value == true then
        msg = msg .. '[ Charm ]'
    end

    if state.Knockback.value == true then
        msg = msg .. '[ Knockback ]'
    end

    if state.Death.value == true then
        msg = msg .. '[ Death ]'
    end

    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode ]'
    end

    msg = msg .. '[ *' .. state.Runes.current .. '* ]'

    add_to_chat(060, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book: (set, book)
    if player.sub_job == 'BLU' then
        set_macro_page(5, 3)
    elseif player.sub_job == 'DRK' then
        set_macro_page(6, 3)
    else
        set_macro_page(5, 3)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end