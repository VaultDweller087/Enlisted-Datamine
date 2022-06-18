from "%enlSqGlob/ui_library.nut" import *

let { opaqueBgColor } = require("%enlSqGlob/ui/viewConst.nut")
let { sound_play } = require("sound")
let { body_txt } = require("%enlSqGlob/ui/fonts_style.nut")


let animations = @(leftAppearance) [ leftAppearance
  ? { prop = AnimProp.translate, from = [-sw(50), 0], to = [0, 0],
      duration = 0.3, play = true, onFinish = sound_play("ui/enlist/notification")
    }
  : { prop = AnimProp.translate, from = [sw(50), 0], to = [0, 0],
      duration = 0.3, play = true, onFinish = sound_play("ui/enlist/notification")
    }
  { prop = AnimProp.color, from = Color(150,20,20), to = Color(225,35,35)
    easing = CosineFull, duration = 1, loop = true, play = true
  }
]

let function serviceMessages(messageTbl, params = {}){
  if (messageTbl.len() <= 0)
    return null
  return {
    rendObj = ROBJ_SOLID
    size = [flex(), SIZE_TO_CONTENT]
    padding = hdpx(7)
    animations = animations((params?.hplace ?? ALIGN_LEFT) == ALIGN_LEFT)
    transform = {}
    children = {
      rendObj = ROBJ_SOLID
      size = [flex(), SIZE_TO_CONTENT]
      flow = FLOW_VERTICAL
      color = opaqueBgColor
      padding = fsh(2)
      gap = fsh(1.5)
      children = [
        {
          rendObj = ROBJ_IMAGE
          size = [hdpx(40), hdpx(34)]
          hplace = ALIGN_CENTER
          image = Picture($"ui/uiskin/attention.png")
        }
        {
          rendObj = ROBJ_TEXTAREA
          size = [flex(), SIZE_TO_CONTENT]
          behavior = Behaviors.TextArea
          text = "\n".join(messageTbl.map(@(n) n.message))
        }.__update(body_txt)
      ]
    }.__update(params)
  }
}

return serviceMessages