function tas_shared_augmented_gear()
	
	--==================================--
	-- Organizer items for all jobs
    --==================================--

    tas_global_organizer_items = {
        warp_ring="Warp Ring",
        
        councilors_garb="Councilor's Garb",
        
        mecistopins_mantle="Mecistopins Mantle",
        trizek_ring="Trizek Ring",
        endorsement_ring="Endorsement Ring",
        facility_ring="Facility Ring",
        capacity_ring="Capacity Ring",
        
        lu_shangs_fishing_rod="Lu Shang's Fishing Rod",
        fishers_torque="Fisher's Torque",
        fishermans_smock="Fisherman's Smock",
        anglers_gloves="Angler's Gloves",
        kachina_gloves="Kachina Gloves",
        anglers_hose="Angler's Hose",
        noddy_ring="Noddy Ring",
        puffin_ring="Puffin Ring",
        shrimp_lure="Shrimp Lure",
		minnow="Minnow",
		fly_lure="Fly Lure",
        sinking_minnow="Sinking Minnow",
        robber_rig="Robber Rig",
        sabiki_rig="Sabiki Rig",
        
        magnifying_specs="Magnifying Specs.",
        weavers_smock="Weaver's Smock",
        weavers_torque="Weaver's Torque",
        orvail_ring="Orvail Ring",
        craftmasters_ring="Craftmaster's Ring"}
	
	sets.Fishing = {
		range="Lu Shang's Fishing Rod", ammo=empty,
		head="Tlahtlamah Glasses", neck="Fisher's Torque",
		body="Fisherman's Smock", hands="Kachina Gloves", ring1="Noddy Ring", ring2="Puffin Ring",
		legs="Angler's Hose", feet="Waders"}
	
	-- Dark Rings
	
	gear.DarkRing = {}
	gear.DarkRing.PDT = {name="Dark Ring", augments={'Phys. dmg. taken -6%'}}
	
	--==================================--
	-- Skirmish gear
    --==================================--
	
	-- Weapons
	
	gear.Kumbhakarna = {}
	gear.Kumbhakarna.Acc1 = {name="Kumbhakarna", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Pet: Phys. dmg. taken -4%','Pet: TP Bonus+200'}}
	gear.Kumbhakarna.Acc2 = {name="Kumbhakarna", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: Phys. dmg. taken -2%','Pet: TP Bonus+200'}}
	
	-- Helios
	
	gear.HeliosBand = {}
	gear.HeliosBand.MAB = {name="Helios Band", augments={'Mag. Acc.+15 "Mag. Atk. Bns."+15'}}
	gear.HeliosBand.PhysBP = {name="Helios Band", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7'}}
    
    gear.HeliosJacket = {}
    gear.HeliosJacket.MAB = {name="Helios Jacket", augments={'"Mag. Atk. Bns."+25'}}
	
	gear.HeliosBoots = {}
	gear.HeliosBoots.MAB = {name="Helios Boots", augments={'Mag. Acc.+19 "Mag. Atk. Bns."+19'}}
	gear.HeliosBoots.PhysBP = {name="Helios Boots", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7'}}
	
	-- Taeon
	
	gear.TaeonChapeau = {}
	gear.TaeonChapeau.TA = {name="Taeon Chapeau", augments={'"Triple Atk."+2'}}
	gear.TaeonChapeau.DW = {name="Taeon Chapeau", augments={'"Dual Wield"+5'}}
	
	gear.TaeonTabard = {}
	gear.TaeonTabard.DW = {name="Taeon Tabard", augments={'"Dual Wield"+5'}}
	gear.TaeonTabard.FC = {name="Taeon Tabard", augments={'"Fast Cast"+5'}}
	
	gear.TaeonGloves = {}
	gear.TaeonGloves.DW = {name="Taeon Gloves", augments={'"Dual Wield"+5'}}
    gear.TaeonGloves.PetDTandWaltz = {name="Taeon Gloves", augments={'Pet: "Regen"+3','Pet: Damage taken -4%'}}
	
	gear.TaeonTights = {}
	gear.TaeonTights.TA = {name="Taeon Tights", augments={'"Triple Atk."+2'}}
	gear.TaeonTights.DW = {name="Taeon Tights", augments={'"Dual Wield"+5'}}
	gear.TaeonTights.PetDT = {name="Taeon Tights", augments={'Pet: "Regen"+3','Pet: Damage taken -4%'}}
	
	gear.TaeonBoots = {}
	gear.TaeonBoots.DW = {name="Taeon Boots", augments={'"Dual Wield"+4'}}
	gear.TaeonBoots.PetDT = {name="Taeon Boots", augments={'Pet: "Regen"+3','Pet: Damage taken -4%'}}
	
	-- Telchine
	
	gear.TelchineCap = {}
	gear.TelchineCap.Enh = {name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10'}}
	
	gear.TelchineChasuble = {}
	gear.TelchineChasuble.Enh = {name="Telchine Chasuble", augments={'Enh. Mag. eff. dur. +10'}}
	
	gear.TelchineGloves = {}
	gear.TelchineGloves.FCandEnh = {name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10'}}
	
    gear.TelchineBraconi = {}
    gear.TelchineBraconi.Enh = {name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10'}}
    
	gear.TelchinePigaches = {}
	gear.TelchinePigaches.Enh = {name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10'}}
	
	--==================================--
	-- Sinister Reign gear
    --==================================--
    
    gear.Malevolence = {}
    gear.Malevolence.Max = {name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5'}}
    gear.Malevolence.Mid = {name="Malevolence", augments={'INT+3','Mag. Acc.+5','"Mag.Atk.Bns."+7'}}
    
    gear.TamingSari = {}
    gear.TamingSari.High = {name="Taming Sari", augments={'STR+8','DEX+9','DMG:+13'}}
    gear.TamingSari.Mid = {name="Taming Sari", augments={'STR+6','DEX+9','DMG:+9'}}
    gear.TamingSari.TH = {name="Taming Sari", augments={'STR+1','"Treasure Hunter"+1'}}
	
	--==================================--
	-- Escha gear
    --==================================--
	
	-- Escha Zi'Tah weapons
	
	gear.NibiruCudgel = {}
	gear.NibiruCudgel.B1 = {name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15'}}
	gear.NibiruCudgel.B2 = {name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15'}}
	
	-- Despair
	
	gear.DespairHelm = {}
	gear.DespairHelm.D = {name="Despair Helm", augments={'STR+15','Enmity+7','"Store TP"+3'}}
	
	gear.DespairFingerGauntlets = {}
	gear.DespairFingerGauntlets.B = {name="Despair Finger Gauntlets", augments={'STR+12', 'VIT+7', 'Haste+2%'}}
	
	gear.DespairCuisses = {}
	gear.DespairCuisses.B = {name="Despair Cuisses", augments={'STR+12','VIT+7','Haste+2%'}}
	
	gear.DespairGreaves = {}
	gear.DespairGreaves.C = {name="Despair Greaves", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%'}}
	
    -- Eschite
    
    gear.EschiteCuisses = {}
    gear.EschiteCuisses.D = {name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5'}}
    
    gear.EschiteGreaves = {}
    gear.EschiteGreaves.A = {name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4'}}
    
	-- Psycloth
	
	gear.PsyclothLappas = {}
	gear.PsyclothLappas.D = {name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7'}}
	
	-- Rawhide
	
	gear.RawhideMask = {}
	gear.RawhideMask.A = {name="Rawhide Mask", augments={'DEX+10','STR+7','INT+7'}}
	
	gear.RawhideVest = {}
	gear.RawhideVest.A = {name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7'}}
	
	gear.RawhideGloves = {}
	gear.RawhideGloves.A = {name="Rawhide Gloves", augments={'DEX+10','STR+7','INT+7'}}
	
	gear.RawhideTrousers = {}
	gear.RawhideTrousers.A = {name="Rawhide Trousers", augments={'DEX+10','STR+7','INT+7'}}
	
	gear.RawhideBoots = {}
	gear.RawhideBoots.D = {name="Rawhide Boots", augments={'STR+10','Attack+15','"Store TP"+5'}}
	
	-- Vanya
	
	gear.VanyaHood = {}
	gear.VanyaHood.A = {name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6'}}
    gear.VanyaHood.D = {name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%'}}
	
	gear.VanyaRobe = {}
	gear.VanyaRobe.C = {name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6'}}
	
	gear.VanyaSlops = {}
	gear.VanyaSlops.C = {name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6'}}
	
	gear.VanyaClogs = {}
	gear.VanyaClogs.D = {name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6'}}
	
	--==================================--
	-- Escha abjuration gear
    --==================================--
    
    -- Adhemar
   
    
    gear.AdhemarBonnetPlus1 = {}
    gear.AdhemarBonnetPlus1.B = {name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20'}}
    
    gear.AdhemarJacketPlus1 = {}
    gear.AdhemarJacketPlus1.B = {name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20'}}
	
	gear.AdhemarWristbandsPlus1 = {}
    gear.AdhemarWristbandsPlus1.B = {name="Adhemar Wristbands +1", augments={'STR+12','DEX+12','Attack+20'}}

    gear.AdhemarKecks = {}
    gear.AdhemarKecks.C = {name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15'}}
	
    -- Amalric
	
    gear.AmalricDoubletPlus1 = {}
    gear.AmalricDoubletPlus1.A = {name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20'}}
    
    gear.AmalricGagesPlus1 = {}
    gear.AmalricGagesPlus1.A = {name="Amalric Gages +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20'}}
    
    gear.AmalricSlopsPlus1 = {}
    gear.AmalricSlopsPlus1.A = {name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20'}}
	
    gear.AmalricNailsPlus1 = {}
    gear.AmalricNailsPlus1.A = {name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20'}}
    
    -- Apogee
    
    gear.ApogeeCrownPlus1 = {}
    gear.ApogeeCrownPlus1.A = {name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8'}}
    
    gear.ApogeeDalmaticaPlus1 = {}
    gear.ApogeeDalmaticaPlus1.A = {name="Apogee Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8'}}
    
    gear.ApogeeSlacksPlus1 = {}
    gear.ApogeeSlacksPlus1.D = {name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4'}}
    
    gear.ApogeePumpsPlus1 = {}
    gear.ApogeePumpsPlus1.A = {name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8'}}
    
    -- Argosy
    
    gear.ArgosyCelata = {}
    gear.ArgosyCelata.A = {name="Argosy Celata", augments={'STR+10','DEX+10','Attack+15'}}
    
    -- Carmine
    
    gear.CarmineMaskPlus1 = {}
    gear.CarmineMaskPlus1.D = {name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4'}}
    
    gear.CarmineCuissesPlus1 = {}
    gear.CarmineCuissesPlus1.D = {name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6'}}
    
    gear.CarmineGreavesPlus1 = {}
    gear.CarmineGreavesPlus1.B = {name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20'}}
    
    -- Emicho
    
    gear.EmichoCoronet = {}
    gear.EmichoCoronet.C = {name="Emicho Coronet", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3'}}
    
    gear.EmichoHaubert = {}
    gear.EmichoHaubert.D = {name="Emicho Haubert", augments={'Pet: HP+100','Pet: INT+15','Pet: "Regen"+2'}}
    
    -- Lustratio
    
    gear.LustratioSubligar = {}
    gear.LustratioSubligar.B = {name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%'}}
    
    -- Ryuo
    
    gear.RyuoTekko = {}
    gear.RyuoTekko.A = {name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15'}}
    
    --==================================--
	-- Reisenjima gear
    --==================================--
    
    -- Weapons
    
    gear.Colada = {}
    gear.Colada.OH = {name="Colada", augments={'"Dbl.Atk."+2','DEX+15','Accuracy+20'}}
    
    gear.Gada = {}
    gear.Gada.MAB = {name="Gada", augments={'Enmity-2','Mag. Acc.+25','"Mag.Atk.Bns."+6','DMG:+2'}}
    
    gear.Grioavolr = {}
	gear.Grioavolr.MAB = {name="Grioavolr", augments={'Magic burst dmg.+4%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26'}}
	gear.Grioavolr.MagicBP = {name="Grioavolr", augments={'Blood Pact Dmg.+6','Pet: Mag. Acc.+1','Pet: "Mag.Atk.Bns."+25','DMG:+3'}}
    
    gear.Holliday = {}
    gear.Holliday.MAB = {name="Holliday", augments={'"Mag.Atk.Bns."+20','MND+6','Rng.Atk.+22','DMG:+17'}}
	
    gear.Skinflayer = {}
    gear.Skinflayer.WSD = {name="Skinflayer", augments={'Weapon skill damage +2%','STR+9','Attack+18','DMG:+16'}}
    
    -- Chironic
    
    gear.ChironicHat = {}
    gear.ChironicHat.DA = {name="Chironic Hat", augments={'"Dbl.Atk."+3','STR+10','Accuracy+14','Attack+14'}}
    gear.ChironicHat.MAB = {name="Chironic Hat", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Resist Silence"+5','MND+10','"Mag.Atk.Bns."+15'}}
    
    gear.ChironicGloves = {}
    gear.ChironicGloves.MAB = {name="Chironic Gloves", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +2','INT+1','Mag. Acc.+7','"Mag.Atk.Bns."+7'}}
    gear.ChironicGloves.WSD = {name="Chironic Gloves", augments={'Accuracy+12 Attack+12','"Subtle Blow"+5','Weapon skill damage +7%','Mag. Acc.+9 "Mag.Atk.Bns."+9'}}
    
    gear.ChironicHose = {}
    gear.ChironicHose.MAB = {name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+10','"Mag.Atk.Bns."+7'}}
    
    -- Herculean
    
    gear.HerculeanHelm = {}
    gear.HerculeanHelm.MAB = {name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+1','INT+6','"Mag.Atk.Bns."+9'}}
    
    gear.HerculeanVest = {}
    gear.HerculeanVest.TA = {name="Herculean Vest", augments={'Attack+13','"Triple Atk."+3','DEX+10'}}
    
    gear.HerculeanGloves = {}
    gear.HerculeanGloves.PDT = {name="Herculean Gloves", augments={'Accuracy+19','Phys. dmg. taken -4%','DEX+5'}}
    gear.HerculeanGloves.TA = {name="Herculean Gloves", augments={'Accuracy+16 Attack+16','"Triple Atk."+4','DEX+6','Attack+14'}}
    gear.HerculeanGloves.Waltz = {name="Herculean Gloves", augments={'Accuracy+3','"Waltz" potency +11%','AGI+6'}}
	gear.HerculeanGloves.Refresh = {name="Herculean Gloves", augments={'"Refresh"+1'}}
    
    gear.HerculeanTrousers = {}
    gear.HerculeanTrousers.STR = {name="Herculean Trousers", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Accuracy+18','Accuracy+14 Attack+14','Mag. Acc.+20 "Mag.Atk.Bns."+20'}}
    
    gear.HerculeanBoots = {}
    gear.HerculeanBoots.TA = {name="Herculean Boots", augments={'Accuracy+22 Attack+22','"Triple Atk."+3','Accuracy+9','Attack+7'}}
    gear.HerculeanBoots.WSD = {name="Herculean Boots", augments={'Pet: "Store TP"+4','Pet: Mag. Acc.+18','Weapon skill damage +7%','Accuracy+16 Attack+16','Mag. Acc.+8 "Mag.Atk.Bns."+8'}}
    
    -- Merlinic
    
    gear.MerlinicHood = {}
    gear.MerlinicHood.MAB = {name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +1','CHR+4','Mag. Acc.+11','"Mag.Atk.Bns."+11'}}
    
    gear.MerlinicJubbah = {}
    gear.MerlinicJubbah.DrainAspir = {name="Merlinic Jubbah", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Drain" and "Aspir" potency +8','CHR+6','Mag. Acc.+10','"Mag.Atk.Bns."+14'}}
    gear.MerlinicJubbah.MAB = {name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic Damage +13','CHR+1','Mag. Acc.+15','"Mag.Atk.Bns."+14'}}
    
    gear.MerlinicDastanas = {}
	gear.MerlinicDastanas.MagicBP = {name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+26','Blood Pact Dmg.+10','Pet: CHR+5'}}
    gear.MerlinicDastanas.PhysBP = {name="Merlinic Dastanas", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Blood Pact Dmg.+10','Pet: Mag. Acc.+5'}}
    
    gear.MerlinicShalwar = {}
    gear.MerlinicShalwar.MAB = {name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','INT+4','Mag. Acc.+1'}}
 
    gear.MerlinicCrackows = {}
    gear.MerlinicCrackows.MAB = {name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','CHR+3','Mag. Acc.+7','"Mag.Atk.Bns."+10'}}
    
    -- Odyssean
    
    gear.OdysseanChestplate = {}
    gear.OdysseanChestplate.FC = {name="Odyss0. Chestplate", augments={'"Fast Cast"+3','AGI+3','Mag. Acc.+11','"Mag.Atk.Bns."+15'}}
    
    gear.OdysseanCuisses = {}
    gear.OdysseanCuisses.TP = {name="Odyssean Cuisses", augments={'Accuracy+24 Attack+24','DEX+7','Attack+9'}}
    
    -- Valorous
    
    gear.ValorousMask = {}
    gear.ValorousMask.Pet ={name="Valorous Mask", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Pet: DEX+5','Pet: Accuracy+13 Pet: Rng. Acc.+13'}}
    
    gear.ValorousMitts = {}
    gear.ValorousMitts.Pet = {name="Valorous Mitts", augments={'Pet: Attack+26 Pet: Rng.Atk.+26','Pet: Phys. dmg. taken -4%','Pet: Accuracy+12 Pet: Rng. Acc.+12'}}
    gear.ValorousMitts.TP = {name="Valorous Mitts", augments={'Accuracy+20 Attack+20','"Store TP"+1'}}
    
    gear.ValorousHose = {}
    gear.ValorousHose.Pet = {name="Valorous Hose", augments={'Pet: "Subtle Blow"+9','Pet: STR+14','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+13 Pet: Rng.Atk.+13'}}
    gear.ValorousHose.WSD = {name="Valorous Hose", augments={'Accuracy+16 Attack+16','Damage taken-1%','VIT+4','Accuracy+12','Attack+14'}}
    
    gear.ValorousGreaves = {}
    gear.ValorousGreaves.Pet = {name="Valorous Greaves", augments={'Pet: Accuracy+30 Pet: Rng. Acc.+30','Pet: "Dbl. Atk."+2','Pet: STR+9','Pet: Attack+1 Pet: Rng.Atk.+1'}}
end