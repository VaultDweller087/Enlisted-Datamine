from "%enlSqGlob/ui_library.nut" import *

let { sub_txt } = require("%enlSqGlob/ui/fonts_style.nut")
let textButton = require("%ui/components/textButton.nut")
let { bigPadding, defBgColor, blurBgColor, blurBgFillColor,
  smallPadding, defTxtColor, activeTxtColor, squadSlotHorSize,
  selectedTxtColor, airSelectedBgColor, fadedTxtColor, opaqueBgColor,
  hoverBgColor, smallOffset
} = require("%enlSqGlob/ui/viewConst.nut")
let mkHeader = require("%enlist/components/mkHeader.nut")
let msgbox = require("%enlist/components/msgbox.nut")
let { txt, noteTextArea } = require("%enlSqGlob/ui/defcomps.nut")
let closeBtnBase = require("%ui/components/closeBtn.nut")
let { openUnlockSquadScene } = require("unlockSquadScene.nut")
let { safeAreaBorders } = require("%enlist/options/safeAreaState.nut")
let { sceneWithCameraAdd, sceneWithCameraRemove
} = require("%enlist/sceneWithCamera.nut")
let { isCurCampaignProgressUnlocked } = require("%enlist/meta/curCampaign.nut")
let { unlockCampaignPromo } = require("lockCampaignPkg.nut")
let { mkHorizontalSlot, mkEmptyHorizontalSlot, curDropData } = require("chooseSquadsSlots.nut")
let { isEventRoom } = require("%enlist/mpRoom/enlRoomState.nut")
let { isEventModesOpened } = require("%enlist/gameModes/eventModesState.nut")
let { unseenSquads, markSeenSquads } = require("model/unseenSquads.nut")
let unseenSignal = require("%ui/components/unseenSignal.nut")()
let hoverHoldAction = require("%darg/helpers/hoverHoldAction.nut")
let buyShopItem = require("%enlist/shop/buyShopItem.nut")
let currenciesWidgetUi = require("%enlist/currency/currenciesWidgetUi.nut")
let { squadsArmy, selectedSquadId, chosenSquads, reserveSquads, slotsCount,
  applyAndClose, closeAndOpenCampaign, changeSquadOrderByUnlockedIdx, unfocusSquad,
  squadsArmyLimits, moveIndex, changeList, curArmyLockedSquadsData, focusedSquads,
  sendSquadActionToBQ
} = require("%enlist/soldiers/model/chooseSquadsState.nut")
let { curArmySquadsUnlocks, scrollToCampaignLvl } = require("model/armyUnlocksState.nut")
let { makeVertScroll, thinStyle } = require("%ui/components/scrollbar.nut")
let { hasPremium } = require("%enlist/currency/premium.nut")
let { armySlotDiscount, armySlotItem } = require("%enlist/shop/armySlotDiscount.nut")
let { premiumImage } = require("%enlist/currency/premiumComp.nut")
let { armySquadsById } = require("model/state.nut")
let { squadsCfgById } = require("model/config/squadsConfig.nut")
let statsd = require("statsd")
let { isGamepad } = require("%ui/control/active_controls.nut")
let colorize = require("%ui/components/colorize.nut")
let { is_pc } = require("%dngscripts/platform.nut")
let premiumWnd = require("%enlist/currency/premiumWnd.nut")
let { mkDiscountIcon } = require("%enlist/shop/shopPkg.nut")
let openSquadTextTutorial = require("%enlist/tutorial/squadTextTutorial.nut")
let { unseenSquadTutorials, markSeenSquadTutorial
} = require("%enlist/tutorial/unseenSquadTextTutorial.nut")
let { tutorials } = require("%enlist/tutorial/squadTextTutorialPresentation.nut")
let {
  isFreemiumCampaign, needFreemiumStatus
} = require("%enlist/campaigns/freemiumState.nut")
let freemiumPromo = require("%enlist/currency/pkgFreemiumWidgets.nut")
let freemiumWnd = require("%enlist/currency/freemiumWnd.nut")
let { mkFreemiumXpImage } = require("%enlist/debriefing/components/mkXpImage.nut")


