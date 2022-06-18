from "%enlSqGlob/ui_library.nut" import *

let hoverHoldAction = require("%darg/helpers/hoverHoldAction.nut")
let unseenSignal = require("%ui/components/unseenSignal.nut")(0.8)
let { sub_txt } = require("%enlSqGlob/ui/fonts_style.nut")
let { makeVertScroll } = require("%ui/components/scrollbar.nut")
let { receiveTaskRewards } = require("taskListState.nut")
let {
  weeklyTasks, unseenWeeklyTasks, markSeenWeeklyTasks,
  saveFinishedWeeklyTasks, triggerBPStarsAnim
} = require("weeklyUnlocksState.nut")
let { getUnlockProgress, unlockProgress } = require("%enlSqGlob/userstats/unlocksState.nut")
let { unlockRewardsInProgress } = require("%enlSqGlob/userstats/userstat.nut")
let {
  smallPadding, smallOffset, tinyOffset, defBgColor, defTxtColor,
  activeTxtColor, taskProgressColor, bigPadding
} = require("%enlSqGlob/ui/viewConst.nut")
let {
  taskMinHeight, taskSlotPadding, mkTaskEmblem, taskHeader, taskDescription,
  taskDescPadding, mkGetTaskRewardBtn, statusBlock
} = require("%enlSqGlob/ui/taskPkg.nut")
let serverTime = require("%enlSqGlob/userstats/serverTime.nut")
let { secondsToStringLoc } = require("%ui/helpers/time.nut")


let finishedOpacity = 0.5
let finishedBgColor = mul_color(defBgColor, 1.0 / finishedOpacity)

let mkTaskContent = @(task) function() {
  let progress = getUnlockProgress(task)
  let { isFinished = false, activity = null } = task
  let { active = false } = activity
  return {
    watch = [unlockProgress]
    size = [flex(), SIZE_TO_CONTENT]
    flow = FLOW_HORIZONTAL
    gap = tinyOffset
    valign = ALIGN_CENTER
    children = [
      mkTaskEmblem(task, progress)
      {
        size = [flex(), SIZE_TO_CONTENT]
        flow = FLOW_VERTICAL
        gap = taskDescPadding
        opacity = isFinished || !active ? finishedOpacity : 1.0
        children = [
          taskHeader(task, progress)
          taskDescription(task.localization.description)
        ]
      }
    ]
  }
}

let timerSize = hdpx(18).tointeger()
let timerIcon = {
  rendObj = ROBJ_IMAGE
  size = [timerSize, timerSize]
  image = Picture($"ui/skin#/battlepass/boost_time.svg:{timerSize}:{timerSize}:K")
  color = taskProgressColor
}

let function mkTaskExpireTimer(expireTime) {
  let expireText = Computed(function() {
    let expireSec = expireTime - serverTime.value
    return expireSec <= 0 ? "" : secondsToStringLoc(expireSec)
  })
  return @() {
    watch = expireText
    flow = FLOW_VERTICAL
    halign = ALIGN_RIGHT
    vplace = ALIGN_CENTER
    children = expireText.value == "" ? null
      : [
          {
            rendObj = ROBJ_TEXT
            text = loc("unlock/expireHeader")
            color = activeTxtColor
          }.__update(sub_txt)
          {
            flow = FLOW_HORIZONTAL
            gap = bigPadding
            valign = ALIGN_CENTER
            children = [
              timerIcon
              {
                rendObj = ROBJ_TEXT
                text = expireText.value
                color = taskProgressColor
              }.__update(sub_txt)
            ]
          }
        ]
  }
}

let function mkWeeklyTaskSlot(task, isUnseen) {
  let { name, isFinished = false, hasReward = false, activity = null } = task
  let { end_timestamp = 0, active = false } = activity
  let hasExpireTimer = active && !isFinished
  return {
    size = [flex(), SIZE_TO_CONTENT]
    children = [
      {
        size = [flex(), SIZE_TO_CONTENT]
        minHeight = taskMinHeight
        rendObj = ROBJ_SOLID
        flow = FLOW_HORIZONTAL
        gap = smallPadding
        padding = taskSlotPadding
        valign = ALIGN_CENTER
        color = isFinished ? finishedBgColor : defBgColor
        xmbNode = XmbNode()
        behavior = Behaviors.Button
        onHover = function(on) {
          if (isUnseen)
            hoverHoldAction("markSeenWeeklyTasks", name, @(v) markSeenWeeklyTasks(v))(on)
        }
        children = [
          mkTaskContent(task)
          hasReward
            ? mkGetTaskRewardBtn(task, receiveTaskRewards, unlockRewardsInProgress)
            : !active ? {
                rendObj = ROBJ_TEXT
                text = loc("notActive")
                color = defTxtColor
              }
            : hasExpireTimer ? mkTaskExpireTimer(end_timestamp)
            : null
        ]
      }
      statusBlock(task)
      isUnseen ? unseenSignal : null
    ]
  }
}

let WINDOW_CONTENT_SIZE = [fsh(100), flex()]
return {
  key = "weeklyBlock"
  size = WINDOW_CONTENT_SIZE
  vplace = ALIGN_CENTER
  hplace = ALIGN_CENTER
  padding = [fsh(2),0,0,0]
  onAttach = saveFinishedWeeklyTasks
  onDetach = triggerBPStarsAnim
  children = makeVertScroll(function() {
    let unseen = unseenWeeklyTasks.value
    return {
      rendObj = ROBJ_WORLD_BLUR_PANEL
      watch = [weeklyTasks, unseenWeeklyTasks]
      size = [flex(), SIZE_TO_CONTENT]
      minHeight = ph(100)
      xmbNode = XmbContainer({
        canFocus = @() false
        scrollSpeed = 5
        isViewport = true
      })
      flow = FLOW_VERTICAL
      gap = smallPadding
      margin = [0,0,0,smallOffset]
      halign = ALIGN_CENTER
      children = weeklyTasks.value.map(@(task) mkWeeklyTaskSlot(task, task.name in unseen))
    }
  })
}
