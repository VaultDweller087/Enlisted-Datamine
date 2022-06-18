let cn = require("xbox.crossnetwork")
let {subscribe, subscribe_onehit} = require("eventbus")


let function register_state_change_callback(callback) {
  subscribe(cn.state_changed_event_name, function(result) {
    let success = result?.success
    callback?(success)
  })
}


let function register_chat_state_change_callback(callback) {
  subscribe(cn.chat_state_changed_event_name, function(result) {
    let permissions = result?.permissions
    callback?(permissions)
  })
}


let function subscribe_for_chat_permissions_event(eventName, callback) {
  subscribe_onehit(eventName, function(result) {
    let success = result?.success
    let state = result?.state
    callback?(success, state)
  })
}


let function retrieve_text_chat_permissions(xuid, callback) {
  let eventName = "xbox_text_chat_permissions_sub"
  subscribe_for_chat_permissions_event(eventName, callback)
  cn.get_text_chat_permissions(xuid, eventName)
}


let function retrieve_voice_chat_permissions(xuid, callback) {
  let eventName = "xbox_voice_chat_permissions_sub"
  subscribe_for_chat_permissions_event(eventName, callback)
  cn.get_voice_chat_permissions(xuid, eventName)
}


return {
  CommunicationState = cn.CommunicationState

  has_multiplayer_sessions_privilege = cn.has_multiplayer_sessions_privilege
  has_crossnetwork_privilege = cn.has_crossnetwork_privilege
  has_communications_privilege = cn.has_communications_privilege

  retrieve_voice_chat_permissions
  retrieve_text_chat_permissions

  track_user_chat_permissions = cn.track_user_chat_permissions
  stop_tracking_user_chat_permissions = cn.stop_tracking_user_chat_permissions

  register_state_change_callback
  register_chat_state_change_callback
}