let sentStatsdData = persist("sentStatsdData", @() {})

let function sendData(key){
  let keyToCheck = isGamepad.value
    ? $"squad_management_gamepad_{key}"
    : $"squad_management_{key}"

  if(keyToCheck in sentStatsdData)
    return

  sentStatsdData[keyToCheck] <- 1
  statsd.send_counter(keyToCheck, 1)
}

let curArmyUnseenSquads = Computed(@() unseenSquads.value?[squadsArmy.value])

let firstSlotToAnim = Watched(null)
let secondSlotToAnim = Watched(null)
let needMoveCursor = Watched(false)
let hoveredSquad = Watched(null)
let function moveSquad(direction) {
  let squadId = selectedSquadId.value
  if (squadId == null)
    return
  foreach(watch in [chosenSquads, reserveSquads]) {
    let list = watch.value
    let idx = list.findindex(@(s) s?.squadId == squadId)
    if (idx == null)
      continue
    let newIdx = idx + direction
    if (newIdx in list) {
      watch(moveIndex(list, idx, newIdx))
      markSeenSquads(squadsArmy.value, [squadId])
      needMoveCursor(hoveredSquad.value != null)
      firstSlotToAnim(watch == reserveSquads ? newIdx + chosenSquads.value.len() : newIdx)
      secondSlotToAnim(watch == reserveSquads ? idx + chosenSquads.value.len() : idx)}
    break
  }
}

let moveParams = Computed(function() {
  local watch = null
  local idx = null
  let selId = isGamepad.value
    ? hoveredSquad.value ?? selectedSquadId.value
    : selectedSquadId.value
  if (selId != null)
    foreach(w in [chosenSquads, reserveSquads]) {
      idx = w.value.findindex(@(s) s?.squadId == selId)
      if (idx != null) {
        watch = w
        break
      }
    }
  return {
    canUp = watch != null && idx > 0
    canDown = watch != null && idx < watch.value.len() - 1
    canTake = watch == reserveSquads
    canRemove = watch == chosenSquads
  }
})

let buttonClose = textButton.Flat(loc("Close"), applyAndClose,
  { key = "closeSquadsManage" //used in tutorial
    margin = 0,
    padding = [0, hdpx(80)]})

let emptySquadToBuy = @(children){
  rendObj = ROBJ_BOX
  size = squadSlotHorSize
  fillColor = Color(0,0,0,0)
  borderColor = fadedTxtColor
  borderWidth = hdpx(1)
  halign = ALIGN_CENTER
  valign = ALIGN_CENTER
  children = children
}

let buySquadBtn = @(sf) {
  size = [flex(), SIZE_TO_CONTENT]
  halign = ALIGN_RIGHT
  margin = [0, bigPadding]
  children = {
    color = sf & S_HOVER ? activeTxtColor : defTxtColor
    rendObj = ROBJ_IMAGE
    size = [hdpx(30), hdpx(30)]
    image = Picture("!ui/squads/plus.svg:{0}:{0}:K".subst(hdpx(30).tointeger()))
  }
}

let squadsCountHint = @() {
  watch = squadsArmyLimits
  size = [flex(), SIZE_TO_CONTENT]
  flow = FLOW_VERTICAL
  children = [
    noteTextArea(loc("squads/maximumInBattleHint"))
      .__update({color = activeTxtColor, maxWidth = hdpx(440)}, sub_txt)
    noteTextArea(loc("squads/maxSquadsToTakeHint",
      { maxSquads =  colorize(activeTxtColor, squadsArmyLimits.value.maxSquadsInBattle),
        infantry  =  colorize(activeTxtColor, squadsArmyLimits.value.maxInfantrySquads),
        bike      =  colorize(activeTxtColor, squadsArmyLimits.value.maxBikeSquads),
        vehicle   =  colorize(activeTxtColor, squadsArmyLimits.value.maxVehicleSquads) }))
  ]
}

let squadsManagementHint = {
  rendObj = ROBJ_TEXTAREA
  behavior = Behaviors.TextArea
  size = [pw(100), SIZE_TO_CONTENT]
  margin = [hdpx(20), 0]
  color = activeTxtColor
  text = loc("squads/movingSquadsHint")
}.__update(sub_txt)

