
function tas_zone_change(new_id, old_id)
    coroutine.schedule(send_command:prepare('input //gs c update'), 2)
end

--==================================--
-- Table utility functions
--==================================--

function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

--==================================--
-- Permissive set combination
--==================================--

-- Intended for use combining organizer_items sets, since set_combine discriminates on keys - i.e. it only uses valid slot
-- identifiers. Treats sets as Lua tables, since that's what they are.
--

-- Uses error-checking code from set_merge in GearSwap.
function tas_permissive_set_combine(...)
    local combined_set = {}
    local sets_to_combine = {...}

    local canCombine = table.all(sets_to_combine, function(t) return type(t) == 'table' end)
    if not canCombine then
        -- the code that called equip() or set_combine() is #3 on the stack from here
        error("Trying to combine non-gear sets.", 3)
    end

    -- Combine the provided sets into combinedSet.  If anything is blocked by having
    -- the slot disabled, assign the item to the not_sent_out_equip table.
    for _,table in pairs(sets_to_combine) do
        for key,value in pairs(table) do
            combined_set[key] = value
		end
		
	end
    
    return combined_set
end

--==================================--
-- Automatic haste handling
--==================================--

-- Based on Alan Warren's determine_haste_group, but with a lot of changes to actually be right in more cases.

tas_haste_buffs = S{'haste', 'indi-haste', 'geo-haste', 'embrava', 'march', 'haste samba', 'mighty guard'}
state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste'}

