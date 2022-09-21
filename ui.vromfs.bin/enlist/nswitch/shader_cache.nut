let nswitchShadersHw = require("nswitch.shaders")

let currentStage = 0
let stages = [
      [//0
        "ablend_2d",
        "ablend_particles",
        "ablend_particles_aces",
        "additive_2d",
        "additive_trails",
        "additive_trails_aces",
        "addsmooth_2d",
        "addsmooth_particles",
        "addsmooth_particles_aces",
        "apply_lowres_fx",
        "applyClouds",
        "applyCloudsDirect",
        "applyCloudsPanorama",
        "applySkies",
        "atest_2d",
        "atest_particles",
        "atest_particles_aces",
        "bc3_compressor",
        "bc3_srgbwrite_compressor",
        "bc4_compressor",
        "billboard_decals",
        "billboard_decals_generator",
        "billboard_decals_clear_sphere",
        "blood_decals_render_depth",
        "blood_on_screen",
        "blood_projective_decal_cull",
        "blood_projective_decal_decals",
        "blood_puddles",
        "bloom_filter_mipchain",
        "blur_blood_on_screen",
        "build_dacloud_shadow",
        "build_dacloud_volume",
        "cache0_compressor",
        "cache1_compressor",
        "cache2_compressor",
        "capture_zone_cull",
        "capture_zone_projective_decals",
        "clear_indirect_buffers",
        "clouds",
        "clouds_alpha_panorama",
        "clouds_panorama",
        "clouds_panorama_mip",
        "clouds_sun_sky",
        "cloudsFog",
        "cloudsTileDepthFilter",
        "combine_shadows",
        "compute_full_tonemap",
        "copy_depth",
        "copy_depth_region",
        "copy_grass_decals",
        "copy_tex",
        "copyInscatter1",
        "copyInscatterN",
        "copyIrradiance",
        "craters",
        "create_indirect",
        "dafx_culling_discard",
        "dafx_sparks_ps_emission",
        "dafx_sparks_ps_simulation",
        "daMoon",
        "daSkies",
        "daStars",
        "debug_lights",
        "debug_spot_lights",
        "debug_tex_overlay",
        "deferred_immediate_resolve",
        "deferred_shadow_to_buffer",
        "deferred_simple",
        "deferredLight",
        "direct_cache_bypass",
        "dof_composite",
        "dof_downsample",
        "dof_gather",
        "dof_tile",
        "downsample_depth_hzb",
        "downsample_depth2x",
        "downsample_shadows_depth_4x",
        "dynamic_crosshair",
        "dynamic_emissive",
        "dynamic_highlighter",
        "dynamic_masked_chrome_bump",
        "dynamic_masked_chrome_bump",
        "dynamic_refraction",
        "dynamic_simple",
        "dynamic_simple_glass",
        "dynamic_simple_transparent",
        "dynamic_skin",
        "eclipse_panorama",
        "fom_additive_particles_aces",
        "fom_particles_aces",
        "forcefield",
        "forcefield_apply",
        "forcefield_apply_fullscreen",
        "fxaa",
        "gbuffer_atest_particles",
        "gbuffer_atest_particles_aces",
        "generate_clouds_slice",
        "generate_imp_mipmaps",
        "get_sun_sky_lighting",
        "grass_render_billboards",
        "gui_blur_gui",
        "gui_default",
        "haze_particles_aces",
        "heightmap",
        "land_mesh_landclass_detailed",
        "land_mesh_landclass_detailed_r",
        "land_mesh_landclass_mega_detailed",
        "land_mesh_landclass_mega_nonormal",
        "land_mesh_landclass_simple",
        "land_mesh_landclass_trivial",
        "landmesh_indexed_landclass",
        "light_clouds_slice",
        "line_decals",
        "loading_splash",
        "make_puddles",
        "outline_edge_detect",
        "outline_fill_depth",
        "outline_final_render",
        "outline_final_render_fxaa",
        "point_lights",
        "postfog",
        "postfx",
        "prefab_simple",
        "preintegrateEnvi",
        "premultalpha_2d",
        "premultalpha_particles",
        "premultalpha_particles_aces",
        "prepareLayeredFogColors",
        "prepareLoss",
        "prepareSkies",
        "prepareSkyInscatter",
        "projective_decal_create_indirect",
        "projective_decal_cull",
        "projective_decal_decals",
        "projective_decal_decals_generator",
        "projectors",
        "rendinst_blend_diffuse_decal",
        "rendinst_deferred_decal",
        "rendinst_deferred_modulate2x_decal",
        "rendinst_emissive",
        "rendinst_baked_impostor",
        "rendinst_layered",
        "rendinst_mask_layered",
        "rendinst_modulate2x_diffuse_decal",
        "rendinst_names_diffuse_decal",
        "rendinst_perlin_layered",
        "rendinst_refraction",
        "rendinst_shadows_to_clipmap",
        "rendinst_simple",
        "rendinst_simple_glass",
        "rendinst_simple_painted",
        "rendinst_tree_colored",
        "rendinst_tree_colored_alpha_split",
        "rendinst_tree_perlin_layered",
        "rendinst_vcolor_layered",
        "scope_lens",
        "simple_gui_tonemap",
        "single_pass_blur11",
        "skyPanorama",
        "smoke_tracers_head",
        "smoke_tracers_tail",
        "sparks_ps",
        "specular_cube",
        "spot_lights",
        "strata_clouds",
        "strata_clouds_panorama",
        "taa",
        "temporalCloudsApply",
        "tileConstantFiller",
        "transmittance",
        "underwater_fog",
        "volmedia_particles_aces",
        "water_gradient",
        "water_gradient_mip",
        "water_normals",
        "water_nv2",
        "wires",
        "wound_decals_find_vertex",
        "yuv_movie"
      ],
      [//1
      ],
  ]

let function getStageShaders(index) {
  if (index >=0 && index < stages.len())
    return stages[index]

  return []
}

let function fire(index) {
  let stageShaders = getStageShaders(index)

  foreach (sh in stageShaders)
    nswitchShadersHw.fireShader(sh)
}

let function updateFromNetwork() {
  nswitchShadersHw.updateFromNetwork()
}

return {
  shaderCacheGetCurrentStage = @() currentStage
  shaderCacheFire = fire
  shaderCacheUpdateFromNetwork = updateFromNetwork
  shaderCacheGetVdrvCacheUuid = @() "unknown" // nswitchShadersHw.getCacheUuid()
}