let faBtnParams = {
  borderWidth = 0
  borderRadius = 0
}

let function manageBlock() {
  let { canUp, canDown, canTake, canRemove } = moveParams.value
  return {
    watch = moveParams
    size = [flex(), SIZE_TO_CONTENT]
    valign = ALIGN_CENTER
    flow = FLOW_HORIZONTAL
    gap = bigPadding
    children = [
      textButton.FAButton("arrow-up", function(){
          if(hoveredSquad.value != null)
            selectedSquadId(hoveredSquad.value)
          moveSquad(-1)
          sendData("arrow-up")
          sendData( "any_button")
        },
        faBtnParams.__merge({
          key = "manageSquadsBtnUp" //used in tutorial
          isEnabled = canUp
          hotkeys = [["^J:Y", {description = loc("Move Up")}]]
        })),
      textButton.FAButton("arrow-down", function(){
          if(hoveredSquad.value != null)
            selectedSquadId(hoveredSquad.value)
          moveSquad(1)
          sendData("arrow-down")
          sendData( "any_button")
        },
        faBtnParams.__merge({
          key = "manageSquadsBtnDown" //used in tutorial
          isEnabled = canDown
          hotkeys = [["^J:X", {description = loc("Move Down")}]]
        })),
      canTake ? textButton.FAButton("arrow-left", function(){
          if(hoveredSquad.value != null)
            selectedSquadId(hoveredSquad.value)
          changeList()
          sendData("arrow-left")
          sendData( "any_button")
        },
        faBtnParams.__merge({
          key = "manageSquadsBtnLeft" //used in tutorial
          isEnabled = canTake
          hotkeys = [["^J:LB", {description = loc("TakeToBattle")}]]
        }))
        : canRemove ? textButton.FAButton("arrow-right", function(){
            if(hoveredSquad.value != null)
              selectedSquadId(hoveredSquad.value)
            changeList()
            sendData("arrow-right")
            sendData( "any_button")
          },
          faBtnParams.__merge({
            key = "manageSquadsBtnRight" //used in tutorial
            isEnabled = canRemove
            hotkeys = [["^J:RB", {description = loc("MoveToReserve")}]]
          }))
        : null,
      { size = [flex(), 0] }
    ]
  }
}

let squadUnseenMark = @(squadId) @() {
  watch = curArmyUnseenSquads
  hplace = ALIGN_RIGHT
  children = (curArmyUnseenSquads.value?[squadId] ?? false) ? unseenSignal : null
}

let mkSquadFocused = @(squadId) function() {
  let res = { watch = focusedSquads }
  if (squadId not in focusedSquads.value)
    return res

  return res.__update({
    size = flex()
    rendObj = ROBJ_FRAME
    borderWidth = hdpx(4)
    color = Color(240, 200, 100, 190)
    transform = {}
    animations = [
      { prop = AnimProp.opacity, from = 0, to = 0.5, easing = CosineFull,
        duration = 0.8, play = true, loop = true }
    ]
  })
}

let emptySlotNumberStyle = {
  fillColor = Color(0,0,0,0)
  borderColor = fadedTxtColor
  borderWidth = hdpx(1)
}

let squadNumber = @(idx, style = {}){
  rendObj = ROBJ_BOX
  size = [hdpx(25), flex()]
  valign = ALIGN_CENTER
  halign = ALIGN_CENTER
  padding = [0, smallPadding]
  margin = [0, bigPadding,0,0]
  fillColor = defBgColor
  borderWidth = 0
  children = {
    rendObj = ROBJ_TEXT
    text = idx + 1
    color = defTxtColor
  }.__update(sub_txt)
}.__merge(style)

let premBlockBg = {
  rendObj = ROBJ_SOLID
  color = defBgColor
  padding = bigPadding
}

