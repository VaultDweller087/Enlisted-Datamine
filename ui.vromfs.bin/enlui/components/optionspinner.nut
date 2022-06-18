from "%enlSqGlob/ui_library.nut" import *

let spinnerList = require("spinnerList.nut")

let locOn = loc($"option/on")
let locOff = loc($"option/off")
let function optionSpinner(opt, group, xmbNode) {
  let available = opt?.available instanceof Watched
    ? opt.available
    : Watched(opt?.available)
  let spinnerElem = @(){
    size = flex()
    watch = available
    children = spinnerList({
      isEqual = opt?.isEqual
      setValue = opt?.setValue
      curValue = opt.var
      valToString = opt?.valToString ?? @(val) val ? locOn : locOff
      allValues = available.value
      xmbNode
      group
    })
  }
  return spinnerElem
}

return optionSpinner