function tas_determine_haste_group()
    -- Haste to DW chart:
	--
    --  +-------------+-------------+----------+
    --  | DW Required | Magic Haste | JA Haste |
    --  +-------------+-------------+----------+
    --  | 36          | 43          | -        |
    --  | 44          | 40          | -        |
    --  | 49          | 35          | -        |
    --  | 56          | 30          | -        |
    --  | 61          | 25          | -        |
    --  | 67          | 15          | -        |
    --  | 70          | 10          | -        |
    --  | 74          | -           | -        |
    --  +-------------+-------------+----------+
    --  | 25          | 43          | 5        |
    --  | 35          | 40          | 5        |
    --  | 41          | 35          | 5        |
    --  | 51          | 30          | 5        |
    --  | 57          | 25          | 5        |
    --  | 64          | 15          | 5        |
    --  | 68          | 10          | 5        |
    --  | 72          | -           | 5        |
    --  +-------------+-------------+----------+
    --  | <15         | 43          | 10       |
    --  | 23          | 40          | 10       |
    --  | 31          | 35          | 10       |
    --  | 43          | 30          | 10       |
    --  | 52          | 25          | 10       |
    --  | 61          | 15          | 10       |
    --  | 65          | 10          | 10       |
    --  | 70          | -           | 10       |
    --  +-------------+-------------+----------+

    -- Buffs and debuffs:
    --
    --   Haste Samba (Sub) 5%
    --   Haste Samba (Merited DNC) 10% (this function always assumes merited)
    --
    -- Magic haste:
    --
    --   Haste or Haste II [33]: 15% or 30%
    --     state.HasteMode is a toggle for when you know Haste II is being cast on you. Defaults to Haste II.
    --     This is clunky to use when both Haste II and Haste I are being cast, but wtf can you do.
    --   Embrava [228]: 25%
    --   Indi-Haste or Geo-Haste [580]: 30%, 35% with Dunna, or 41% with Idris
    --     This code assumes 30%, which is either a GEO without Dunna (scrub) or approximately a GEO with Dunna but without JP.
    --   Victory March +0/+3/+4/+5    9.4%/14%/15.6%/17.1%
    --   Advancing March +0/+3/+4/+5  6.3%/10.9%/12.5%/14%
    --     This code assumes trust marches, which are +0. In any party buff situation with a real bard, we will almost certainly
    --     hit magic haste cap anyway via Haste II + 2x march or GEO haste or something.
    --   Mighty Guard [604]: 15%
    
    classes.CustomMeleeGroups:clear()
    
    -- TODO: buffactive['haste samba']
    
    if buffactive.slow then
        add_to_chat(8, '---------------Slow----------------')
        classes.CustomMeleeGroups:append('Slow')
    elseif state.HasteMode.value == 'Haste II' then
        if (buffactive[33] and buffactive[580]) or
           ((buffactive[33] or buffactive[580]) and (buffactive.march == 2 or buffactive.embrava or buffactive['mighty guard'])) or
           (buffactive['mighty guard'] and buffactive.embrava and buffactive.march) then
            add_to_chat(8, '-------------Haste Max-------------')
            classes.CustomMeleeGroups:append('DW36')
        elseif (buffactive.embrava and (buffactive.march == 2 or buffactive['mighty guard'])) or
               ((buffactive[33] or buffactive[580]) and buffactive.march == 1) then
            add_to_chat(8, '-------------Haste 40%-------------')
            classes.CustomMeleeGroups:append('DW44')
        elseif (buffactive.embrava and buffactive.march == 1) then
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('DW49')
        elseif buffactive[580] or buffactive[33] or (buffactive['mighty guard'] and buffactive.march == 2) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('DW56')
        elseif buffactive.embrava or (buffactive['mighty guard'] and buffactive.march == 1) then
            add_to_chat(8, '-------------Haste 25%-------------')
            classes.CustomMeleeGroups:append('DW61')
        elseif buffactive.march == 2 or buffactive['mighty guard'] then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('DW67')
        elseif buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 10%-------------')
            classes.CustomMeleeGroups:append('DW70')
        else
            add_to_chat(8, '-------------No Haste-------------')
            classes.CustomMeleeGroups:append('DW74')
        end
    else
        if (buffactive[580] and (buffactive[33] or buffactive['mighty guard'] or buffactive.march == 2 or buffactive.embrava)) or
           (buffactive[33] and buffactive['mighty guard'] and (buffactive.march == 2 or buffactive.embrava)) or
           (buffactive[33] and buffactive.march and buffactive.embrava) or
           (buffactive['mighty guard'] and buffactive.embrava and buffactive.march) then
            add_to_chat(8, '-------------Haste Max-------------')
            classes.CustomMeleeGroups:append('DW36')
        elseif (buffactive.embrava and (buffactive[33] or buffactive['mighty guard'] or buffactive.march == 2)) or
               (buffactive[580] and buffactive.march == 1) or
               (buffactive[33] and buffactive['mighty guard'] and buffactive.march == 1) then
            add_to_chat(8, '-------------Haste 40%-------------')
            classes.CustomMeleeGroups:append('DW44')
        elseif (buffactive.embrava and buffactive.march == 1) then
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('DW49')
        elseif (buffactive[33] and (buffactive['mighty guard'] or buffactive.march == 2)) or
               (buffactive['mighty guard'] and buffactive.march == 2) or
               buffactive[580] then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('DW56')
        elseif ((buffactive[33] or buffactive['mighty guard']) and buffactive.march == 1) or buffactive.embrava then
            add_to_chat(8, '-------------Haste 25%-------------')
            classes.CustomMeleeGroups:append('DW61')
        elseif buffactive[33] or buffactive.march == 2 or buffactive['mighty guard'] then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('DW67')
        elseif buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 10%-------------')
            classes.CustomMeleeGroups:append('DW70')
        else
            add_to_chat(8, '-------------No Haste-------------')
            classes.CustomMeleeGroups:append('DW74')
        end
    end
end

--==================================--
-- Fucho-no-Obi
--==================================--

-- Automatically use Fucho-no-Obi when MP < 51, and a specified alternate belt otherwise.
--
-- Needs setup code like this in job_setup or user_setup:
--
--   event_list = L{}
--   event_list:append(windower.register_event('mpp change',tas_fucho_no_obi))
--   gear.default.idle_belt = "Slipor Sash"
--
-- Also, if you use Organizer, make sure Fucho-no-Obi and the value of gear.default.idle_belt are both in
-- organizer_items.
--
-- Then use waist=gear.IdleBelt in your sets. Magic will happen.