let buyAdditionalSlot = @(num, shopItem) watchElemState(@(sf) {
  watch = [armySlotDiscount]
  size = [flex(), SIZE_TO_CONTENT]
  flow = FLOW_HORIZONTAL
  gap = smallPadding
  behavior = Behaviors.Button
  onClick = @() buyShopItem({ shopItem })
  children = [
    squadNumber(num, emptySlotNumberStyle)
    emptySquadToBuy([
      {
        size = flex()
        valign = ALIGN_CENTER
        flow = FLOW_HORIZONTAL
        margin = [0, hdpx(20)]
        gap = hdpx(20)
        children = [
          {
            rendObj = ROBJ_TEXT
            text = loc("squad/openNewSlot")
            color = sf & S_HOVER ? activeTxtColor : fadedTxtColor
          }
          mkDiscountIcon(armySlotDiscount.value,
            { hplace = ALIGN_LEFT, vplace = ALIGN_CENTER, pos = null })
        ]
      }
      buySquadBtn(sf)
    ])
  ]
})

let buySquadSlot = @(num) function() {
  let res = { watch = [hasPremium, isCurCampaignProgressUnlocked,
    armySlotItem, isFreemiumCampaign] }
  if (isFreemiumCampaign.value)
    return res

  let shopItem = armySlotItem.value
  return res.__update({
    size = [flex(), SIZE_TO_CONTENT]
    children = !isCurCampaignProgressUnlocked.value ? unlockCampaignPromo(premBlockBg)
      : hasPremium.value && shopItem ? buyAdditionalSlot(num, shopItem)
      : null
  })
}

let squadHorSlot = @(squad, idx, slotsCount) @(){
  watch = [needMoveCursor, hoveredSquad, firstSlotToAnim, secondSlotToAnim,
            chosenSquads, unseenSquadTutorials]
  children = mkHorizontalSlot(
    squad.__merge({
      idx = idx
      onDropCb = function(idxFrom, idxTo){
        changeSquadOrderByUnlockedIdx(idxFrom, idxTo)
        sendData("drag_and_drop")
        foreach (cSquad in chosenSquads.value){
          let { squadType = null } = cSquad
          if (squadType in unseenSquadTutorials.value){
              openSquadTextTutorial(squadType)
              markSeenSquadTutorial(squadType)
              break
            }
        }
      }
      onInfoCb = function(squadId) {
        let armyId = squadsArmy.value
        openUnlockSquadScene({
          armyId
          squad = armySquadsById.value?[armyId][squadId]
          squadCfg = squadsCfgById.value?[armyId][squadId]
          unlockInfo = null
        })
        selectedSquadId(null)
      }
      onClick = @() selectedSquadId(squad.squadId)
      isSelected = Computed(@() selectedSquadId.value == squad.squadId)
      override = {
        onHover = function(on, squadId){
          if(on)
             hoveredSquad(squad.squadId)
          else
            hoveredSquad(null)
          hoverHoldAction("unseenSquad", squad.squadId,
            function() {
              unfocusSquad(squadId)
              markSeenSquads(squadsArmy.value, [squadId])
            })
          }
      }
      group = ElemGroup()
      fixedSlots = slotsCount
      needMoveCursor = hoveredSquad.value == squad.squadId ? needMoveCursor.value : false
      firstSlotToAnim = firstSlotToAnim.value
      secondSlotToAnim = secondSlotToAnim.value
      addChildren = [
        mkSquadFocused(squad.squadId)
        squadUnseenMark(squad.squadId)
      ]
      needSquadTutorial = squad.squadType in tutorials
    }),
    KWARG_NON_STRICT
  )
}

let emptyHorSquadSlot = @(idx, slotsCount, isReserveEmpty) mkEmptyHorizontalSlot({
  idx = idx
  onDropCb = function(idxFrom, idxTo){
    changeSquadOrderByUnlockedIdx(idxFrom, idxTo)
    sendData("drag_and_drop")
  }
  fixedSlots = slotsCount
  hasBlink = !isReserveEmpty
})

let mkSquadSlot = @(squad, idx, slotsCount, isReserve, isReserveEmpty = true) {
  flow = FLOW_HORIZONTAL
  gap = smallPadding
  children = [
    !isReserve ? squadNumber(idx) : null
    squad != null
      ? squadHorSlot(squad, idx, slotsCount)
      : emptyHorSquadSlot(idx, slotsCount, isReserveEmpty)
    ]
}

