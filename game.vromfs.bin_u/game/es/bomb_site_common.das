module bomb_site_common shared
require ecs

def can_plant_bomb(bomb_eid : EntityId; human_eid : EntityId) : bool
  var result = false
  query(bomb_eid) <| $ [es] (active : bool;
                             bomb_site__operator : EntityId;
                             bomb_site__plantingTeam : int;
                             bomb_site__isPlantingOrReseting : bool;
                             bomb_site__isBombPlanted : bool)
    query(human_eid) <| $ [es] (team : int)
      let canStartOrContinuePlant = !bomb_site__isPlantingOrReseting || bomb_site__operator == human_eid
      result = active && team == bomb_site__plantingTeam && !bomb_site__isBombPlanted && canStartOrContinuePlant
  return result

def can_defuse_bomb(bomb_eid : EntityId; human_eid : EntityId) : bool
  var result = false
  query(bomb_eid) <| $ [es] (active : bool;
                             bomb_site__operator : EntityId;
                             bomb_site__plantingTeam : int;
                             bomb_site__isDefusing : bool;
                             bomb_site__isBombPlanted : bool)
    query(human_eid) <| $ [es] (team : int)
      let canStartOrContinueDefuse = !bomb_site__isDefusing || bomb_site__operator == human_eid
      result = active && team != bomb_site__plantingTeam && bomb_site__isBombPlanted && canStartOrContinueDefuse
  return result