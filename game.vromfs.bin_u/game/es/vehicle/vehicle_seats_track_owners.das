require ecs
require game.es.vehicle.vehicle_events
require danetlibs.native_dasevents.main.native_events

[es(track=(seat__ownerEid, seat__playerEid, seat__squadEid, seat__isPlayer, seat__isOwnerAlive),
    REQUIRE=(seat__ownerEid, seat__playerEid, seat__squadEid, seat__isPlayer, seat__isOwnerAlive))]
def track_seat_owners(evt : Event; seat__vehicleEid : EntityId)
  sendEvent(seat__vehicleEid, [[EventOnSeatOwnersChanged]])