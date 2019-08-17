---- Gearsets your character will use among multiple jobs.

sets.Sheltered = {ring2="Sheltered Ring"}
sets.Capacity = {back="Mecistopins Mantle"}

sets.buff.Doom = {neck="Nicander's Necklace", waist="Gishdubar Sash"} -- ring1="Eshmun's Ring",ring2="Eshmun's Ring"
sets.TreasureHunter = {waist="Chaac Belt"}

sets.precast.Item['Hallowed Water'] = {}
sets.precast.Item['Holy Water'] = {}

---- Augmented items that you'll use among multiple jobs.

gear.DarkRing = {}
gear.DarkRing.PDT = {name="Dark Ring", augments={'Phys. dmg. taken -6%'}}

---- Skirmish weapons.

gear.Kumbhakarna = {}
gear.Kumbhakarna.Acc1 = {name="Kumbhakarna", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Pet: Phys. dmg. taken -4%','Pet: TP Bonus+200'}}
gear.Kumbhakarna.Acc2 = {name="Kumbhakarna", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: Phys. dmg. taken -2%','Pet: TP Bonus+200'}}

gear.Linos = {}
gear.Linos.DT = {name="Linos", augments={'Mag. Evasion+15','Phys. dmg. taken -4%'}}
gear.Linos.TP = {name="Linos", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+2','Quadruple Attack +3'}}

---- Sinister Reign gear.

gear.Malevolence = {}
gear.Malevolence.Max = {name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5'}}
gear.Malevolence.High = {name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+8','"Fast Cast"+5'}}

gear.TamingSari = {}
gear.TamingSari.High = {name="Taming Sari", augments={'STR+8','DEX+9','DMG:+13'}}
gear.TamingSari.Mid = {name="Taming Sari", augments={'STR+6','DEX+9','DMG:+9'}}
gear.TamingSari.TH = {name="Taming Sari", augments={'STR+1','"Treasure Hunter"+1'}}

gear.Vampirism = {}
gear.Vampirism.High1 = {name="Vampirism", augments={'STR+8','INT+9','"Occult Acumen"+8','DMG:+14'}}
gear.Vampirism.High2 = {name="Vampirism", augments={'STR+9','INT+8','"Occult Acumen"+9','DMG:+13'}}

---- Escha Zi'Tah weapons.

gear.NibiruCudgel = {}
gear.NibiruCudgel.B = {name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15'}}

---- Escha Ru'Aun weapons.

gear.Kali = {}
gear.Kali.A = {name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15'}}

gear.Solstice = {}
gear.Solstice.B = {name="Solstice", augments={'MP+60','INT+15','Mag. Acc.+15'}}

---- Reisenjima weapons.

gear.Colada = {}
gear.Colada.DA = {name="Colada", augments={'"Dbl.Atk."+3','STR+5','Accuracy+20','Attack+1'}}

gear.Gada = {}
gear.Gada.Enh = {name="Gada", augments={'Enh. Mag. eff. dur. +5','VIT+5','Mag. Acc.+9','DMG:+8'}}

gear.Grioavolr = {}
gear.Grioavolr.MAB = {name="Grioavolr", augments={'Magic burst dmg.+4%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26'}}

gear.Holliday = {}
gear.Holliday.MAB = {name="Holliday", augments={'"Mag.Atk.Bns."+20','MND+6','Rng.Atk.+22','DMG:+17'}}

gear.Skinflayer = {}
gear.Skinflayer.WSD = {name="Skinflayer", augments={'Weapon skill damage +2%','STR+9','Attack+18','DMG:+16'}}

---- Helios armor.

gear.HeliosBand = {}
gear.HeliosJacket = {}
gear.HeliosBoots = {}

-- Magic burst. Placeholder piece, really.

gear.HeliosJacket.MB = {name="Helios Jacket", augments={'"Mag.Atk.Bns."+25','Spell interruption rate down -10%','Magic burst dmg.+9%'}}

-- Blood Pact damage. Helios band and boots are used for physical BPs. Augments have to be basically perfect for this.
-- Ideal augments are {'Pet: Accuracy+30' or 'Pet: Attack +30','Pet: "Dbl. Atk."+8','Blood Pact Damage+7'}.

gear.HeliosBand.PhysBP = {name="Helios Band", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7'}}
gear.HeliosBoots.PhysBP = {name="Helios Boots", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7'}}

---- Taeon armor.

gear.TaeonChapeau = {}
gear.TaeonTabard = {}
gear.TaeonGloves = {}
gear.TaeonTights = {}
gear.TaeonBoots = {}

-- Triple Attack. Some of these can probably be phased out or turned into DW pieces. Need to theorycraft max haste sets
-- for RDM and BST (especially the former).
-- Ideal augments are {'Accuracy+20 Attack+20','"Triple Atk."+2','STR+7 DEX+7'}.

gear.TaeonChapeau.TA = {name="Taeon Chapeau", augments={'Accuracy+18 Attack+18','"Triple Atk."+2','STR+6 DEX+6'}}
gear.TaeonTights.TA = {name="Taeon Tights", augments={'Accuracy+18 Attack+18','"Triple Atk."+2','STR+7 DEX+7'}}

-- Dual Wield. All five are useful for various jobs, including RDM and BST, in low-haste situations.
-- Ideal augments are {'Accuracy+20 Attack+20','"Dual Wield"+5','STR+7 DEX+7'}.

gear.TaeonChapeau.DW = {name="Taeon Chapeau", augments={'Accuracy+20 Attack+20','"Dual Wield"+5','STR+5 DEX+5'}}
gear.TaeonTabard.DW = {name="Taeon Tabard", augments={'Accuracy+18 Attack+18','"Dual Wield"+5','STR+5 DEX+5'}}
gear.TaeonGloves.DW = {name="Taeon Gloves", augments={'Accuracy+18 Attack+18','"Dual Wield"+5','STR+5 DEX+5'}}
gear.TaeonTights.DW = {name="Taeon Tights", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','STR+7 DEX+7'}}
gear.TaeonBoots.DW = {name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+5','STR+5 DEX+5'}}

-- Pet meva, regen, and DT. Head is not needed because of Anwig Salade. BST uses hands and feet, PUP uses all four.
-- Ideal augments are {'Pet: Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%'}.

gear.TaeonTabard.Pet = {name="Taeon Tabard", augments={'Pet: Mag. Evasion+23','Pet: "Regen"+3','Pet: Damage taken -4%'}}
gear.TaeonGloves.Pet = {name="Taeon Gloves", augments={'Pet: Mag. Evasion+20','Pet: "Regen"+3','Pet: Damage taken -4%'}}
gear.TaeonTights.Pet = {name="Taeon Tights", augments={'Pet: Mag. Evasion+20','Pet: "Regen"+3','Pet: Damage taken -4%'}}
gear.TaeonBoots.Pet = {name="Taeon Boots", augments={'Pet: Mag. Evasion+23','Pet: "Regen"+3','Pet: Damage taken -4%'}}

-- Fast Cast and Phalanx. For FC, tabard is BIS or tied for many jobs, others would really only be used for BST.
-- Phalanx is used by all jobs that can equip Taeon, since it is a 'received' effect.
-- Ideal augments are {'Mag. Evasion+20','"Fast Cast"+5','Phalanx +3'}.

gear.TaeonChapeau.PhalanxFC = {name="Taeon Chapeau", augments={'"Fast Cast"+5','Phalanx +3'}}
gear.TaeonTabard.PhalanxFC = {name="Taeon Tabard", augments={'Mag. Evasion+18','"Fast Cast"+5','Phalanx +3'}}
gear.TaeonGloves.PhalanxFC = {name="Taeon Gloves", augments={'Mag. Evasion+17','"Fast Cast"+5','Phalanx +3'}}
gear.TaeonTights.PhalanxFC = {name="Taeon Tights", augments={'"Fast Cast"+5','Phalanx +3'}}
gear.TaeonBoots.PhalanxSIRD = {name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3'}}

-- Snapshot. Only the head is relevant to RNG and COR.
-- Ideal augments are {'Mag. Evasion+20','"Snapshot"+5','"Snapshot"+5'}.

gear.TaeonChapeau.Snapshot = {name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5'}}

---- Telchine armor.

gear.TelchineCap = {}
gear.TelchineChasuble = {}
gear.TelchineGloves = {}
gear.TelchineBraconi = {}
gear.TelchinePigaches = {}

-- Enhancing magic effect duration.
-- Ideal augments are {'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10'}, but the Leaf slot can vary.
-- In particular, the hands are useful with Fast Cast for Summoner, and the feet are useful with Song spellcasting time for Bard.

gear.TelchineCap.Enh = {name="Telchine Cap", augments={'Mag. Evasion+19','"Conserve MP"+3','Enh. Mag. eff. dur. +10'}}
gear.TelchineChasuble.Enh = {name="Telchine Chasuble", augments={'Mag. Evasion+17','"Conserve MP"+3','Enh. Mag. eff. dur. +10'}}
gear.TelchineGloves.Enh = {name="Telchine Gloves", augments={'Mag. Evasion+17','"Fast Cast"+5','Enh. Mag. eff. dur. +10'}}
gear.TelchineBraconi.Enh = {name="Telchine Braconi", augments={'Mag. Evasion+20','"Conserve MP"+3','Enh. Mag. eff. dur. +10'}}
gear.TelchinePigaches.Enh = {name="Telchine Pigaches", augments={'Mag. Evasion+24','Song spellcasting time -7%','Enh. Mag. eff. dur. +10'}}

-- Pet meva, regen, and DT. Idris GEO uses probably hands and legs at most, pre-Idris GEO uses others.
-- Ideal augments are {'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%'}.

gear.TelchineCap.Pet = {name="Telchine Cap", augments={'Mag. Evasion+22','Pet: "Regen"+3','Pet: Damage taken -3%'}}
gear.TelchineChasuble.Pet = {name="Telchine Chasuble", augments={'Pet: "Regen"+3','Pet: Damage taken -3%'}}
gear.TelchineGloves.Pet = {name="Telchine Gloves", augments={'Mag. Evasion+21','Pet: "Regen"+3','Pet: Damage taken -4%'}}
gear.TelchineBraconi.Pet = {name="Telchine Braconi", augments={'Mag. Evasion+20','Pet: "Regen"+3','Pet: Damage taken -4%'}}
gear.TelchinePigaches.Pet = {name="Telchine Pigaches", augments={'Pet: "Subtle Blow"+3','Pet: Damage taken -3%'}}

-- Despair armor.

gear.DespairHelm = {}
gear.DespairHelm.D = {name="Despair Helm", augments={'STR+15','Enmity+7','"Store TP"+3'}}

gear.DespairFingerGauntlets = {}
gear.DespairFingerGauntlets.B = {name="Despair Finger Gauntlets", augments={'STR+12','VIT+7','Haste+2%'}}

gear.DespairCuisses = {}
gear.DespairCuisses.B = {name="Despair Cuisses", augments={'STR+12','VIT+7','Haste+2%'}}

gear.DespairGreaves = {}
gear.DespairGreaves.C = {name="Despair Greaves", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%'}}

-- Eschite armor.

gear.EschiteCuisses = {}
gear.EschiteCuisses.D = {name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5'}}

gear.EschiteGreaves = {}
gear.EschiteGreaves.A = {name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4'}}

-- Psycloth armor.

gear.PsyclothLappas = {}
gear.PsyclothLappas.D = {name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7'}}

-- Rawhide armor.

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

-- Vanya armor.

gear.VanyaHood = {}
gear.VanyaHood.A = {name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6'}}
gear.VanyaHood.D = {name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%'}}

gear.VanyaRobe = {}
gear.VanyaRobe.C = {name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6'}}

gear.VanyaSlops = {}
gear.VanyaSlops.C = {name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6'}}

gear.VanyaClogs = {}
gear.VanyaClogs.D = {name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6'}}

---- Adhemar armor.

gear.AdhemarBonnetPlus1 = {}
gear.AdhemarBonnetPlus1.B = {name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20'}}

gear.AdhemarJacketPlus1 = {}
gear.AdhemarJacketPlus1.B = {name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20'}}
gear.AdhemarJacketPlus1.D = {name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4'}}

gear.AdhemarWristbandsPlus1 = {}
gear.AdhemarWristbandsPlus1.B = {name="Adhemar Wristbands +1", augments={'STR+12','DEX+12','Attack+20'}}

gear.AdhemarKecks = {}
gear.AdhemarKecks.C = {name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15'}}

---- Amalric armor.

gear.AmalricDoubletPlus1 = {}
gear.AmalricDoubletPlus1.A = {name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20'}}

gear.AmalricGagesPlus1 = {}
gear.AmalricGagesPlus1.A = {name="Amalric Gages +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20'}}

gear.AmalricSlopsPlus1 = {}
gear.AmalricSlopsPlus1.A = {name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20'}}

gear.AmalricNailsPlus1 = {}
gear.AmalricNailsPlus1.A = {name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20'}}

---- Apogee armor.

gear.ApogeeCrownPlus1 = {}
gear.ApogeeCrownPlus1.A = {name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8'}}

gear.ApogeeDalmaticaPlus1 = {}
gear.ApogeeDalmaticaPlus1.A = {name="Apogee Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8'}}

gear.ApogeeSlacksPlus1 = {}
gear.ApogeeSlacksPlus1.D = {name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4'}}

gear.ApogeePumpsPlus1 = {}
gear.ApogeePumpsPlus1.A = {name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8'}}

---- Argosy armor.

gear.ArgosyCelata = {}
gear.ArgosyCelata.A = {name="Argosy Celata", augments={'STR+10','DEX+10','Attack+15'}}

---- Carmine armor.

gear.CarmineMaskPlus1 = {}
gear.CarmineMaskPlus1.D = {name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4'}}

gear.CarmineCuissesPlus1 = {}
gear.CarmineCuissesPlus1.D = {name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6'}}

gear.CarmineGreavesPlus1 = {}
gear.CarmineGreavesPlus1.D = {name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4'}}

---- Emicho armor.

gear.EmichoCoronet = {}
gear.EmichoCoronet.C = {name="Emicho Coronet", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3'}}

gear.EmichoHaubert = {}
gear.EmichoHaubert.D = {name="Emicho Haubert", augments={'Pet: HP+100','Pet: INT+15','Pet: "Regen"+2'}}

---- Kaykaus armor.

gear.KaykausMitraPlus1 = {}
gear.KaykausMitraPlus1.B = {name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6'}}

gear.KaykausBliautPlus1 = {}
gear.KaykausBliautPlus1.D = {name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" potency +6%','"Conserve MP"+7'}}

gear.KaykausCuffsPlus1 = {}
gear.KaykausCuffsPlus1.A = {name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20'}}

gear.KaykausTightsPlus1 = {}
gear.KaykausTightsPlus1.B = {name="Kaykaus Tights +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6'}}

gear.KaykausBootsPlus1 = {}
gear.KaykausBootsPlus1.B = {name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6'}}

---- Lustratio armor.

gear.LustratioSubligarPlus1 = {}
gear.LustratioSubligarPlus1.B = {name="Lustratio Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%'}}

gear.LustratioLeggingsPlus1 = {}
gear.LustratioLeggingsPlus1.D = {name="Lustratio Leggings +1", augments={'HP+65','STR+15','DEX+15'}}

-- Ryuo armor.

gear.RyuoTekko = {}
gear.RyuoTekko.A = {name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15'}}

---- Chironic armor.

gear.ChironicHat = {}
gear.ChironicHat.Nuke = {name="Chironic Hat", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Resist Silence"+5','MND+10','"Mag.Atk.Bns."+15'}}
gear.ChironicHat.TP = {name="Chironic Hat", augments={'"Dbl.Atk."+3','STR+10','Accuracy+14','Attack+14'}}

gear.ChironicGloves = {}
gear.ChironicGloves.Nuke = {name="Chironic Gloves", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +2','INT+1','Mag. Acc.+7','"Mag.Atk.Bns."+7'}}
gear.ChironicGloves.WSD = {name="Chironic Gloves", augments={'Accuracy+12 Attack+12','"Subtle Blow"+5','Weapon skill damage +7%','Mag. Acc.+9 "Mag.Atk.Bns."+9'}}

gear.ChironicHose = {}
gear.ChironicHose.Nuke = {name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+10','"Mag.Atk.Bns."+7'}}

---- Herculean armor.

gear.HerculeanHelm = {}
gear.HerculeanHelm.Nuke = {name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+1','INT+6','"Mag.Atk.Bns."+9'}}
gear.HerculeanHelm.PDT = {name="Herculean Helm", augments={'Attack+12','Phys. dmg. taken -4%','STR+10'}}

gear.HerculeanVest = {}
gear.HerculeanVest.TP = {name="Herculean Vest", augments={'Attack+13','"Triple Atk."+3','DEX+10'}}

gear.HerculeanGloves = {}
gear.HerculeanGloves.TA = {name="Herculean Gloves", augments={'Accuracy+16 Attack+16','"Triple Atk."+4','DEX+6','Attack+14'}}
gear.HerculeanGloves.PDT = {name="Herculean Gloves", augments={'Accuracy+19','Phys. dmg. taken -4%','DEX+5'}}
gear.HerculeanGloves.Refresh = {name="Herculean Gloves", augments={'"Mag.Atk.Bns."+10','"Dual Wield"+2','"Refresh"+1','Mag. Acc.+18 "Mag.Atk.Bns."+18'}}
gear.HerculeanGloves.Waltz = {name="Herculean Gloves", augments={'Accuracy+3','"Waltz" potency +11%','AGI+6'}}

gear.HerculeanTrousers = {}
gear.HerculeanTrousers.HybridWhy = {name="Herculean Trousers", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Accuracy+18','Accuracy+14 Attack+14','Mag. Acc.+20 "Mag.Atk.Bns."+20'}}

gear.HerculeanBoots = {}
gear.HerculeanBoots.TA = {name="Herculean Boots", augments={'Accuracy+22 Attack+22','"Triple Atk."+3','Accuracy+9','Attack+7'}}
gear.HerculeanBoots.WSD = {name="Herculean Boots", augments={'Pet: "Store TP"+4','Pet: Mag. Acc.+18','Weapon skill damage +7%','Accuracy+16 Attack+16','Mag. Acc.+8 "Mag.Atk.Bns."+8'}}
gear.HerculeanBoots.Spare = {name="Herculean Boots", augments={'Rng.Atk.+11','"Triple Atk."+2','Accuracy+11'}}

---- Merlinic armor.

gear.MerlinicHood = {}
gear.MerlinicHood.MAB = {name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Enmity-3','VIT+2','Mag. Acc.+15','"Mag.Atk.Bns."+11'}}

gear.MerlinicJubbah = {}
gear.MerlinicJubbah.DrainAspir = {name="Merlinic Jubbah", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Drain" and "Aspir" potency +8','CHR+6','Mag. Acc.+10','"Mag.Atk.Bns."+14'}}
gear.MerlinicJubbah.MAB = {name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic Damage +13','CHR+1','Mag. Acc.+15','"Mag.Atk.Bns."+14'}}
gear.MerlinicJubbah.MAB2 = {name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic Damage +1','INT+3','Mag. Acc.+10','"Mag.Atk.Bns."+10'}}

gear.MerlinicDastanas = {}
gear.MerlinicDastanas.PhysBP = {name="Merlinic Dastanas", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Blood Pact Dmg.+10','Pet: Mag. Acc.+5'}}

gear.MerlinicShalwar = {}
gear.MerlinicShalwar.Burst = {name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','INT+4','Mag. Acc.+1'}}

gear.MerlinicCrackows = {}
gear.MerlinicCrackows.MAB = {name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','CHR+3','Mag. Acc.+7','"Mag.Atk.Bns."+10'}}

---- Odyssean armor.

gear.OdysseanChestplate = {}
gear.OdysseanChestplate.FC = {name="Odyssean Chestplate", augments={'"Fast Cast"+3','AGI+3','Mag. Acc.+11','"Mag.Atk.Bns."+15'}}

gear.OdysseanCuisses = {}
gear.OdysseanCuisses.TP = {name="Odyssean Cuisses", augments={'Accuracy+24 Attack+24','DEX+7','Attack+9'}}

---- Valorous armor.

gear.ValorousMask = {}
gear.ValorousMask.PhysReady = {name="Valorous Mask", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Pet: DEX+5','Pet: Accuracy+13 Pet: Rng. Acc.+13'}}

gear.ValorousMail = {}
gear.ValorousMail.PhysReady = {name="Valorous Mail", augments={'Pet: Attack+22 Pet: Rng.Atk.+22','Pet: Phys. dmg. taken -3%','Pet: STR+11','Pet: Accuracy+8 Pet: Rng. Acc.+8'}}

gear.ValorousMitts = {}
gear.ValorousMitts.PhysReady = {name="Valorous Mitts", augments={'Pet: Attack+26 Pet: Rng.Atk.+26','Pet: Phys. dmg. taken -4%','Pet: Accuracy+12 Pet: Rng. Acc.+12'}}

gear.ValorousHose = {}
gear.ValorousHose.PhysReady = {name="Valorous Hose", augments={'Pet Attack+28 Pet Rng.Atk.+28','Pet Subtle Blow+10','Pet STR+12','Pet Accuracy+9 Pet Rng. Acc.+9'}}
gear.ValorousHose.MagicReady = {name="Valorous Hose", augments={'Pet Mag.Atk.Bns.+24','Pet Subtle Blow+10','Pet INT+15','Pet Accuracy+4 Pet Rng. Acc.+4','Pet Attack+6 Pet Rng.Atk.+6'}}

gear.ValorousGreaves = {}
gear.ValorousGreaves.PhysReady = {name="Valorous Greaves", augments={'Pet: Accuracy+30 Pet: Rng. Acc.+30','Pet: "Dbl. Atk."+2','Pet: STR+9','Pet: Attack+1 Pet: Rng.Atk.+1'}}

--[[
gear.gada_enhancing_club = {name="Gada",augments={'Enh. Mag. eff. dur. +6','STR+3','Mag. Acc.+8','"Mag.Atk.Bns."+17','DMG:+7',}}
gear.gada_healing_club = {name="Gada",augments={'"Cure" potency +9%','Mag. Acc.+11','"Mag.Atk.Bns."+13','DMG:+3',}}
gear.gada_matk_club = {name="Gada",augments={'Mag. Acc.+23','"Mag.Atk.Bns."+24','DMG:+14',}}
gear.grioavolr_nuke_staff = {name="Grioavolr",augments={'Magic burst dmg.+8%','MP+61','Mag. Acc.+16','"Mag.Atk.Bns."+30','Magic Damage +7',}}
gear.grioavolr_fc_staff = {name="Grioavolr",augments={'"Fast Cast"+7','MP+20','Mag. Acc.+17','"Mag.Atk.Bns."+10','Magic Damage +5',}}
gear.grioavolr_pet_staff = {name="Grioavolr",augments={'Blood Pact Dmg.+8','Pet: STR+10','Pet: Mag. Acc.+19','Pet: "Mag.Atk.Bns."+30',}}

gear.chironic_enfeeble_hands = {name="Chironic Gloves",augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','MND+10','Mag. Acc.+15',}}
gear.chironic_refresh_hands = {name="Chironic Gloves",augments={'"Counter"+4','DEX+4','"Refresh"+2','Accuracy+19 Attack+19','Mag. Acc.+13 "Mag.Atk.Bns."+13',}}
gear.chironic_treasure_feet = {name="Chironic Slippers",augments={'"Occult Acumen"+8','MND+7','"Treasure Hunter"+2',}}
gear.chironic_nuke_feet = {name="Chironic Slippers",augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +10','CHR+6','"Mag.Atk.Bns."+15',}}
gear.chironic_refresh_feet = {name="Chironic Slippers",augments={'Pet: Mag. Acc.+18 Pet: "Mag.Atk.Bns."+18','Pet: Mag. Acc.+3','"Refresh"+1','Accuracy+13 Attack+13','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}

gear.herculean_fc_head = {name="Herculean Helm",augments={'"Fast Cast"+6','"Mag.Atk.Bns."+13',}}
gear.herculean_nuke_head = {name="Herculean Helm",augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Enmity-3','INT+9','"Mag.Atk.Bns."+13',}}
gear.herculean_dt_hands = {name="Herculean Gloves",augments={'Attack+4','Damage taken-4%',}}
gear.herculean_refresh_hands = {name="Herculean Gloves",augments={'Enmity+2','Pet: "Store TP"+4','"Refresh"+1',}}
gear.herculean_waltz_hands = {name="Herculean Gloves",augments={'Rng.Acc.+16','"Waltz" potency +11%','AGI+1',}}
gear.herculean_waltz_body = {name="Herculean Vest",augments={'Attack+26','"Waltz" potency +11%','AGI+4','Accuracy+5',}}
gear.herculean_wsd_body = {name="Herculean Vest",augments={'Accuracy+11','Weapon skill damage +5%','DEX+7',}}
gear.herculean_dt_legs = {name="Herculean Trousers",augments={'Attack+15','Damage taken-4%','STR+3','Accuracy+12',}}
gear.herculean_wsd_legs = {name="Herculean Trousers",augments={'Weapon skill damage +5%','DEX+8','Accuracy+13','Attack+14',}}
gear.herculean_nuke_legs = {name="Herculean Trousers",augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Damage taken-2%','"Mag.Atk.Bns."+14',}}
gear.herculean_acc_feet = {name="Herculean Boots",augments={'Accuracy+25 Attack+25','Crit. hit damage +1%','DEX+10','Accuracy+14','Attack+1',}}
gear.herculean_ta_feet = {name="Herculean Boots",augments={'Accuracy+19 Attack+19','"Triple Atk."+4','DEX+5','Accuracy+8','Attack+11',}}
gear.herculean_dt_feet = {name="Herculean Boots",augments={'Damage taken-4%','MND+7','Attack+6',}}
gear.herculean_wsd_feet = {name="Herculean Boots",augments={'Accuracy+23 Attack+23','Weapon skill damage +5%','DEX+10','Accuracy+10','Attack+1',}}
gear.herculean_waltz_feet = {name="Herculean Boots",augments={'Attack+10','"Waltz" potency +10%','AGI+4','Accuracy+9',}}
gear.herculean_nuke_feet = {name="Herculean Boots",augments={'"Mag.Atk.Bns."+23','Rng.Acc.+14','Phalanx +1','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
gear.herculean_refresh_feet = {name="Herculean Boots",augments={'CHR+8','Rng.Acc.+7','"Refresh"+1','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}

gear.merlinic_nuke_head = {name="Merlinic Hood",augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','INT+15','Mag. Acc.+3','"Mag.Atk.Bns."+13',}}
gear.merlinic_nuke_body = {name="Merlinic Jubbah",augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Occult Acumen"+4','INT+10','Mag. Acc.+2','"Mag.Atk.Bns."+15',}}
gear.merlinic_occult_body = {name="Merlinic Jubbah",augments={'Mag. Acc.+14','"Occult Acumen"+11','MND+6',}}
gear.merlinic_refresh_hands = {name="Merlinic Dastanas",augments={'Attack+17','Pet: INT+5','"Refresh"+2','Accuracy+11 Attack+11',}}
gear.merlinic_magpact_hands = {name="Merlinic Dastanas",augments={'Pet: Mag. Acc.+27','Blood Pact Dmg.+10','Pet: DEX+8','Pet: "Mag.Atk.Bns."+13',}}
gear.merlinic_physpact_hands = {name="Merlinic Dastanas",augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Blood Pact Dmg.+10','Pet: STR+7','Pet: Mag. Acc.+6',}}
gear.merlinic_occult_hands = {name="Merlinic Dastanas",augments={'"Mag.Atk.Bns."+25','"Occult Acumen"+11','CHR+9',}}
gear.merlinic_nuke_feet = {name="Merlinic Crackows",augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Conserve MP"+1','INT+11','Mag. Acc.+3','"Mag.Atk.Bns."+15',}}
gear.merlinic_aspir_feet = {name="Merlinic Crackows",augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +10','Mag. Acc.+15',}}
gear.merlinic_treasure_feet = {name="Merlinic Crackows",augments={'Accuracy+5','"Snapshot"+2','"Treasure Hunter"+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}
gear.merlinic_refresh_feet = {name="Merlinic Crackows",augments={'Pet: DEX+7','Pet: Mag. Acc.+7','"Refresh"+2','Accuracy+20 Attack+20',}}
gear.merlinic_occult_feet = {name="Merlinic Crackows",augments={'"Occult Acumen"+11','INT+8','Mag. Acc.+4',}}

gear.odyssean_wsd_hands = { name="Odyssean Gauntlets",augments={'Accuracy+26','Weapon skill damage +4%','STR+6','Attack+14',}}
gear.odyssean_stp_legs = {name="Odyssean Cuisses",augments={'Accuracy+28','"Store TP"+6','DEX+9',}}
gear.odyssean_fc_legs = {name="Odyssean Cuisses",augments={'"Fast Cast"+6','"Mag.Atk.Bns."+12',}}

gear.valorous_magical_wsd_head = {name="Valorous Mask",augments={'"Mag.Atk.Bns."+17','Weapon skill damage +5%','Attack+10',}}
gear.valorous_wsd_head = {name="Valorous Mask",augments={'Attack+23','Weapon skill damage +4%','Accuracy+15',}}
gear.valorous_pet_head = {name="Valorous Mask",augments={'Pet: "Mag.Atk.Bns."+25','Pet: "Regen"+3','Pet: INT+14','Pet: Accuracy+2 Pet: Rng. Acc.+2',}}
gear.valorous_pet_body = {name="Valorous Mail",augments={'Pet: "Mag.Atk.Bns."+26','"Dbl.Atk."+3','Pet: INT+8','Pet: Accuracy+13 Pet: Rng. Acc.+13','Pet: Attack+12 Pet: Rng.Atk.+12',}}
gear.valorous_wsd_body = {name="Valorous Mail",augments={'Accuracy+25 Attack+25','Weapon skill damage +4%','Accuracy+10','Attack+12',}}
gear.valorous_wsd_hands = {name="Valorous Mitts",augments={'Accuracy+30','Weapon skill damage +2%','STR+10','Attack+10',}}
gear.valorous_acc_hands = {name="Valorous Mitts",augments={'Accuracy+21 Attack+21','"Store TP"+4','Accuracy+15','Attack+9',}}
gear.valorous_physical_pet_legs = {name="Valor. Hose",augments={'Pet: Attack+29 Pet: Rng.Atk.+29','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Pet: STR+8','Pet: Accuracy+8 Pet: Rng. Acc.+8',}}
gear.valorous_magical_pet_legs = { name="Valor. Hose",augments={'Pet: "Mag.Atk.Bns."+28','Pet: "Regen"+3','Pet: INT+13','Pet: Attack+2 Pet: Rng.Atk.+2',}}
gear.valorous_magical_pet_feet = {name="Valorous Greaves",augments={'Pet: "Mag.Atk.Bns."+29','Pet: "Dbl.Atk."+1 Pet: Crit.hit rate +1','Pet: INT+9','Pet: Accuracy+1 Pet: Rng. Acc.+1','Pet: Attack+4 Pet: Rng.Atk.+4',}}
gear.valorous_wsd_feet = {name="Valorous Greaves",augments={'Accuracy+25','Weapon skill damage +4%','STR+5',}}

]]--