let iconSize = hdpx(30).tointeger()
let premiumIcon = premiumImage(iconSize)
let freemiumIcon = mkFreemiumXpImage(iconSize)

let mkPrimeSlotTxt = @(icon, locId) {
  flow = FLOW_HORIZONTAL
  size = [flex(), SIZE_TO_CONTENT]
  gap = bigPadding
  valign = ALIGN_CENTER
  margin = [0, hdpx(20)]
  children = [
    icon
    {
      rendObj = ROBJ_TEXT
      text = loc(locId)
      color = fadedTxtColor
    }
  ]
}

let slotToBuy = @(num, icon, locId) {
  flow = FLOW_HORIZONTAL
  gap = smallPadding
  children = [
    squadNumber(num, emptySlotNumberStyle)
    emptySquadToBuy(mkPrimeSlotTxt(icon, locId))
  ]
}

let mkPrimeSlots = @(num, count, icon, locId) {
  flow = FLOW_VERTICAL
  gap = bigPadding
  children = array(count).map(@(_, idx) slotToBuy(num + idx, icon, locId))
}

let buyPremBtn = @(onClick)
  watchElemState(@(sf){
    rendObj = ROBJ_BOX
    behavior = Behaviors.Button
    onClick
    size = [hdpx(40), hdpx(40)]
    fillColor = sf & S_HOVER ? hoverBgColor : opaqueBgColor
    borderWidth = hdpx(1)
    borderRadius = hdpx(40)
    borderColor = sf & S_HOVER ? selectedTxtColor : fadedTxtColor
    pos = [squadSlotHorSize[0] - bigPadding * 2, 0]
    valign = ALIGN_CENTER
    halign = ALIGN_CENTER
    sound = {
      click  = "ui/enlist/button_click"
      hover  = "ui/enlist/button_highlight"
      active = "ui/enlist/button_action"
    }
    children = {
      keepAspect = true
      rendObj = ROBJ_IMAGE
      size = [hdpx(30), hdpx(30)]
      image = Picture("!ui/squads/plus.svg:{0}:{1}:K".subst(hdpx(30), hdpx(30)))
      color = sf & S_HOVER ? selectedTxtColor : activeTxtColor
    }
  })


let lockedPrimeSlots = @(squadNum) function() {
  let res = { watch = [
    isCurCampaignProgressUnlocked, hasPremium, needFreemiumStatus
  ]}

  if (!isCurCampaignProgressUnlocked.value)
    return res

  let children = []
  if (needFreemiumStatus.value)
    children.append(
      mkPrimeSlots(squadNum, 4, freemiumIcon, "squad/plusFreemiumSquadSlot"),
      buyPremBtn(freemiumWnd)
    )
  else if (!hasPremium.value)
    children.append(
      mkPrimeSlots(squadNum, 2, premiumIcon, "squad/plusPremiunSquadSlot"),
      buyPremBtn(premiumWnd)
    )

  return res.__update({
    valign = ALIGN_CENTER
    children
  })
}

let scrollHandlerLeftPanel = ScrollHandler()

let mkChosenSquads = @(chosen, ctor, bottomPrime, buySquadSlot) {
  size = [SIZE_TO_CONTENT, flex()]
  flow = FLOW_VERTICAL
  clipChildren = true
  gap = bigPadding
  children = makeVertScroll({
    flow = FLOW_VERTICAL
    gap = bigPadding
    children = chosen.map(ctor)
      .append(bottomPrime)
      .append(buySquadSlot)
  },
  {
    size = [SIZE_TO_CONTENT, flex()]
    styling = thinStyle
    scrollHandler = scrollHandlerLeftPanel
  })
}

let panelBg = {
  size = [SIZE_TO_CONTENT, flex()]
  padding = bigPadding
  rendObj = ROBJ_WORLD_BLUR_PANEL
  color = blurBgColor
  fillColor = blurBgFillColor
}

