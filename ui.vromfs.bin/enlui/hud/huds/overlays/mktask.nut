from "%enlSqGlob/ui_library.nut" import *

let {
  mkTaskEmblem, taskHeader, taskMinHeight, taskSlotPadding,
  taskDescription, taskDescPadding
} = require("%enlSqGlob/ui/taskPkg.nut")
let {
  darkBgColor, smallPadding
} = require("%enlSqGlob/ui/viewConst.nut")


let function mkTaskContent(unlockDesc) {
  let {
    isCompleted = false, isFinished = false, required = 0, current = 0
  } = unlockDesc
  let progress = { isCompleted, required, current, isFinished }
  return {
    size = [flex(), SIZE_TO_CONTENT]
    valign = ALIGN_CENTER
    children = {
      size = [flex(), SIZE_TO_CONTENT]
      flow = FLOW_HORIZONTAL
      gap = hdpx(10)
      valign = ALIGN_CENTER
      children = [
        mkTaskEmblem(unlockDesc, progress)
        taskHeader(unlockDesc, progress)
      ]
    }
  }
}

let mkUnlockSlot = @(unlockDesc) {
  size = [flex(), SIZE_TO_CONTENT]
  minHeight = taskMinHeight
  valign = ALIGN_CENTER
  children = [
    {
      rendObj = ROBJ_SOLID
      size = flex()
      color = darkBgColor
    }
    {
      size = [flex(), SIZE_TO_CONTENT]
      flow = FLOW_VERTICAL
      padding = taskSlotPadding
      gap = smallPadding
      valign = ALIGN_CENTER
      children = [
        mkTaskContent(unlockDesc)
        taskDescription(unlockDesc.localization.description, {
          margin = taskDescPadding
        })
      ]
    }
  ]
}

return mkUnlockSlot
