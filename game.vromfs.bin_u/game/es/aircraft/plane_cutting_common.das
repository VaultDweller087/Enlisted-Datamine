module plane_cutting_common shared
require ecs

enum WreckageCutPartId : int
  WRECK_PART_PART_WING_L
  WRECK_PART_PART_WING1_L
  WRECK_PART_PART_WING2_L

  WRECK_PART_PART_WING_R
  WRECK_PART_PART_WING1_R
  WRECK_PART_PART_WING2_R

  WRECK_PART_PART_TAIL
  WRECK_PART_PART_FIN
  WRECK_PART_PART_STAB
  WRECK_PART_PART_STAB_1
  WRECK_PART_PART_STAB_2

enum FlightModelCutState : int
  FMCS_NONE
  FMCS_SMALL_CUT
  FMCS_MID_CUT
  FMCS_ALL_CUT
  FMCS_CUT_NUM

enum WreckageType : int
  WRECKAGE_WING_L
  WRECKAGE_WING_R
  WRECKAGE_TAIL
  WRECKAGE_STAB_L
  WRECKAGE_STAB_R
  WRECKAGE_FIN
