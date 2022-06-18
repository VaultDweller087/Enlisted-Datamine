from "%enlSqGlob/ui_library.nut" import *

require("%ui/ui_config.nut")
require("%ui/sound_handlers.nut")
let hud = require("hud.nut")
let {msgboxes} = require("%ui/msgboxes.nut")
let {uiDisabled, levelLoaded} = require("%ui/hud/state/appState.nut")
let {loadingUI, showLoading} = require("%ui/loading/loading.nut")
let globInput = require("%ui/glob_input.nut")
let {hotkeysButtonsBar} = require("%ui/hotkeysPanel.nut")
let speakingList = require("%ui/speaking_list.nut")
let {modalWindowsComponent} = require("%darg/components/modalWindows.nut")
let {dbgSafeArea} = require("%ui/dbgSafeArea.nut")
let platform = require("%dngscripts/platform.nut")
let {editor, showUIinEditor, editorIsActive} = require("%ui/editor.nut")
let {extraPropPanelCtors = null} = require("%daeditor/state.nut")
let {serviceInfo} = require("%ui/service_info.nut")
let {sandboxEditorEnabled, sandboxEditor} = require("sandbox_editor.nut")
let {canShowReplayHud} = require("%ui/hud/replay/replayState.nut")
let {isReplay} = require("%ui/hud/state/replay_state.nut")

if (extraPropPanelCtors!=null)
  extraPropPanelCtors([require("%ui/editorCustomView.nut")])

require("dainput2").set_double_click_time(220)

if (platform.is_xbox || platform.is_sony)
  require("%ui/invitation/onInviteAccept.nut")

let function root() {

  local content
  if (uiDisabled.value) {
    content = null
  }
  else if (showLoading.value || !levelLoaded.value) {
    content = loadingUI
  }
  else {
    content = hud
  }

  local children = !uiDisabled.value
    ? [
        content
        modalWindowsComponent
        msgboxes
        hotkeysButtonsBar
        speakingList
        dbgSafeArea
        globInput
      ]
    : [ dbgSafeArea, content ]


  if (editorIsActive.value && !showUIinEditor.value)
    children = [globInput, editor]
  else if (showUIinEditor.value)
    children.append(editor)

  if (!uiDisabled.value && levelLoaded.value)
    children.append(serviceInfo)
  if (sandboxEditorEnabled.value)
    children.append(sandboxEditor)
  if (isReplay.value)
    children.append({
      eventHandlers = {
        ["Replay.DisableHUD"] = @(_event) canShowReplayHud(!canShowReplayHud.value)
      }
    })

  return {
    watch = [showLoading, uiDisabled, editorIsActive, showUIinEditor, levelLoaded, sandboxEditorEnabled, isReplay]
    size = flex()
    children
  }
}

return root
