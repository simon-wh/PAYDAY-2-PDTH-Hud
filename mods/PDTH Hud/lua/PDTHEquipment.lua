function pdth_hud:UseDoorDrill()
	return true
end

pdth_hud.PDTHEquipment = {
	["units/payday2/equipment/item_door_drill_small/item_door_drill_small"] = {
		SequenceMods = {
			["'activate'"] = {
				ElementMods = {
					["'anim'"] = { enabled = false },
					["'g_base'"] = { enabled = true },
					["'g_drill'"] = { enabled = true },
					["'g_drill_drill'"] = { enabled = true },
					["'icon'"] = { visibility = false },
				},
				NewElements = {
					[1] = { 
						_meta = "material",
						name = "'mtr_drill'",
						texture = "'units/gui/gui_color_use_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					},
					material = {
						_meta = "material",
						name = "'mtr_drill'",
						texture = "'units/gui/gui_color_use_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					}
				}
			},
			["'int_seq_show_texured'"] = {
				NewElements = {
					[1] = {
						_meta = "material",
						name = "'mtr_drill'",
						texture = "'units/payday2/equipment/gen_interactable_drill_small/drill_small_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					},
					material = {
						_meta = "material",
						name = "'mtr_drill'",
						texture = "'units/payday2/equipment/gen_interactable_drill_small/drill_small_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					}
				}
			}
		},
		priority = 0,
		use_callback = callback(pdth_hud, pdth_hud, "UseDoorDrill")
	},
	["units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge"] = {
		SequenceMods = {
			["'show'"] = {
				NewElements = {
					[1] = {
						_meta = "material_config",
						name = "'units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge'"
					},
					material_config = {
						_meta = "material_config",
						name = "'units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge'"
					}
				}
			}
		},
		NewSequences = {
			[1] = {	
				_meta = "sequence",
				[1] = {
					_meta = "interaction",
					enabled = true
				},
				[2] = {
					_meta = "body",
					enabled = false,
					name = "'body_static'"
				},
				[3] = {
					_meta = "object",
					enabled = true,
					name = "'g_gen_equipment_shape_charge'"
				},
				[4] = {
					_meta = "object",
					enabled = false,
					name = "'g_gen_equipment_shape_charge_glow'"
				},
				[5] = {
					_meta = "effect_spawner",
					enabled = false,
					name = "'effect_light'"
				},
				[6] = {
					_meta = "effect_spawner",
					enabled = false,
					name = "'effect_light2'"
				},
				[7] = {
					_meta = "material_config",
					name = "'units/weapons/shield/shield'"
				},
				[8] = {
					_meta = "graphic_group",
					name = "'c4_icon'",
					visibility = false
				},
				body = {
					_meta = "body",
					enabled = false,
					name = "'body_static'"
				},
				editable_state = true,
				effect_spawner = {
					_meta = "effect_spawner",
					enabled = false,
					name = "'effect_light'"
				},
				interaction = {
					_meta = "interaction",
					enabled = true
				},
				--[[material = {
					_meta = "material",
					name = "'mtr_shape_charge'",
					texture = "'units/gui/gui_color_use_df'",
					search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
					multiple_objects = false
				},]]--
				material_config = {
					_meta = "material_config",
					name = "'units/weapons/shield/shield'"
				},
				graphic_group = {
					_meta = "graphic_group",
					name = "'c4_icon'",
					visibility = false
				},
				name = "'activate'",
				object = {
					_meta = "object",
					enabled = true,
					name = "'g_gen_equipment_shape_charge'"
				},
				triggable = true
			}
		},
		priority = 0
	},
	["units/payday2/equipment/gen_interactable_door_keycard/gen_interactable_door_keycard_jammer"] = { 
		SequenceMods = {
			[" 'interact' "] = {
				NewElements = {
					[1] = {
						_meta = "material",
						name = "'ecm'",
						texture = "'units/payday2/equipment/gen_equipment_jammer/ecm_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = false		
					},
					material = {
						_meta = "material",
						name = "'ecm'",
						texture = "'units/payday2/equipment/gen_equipment_jammer/ecm_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = false
					}
				}
			}
		},
		NewSequences = {
			[1] = {
				_meta = "sequence",
				[1] = {
					_meta = "object",
					enabled = true,
					name = "'g_ecm'"
				},
				[2] = {
					_meta = "material",
					name = "'ecm'",
					texture = "'units/gui/gui_color_use_df'",
					search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
					multiple_objects = false
				},
				[3] = {
					_meta = "graphic_group",
					name = "'ecm_icon'",
					visibility = false
				},
				editable_state = false,
				material = {
					_meta = "material",
					name = "'ecm'",
					texture = "'units/gui/gui_color_use_df'",
					search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
					multiple_objects = false
				},
				graphic_group = {
					_meta = "graphic_group",
					name = "'ecm_icon'",
					visibility = false
				},
				name = "'activate'",
				object = {
					_meta = "object",
					enabled = true,
					name = "'g_ecm'"
				},
				triggable = true
			}
		},
		priority = 0
	},
	["units/payday2/equipment/gen_interactable_door_keycard/item_door_keycard_jammer_double"] = {
		SequenceMods = {
			[" 'interact' "] = {
				NewElements = {
					[1] = {
						_meta = "material",
						name = "'ecm'",
						texture = "'units/payday2/equipment/gen_equipment_jammer/ecm_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = false
					},
					material = {
						_meta = "material",
						name = "'ecm'",
						texture = "'units/payday2/equipment/gen_equipment_jammer/ecm_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = false
					}
				}
			}
		},
		NewSequences = {
			[1] = {	
				_meta = "sequence",
				[1] = {
					_meta = "object",
					enabled = true,
					name = "'g_ecm'"
				},
				[2] = {
					_meta = "material",
					name = "'ecm'",
					texture = "'units/gui/gui_color_use_df'",
					search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
					multiple_objects = false
				},
				[3] = {
					_meta = "graphic_group",
					name = "'ecm_icon'",
					visibility = false
				},
				editable_state = false,
				material = {
					_meta = "material",
					name = "'ecm'",
					texture = "'units/gui/gui_color_use_df'",
					search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
					multiple_objects = false
				},
				graphic_group = {
					_meta = "graphic_group",
					name = "'ecm_icon'",
					visibility = false
				},
				name = "'activate'",
				object = {
					_meta = "object",
					enabled = true,
					name = "'g_ecm'"
				},
				triggable = true
			}
		},
		priority = 0
	},
	["units/payday2/props/gen_prop_bank_atm_standing/gen_prop_bank_atm_jammer"] = {
		SequenceMods  = {
			[" 'interact' "] = {
				NewElements = {
					[1] = {
						_meta = "material",
						name = "'ecm'",
						texture = "'units/payday2/equipment/gen_equipment_jammer/ecm_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = false
					},
					material = {
						_meta = "material",
						name = "'ecm'",
						texture = "'units/payday2/equipment/gen_equipment_jammer/ecm_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = false
					}
				}
			}
		},
		NewSequences = {
			[1] = {	
				_meta = "sequence",
				[1] = {
					_meta = "object",
					enabled = true,
					name = "'g_ecm'"
				},
				[2] = {
					_meta = "material",
					name = "'ecm'",
					texture = "'units/gui/gui_color_use_df'",
					search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
					multiple_objects = false
				},
				[3] = {
					_meta = "graphic_group",
					name = "'ecm_icon'",
					visibility = false
				},
				editable_state = true,
				material = {
					_meta = "material",
					name = "'ecm'",
					texture = "'units/gui/gui_color_use_df'",
					search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
					multiple_objects = false
				},
				graphic_group = {
					_meta = "graphic_group",
					name = "'ecm_icon'",
					visibility = false
				},
                name = "'activate'",
				object = {
					_meta = "object",
					enabled = true,
					name = "'g_ecm'"
				},
				triggable = true
			}
		},
		priority = 0
	},
	["units/payday2/equipment/gen_interactable_drill_large_thermic/gen_interactable_drill_large_thermic"] = {
		SequenceMods = {
			[" 'activate' "] = {
				ElementMods = {
					["'drillicongroup'"] = { visibility = false },
					["'g_drill'"] = { enabled = true }, 
					["'g_base'"] = { enabled = true },
				},
				NewElements = {
					[1] = {
						_meta = "material",
						name = "'drill'",
						texture = "'units/gui/gui_color_use_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					},
					material = {
						_meta = "material",
						name = "'drill'",
						texture = "'units/gui/gui_color_use_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					}
                }
			},
            [" 'interact' "] = {
				NewElements = {
					[1] = {
						_meta = "material",
						name = "'drill'",
						texture = "'units/payday2/equipment/gen_interactable_drill_large_thermic/drill_lance_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					},
					material = {
						_meta = "material",
						name = "'drill'",
						texture = "'units/payday2/equipment/gen_interactable_drill_large_thermic/drill_lance_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					}
				}
			}
		},
		priority = 0
	},
	["units/payday2/equipment/gen_interactable_lance_large/gen_interactable_lance_large"] = {
		SequenceMods = {
			[" 'activate' "] = {
				ElementMods = {
					["'drillicongroup'"] = { visibility = false },
					["'g_drill'"] = { enabled = true },
					["'g_base'"] = { enabled = true }
				},
				NewElements = {
					[1] = {
						_meta = "material",
						name = "'drill'",
						texture = "'units/gui/gui_color_use_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					},
					material = {
						_meta = "material",
						name = "'drill'",
						texture = "'units/gui/gui_color_use_df'",
                        search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					}
				}
			},
			[" 'interact' "] = {
				NewElements = {
					[1] = {
						_meta = "material",
						name = "'drill'",
						texture = "'units/payday2/equipment/gen_interactable_drill_large_thermic/drill_lance_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					},
					material = {
						__meta = "material",
						name = "'drill'",
						texture = "'units/payday2/equipment/gen_interactable_drill_large_thermic/drill_lance_df'",
						search_render_template = "'generic:CONTOUR:DIFFUSE_TEXTURE:NORMALMAP'",
						multiple_objects = true
					}
				}
			}
		},
		priority = 0
	},
	["units/payday2/equipment/hlm_equipment_gas_can_shoot/hlm_equipment_gas_can_shoot"] = {
		SequenceMods = {
			["'state_vis_show_interactable'"] = {
				ElementMods = {
					["'g_g'"] = { enabled = true },
				},
				NewElements = {
					[1] = {
						_meta = "material_config",
						name = "'units/weapons/smoke_grenade/smoke_grenade'"
					},
					material_config = {
						_meta = "material_config",
						name = "'units/weapons/smoke_grenade/smoke_grenade'"
					}
				}
			},
			["'state_vis_hide_contour'"] = {
			NewElements = {
					[1] = {
						_meta = "object",
						enabled = false,
						name = "'g_g'"
					}
				}
			},
			["'interact'"] = {
				NewElements = {
					[1] = {
						_meta = "material_config",
						name = "'units/payday2/equipment/hlm_equipment_gas_can_shoot/hlm_equipment_gas_can_shoot'"
					},
					material_config = {
						_meta = "material_config",
						name = "'units/payday2/equipment/hlm_equipment_gas_can_shoot/hlm_equipment_gas_can_shoot'"
					}
				}
			}
		},
		priority = 0
	},
	["units/payday2/equipment/gen_equipment_shape_charge_plantable/gen_equipment_shape_charge_plantable"] = {
		SequenceMods = {
			["'show_interactive'"] = {
				ElementMods = {
					["'g_c4'"] = { enabled = true },
					["'c4_icon'"] = { visibility = false },
				},
				NewElements = {
					[1] = {
						_meta = "material_config",
						name = "'units/weapons/raging_bull/raging_bull'"
					},
					material_config = {
						_meta = "material_config",
						name = "'units/weapons/raging_bull/raging_bull'"
					},
				}
            },
			["'show'"] = {
				NewElements = {
					[7] = {
						_meta = "material_config",
						name = "'units/payday2/equipment/gen_equipment_shape_charge_plantable/gen_equipment_shape_charge_plantable'"
					},
					material_config = {
                        _meta = "material_config",
						name = "'units/payday2/equipment/gen_equipment_shape_charge_plantable/gen_equipment_shape_charge_plantable'"
					}
				}
			}
		},
		--use_callback = callback(pdth_hud, pdth_hud, "mod_shaped_charge"),
		priority = 0
	}
}