gear.IdleBelt = {name="Slipor Sash"}
gear.default.idle_belt = "Slipor Sash"

function tas_fucho_no_obi(newmpp,oldmpp)
    if (newmpp < 51) then
        gear.IdleBelt.name = "Fucho-no-Obi"
    else
        gear.IdleBelt.name = gear.default.idle_belt
    end

    if (player.status == 'Idle' or player.status == 'Resting') and not midaction() then
        equip({waist=gear.IdleBelt})
    end
end

--==================================--
--==================================--
-- Gavialis Helm

-- From Alan Warren.

function aw_is_sc_element_today(spell)
    if spell.type ~= 'WeaponSkill' then
        return
    end

   local weaponskill_elements = S{}:
    union(skillchain_elements[spell.skillchain_a]):
    union(skillchain_elements[spell.skillchain_b]):
    union(skillchain_elements[spell.skillchain_c])

    if weaponskill_elements:contains(world.day_element) then
        return true
    else
        return false
    end
end

--==================================--
-- Oneiros Ring
--==================================--

-- Automatically use Oneiros Ring when MP > 100, and a specified alternate ring otherwise.
--
-- Needs setup code like this in job_setup or user_setup:
--
--   event_list = L{}
--   event_list:append(windower.register_event('mp change',tas_oneiros_ring))
--   gear.default.tp_ring = "Rajas Ring"
--
-- Then use ring1=gear.TPRing in your sets. Magic will happen.
--
-- Also, if you use Organizer, make sure Oneiros Ring and the value of gear.default.tp_ring are both in
-- organizer_items.
--
-- If you want to use ring2 for this ring instead of ring1 for some unholy reason, add this to the setup
-- code:
--
--   info.oneiros_in_ring2 = true

gear.TPRing = {name="Oneiros Ring"}
gear.default.tp_ring = "Rajas Ring"
info.oneiros_in_ring2 = false

function tas_oneiros_ring(newmp,oldmp)
	if (newmp > 100) then
		gear.TPRing.name = "Oneiros Ring"
	else
		gear.TPRing.name = gear.default.tp_ring
	
	end
	if player.status == 'Engaged' and not midaction() then
        if info.oneiros_in_ring2 == true then
            equip({ring2=gear.TPRing})
        else
            equip({ring1=gear.TPRing})
        end
	end
end

--==================================--
-- Sorcerer's Ring
--==================================--

-- Automatically use Sorcerer's Ring when MP < 75% and TP < 1000, and a specified alternate ring otherwise.
--
-- This function is slightly naive, in that it assumes that you are not midcasting in any "Converts HP to MP"
-- gear. If you are, this function is pessimistic and will sometimes use the alternate ring when it could have
-- used Sorcerer's Ring.
--
-- Needs setup code like this in job_setup or user_setup:
--
--   event_list = L{}
--   event_list:append(windower.register_event('mpp change',tas_sorcerers_ring_mpp))
--   event_list:append(windower.register_event('tp change',tas_sorcerers_ring_tp))
--   gear.default.mab_ring = "Shiva Ring +1"
--
-- Also, if you use Organizer, make sure Sorcerer's Ring and the value of gear.default.mab_ring are both in
-- organizer_items.
--
-- Then use ring1=gear.MABRing in your sets. Magic will happen.

gear.MABRing = {name="Sorcerer's Ring"}
gear.default.mab_ring = "Shiva Ring +1"

function tas_sorcerers_ring_mpp(newmpp,oldmpp)
    local player = windower.ffxi.get_player()
    
    if (newmpp < 76 and player.tp < 1000) then
		gear.MABRing.name = "Sorcerer's Ring"
	else
		gear.MABRing.name = gear.default.mab_ring
	end
end

function tas_sorcerers_ring_tp(newtp,oldtp)
    local player = windower.ffxi.get_player()
    
    if (player.mpp < 76 and newtp < 1000) then
		gear.MABRing.name = "Sorcerer's Ring"
	else
		gear.MABRing.name = gear.default.mab_ring
	end
end