let function leftHeader(){
  local infantryCur = 0
  local bikeCur = 0
  local vehicleCur = 0
  chosenSquads.value.each(function(squad) {
    if (squad == null)
      return
    let { vehicleType = "" } = squad
    if (vehicleType == "bike")
      ++bikeCur
    else if (vehicleType != "")
      ++vehicleCur
    else
      ++infantryCur
  })
  let curSquads = infantryCur + bikeCur + vehicleCur
  let infantryStr = loc("squads/maxInfantry",
    { infantryCur, infantryMax =  squadsArmyLimits.value.maxInfantrySquads })
  let bikeStr = loc("squads/maxBike",
    { bikeCur, bikeMax =  squadsArmyLimits.value.maxBikeSquads })
  let vehicleStr = loc("squads/maxVehicle",
    { vehicleCur, vehicleMax = squadsArmyLimits.value.maxVehicleSquads })
  return {
    watch = [squadsArmyLimits, chosenSquads]
    size = [flex(), SIZE_TO_CONTENT]
    children = [
    txt(loc("squads/maxSquads", { curSquads, maxSquads = chosenSquads.value.len() }))
    {
     rendObj = ROBJ_TEXT
     color = defTxtColor
     hplace = ALIGN_RIGHT
     text = " | ".join([infantryStr, bikeStr, vehicleStr])
    }
  ]
}}

let leftPanel = @() panelBg.__merge({
  watch = [chosenSquads, reserveSquads]
  children = {
    size = [SIZE_TO_CONTENT, flex()]
    flow = FLOW_VERTICAL
    gap = bigPadding
    children = [
      leftHeader
      mkChosenSquads(chosenSquads.value, @(squad, idx)
        mkSquadSlot(squad, idx, chosenSquads.value.len(),
          false, reserveSquads.value.len() == 0),
        lockedPrimeSlots(chosenSquads.value.len()),
        buySquadSlot(chosenSquads.value.len()))
      is_pc ? squadsManagementHint : null
      manageBlock
      {
        flow = FLOW_HORIZONTAL
        size = [flex(), SIZE_TO_CONTENT]
        padding = [hdpx(10), 0]
        children = [
          squadsCountHint
          buttonClose
        ]
      }
    ]
  }
})

let showLockedSquadMsgbox = function(squadDesc) {
  let { squadId, nameLocId } = squadDesc
  let unlock = curArmySquadsUnlocks.value
    .findvalue(@(u) u.unlockType == "squad" && u.unlockId == squadId)
  if (unlock == null)
    return

  let btnBlock = [{ text = loc("Ok"), isCancel = true }]

  msgbox.show({
    text = loc("squads/cantUseLocked", {
      name = loc(nameLocId)
      level = unlock.level
    })
    buttons = Computed(@() isEventRoom.value || isEventModesOpened.value
      ? btnBlock
      : btnBlock.append(
        {
          text = loc("squads/gotoUnlockBtn")
          action = function() {
            scrollToCampaignLvl(unlock.level)
            closeAndOpenCampaign()
          }
          isCurrent = true
        }
      )
    )
  })
}

let labelText = @(sf, needHighlight) {
  rendObj = ROBJ_TEXT
  text = loc("squad/dropToReserve")
  hplace = ALIGN_CENTER
  vplace = ALIGN_CENTER
  color = (sf & S_ACTIVE) != 0 && needHighlight? selectedTxtColor : defTxtColor
}.__update(sub_txt)

let function dropToReserveContainer() {
  let function dropContainer(sf) {
    let highligtToDrop = curDropData.value?.squadIdx != null
      && curDropData.value.squadIdx <= chosenSquads.value.len() - 1
    return {
      watch = [curDropData, chosenSquads]
      key = "dropToReserveSquad" //used in tutorial
      rendObj = ROBJ_BOX
      fillColor = (sf & S_ACTIVE) != 0 && highligtToDrop ? airSelectedBgColor : defBgColor
      size = squadSlotHorSize
      borderWidth = highligtToDrop ? hdpx(1) : 0
      transform = {}
      behavior = Behaviors.DragAndDrop
      onDrop = function(data) {
        if(data.squadIdx > chosenSquads.value.len() - 1)
          return

        let { guid, squadId } = chosenSquads.value[data.squadIdx]
        sendSquadActionToBQ("move_to_reserve", guid, squadId)
        reserveSquads.mutate(@(v) v.insert(0, chosenSquads.value[data.squadIdx]))
        chosenSquads.mutate(@(v) v[data.squadIdx] = null)
      }
      children = labelText(sf, highligtToDrop)
    }
  }
  return watchElemState(dropContainer)
}


