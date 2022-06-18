from "%enlSqGlob/ui_library.nut" import *

let { configs } = require("%enlSqGlob/configs/configs.nut")

let bonusesList = Computed(@()
  configs.value?.game_bonuses ?? {})

return {
  bonusesList = bonusesList
}
