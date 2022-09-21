const ICON_EVENT = "!ui/squads/event_squad_icon.svg"

// TODO most squad identifiers are equal to arguments of factory helper functions
// static table generation probably should be changed to map of callbacks, so
// acquiring of squad data will be transformed to: sqPres?[armyId][squadId]()

let mkGenSquad = @(armyId) @(id, override = {}) {
  nameLocId = $"squad/{id}"
  titleLocId = $"regiment/{id}"
  manageLocId = $"regiment/{id}"
  announceLocId = $"squadannounce/{id}"
  summaryLocId = $"squadsummary/{id}"
  icon = $"!ui/soldiers/{armyId}/{id}_icon.svg"
  image = $"ui/soldiers/{armyId}/{id}_image.jpg"
  // other possible keys to override: premIcon
}.__update(override)

let genSquadUssr = mkGenSquad("ussr")
let genSquadGer = mkGenSquad("germany")
let genSquadUsa = mkGenSquad("usa")
let genSquadJap = mkGenSquad("japan")

return freeze({
  berlin_allies = {
    ussr_berlin_tank_1 = genSquadUssr("ussr_berlin_tank_1")
    ussr_berlin_mortarman_1 = genSquadUssr("ussr_berlin_mortarman_1")
    ussr_berlin_antitank_1 = genSquadUssr("ussr_berlin_antitank_1")
    ussr_berlin_mgun_1 = genSquadUssr("ussr_berlin_mgun_1")
    ussr_berlin_pilot_fighter_1 = genSquadUssr("ussr_berlin_pilot_fighter_1")
    ussr_berlin_sniper_1 = genSquadUssr("ussr_berlin_sniper_1")
    ussr_berlin_rifle_1 = genSquadUssr("ussr_berlin_rifle_1")
    ussr_berlin_assault_1 = genSquadUssr("ussr_berlin_assault_1")
    ussr_berlin_flametrooper_1 = genSquadUssr("ussr_berlin_flametrooper_1")
    ussr_berlin_radioman_1 = genSquadUssr("ussr_berlin_radioman_1")
    ussr_berlin_pilot_assaulter_1 = genSquadUssr("ussr_berlin_pilot_assaulter_1")
    ussr_berlin_engineer_1 = genSquadUssr("ussr_berlin_engineer_1")
    ussr_berlin_sniper_2 = genSquadUssr("ussr_berlin_sniper_2")
    ussr_berlin_assault_2 = genSquadUssr("ussr_berlin_assault_2")
    ussr_berlin_rifle_2 = genSquadUssr("ussr_berlin_rifle_2")
    ussr_berlin_pilot_assaulter_2 = genSquadUssr("ussr_berlin_pilot_assaulter_2")
    ussr_berlin_engineer_2 = genSquadUssr("ussr_berlin_engineer_2")
    ussr_berlin_mgun_2 = genSquadUssr("ussr_berlin_mgun_2")
    ussr_berlin_pilot_fighter_2 = genSquadUssr("ussr_berlin_pilot_fighter_2")
    ussr_berlin_flametrooper_2 = genSquadUssr("ussr_berlin_flametrooper_2")
    ussr_berlin_radioman_2 = genSquadUssr("ussr_berlin_radioman_2")
    ussr_berlin_tank_2 = genSquadUssr("ussr_berlin_tank_2")
    ussr_berlin_assault_3 = genSquadUssr("ussr_berlin_assault_3")
    ussr_berlin_sniper_3 = genSquadUssr("ussr_berlin_sniper_3")

//prems
    ussr_berlin_prem_assault_1 = genSquadUssr("ussr_berlin_prem_assault_1")
    ussr_berlin_prem_engineer_1 = genSquadUssr("ussr_berlin_prem_engineer_1")
    ussr_berlin_prem_engineer_1_ch = genSquadUssr("ussr_berlin_prem_engineer_1")
    ussr_berlin_prem_rifle_1 = genSquadUssr("ussr_berlin_prem_rifle_1")
    ussr_berlin_prem_tank_1 = genSquadUssr("ussr_berlin_prem_tank_1")
    ussr_berlin_prem_tank_2 = genSquadUssr("ussr_berlin_prem_tank_2")
    ussr_berlin_prem_pilot_fighter_1 = genSquadUssr("ussr_berlin_prem_pilot_fighter_1")
    ussr_berlin_prem_assault_2 = genSquadUssr("ussr_berlin_prem_assault_2")
    ussr_berlin_event_assault_1 = genSquadUssr("ussr_berlin_event_assault_1", {premIcon = ICON_EVENT})
    ussr_berlin_prem_pilot_assaulter_1 = genSquadUssr("ussr_berlin_prem_pilot_assaulter_1")
    ussr_berlin_prem_assault_3 = genSquadUssr("ussr_berlin_prem_assault_3")
    ussr_berlin_prem_mgun_1 = genSquadUssr("ussr_berlin_prem_mgun_1")

//moon squads
    ussr_moon_assault_1 = genSquadUssr("ussr_moon_assault_1")
    ussr_moon_sniper_1 = genSquadUssr("ussr_moon_sniper_1")
    ussr_moon_antitank_1 = genSquadUssr("ussr_moon_antitank_1")
    ussr_moon_tank_1 = genSquadUssr("ussr_moon_tank_1")

//modern squads
    ussr_modern_inf_1 = genSquadUssr("ussr_modern_inf_1")
    ussr_modern_inf_2 = genSquadUssr("ussr_modern_inf_2")
    ussr_modern_inf_3 = genSquadUssr("ussr_modern_inf_3")
    ussr_modern_tank_1 = genSquadUssr("ussr_modern_tank_1")
  }

  berlin_axis = {
    ger_berlin_sniper_1 = genSquadGer("ger_berlin_sniper_1")
    ger_berlin_antitank_1 = genSquadGer("ger_berlin_antitank_1")
    ger_berlin_mgun_1 = genSquadGer("ger_berlin_mgun_1")
    ger_berlin_assault_1 = genSquadGer("ger_berlin_assault_1")
    ger_berlin_tank_1 = genSquadGer("ger_berlin_tank_1")
    ger_berlin_mortarman_1 = genSquadGer("ger_berlin_mortarman_1")
    ger_berlin_rifle_1 = genSquadGer("ger_berlin_rifle_1")
    ger_berlin_flametrooper_1 = genSquadGer("ger_berlin_flametrooper_1")
    ger_berlin_radioman_1 = genSquadGer("ger_berlin_radioman_1")
    ger_berlin_engineer_1 = genSquadGer("ger_berlin_engineer_1")
    ger_berlin_pilot_fighter_1 = genSquadGer("ger_berlin_pilot_fighter_1")
    ger_berlin_pilot_assaulter_1 = genSquadGer("ger_berlin_pilot_assaulter_1")
    ger_berlin_sniper_2 = genSquadGer("ger_berlin_sniper_2")
    ger_berlin_assault_2 = genSquadGer("ger_berlin_assault_2")
    ger_berlin_rifle_2 = genSquadGer("ger_berlin_rifle_2")
    ger_berlin_pilot_assaulter_2 = genSquadGer("ger_berlin_pilot_assaulter_2")
    ger_berlin_engineer_2 = genSquadGer("ger_berlin_engineer_2")
    ger_berlin_mgun_2 = genSquadGer("ger_berlin_mgun_2")
    ger_berlin_pilot_fighter_2 = genSquadGer("ger_berlin_pilot_fighter_2")
    ger_berlin_flametrooper_2 = genSquadGer("ger_berlin_flametrooper_2")
    ger_berlin_radioman_2 = genSquadGer("ger_berlin_radioman_2")
    ger_berlin_tank_2 = genSquadGer("ger_berlin_tank_2")
    ger_berlin_assault_3 = genSquadGer("ger_berlin_assault_3")
    ger_berlin_sniper_3 = genSquadGer("ger_berlin_sniper_3")

//prems
    ger_berlin_prem_assault_1 = genSquadGer("ger_berlin_prem_assault_1")
    ger_berlin_prem_engineer_1 = genSquadGer("ger_berlin_prem_engineer_1")
    ger_berlin_prem_engineer_1_ch = genSquadGer("ger_berlin_prem_engineer_1")
    ger_berlin_prem_rifle_1 = genSquadGer("ger_berlin_prem_rifle_1")
    ger_berlin_prem_tank_1 = genSquadGer("ger_berlin_prem_tank_1")
    ger_berlin_prem_tank_2 = genSquadGer("ger_berlin_prem_tank_2")
    ger_berlin_prem_pilot_fighter_1 = genSquadGer("ger_berlin_prem_pilot_fighter_1")
    ger_berlin_prem_rifle_2 = genSquadGer("ger_berlin_prem_rifle_2")
    ger_berlin_prem_tank_3 = genSquadGer("ger_berlin_prem_tank_3")
    ger_berlin_prem_assault_2 = genSquadGer("ger_berlin_prem_assault_2")
    ger_berlin_prem_mgun_1 = genSquadGer("ger_berlin_prem_mgun_1")

//moon squads
    germany_moon_assault_1 = genSquadGer("germany_moon_assault_1")
    germany_moon_sniper_1 = genSquadGer("germany_moon_sniper_1")
    germany_moon_antitank_1 = genSquadGer("germany_moon_antitank_1")
    germany_moon_tank_1 = genSquadGer("germany_moon_tank_1")
  }

  moscow_allies = {
    ussr_moscow_mgun_1 = genSquadUssr("ussr_moscow_mgun_1")
    ussr_moscow_tank_1 = genSquadUssr("ussr_moscow_tank_1")
    ussr_moscow_tank_2 = genSquadUssr("ussr_moscow_tank_2")
    ussr_moscow_mortarman_1 = genSquadUssr("ussr_moscow_mortarman_1")
    ussr_moscow_sniper_1 = genSquadUssr("ussr_moscow_sniper_1")
    ussr_moscow_rifle_1 = genSquadUssr("ussr_moscow_rifle_1")
    ussr_moscow_antitank_1 = genSquadUssr("ussr_moscow_antitank_1")
    ussr_moscow_assault_1 = genSquadUssr("ussr_moscow_assault_1")
    ussr_moscow_flametrooper_1 = genSquadUssr("ussr_moscow_flametrooper_1")
    ussr_moscow_pilot_fighter_1 = genSquadUssr("ussr_moscow_pilot_fighter_1")
    ussr_moscow_pilot_assaulter_1 = genSquadUssr("ussr_moscow_pilot_assaulter_1")
    ussr_moscow_radioman_1 = genSquadUssr("ussr_moscow_radioman_1")
    ussr_moscow_engineer_1 = genSquadUssr("ussr_moscow_engineer_1")
    ussr_moscow_rifle_2 = genSquadUssr("ussr_moscow_rifle_2")
    ussr_moscow_pilot_fighter_2 = genSquadUssr("ussr_moscow_pilot_fighter_2")
    ussr_moscow_mgun_2 = genSquadUssr("ussr_moscow_mgun_2")
    ussr_moscow_engineer_2 = genSquadUssr("ussr_moscow_engineer_2")
    ussr_moscow_assault_2 = genSquadUssr("ussr_moscow_assault_2")
    ussr_moscow_sniper_2 = genSquadUssr("ussr_moscow_sniper_2")
    ussr_moscow_pilot_assaulter_2 = genSquadUssr("ussr_moscow_pilot_assaulter_2")
    ussr_moscow_radioman_2 = genSquadUssr("ussr_moscow_radioman_2")
    ussr_moscow_antitank_2 = genSquadUssr("ussr_moscow_antitank_2")
    ussr_moscow_assault_3 = genSquadUssr("ussr_moscow_assault_3")
    ussr_moscow_sniper_3 = genSquadUssr("ussr_moscow_sniper_3")
    ussr_moscow_flametrooper_2 = genSquadUssr("ussr_moscow_flametrooper_2")
    ussr_moscow_tank_3 = genSquadUssr("ussr_moscow_tank_3")
    ussr_moscow_pilot_assaulter_3 = genSquadUssr("ussr_moscow_pilot_assaulter_3")
    ussr_moscow_assault_4 = genSquadUssr("ussr_moscow_assault_4")

//prems
    ussr_moscow_prem_assault_1 = genSquadUssr("ussr_moscow_prem_assault_1")
    ussr_moscow_prem_assault_1_ch = genSquadUssr("ussr_moscow_prem_assault_1")
    ussr_moscow_prem_mgun_1 = genSquadUssr("ussr_moscow_prem_mgun_1")
    ussr_moscow_prem_mgun_1_ch = genSquadUssr("ussr_moscow_prem_mgun_1")
    ussr_moscow_prem_mgun_1_legacy = genSquadUssr("ussr_moscow_prem_mgun_1")
    ussr_moscow_prem_assault_2 = genSquadUssr("ussr_moscow_prem_assault_2")
    ussr_moscow_prem_tank_1 = genSquadUssr("ussr_moscow_prem_tank_1")
    ussr_moscow_prem_pilot_fighter_1 = genSquadUssr("ussr_moscow_prem_pilot_fighter_1")
    ussr_moscow_prem_engineer_1 = genSquadUssr("ussr_moscow_prem_engineer_1")
    ussr_moscow_prem_rifle_1 = genSquadUssr("ussr_moscow_prem_rifle_1")
    ussr_moscow_prem_tank_2 = genSquadUssr("ussr_moscow_prem_tank_2")
    ussr_moscow_prem_mgun_2 = genSquadUssr("ussr_moscow_prem_mgun_2")
    ussr_moscow_prem_tank_3 = genSquadUssr("ussr_moscow_prem_tank_3")
    ussr_moscow_prem_tank_4 = genSquadUssr("ussr_moscow_prem_tank_4")
    ussr_moscow_prem_sniper_1 = genSquadUssr("ussr_moscow_prem_sniper_1")
    ussr_moscow_prem_pilot_fighter_2 = genSquadUssr("ussr_moscow_prem_pilot_fighter_2")
  }

  moscow_axis = {
    ger_moscow_engineer_1 = genSquadGer("ger_moscow_engineer_1")
    ger_moscow_tank_1 = genSquadGer("ger_moscow_tank_1")
    ger_moscow_tank_2 = genSquadGer("ger_moscow_tank_2")
    ger_moscow_antitank_1 = genSquadGer("ger_moscow_antitank_1")
    ger_moscow_assault_1 = genSquadGer("ger_moscow_assault_1")
    ger_moscow_rifle_1 = genSquadGer("ger_moscow_rifle_1")
    ger_moscow_radioman_1 = genSquadGer("ger_moscow_radioman_1")
    ger_moscow_mgun_1 = genSquadGer("ger_moscow_mgun_1")
    ger_moscow_mortarman_1 = genSquadGer("ger_moscow_mortarman_1")
    ger_moscow_sniper_1 = genSquadGer("ger_moscow_sniper_1")
    ger_moscow_flametrooper_1 = genSquadGer("ger_moscow_flametrooper_1")
    ger_moscow_pilot_fighter_1 = genSquadGer("ger_moscow_pilot_fighter_1")
    ger_moscow_pilot_assaulter_1 = genSquadGer("ger_moscow_pilot_assaulter_1")
    ger_moscow_rifle_2 = genSquadGer("ger_moscow_rifle_2")
    ger_moscow_pilot_fighter_2 = genSquadGer("ger_moscow_pilot_fighter_2")
    ger_moscow_mgun_2 = genSquadGer("ger_moscow_mgun_2")
    ger_moscow_engineer_2 = genSquadGer("ger_moscow_engineer_2")
    ger_moscow_assault_2 = genSquadGer("ger_moscow_assault_2")
    ger_moscow_sniper_2 = genSquadGer("ger_moscow_sniper_2")
    ger_moscow_pilot_assaulter_2 = genSquadGer("ger_moscow_pilot_assaulter_2")
    ger_moscow_radioman_2 = genSquadGer("ger_moscow_radioman_2")
    ger_moscow_antitank_2 = genSquadGer("ger_moscow_antitank_2")
    ger_moscow_assault_3 = genSquadGer("ger_moscow_assault_3")
    ger_moscow_sniper_3 = genSquadGer("ger_moscow_sniper_3")
    ger_moscow_flametrooper_2 = genSquadGer("ger_moscow_flametrooper_2")
    ger_moscow_tank_3 = genSquadGer("ger_moscow_tank_3")
    ger_moscow_pilot_assaulter_3 = genSquadGer("ger_moscow_pilot_assaulter_3")
    ger_moscow_assault_4 = genSquadGer("ger_moscow_assault_4")

//prems
    ger_moscow_prem_assault_1 = genSquadGer("ger_moscow_prem_assault_1")
    ger_moscow_prem_assault_1_ch = genSquadGer("ger_moscow_prem_assault_1")
    ger_moscow_prem_mgun_1 = genSquadGer("ger_moscow_prem_mgun_1")
    ger_moscow_prem_mgun_1_ch = genSquadGer("ger_moscow_prem_mgun_1")
    ger_moscow_prem_mgun_1_legacy = genSquadGer("ger_moscow_prem_mgun_1")
    ger_moscow_prem_tank_1 = genSquadGer("ger_moscow_prem_tank_1")
    ger_moscow_prem_assault_2 = genSquadGer("ger_moscow_prem_assault_2")
    ger_moscow_prem_pilot_fighter_1 = genSquadGer("ger_moscow_prem_pilot_fighter_1")
    ger_moscow_prem_engineer_1 = genSquadGer("ger_moscow_prem_engineer_1")
    ger_moscow_prem_rifle_1 = genSquadGer("ger_moscow_prem_rifle_1")
    ger_moscow_prem_tank_2 = genSquadGer("ger_moscow_prem_tank_2")
    ger_moscow_prem_mgun_2 = genSquadGer("ger_moscow_prem_mgun_2")
    ger_moscow_prem_pilot_fighter_2 = genSquadGer("ger_moscow_prem_pilot_fighter_2")
    ger_moscow_prem_sniper_1 = genSquadGer("ger_moscow_prem_sniper_1")
    ger_moscow_prem_tank_3 = genSquadGer("ger_moscow_prem_tank_3")
  }

  normandy_allies = {
    usa_normandy_rifle_1 = genSquadUsa("usa_normandy_rifle_1")
    usa_normandy_sniper_1 = genSquadUsa("usa_normandy_sniper_1")
    usa_normandy_assault_1 = genSquadUsa("usa_normandy_assault_1")
    usa_normandy_tank_1 = genSquadUsa("usa_normandy_tank_1")
    usa_normandy_engineer_1 = genSquadUsa("usa_normandy_engineer_1")
    usa_normandy_pilot_fighter_1 = genSquadUsa("usa_normandy_pilot_fighter_1")
    usa_normandy_flametrooper_1 = genSquadUsa("usa_normandy_flametrooper_1")
    usa_normandy_radioman_1 = genSquadUsa("usa_normandy_radioman_1")
    usa_normandy_antitank_1 = genSquadUsa("usa_normandy_antitank_1")
    usa_normandy_mgun_1 = genSquadUsa("usa_normandy_mgun_1")
    usa_normandy_pilot_fighter_2 = genSquadUsa("usa_normandy_pilot_fighter_2")
    usa_normandy_mortarman_1 = genSquadUsa("usa_normandy_mortarman_1")
    usa_normandy_sniper_2 = genSquadUsa("usa_normandy_sniper_2")
    usa_normandy_rifle_2 = genSquadUsa("usa_normandy_rifle_2")
    usa_normandy_pilot_assaulter_1 = genSquadUsa("usa_normandy_pilot_assaulter_1")
    usa_normandy_tank_2 = genSquadUsa("usa_normandy_tank_2")
    usa_normandy_sniper_3 = genSquadUsa("usa_normandy_sniper_3")
    usa_normandy_assault_2 = genSquadUsa("usa_normandy_assault_2")
    usa_normandy_engineer_2 = genSquadUsa("usa_normandy_engineer_2")
    usa_normandy_mgun_2 = genSquadUsa("usa_normandy_mgun_2")
    usa_normandy_pilot_assaulter_2 = genSquadUsa("usa_normandy_pilot_assaulter_2")
    usa_normandy_flametrooper_2 = genSquadUsa("usa_normandy_flametrooper_2")
    usa_normandy_tank_3 = genSquadUsa("usa_normandy_tank_3")
    usa_normandy_assault_3 = genSquadUsa("usa_normandy_assault_3")
    usa_normandy_rifle_3 = genSquadUsa("usa_normandy_rifle_3")
    usa_normandy_mgun_3 = genSquadUsa("usa_normandy_mgun_3")
    usa_normandy_antitank_2 = genSquadUsa("usa_normandy_antitank_2")

//moon squads
    usa_moon_assault_1 = genSquadUsa("usa_moon_assault_1")
    usa_moon_sniper_1 = genSquadUsa("usa_moon_sniper_1")
    usa_moon_antitank_1 = genSquadUsa("usa_moon_antitank_1")
    usa_moon_tank_1 = genSquadUsa("usa_moon_tank_1")

//prems
    usa_normandy_prem_assault_1 = genSquadUsa("usa_normandy_prem_assault_1")
    usa_normandy_prem_assault_1_ch = genSquadUsa("usa_normandy_prem_assault_1")
    usa_normandy_prem_assault_2 = genSquadUsa("usa_normandy_prem_assault_2")
    usa_normandy_prem_mgun_1 = genSquadUsa("usa_normandy_prem_mgun_1")
    usa_normandy_prem_mgun_1_ch = genSquadUsa("usa_normandy_prem_mgun_1")
    usa_normandy_prem_pilot_fighter_1 = genSquadUsa("usa_normandy_prem_pilot_fighter_1")
    usa_normandy_prem_engineer_1 = genSquadUsa("usa_normandy_prem_engineer_1")
    usa_normandy_prem_tank_1 = genSquadUsa("usa_normandy_prem_tank_1")
    usa_normandy_prem_assault_3 = genSquadUsa("usa_normandy_prem_assault_3")
    usa_normandy_prem_tank_2 = genSquadUsa("usa_normandy_prem_tank_2")
    usa_normandy_prem_tank_3 = genSquadUsa("usa_normandy_prem_tank_3")
    usa_normandy_prem_tank_4 = genSquadUsa("usa_normandy_prem_tank_4")
    usa_normandy_prem_mgun_2 = genSquadUsa("usa_normandy_prem_mgun_2")
    usa_normandy_prem_tank_5 = genSquadUsa("usa_normandy_prem_tank_5")
    usa_normandy_prem_pilot_fighter_2 = genSquadUsa("usa_normandy_prem_pilot_fighter_2")

//modern squads
    usa_modern_inf_1 = genSquadUsa("usa_modern_inf_1")
    usa_modern_inf_2 = genSquadUsa("usa_modern_inf_2")
    usa_modern_inf_3 = genSquadUsa("usa_modern_inf_3")
    usa_modern_tank_1 = genSquadUsa("usa_modern_tank_1")
  }

  normandy_axis = {
    ger_normandy_rifle_1 = genSquadGer("ger_normandy_rifle_1")
    ger_normandy_sniper_1 = genSquadGer("ger_normandy_sniper_1")
    ger_normandy_assault_1 = genSquadGer("ger_normandy_assault_1")
    ger_normandy_tank_1 = genSquadGer("ger_normandy_tank_1")
    ger_normandy_engineer_1 = genSquadGer("ger_normandy_engineer_1")
    ger_normandy_pilot_assaulter_1 = genSquadGer("ger_normandy_pilot_assaulter_1")
    ger_normandy_flametrooper_1 = genSquadGer("ger_normandy_flametrooper_1")
    ger_normandy_radioman_1 = genSquadGer("ger_normandy_radioman_1")
    ger_normandy_antitank_1 = genSquadGer("ger_normandy_antitank_1")
    ger_normandy_mgun_1 = genSquadGer("ger_normandy_mgun_1")
    ger_normandy_pilot_fighter_1 = genSquadGer("ger_normandy_pilot_fighter_1")
    ger_normandy_mortarman_1 = genSquadGer("ger_normandy_mortarman_1")
    ger_normandy_sniper_2 = genSquadGer("ger_normandy_sniper_2")
    ger_normandy_rifle_2 = genSquadGer("ger_normandy_rifle_2")
    ger_normandy_pilot_assaulter_2 = genSquadGer("ger_normandy_pilot_assaulter_2")
    ger_normandy_tank_2 = genSquadGer("ger_normandy_tank_2")
    ger_normandy_sniper_3 = genSquadGer("ger_normandy_sniper_3")
    ger_normandy_assault_2 = genSquadGer("ger_normandy_assault_2")
    ger_normandy_engineer_2 = genSquadGer("ger_normandy_engineer_2")
    ger_normandy_mgun_2 = genSquadGer("ger_normandy_mgun_2")
    ger_normandy_pilot_fighter_2 = genSquadGer("ger_normandy_pilot_fighter_2")
    ger_normandy_flametrooper_2 = genSquadGer("ger_normandy_flametrooper_2")
    ger_normandy_tank_3 = genSquadGer("ger_normandy_tank_3")
    ger_normandy_assault_3 = genSquadGer("ger_normandy_assault_3")
    ger_normandy_rifle_3 = genSquadGer("ger_normandy_rifle_3")
    ger_normandy_mgun_3 = genSquadGer("ger_normandy_mgun_3")
    ger_normandy_antitank_2 = genSquadGer("ger_normandy_antitank_2")

//prems
    ger_normandy_prem_assault_1 = genSquadGer("ger_normandy_prem_assault_1")
    ger_normandy_prem_assault_1_ch = genSquadGer("ger_normandy_prem_assault_1")
    ger_normandy_prem_assault_2 = genSquadGer("ger_normandy_prem_assault_2")
    ger_normandy_prem_mgun_1 = genSquadGer("ger_normandy_prem_mgun_1")
    ger_normandy_prem_mgun_1_ch = genSquadGer("ger_normandy_prem_mgun_1")
    ger_normandy_prem_pilot_fighter_1 = genSquadGer("ger_normandy_prem_pilot_fighter_1")
    ger_normandy_prem_engineer_1 = genSquadGer("ger_normandy_prem_engineer_1")
    ger_normandy_prem_tank_1 = genSquadGer("ger_normandy_prem_tank_1")
    ger_normandy_prem_assault_3 = genSquadGer("ger_normandy_prem_assault_3")
    ger_normandy_prem_pilot_fighter_2 = genSquadGer("ger_normandy_prem_pilot_fighter_2")
    ger_normandy_prem_tank_3 = genSquadGer("ger_normandy_prem_tank_3")
    ger_normandy_prem_tank_2 = genSquadGer("ger_normandy_prem_tank_2")
    ger_normandy_prem_assault_4 = genSquadGer("ger_normandy_prem_assault_4")
    ger_normandy_prem_tank_4 = genSquadGer("ger_normandy_prem_tank_4")
    ger_normandy_event_assault_1 = genSquadGer("ger_normandy_event_assault_1", {premIcon = ICON_EVENT})
    ger_normandy_prem_pilot_fighter_3 = genSquadGer("ger_normandy_prem_pilot_fighter_3")
  }

  tunisia_allies = {
    allies_tunisia_rifle_1 = genSquadUsa("allies_tunisia_rifle_1")
    allies_tunisia_radioman_1 = genSquadUsa("allies_tunisia_radioman_1")
    allies_tunisia_tank_1 = genSquadUsa("allies_tunisia_tank_1")
    allies_tunisia_sniper_1 = genSquadUsa("allies_tunisia_sniper_1")
    allies_tunisia_assault_1 = genSquadUsa("allies_tunisia_assault_1")
    allies_tunisia_pilot_fighter_1 = genSquadUsa("allies_tunisia_pilot_fighter_1")
    allies_tunisia_antitank_1 = genSquadUsa("allies_tunisia_antitank_1")
    allies_tunisia_engineer_1 = genSquadUsa("allies_tunisia_engineer_1")
    allies_tunisia_mgun_1 = genSquadUsa("allies_tunisia_mgun_1")
    allies_tunisia_pilot_assaulter_1 = genSquadUsa("allies_tunisia_pilot_assaulter_1")
    allies_tunisia_mortarman_1 = genSquadUsa("allies_tunisia_mortarman_1")
    allies_tunisia_sniper_2 = genSquadUsa("allies_tunisia_sniper_2")
    allies_tunisia_flametrooper_1 = genSquadUsa("allies_tunisia_flametrooper_1")
    allies_tunisia_tank_2 = genSquadUsa("allies_tunisia_tank_2")
    allies_tunisia_rifle_2 = genSquadUsa("allies_tunisia_rifle_2")
    allies_tunisia_biker_1 = genSquadUsa("allies_tunisia_biker_1")
    allies_tunisia_assault_2 = genSquadUsa("allies_tunisia_assault_2")
    allies_tunisia_pilot_fighter_2 = genSquadUsa("allies_tunisia_pilot_fighter_2")
    allies_tunisia_engineer_2 = genSquadUsa("allies_tunisia_engineer_2")
    allies_tunisia_sniper_3 = genSquadUsa("allies_tunisia_sniper_3")
    allies_tunisia_mgun_2 = genSquadUsa("allies_tunisia_mgun_2")
    allies_tunisia_pilot_assaulter_2 = genSquadUsa("allies_tunisia_pilot_assaulter_2")
    allies_tunisia_tank_3 = genSquadUsa("allies_tunisia_tank_3")
    allies_tunisia_assault_3 = genSquadUsa("allies_tunisia_assault_3")
    allies_tunisia_antitank_2 = genSquadUsa("allies_tunisia_antitank_2")

//prems
    allies_tunisia_prem_biker_1 = genSquadUsa("allies_tunisia_prem_biker_1")
    allies_tunisia_prem_tank_1 = genSquadUsa("allies_tunisia_prem_tank_1")
    allies_tunisia_prem_assault_1 = genSquadUsa("allies_tunisia_prem_assault_1")
    allies_tunisia_prem_radioman_1 = genSquadUsa("allies_tunisia_prem_radioman_1")
    allies_tunisia_prem_radioman_1_ch = genSquadUsa("allies_tunisia_prem_radioman_1")
    allies_tunisia_prem_pilot_assaulter_1 = genSquadUsa("allies_tunisia_prem_pilot_assaulter_1")
    allies_tunisia_prem_rifle_1 = genSquadUsa("allies_tunisia_prem_rifle_1")
    allies_tunisia_event_mgun_1 = genSquadUsa("allies_tunisia_event_mgun_1", {premIcon = ICON_EVENT})
    allies_tunisia_prem_tank_2 = genSquadUsa("allies_tunisia_prem_tank_2")
    allies_tunisia_prem_pilot_assaulter_2 = genSquadUsa("allies_tunisia_prem_pilot_assaulter_2")
    allies_tunisia_event_assault_1 = genSquadUsa("allies_tunisia_event_assault_1", {premIcon = ICON_EVENT})
    allies_tunisia_prem_flametrooper_1 = genSquadUsa("allies_tunisia_prem_flametrooper_1")
  }



  tunisia_axis = {
    axis_tunisia_rifle_1 = genSquadGer("axis_tunisia_rifle_1")
    axis_tunisia_tank_1 = genSquadGer("axis_tunisia_tank_1")
    axis_tunisia_sniper_1 = genSquadGer("axis_tunisia_sniper_1")
    axis_tunisia_radioman_1 = genSquadGer("axis_tunisia_radioman_1")
    axis_tunisia_assault_1 = genSquadGer("axis_tunisia_assault_1")
    axis_tunisia_pilot_fighter_1 = genSquadGer("axis_tunisia_pilot_fighter_1")
    axis_tunisia_antitank_1 = genSquadGer("axis_tunisia_antitank_1")
    axis_tunisia_engineer_1 = genSquadGer("axis_tunisia_engineer_1")
    axis_tunisia_mgun_1 = genSquadGer("axis_tunisia_mgun_1")
    axis_tunisia_pilot_assaulter_1 = genSquadGer("axis_tunisia_pilot_assaulter_1")
    axis_tunisia_mortarman_1 = genSquadGer("axis_tunisia_mortarman_1")
    axis_tunisia_sniper_2 = genSquadGer("axis_tunisia_sniper_2")
    axis_tunisia_flametrooper_1 = genSquadGer("axis_tunisia_flametrooper_1")
    axis_tunisia_tank_2 = genSquadGer("axis_tunisia_tank_2")
    axis_tunisia_rifle_2 = genSquadGer("axis_tunisia_rifle_2")
    axis_tunisia_biker_1 = genSquadGer("axis_tunisia_biker_1")
    axis_tunisia_assault_2 = genSquadGer("axis_tunisia_assault_2")
    axis_tunisia_pilot_fighter_2 = genSquadGer("axis_tunisia_pilot_fighter_2")
    axis_tunisia_engineer_2 = genSquadGer("axis_tunisia_engineer_2")
    axis_tunisia_sniper_3 = genSquadGer("axis_tunisia_sniper_3")
    axis_tunisia_mgun_2 = genSquadGer("axis_tunisia_mgun_2")
    axis_tunisia_pilot_assaulter_2 = genSquadGer("axis_tunisia_pilot_assaulter_2")
    axis_tunisia_tank_3 = genSquadGer("axis_tunisia_tank_3")
    axis_tunisia_assault_3 = genSquadGer("axis_tunisia_assault_3")
    axis_tunisia_antitank_2 = genSquadGer("axis_tunisia_antitank_2")

//prems
    axis_tunisia_prem_biker_1 = genSquadGer("axis_tunisia_prem_biker_1")
    axis_tunisia_prem_tank_1 = genSquadGer("axis_tunisia_prem_tank_1")
    axis_tunisia_prem_assault_1 = genSquadGer("axis_tunisia_prem_assault_1")
    axis_tunisia_prem_radioman_1 = genSquadGer("axis_tunisia_prem_radioman_1")
    axis_tunisia_prem_radioman_1_ch = genSquadGer("axis_tunisia_prem_radioman_1")
    axis_tunisia_prem_pilot_assaulter_1 = genSquadGer("axis_tunisia_prem_pilot_assaulter_1")
    axis_tunisia_prem_rifle_1 = genSquadGer("axis_tunisia_prem_rifle_1")
    axis_tunisia_prem_tank_2 = genSquadGer("axis_tunisia_prem_tank_2")
    axis_tunisia_prem_pilot_assaulter_2 = genSquadGer("axis_tunisia_prem_pilot_assaulter_2")
    axis_tunisia_prem_flametrooper_1 = genSquadGer("axis_tunisia_prem_flametrooper_1")
  }



  stalingrad_allies = {
    allies_stalingrad_rifle_1 = genSquadUssr("allies_stalingrad_rifle_1")
    allies_stalingrad_tank_1 = genSquadUssr("allies_stalingrad_tank_1")
    allies_stalingrad_sniper_1 = genSquadUssr("allies_stalingrad_sniper_1")
    allies_stalingrad_medic_1 = genSquadUssr("allies_stalingrad_medic_1")
    allies_stalingrad_pilot_fighter_1 = genSquadUssr("allies_stalingrad_pilot_fighter_1")
    allies_stalingrad_engineer_1 = genSquadUssr("allies_stalingrad_engineer_1")
    allies_stalingrad_mgun_1 = genSquadUssr("allies_stalingrad_mgun_1")
    allies_stalingrad_radioman_1 = genSquadUssr("allies_stalingrad_radioman_1")
    allies_stalingrad_antitank_1 = genSquadUssr("allies_stalingrad_antitank_1")
    allies_stalingrad_pilot_assaulter_1 = genSquadUssr("allies_stalingrad_pilot_assaulter_1")
    allies_stalingrad_mortarman_1 = genSquadUssr("allies_stalingrad_mortarman_1")
    allies_stalingrad_tank_2 = genSquadUssr("allies_stalingrad_tank_2")
    allies_stalingrad_rifle_2 = genSquadUssr("allies_stalingrad_rifle_2")
    allies_stalingrad_assault_2 = genSquadUssr("allies_stalingrad_assault_2")
    allies_stalingrad_pilot_fighter_2 = genSquadUssr("allies_stalingrad_pilot_fighter_2")
    allies_stalingrad_sniper_2 = genSquadUssr("allies_stalingrad_sniper_2")
    allies_stalingrad_flametrooper_1 = genSquadUssr("allies_stalingrad_flametrooper_1")
    allies_stalingrad_mgun_2 = genSquadUssr("allies_stalingrad_mgun_2")
    allies_stalingrad_engineer_2 = genSquadUssr("allies_stalingrad_engineer_2")
    allies_stalingrad_sniper_3 = genSquadUssr("allies_stalingrad_sniper_3")
    allies_stalingrad_pilot_assaulter_2 = genSquadUssr("allies_stalingrad_pilot_assaulter_2")
    allies_stalingrad_assault_3 = genSquadUssr("allies_stalingrad_assault_3")
    allies_stalingrad_rifle_3 = genSquadUssr("allies_stalingrad_rifle_3")
    allies_stalingrad_pilot_fighter_3 = genSquadUssr("allies_stalingrad_pilot_fighter_3")

//prems
    allies_stalingrad_prem_tank_1 = genSquadUssr("allies_stalingrad_prem_tank_1")
    allies_stalingrad_prem_medic_1 = genSquadUssr("allies_stalingrad_prem_medic_1")
    allies_stalingrad_prem_pilot_assaulter_1 = genSquadUssr("allies_stalingrad_prem_pilot_assaulter_1")
    allies_stalingrad_prem_assault_1 = genSquadUssr("allies_stalingrad_prem_assault_1")
    allies_stalingrad_prem_assault_1_ch = genSquadUssr("allies_stalingrad_prem_assault_1")
  }



  stalingrad_axis = {
    axis_stalingrad_rifle_1 = genSquadGer("axis_stalingrad_rifle_1")
    axis_stalingrad_tank_1 = genSquadGer("axis_stalingrad_tank_1")
    axis_stalingrad_sniper_1 = genSquadGer("axis_stalingrad_sniper_1")
    axis_stalingrad_medic_1 = genSquadGer("axis_stalingrad_medic_1")
    axis_stalingrad_pilot_fighter_1 = genSquadGer("axis_stalingrad_pilot_fighter_1")
    axis_stalingrad_engineer_1 = genSquadGer("axis_stalingrad_engineer_1")
    axis_stalingrad_mgun_1 = genSquadGer("axis_stalingrad_mgun_1")
    axis_stalingrad_radioman_1 = genSquadGer("axis_stalingrad_radioman_1")
    axis_stalingrad_antitank_1 = genSquadGer("axis_stalingrad_antitank_1")
    axis_stalingrad_pilot_assaulter_1 = genSquadGer("axis_stalingrad_pilot_assaulter_1")
    axis_stalingrad_mortarman_1 = genSquadGer("axis_stalingrad_mortarman_1")
    axis_stalingrad_tank_2 = genSquadGer("axis_stalingrad_tank_2")
    axis_stalingrad_rifle_2 = genSquadGer("axis_stalingrad_rifle_2")
    axis_stalingrad_assault_2 = genSquadGer("axis_stalingrad_assault_2")
    axis_stalingrad_pilot_fighter_2 = genSquadGer("axis_stalingrad_pilot_fighter_2")
    axis_stalingrad_sniper_2 = genSquadGer("axis_stalingrad_sniper_2")
    axis_stalingrad_flametrooper_1 = genSquadGer("axis_stalingrad_flametrooper_1")
    axis_stalingrad_mgun_2 = genSquadGer("axis_stalingrad_mgun_2")
    axis_stalingrad_engineer_2 = genSquadGer("axis_stalingrad_engineer_2")
    axis_stalingrad_sniper_3 = genSquadGer("axis_stalingrad_sniper_3")
    axis_stalingrad_pilot_assaulter_2 = genSquadGer("axis_stalingrad_pilot_assaulter_2")
    axis_stalingrad_assault_3 = genSquadGer("axis_stalingrad_assault_3")
    axis_stalingrad_rifle_3 = genSquadGer("axis_stalingrad_rifle_3")
    axis_stalingrad_pilot_fighter_3 = genSquadGer("axis_stalingrad_pilot_fighter_3")

//prems
    axis_stalingrad_prem_tank_1 = genSquadGer("axis_stalingrad_prem_tank_1")
    axis_stalingrad_prem_medic_1 = genSquadGer("axis_stalingrad_prem_medic_1")
    axis_stalingrad_prem_assault_1 = genSquadGer("axis_stalingrad_prem_assault_1")
    axis_stalingrad_prem_assault_1_ch = genSquadGer("axis_stalingrad_prem_assault_1")
  }



  pacific_allies = {
    allies_pacific_rifle_1 = genSquadUsa("allies_pacific_rifle_1")
    allies_pacific_tank_1 = genSquadUsa("allies_pacific_tank_1")
    allies_pacific_sniper_1 = genSquadUsa("allies_pacific_sniper_1")
    allies_pacific_medic_1 = genSquadUsa("allies_pacific_medic_1")
    allies_pacific_engineer_1 = genSquadUsa("allies_pacific_engineer_1")
    allies_pacific_pilot_assaulter_1 = genSquadUsa("allies_pacific_pilot_assaulter_1")
    allies_pacific_antitank_1 = genSquadUsa("allies_pacific_antitank_1")
    allies_pacific_mgun_1 = genSquadUsa("allies_pacific_mgun_1")
    allies_pacific_mortarman_1 = genSquadUsa("allies_pacific_mortarman_1")
    allies_pacific_radioman_1 = genSquadUsa("allies_pacific_radioman_1")
    allies_pacific_pilot_fighter_1 = genSquadUsa("allies_pacific_pilot_fighter_1")
    allies_pacific_assault_2 = genSquadUsa("allies_pacific_assault_2")
    allies_pacific_flametrooper_1 = genSquadUsa("allies_pacific_flametrooper_1")
    allies_pacific_rifle_2 = genSquadUsa("allies_pacific_rifle_2")
    allies_pacific_pilot_fighter_2 = genSquadUsa("allies_pacific_pilot_fighter_2")
    allies_pacific_sniper_2 = genSquadUsa("allies_pacific_sniper_2")
    allies_pacific_engineer_2 = genSquadUsa("allies_pacific_engineer_2")
    allies_pacific_tank_2 = genSquadUsa("allies_pacific_tank_2")
    allies_pacific_mgun_2 = genSquadUsa("allies_pacific_mgun_2")
    allies_pacific_flametrooper_2 = genSquadUsa("allies_pacific_flametrooper_2")
    allies_pacific_assault_3 = genSquadUsa("allies_pacific_assault_3")
    allies_pacific_pilot_assaulter_2 = genSquadUsa("allies_pacific_pilot_assaulter_2")


//prems
    allies_pacific_prem_medic_1 = genSquadUsa("allies_pacific_prem_medic_1")
    allies_pacific_prem_assault_1 = genSquadUsa("allies_pacific_prem_assault_1")
    allies_pacific_prem_tank_1 = genSquadUsa("allies_pacific_prem_tank_1")
  }



  pacific_axis = {
    axis_pacific_rifle_1 = genSquadJap("axis_pacific_rifle_1")
    axis_pacific_tank_1 = genSquadJap("axis_pacific_tank_1")
    axis_pacific_sniper_1 = genSquadJap("axis_pacific_sniper_1")
    axis_pacific_medic_1 = genSquadJap("axis_pacific_medic_1")
    axis_pacific_engineer_1 = genSquadJap("axis_pacific_engineer_1")
    axis_pacific_pilot_assaulter_1 = genSquadJap("axis_pacific_pilot_assaulter_1")
    axis_pacific_antitank_1 = genSquadJap("axis_pacific_antitank_1")
    axis_pacific_mgun_1 = genSquadJap("axis_pacific_mgun_1")
    axis_pacific_mortarman_1 = genSquadJap("axis_pacific_mortarman_1")
    axis_pacific_radioman_1 = genSquadJap("axis_pacific_radioman_1")
    axis_pacific_pilot_fighter_1 = genSquadJap("axis_pacific_pilot_fighter_1")
    axis_pacific_assault_2 = genSquadJap("axis_pacific_assault_2")
    axis_pacific_flametrooper_1 = genSquadJap("axis_pacific_flametrooper_1")
    axis_pacific_rifle_2 = genSquadJap("axis_pacific_rifle_2")
    axis_pacific_pilot_fighter_2 = genSquadJap("axis_pacific_pilot_fighter_2")
    axis_pacific_sniper_2 = genSquadJap("axis_pacific_sniper_2")
    axis_pacific_engineer_2 = genSquadJap("axis_pacific_engineer_2")
    axis_pacific_tank_2 = genSquadJap("axis_pacific_tank_2")
    axis_pacific_mgun_2 = genSquadJap("axis_pacific_mgun_2")
    axis_pacific_flametrooper_2 = genSquadJap("axis_pacific_flametrooper_2")
    axis_pacific_assault_3 = genSquadJap("axis_pacific_assault_3")
    axis_pacific_pilot_assaulter_2 = genSquadJap("axis_pacific_pilot_assaulter_2")


//prems
    axis_pacific_prem_medic_1 = genSquadJap("axis_pacific_prem_medic_1")
    axis_pacific_prem_assault_1 = genSquadJap("axis_pacific_prem_assault_1")
    axis_pacific_prem_tank_1 = genSquadJap("axis_pacific_prem_tank_1")
  }
})