let scrollHandlerRightPanel = ScrollHandler()
let function rightPanel() {
  let sCount = slotsCount.value
  let children = []
  let reserveChildren = reserveSquads.value
    .map(@(squad, idx) mkSquadSlot(squad, idx + sCount, sCount, true))
  if (reserveChildren.len() >= 0)
    children
      .append(txt(loc("squads/reserveSquads", "Reserve squads")))
      .append(chosenSquads.value.findvalue(@(squad) squad != null)
        ? dropToReserveContainer()
        : null)
      .extend(reserveChildren)

  let lockedChildren = curArmyLockedSquadsData.value
    .map(@(val) mkHorizontalSlot(val.squad.__merge({
      guid = ""
      isLocked = true
      idx = -1
      onClick = @() showLockedSquadMsgbox(val.squad)
      unlocObj = txt({
        text = loc("campaignLevel", { lvl = val.unlockData.level })
        margin = bigPadding
      })
    }), KWARG_NON_STRICT))
  if (lockedChildren.len() > 0) {
    children
      .append(txt(loc("squads/lockedSquads", "Locked squads")))
      .extend(lockedChildren)
  }

  return panelBg.__merge({
    watch = [slotsCount, reserveSquads, curArmyLockedSquadsData, chosenSquads]
    size = [SIZE_TO_CONTENT, flex()]
    flow = FLOW_VERTICAL
    gap = smallOffset
    children = [
      {
        size = [SIZE_TO_CONTENT, flex()]
        children = makeVertScroll({
          flow = FLOW_VERTICAL
          gap = bigPadding
          children = children
        },
        {
          size = [SIZE_TO_CONTENT, flex()]
          styling = thinStyle
          scrollHandler = scrollHandlerRightPanel
        })
      }
      @() {
        watch = needFreemiumStatus
        size = [flex(), SIZE_TO_CONTENT]
        children = !needFreemiumStatus.value ? null : freemiumPromo("squads_manage", null, {
          size = [flex(), SIZE_TO_CONTENT]
        })
      }
    ]
  })
}

let allSquadsList = {
  size = flex()
  flow = FLOW_HORIZONTAL
  gap = bigPadding
  children = [
    leftPanel
    rightPanel
  ]
}

let function chooseSquadsScene(){
  let neededSquad = hoveredSquad.value ?? selectedSquadId.value
  return  {
    watch = [squadsArmy, safeAreaBorders, hoveredSquad, selectedSquadId]
    size = [sw(100), sh(100)]
    flow = FLOW_VERTICAL
    padding = safeAreaBorders.value
    hotkeys = neededSquad != null
      ? [["^J:Start", {description = loc("squads/squadInfo"),
          action = function() {
            let armyId = squadsArmy.value
            openUnlockSquadScene({
              armyId
              squad = armySquadsById.value?[armyId][neededSquad]
              squadCfg = squadsCfgById.value?[armyId][neededSquad]
              unlockInfo = null
            })
        }}]]
      : null
    onDetach = @() markSeenSquads(squadsArmy.value, (curArmyUnseenSquads.value ?? {}).keys())

    children = [
      mkHeader({
        armyId = squadsArmy.value
        textLocId = "squads/manageTitle"
        closeButton = closeBtnBase({ onClick = applyAndClose })
        addToRight = currenciesWidgetUi
      })
      {
        size = flex()
        children = allSquadsList
      }
    ]}
}

let isOpened = keepref(Computed(@() squadsArmy.value != null))
let open = @() sceneWithCameraAdd(chooseSquadsScene, "soldiers")
if (isOpened.value)
  open()

isOpened.subscribe(function(v) {
  if (v == true)
    open()
  else
    sceneWithCameraRemove(chooseSquadsScene)
})