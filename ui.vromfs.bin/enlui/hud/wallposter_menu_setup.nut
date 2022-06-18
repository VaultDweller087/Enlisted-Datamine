import "%dngscripts/ecs.nut" as ecs
from "%enlSqGlob/ui_library.nut" import *

let {
  wallposterMenuItems, showWallposterMenu, elemSize
} = require("%ui/hud/state/wallposter_menu.nut")
let { wallPosters } = require("%ui/hud/state/wallposter.nut")
let { localPlayerEid } = require("%ui/hud/state/local_player.nut")
let { CmdWallposterPreview } = require("wallposterevents")
let mkPieItemCtor = require("%ui/hud/components/wallposter_menu_item_ctor.nut")

let svg = @(img) "!ui/uiskin/{0}.svg:{1}:{1}:K".subst(img, elemSize.value[1])

let wallPosterPreview = @(index)
  ecs.g_entity_mgr.sendEvent(localPlayerEid.value, CmdWallposterPreview(true, index))

wallPosters.subscribe(function(posters) {
  wallposterMenuItems(posters.map(function(poster, index) {
    let template = ecs.g_entity_mgr.getTemplateDB().getTemplateByName(poster)
    let text = template?.getCompValNullable?("wallposter_menu__text") ?? ""
    let imageName = template?.getCompValNullable?("wallposter_menu__image")
    let image = imageName ? svg(imageName) : null
    let hintText = loc(text)
    return {
      action = @() wallPosterPreview(index)
      text = hintText
      closeOnClick = true
      ctor = mkPieItemCtor(index, image, hintText)
    }
  }))
  if (posters.len() == 0)
    showWallposterMenu(false)
})
