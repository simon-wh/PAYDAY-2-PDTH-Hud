tweak_data.contour.character.standard_color = Vector3(0.1, 1, 0.5)
tweak_data.contour.character.friendly_color = Vector3(0.2, 0.8, 1)
tweak_data.contour.character.downed_color = Vector3(1, 0.5, 0)
tweak_data.contour.character.dead_color = Vector3(1, 0.1, 0.1)
tweak_data.contour.character.dangerous_color = Vector3(0.6, 0.2, 0.2)
tweak_data.contour.character.more_dangerous_color = Vector3(1, 0.1, 0.1)
tweak_data.contour.character.standard_opacity = 0
tweak_data.contour.character_interactable.standard_color = Vector3(1, 0.5, 0)
tweak_data.contour.character_interactable.selected_color = Vector3(1, 1, 1)
tweak_data.contour.interactable.standard_color = Vector3(1, 0.4, 0)
tweak_data.contour.interactable.selected_color = Vector3(1, 1, 1)
tweak_data.contour.contour_off.standard_color = Vector3(0, 0, 0)
tweak_data.contour.contour_off.selected_color = Vector3(0, 0, 0)
tweak_data.contour.contour_off.standard_opacity = 0
tweak_data.contour.deployable.standard_color = Vector3(0.1, 1, 0.5)
tweak_data.contour.deployable.selected_color = Vector3(1, 1, 1)
tweak_data.contour.deployable.active_color = Vector3(0.1, 0.5, 1)
tweak_data.contour.deployable.interact_color = Vector3(0.1, 1, 0.1)
tweak_data.contour.deployable.disabled_color = Vector3(1, 0.1, 0.1)
tweak_data.contour.upgradable.standard_color = Vector3(0.1, 0.5, 1)
tweak_data.contour.upgradable.selected_color = Vector3(1, 1, 1)
tweak_data.contour.pickup.standard_color = Vector3(0.1, 1, 0.5)
tweak_data.contour.pickup.selected_color = Vector3(1, 1, 1)
tweak_data.contour.pickup.standard_opacity = 1
tweak_data.contour.interactable_icon.standard_color = Vector3(0, 0, 0)
tweak_data.contour.interactable_icon.selected_color = Vector3(0, 1, 0)
tweak_data.contour.interactable_icon.standard_opacity = 0

if pdth_hud.Options.Grading then
    for level_id, value in pairs(pdth_hud.Options.Grading) do
        if tweak_data.levels[level_id] then
            tweak_data.levels[level_id].env_params = tweak_data.levels[level_id].env_params or {}
            tweak_data.levels[level_id].env_params.color_grading = value == 1 and pdth_hud.colour_gradings[pdth_hud.Options.Menu.Grading] or pdth_hud.heist_colour_gradings[value]
        end
    end
end

if pdth_hud.Options.HUD.MainHud then
    tweak_data.hud_icons.equipment_body_bag = {
        texture = "guis/textures/pd2/equipment",
        texture_rect = {
            96,
            32,
            32,
            32
        }
    }

    tweak_data.hud_icons.equipment_ammo_bag = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            48,
            96,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_doctor_bag = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            96,
            96,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_sentry = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            320,
            288,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_trip_mine = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            0,
            96,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_ecm_jammer = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            143,
            464,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_armor_kit = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            95,
            464,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_first_aid_kit = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            1,
            464,
            47,
            48
        }
    }

    tweak_data.hud_icons.equipment_bodybags_bag = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            48,
            464,
            48,
            48
        }
    }

    tweak_data.hud_icons.frag_grenade = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            416,
            384,
            48,
            48
        }
    }

    tweak_data.hud_icons.molotov_grenade = {
        texture = "guis/textures/upgrade_images",
        texture_rect = {
            784,
            1709,
            160,
            167
        }
    }

    tweak_data.hud_icons.dynamite_grenade = {
        texture = "guis/textures/upgrade_images",
        texture_rect = {
            213,
            1887,
            184,
            167
        }
    }

    tweak_data.hud_icons.four_projectile = {
        texture = "guis/textures/upgrade_images",
        texture_rect = {
            972, 
            1886, 
            160, 
            167
        }
    }

    tweak_data.hud_icons.ace_projectile = {
        texture = "guis/textures/upgrade_images",
        texture_rect = {
            406, 
            2079, 
            163, 
            167
        }
    }

    tweak_data.hud_icons.jav_projectile = {
        texture = "guis/textures/upgrade_images",
        texture_rect = {
            1151, 
            2082,
            176, 
            164
        }
    }

    tweak_data.hud_icons.cable = {
        texture = "guis/textures/pd2/hud_pickups",
        texture_rect = {
            32,
            96,
            32,
            32
        }
    }

    tweak_data.hud_icons.repair = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            48,
            48,
            48,
            48
        }
    }

    tweak_data.hud_icons.grenade_pdth = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            416,
            384,
            48,
            48
        }
    }

    tweak_data.hud_icons.agressor = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            0,
            48,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_drill = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            240,
            96,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_bank_manager_key = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            288,
            144,
            48,
            48
        }
    }
    tweak_data.hud_icons.equipment_chavez_key = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            192,
            96,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_generic_key = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            192,
            96,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_planks = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            144,
            288,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_cable_ties = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            384,
            96,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_saw = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            336,
            144,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_thermite = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            560,
            49,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_sentry = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            320,
            288,
            48,
            48
        }
    }

    --[[tweak_data.hud_icons.equipment_glasscutter = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            384,
            192,
            48,
            48
        }
    }]]--

    tweak_data.hud_icons.equipment_harddrive = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            272,
            288,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_crowbar = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            192,
            240,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_c4 = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            336,
            96,
            48,
            48
        }
    }

    --[[tweak_data.hud_icons.pd2_c4 = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            336,
            96,
            48,
            48
        }
    }]]--

    --[[tweak_data.hud_icons.wp_c4 = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            336,
            96,
            48,
            48
        }
    }]]--

    tweak_data.hud_icons.equipment_gasoline = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            288,
            96,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_muriatic_acid = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            512,
            1,
            48,
            48
        }
    }
    tweak_data.hud_icons.equipment_hydrogen_chloride = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            560,
            1,
            48,
            48
        }
    }
    tweak_data.hud_icons.equipment_caustic_soda = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            608,
            1,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_barcode = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            848,
            1,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_glasscutter = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            944,
            1,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_ticket = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            800,
            1,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_files = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            896,
            1,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_harddrive = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            752,
            1,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_evidence = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            656,
            1,
            48,
            48
        }
    }
    tweak_data.hud_icons.equipment_chainsaw = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            704,
            1,
            48,
            48
        }
    }
    tweak_data.hud_icons.equipment_manifest = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            432,
            192,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_drillfix = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            608,
            49,
            48,
            48
        }
    }


    tweak_data.hud_icons.equipment_fire_extinguisher = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            656,
            49,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_winch_hook = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            704,
            49,
            48,
            48
        }
    }
    tweak_data.hud_icons.equipment_bottle = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            752,
            49,
            48,
            48
        }
    }
    tweak_data.hud_icons.equipment_sleeping_gas = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            800,
            49,
            48,
            48
        }
    }
    tweak_data.hud_icons.equipment_usb_with_data = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            896,
            49,
            48,
            48
        }
    }
    tweak_data.hud_icons.equipment_usb_no_data = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            848,
            49,
            48,
            48
        }
    }
    --[[tweak_data.hud_icons.equipment_empty_cooling_bottle = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            0,
            160,
            32,
            32
        }
    }
    tweak_data.hud_icons.equipment_cooling_bottle = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            0,
            128,
            32,
            32
        }
    }]]--
    tweak_data.hud_icons.equipment_bfd_tool = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            240,
            96,
            48,
            48
        }
    }
    tweak_data.hud_icons.equipment_elevator_key = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            192,
            96,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_blow_torch = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            944,
            49,
            48,
            48
        }
    }

    tweak_data.hud_icons.equipment_saw = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            336,
            144,
            48,
            48
        }
    }
    
    tweak_data.hud_icons.pd2_generic_saw = {
        texture = "guis/textures/hud_icons",
        texture_rect = {
            336,
            144,
            48,
            48
        }
    }
    
end
tweak_data.interaction.copy_machine_smuggle.icon = "equipment_gasoline"
tweak_data.interaction.safety_deposit.icon = "develop"
tweak_data.interaction.paper_pickup.icon = "develop"
tweak_data.interaction.thermite.icon = "equipment_thermite"
tweak_data.interaction.gasoline.icon = "equipment_gasoline"
tweak_data.interaction.gasoline_engine.icon = "equipment_gasoline"
tweak_data.interaction.train_car.icon = "develop"
tweak_data.interaction.walkout_van.icon = "develop"
tweak_data.interaction.alaska_plane.icon = "develop"
tweak_data.interaction.suburbia_door_crowbar.icon = "equipment_crowbar"
tweak_data.interaction.secret_stash_trunk_crowbar.icon = "equipment_crowbar"
tweak_data.interaction.requires_saw_blade.icon = "equipment_saw"
tweak_data.interaction.saw_blade.icon = "equipment_saw"
tweak_data.interaction.open_slash_close_sec_box.icon = "develop"
tweak_data.interaction.activate_camera.icon = "interaction_powercord"
tweak_data.interaction.requires_ecm_jammer_double.icon = "equipment_ecm_jammer"
tweak_data.interaction.muriatic_acid.icon = "equipment_muriatic_acid"
tweak_data.interaction.pickup_keycard.icon = "equipment_bank_manager_key"
tweak_data.interaction.weapon_cache_drop_zone.icon = "develop"
tweak_data.interaction.secret_stash_limo_roof_crowbar.icon = "equipment_crowbar"
tweak_data.interaction.suburbia_iron_gate_crowbar.icon = "equipment_crowbar"
tweak_data.interaction.apartment_key.icon = "equipment_chavez_key"
tweak_data.interaction.hospital_sample_validation_machine.icon = "equipment_vial"
tweak_data.interaction.methlab_bubbling.icon = "equipment_muriatic_acid"
tweak_data.interaction.methlab_caustic_cooler.icon = "equipment_caustic_soda"
tweak_data.interaction.methlab_gas_to_salt.icon = "equipment_hydrogen_chloride"
tweak_data.interaction.methlab_drying_meth.icon = "pd2_methlab"
tweak_data.interaction.caustic_soda.icon = "equipment_caustic_soda"
tweak_data.interaction.hydrogen_chloride.icon = "equipment_hydrogen_chloride"
tweak_data.interaction.elevator_button.icon = "interaction_elevator"
tweak_data.interaction.use_computer.icon = "interaction_keyboard"
tweak_data.interaction.elevator_button_roof.icon = "interaction_elevator"
tweak_data.interaction.key_double.icon = "equipment_chavez_key"
tweak_data.interaction.numpad.icon = "develop"
tweak_data.interaction.numpad_keycard.icon = "equipment_bank_manager_key"
tweak_data.interaction.timelock_panel.icon = "develop"
tweak_data.interaction.take_weapons.icon = "develop"
tweak_data.interaction.pick_lock_easy.icon = "locked"
tweak_data.interaction.pick_lock_easy_no_skill.icon = "locked"
tweak_data.interaction.pick_lock_hard.icon = "locked"
tweak_data.interaction.pick_lock_hard_no_skill.icon = "locked"
tweak_data.interaction.open_door_with_keys.icon = "equipment_chavez_key"
tweak_data.interaction.cant_pick_lock.icon = "locked"
tweak_data.interaction.hospital_veil_container.icon = "equipment_vialOK"
tweak_data.interaction.hospital_security_cable.icon = "cable"
tweak_data.interaction.hospital_veil.icon = "equipment_vial"
tweak_data.interaction.hospital_sentry.icon = "interaction_sentrygun"
tweak_data.interaction.drill.icon = "equipment_drill"
tweak_data.interaction.drill_upgrade.icon = "repair"
tweak_data.interaction.drill_jammed.icon = "repair"
tweak_data.interaction.lance.icon = "equipment_drill"
tweak_data.interaction.lance_jammed.icon = "repair"
tweak_data.interaction.lance_upgrade.icon = "repair"
tweak_data.interaction.glass_cutter.icon = "equipment_cutter"
tweak_data.interaction.glass_cutter_jammed.icon = "repair"
tweak_data.interaction.hack_ipad.icon = "equipment_hack_ipad"
tweak_data.interaction.hack_ipad_jammed.icon = "repair"
tweak_data.interaction.hack_suburbia.icon = "equipment_hack_ipad"
tweak_data.interaction.hack_suburbia_jammed.icon = "repair"
tweak_data.interaction.security_station.icon = "equipment_hack_ipad"
tweak_data.interaction.security_station_keyboard.icon = "interaction_keyboard"
tweak_data.interaction.big_computer_hackable.icon = "interaction_keyboard"
tweak_data.interaction.big_computer_not_hackable.icon = "interaction_keyboard"
tweak_data.interaction.big_computer_server.icon = "interaction_keyboard"
tweak_data.interaction.security_station_jammed.icon = "interaction_keyboard"
tweak_data.interaction.apartment_drill.icon = "equipment_drill"
tweak_data.interaction.apartment_drill_jammed.icon = "repair"
tweak_data.interaction.suburbia_drill.icon = "equipment_drill"
tweak_data.interaction.suburbia_drill_jammed.icon = "repair"
tweak_data.interaction.goldheist_drill.icon = "equipment_drill"
tweak_data.interaction.goldheist_drill_jammed.icon = "repair"
tweak_data.interaction.hospital_saw_teddy.icon = "equipment_saw"
tweak_data.interaction.hospital_saw.icon = "equipment_saw"
tweak_data.interaction.hospital_saw_jammed.icon = "repair"
tweak_data.interaction.apartment_saw.icon = "equipment_saw"
tweak_data.interaction.apartment_saw_jammed.icon = "repair"
tweak_data.interaction.secret_stash_saw.icon = "equipment_saw"
tweak_data.interaction.secret_stash_saw_jammed.icon = "repair"
tweak_data.interaction.revive.icon = "interaction_help"
tweak_data.interaction.free.icon = "interaction_free"
tweak_data.interaction.hostage_trade.icon = "interaction_trade"
tweak_data.interaction.hostage_move.icon = "interaction_trade"
tweak_data.interaction.hostage_stay.icon = "interaction_trade"
tweak_data.interaction.trip_mine.icon = "equipment_trip_mine"
tweak_data.interaction.sentry_gun_refill.icon = "equipment_ammo_bag"
tweak_data.interaction.sentry_gun_revive.icon = "equipment_ammo_bag"
tweak_data.interaction.bodybags_bag.icon = "equipment_body_bag"
tweak_data.interaction.grenade_crate.icon = "grenade_pdth"
tweak_data.interaction.ammo_bag.icon = "equipment_ammo_bag"
tweak_data.interaction.doctor_bag.icon = "equipment_doctor_bag"
tweak_data.interaction.ecm_jammer.icon = "equipment_ecm_jammer"
tweak_data.interaction.laptop_objective.icon = "laptop_objective"
tweak_data.interaction.money_bag.icon = "equipment_money_bag"
tweak_data.interaction.apartment_helicopter.icon = "develop"
tweak_data.interaction.test_interactive_door.icon = "interaction_open_door"
tweak_data.interaction.temp_interact_box.icon = "develop"
tweak_data.interaction.requires_cable_ties.icon = "equipment_cable_ties"
tweak_data.interaction.temp_interact_box_no_timer.icon = "develop"
tweak_data.interaction.access_camera.icon = "laptop_objective"
tweak_data.interaction.interaction_ball.icon = "develop"
tweak_data.interaction.invisible_interaction_open.icon = "develop"
tweak_data.interaction.fork_lift_sound.icon = "develop"
tweak_data.interaction.money_briefcase.icon = "develop"
tweak_data.interaction.grenade_briefcase.icon = "develop"
tweak_data.interaction.cash_register.icon = "develop"
tweak_data.interaction.atm_interaction.icon = "develop"
tweak_data.interaction.weapon_case.icon = "develop"
tweak_data.interaction.invisible_interaction_close.icon = "develop"
tweak_data.interaction.interact_gen_pku_loot_take.icon = "develop"
tweak_data.interaction.water_tap.icon = "wp_watersupply"
tweak_data.interaction.water_manhole.icon = "develop"
tweak_data.interaction.sewer_manhole.icon = "develop"
tweak_data.interaction.circuit_breaker.icon = "interaction_powerbox"
tweak_data.interaction.hold_circuit_breaker.icon = "interaction_powerbox"
tweak_data.interaction.transformer_box.icon = "interaction_powerbox"
tweak_data.interaction.stash_server_cord.icon = "interaction_powercord"
tweak_data.interaction.stash_planks.icon = "equipment_planks"
tweak_data.interaction.stash_planks_pickup.icon = "equipment_planks"
tweak_data.interaction.stash_server.icon = "equipment_stash_server"
tweak_data.interaction.stash_server_pickup.icon = "equipment_stash_server"
tweak_data.interaction.shelf_sliding_suburbia.icon = "develop"
tweak_data.interaction.tear_painting.icon = "develop"
tweak_data.interaction.ejection_seat_interact.icon = "equipment_ejection_seat"
tweak_data.interaction.diamond_pickup.icon = "interaction_diamond"
tweak_data.interaction.safe_loot_pickup.icon = "develop"
tweak_data.interaction.mus_pku_artifact.icon = "develop"
tweak_data.interaction.tiara_pickup.icon = "interaction_diamond"
tweak_data.interaction.patientpaper_pickup.icon = "interaction_patientfile"
tweak_data.interaction.diamond_case.icon = "interaction_diamond"
tweak_data.interaction.diamond_single_pickup.icon = "interaction_diamond"
tweak_data.interaction.suburbia_necklace_pickup.icon = "develop"
tweak_data.interaction.temp_interact_box2.icon = "develop"
tweak_data.interaction.printing_plates.icon = "develop"
tweak_data.interaction.c4.icon = "equipment_c4"
tweak_data.interaction.c4_mission_door.icon = "equipment_c4"
tweak_data.interaction.c4_diffusible.icon = "equipment_c4"
tweak_data.interaction.open_trunk.icon = "develop"
tweak_data.interaction.open_door.icon = "interaction_open_door"
tweak_data.interaction.embassy_door.icon = "interaction_open_door"
tweak_data.interaction.c4_special.icon = "equipment_c4"
tweak_data.interaction.c4_bag.icon = "equipment_c4"
tweak_data.interaction.money_wrap.icon = "interaction_money_wrap"
tweak_data.interaction.suburbia_money_wrap.icon = "interaction_money_wrap"
tweak_data.interaction.money_wrap_single_bundle.icon = "interaction_money_wrap"
tweak_data.interaction.christmas_present.icon = "interaction_christmas_present"
tweak_data.interaction.gold_pile.icon = "interaction_gold"
tweak_data.interaction.gold_bag.icon = "interaction_gold"
tweak_data.interaction.requires_gold_bag.icon = "interaction_gold"
tweak_data.interaction.intimidate.icon = "equipment_cable_ties"
tweak_data.interaction.intimidate_and_search.icon = "equipment_cable_ties"
tweak_data.interaction.computer_test.icon = "develop"
tweak_data.interaction.carry_drop.icon = "equipment_money_bag"
tweak_data.interaction.painting_carry_drop.icon = "equipment_money_bag"
tweak_data.interaction.corpse_alarm_pager.icon = "develop"
tweak_data.interaction.corpse_dispose.icon = "develop"
tweak_data.interaction.shaped_sharge.icon = "equipment_c4"
tweak_data.interaction.hostage_convert.icon = "interaction_trade"
tweak_data.interaction.break_open.icon = "interaction_wirecutter"
tweak_data.interaction.cut_fence.icon = "interaction_wirecutter"
tweak_data.interaction.burning_money.icon = "agressor"
tweak_data.interaction.hold_take_painting.icon = "develop"
tweak_data.interaction.barricade_fence.icon = "equipment_planks"
tweak_data.interaction.hack_numpad.icon = "develop"
tweak_data.interaction.pickup_phone.icon = "interaction_answerphone"
tweak_data.interaction.hold_take_server.icon = "equipment_ecm_jammer"
tweak_data.interaction.hold_take_blueprints.icon = "develop"
tweak_data.interaction.take_confidential_folder.icon = "develop"
tweak_data.interaction.hold_take_gas_can.icon = "equipment_gasoline"
tweak_data.interaction.gen_ladyjustice_statue.icon = "develop"

tweak_data.interaction.hold_place_gps_tracker.icon = "develop"

tweak_data.interaction.hold_use_computer.icon = "interaction_keyboard"
tweak_data.interaction.use_server_device.icon = "equipment_ecm_jammer"
tweak_data.interaction.iphone_answer.icon = "interaction_answerphone"
tweak_data.interaction.use_flare.icon = "develop"
tweak_data.interaction.steal_methbag.icon = "equipment_money_bag"
tweak_data.interaction.open_from_inside.icon = "develop"
tweak_data.interaction.hold_pickup_lance.icon = "develop"
tweak_data.interaction.barrier_numpad.icon = "develop"
tweak_data.interaction.timelock_numpad.icon = "develop"
tweak_data.interaction.pickup_asset.icon = "develop"
tweak_data.interaction.open_slash_close.icon = "develop"
tweak_data.interaction.raise_balloon.icon = "develop"
tweak_data.interaction.stn_int_place_camera.icon = "develop"
tweak_data.interaction.stn_int_take_camera.icon = "develop"
tweak_data.interaction.exit_to_crimenet.icon = "develop"
tweak_data.interaction.gage_assignment.icon = "develop"
tweak_data.interaction.gen_pku_fusion_reactor.icon = "develop"
tweak_data.interaction.gen_pku_cocaine.icon = "develop"
tweak_data.interaction.gen_pku_artifact_statue.icon = "develop"
tweak_data.interaction.gen_pku_artifact.icon = "develop"
tweak_data.interaction.gen_pku_artifact_painting.icon = "develop"
tweak_data.interaction.gen_pku_jewelry.icon = "equipment_money_bag"
tweak_data.interaction.taking_meth.icon = "develop"
tweak_data.interaction.gen_pku_crowbar.icon = "equipment_crowbar"
tweak_data.interaction.gen_pku_thermite.icon = "equipment_thermite"
tweak_data.interaction.gen_pku_thermite_paste.icon = "equipment_thermite"
tweak_data.interaction.button_infopad.icon = "develop"
tweak_data.interaction.crate_loot.icon = "develop"
tweak_data.interaction.crate_loot_crowbar.icon = "equipment_crowbar"
tweak_data.interaction.crate_loot_close.icon = "develop"
tweak_data.interaction.halloween_trick.icon = "develop"
tweak_data.interaction.disassemble_turret.icon = "develop"
tweak_data.interaction.take_ammo.icon = "equipment_ammo_bag"
tweak_data.interaction.bank_note.icon = "develop"
tweak_data.interaction.pickup_boards.icon = "equipment_planks"
tweak_data.interaction.need_boards.icon = "equipment_planks"
tweak_data.interaction.uload_database.icon = "develop"
tweak_data.interaction.uload_database_jammed.icon = "develop"
tweak_data.interaction.votingmachine2.icon = "develop"
tweak_data.interaction.votingmachine2_jammed.icon = "develop"
tweak_data.interaction.sc_tape_loop.icon = "equipment_stash_server" --"interaction_help"
tweak_data.interaction.shape_charge_plantable.icon = "equipment_c4"
tweak_data.interaction.player_zipline.icon = "develop"
tweak_data.interaction.bag_zipline.icon = "develop"
tweak_data.interaction.huge_lance.icon = "equipment_drill"
tweak_data.interaction.huge_lance_jammed.icon = "repair"
tweak_data.interaction.gen_pku_lance_part.icon = "develop"
tweak_data.interaction.crane_joystick_left.icon = "develop"
tweak_data.interaction.crane_joystick_lift.icon = "develop"
tweak_data.interaction.crane_joystick_right.icon = "develop"
tweak_data.interaction.crane_joystick_release.icon = "develop"
tweak_data.interaction.gen_int_thermite_rig.icon = "equipment_thermite"
tweak_data.interaction.gen_int_thermite_apply.icon = "equipment_thermite"
tweak_data.interaction.apply_thermite_paste.icon = "equipment_thermite"
tweak_data.interaction.set_off_alarm.icon = "develop"
tweak_data.interaction.hold_open_vault.icon = "develop"
tweak_data.interaction.samurai_armor.icon = "develop"
tweak_data.interaction.fingerprint_scanner.icon = "develop"
tweak_data.interaction.enter_code.icon = "develop"
tweak_data.interaction.take_keys.icon = "equipment_chavez_key"
tweak_data.interaction.push_button.icon = "develop"
tweak_data.interaction.breach_door.icon = "develop"
tweak_data.interaction.bus_wall_phone.icon = "interaction_answerphone"
tweak_data.interaction.zipline_mount.icon = "develop"
tweak_data.interaction.rewire_timelock.icon = "develop"
tweak_data.interaction.pick_lock_x_axis.icon = "develop"
tweak_data.interaction.pku_barcode_downtown.icon = "equipment_barcode"
tweak_data.interaction.pku_barcode_brickell.icon = "equipment_barcode"
tweak_data.interaction.pku_barcode_edgewater.icon = "equipment_barcode"
tweak_data.interaction.pku_barcode_isles_beach.icon = "equipment_barcode"
tweak_data.interaction.pku_barcode_opa_locka.icon = "equipment_barcode"
tweak_data.interaction.read_barcode_downtown.icon = "equipment_barcode"
tweak_data.interaction.read_barcode_brickell.icon = "equipment_barcode"
tweak_data.interaction.read_barcode_edgewater.icon = "equipment_barcode"
tweak_data.interaction.read_barcode_isles_beach.icon = "equipment_barcode"
tweak_data.interaction.read_barcode_opa_locka.icon = "equipment_barcode"
tweak_data.interaction.read_barcode_activate.icon = "equipment_barcode"
tweak_data.interaction.hlm_motor_start.icon = "develop"
tweak_data.interaction.hlm_connect_equip.icon = "develop"
tweak_data.interaction.hlm_roll_carpet.icon = "develop"
tweak_data.interaction.hold_pku_equipmentbag.icon = "equipment_c4"
tweak_data.interaction.disarm_bomb.icon = "equipment_c4"
tweak_data.interaction.pku_take_mask.icon = "develop"
tweak_data.interaction.hold_activate_sprinklers.icon = "develop"
tweak_data.interaction.hold_hlm_open_circuitbreaker.icon = "develop"
tweak_data.interaction.hold_remove_cover.icon = "develop"
tweak_data.interaction.hold_cut_cable.icon = "develop"
tweak_data.interaction.firstaid_box.icon = "interaction_help"
tweak_data.interaction.first_aid_kit.icon = "equipment_first_aid_kit"
tweak_data.interaction.road_spikes.icon = "develop"
tweak_data.interaction.grab_server.icon = "develop"
tweak_data.interaction.pickup_harddrive.icon = "equipment_harddrive"
tweak_data.interaction.place_harddrive.icon = "equipment_harddrive"
tweak_data.interaction.invisible_interaction_searching.icon = "develop"
tweak_data.interaction.invisible_interaction_gathering.icon = "develop"
tweak_data.interaction.invisible_interaction_checking.icon = "develop"
tweak_data.interaction.take_medical_supplies.icon = "interaction_help"
tweak_data.interaction.search_files_false.icon = "develop"
tweak_data.interaction.use_files.icon = "equipment_evidence"
tweak_data.interaction.hack_electric_box.icon = "interaction_powerbox"
tweak_data.interaction.take_ticket.icon = "equipment_ticket"
tweak_data.interaction.use_ticket.icon = "equipment_ticket"
tweak_data.interaction.hold_signal_driver.icon = "pd2_talk"
tweak_data.interaction.hold_hack_comp.icon = "interaction_keyboard"
tweak_data.interaction.hold_approve_req.icon = "interaction_keyboard"
tweak_data.interaction.hold_download_keys.icon = "equipment_harddrive"
tweak_data.interaction.hold_analyze_evidence.icon = "develop"
tweak_data.interaction.take_bridge.icon = "equipment_planks"
tweak_data.interaction.use_bridge.icon = "equipment_planks"
tweak_data.interaction.hold_close_keycard.icon = "equipment_bank_manager_key"
tweak_data.interaction.hold_close.icon = "interaction_open_door"
tweak_data.interaction.hold_open.icon = "interaction_open_door"
tweak_data.interaction.hold_move_car.icon = "develop"
tweak_data.interaction.hold_remove_armor_plating.icon = "develop"
tweak_data.interaction.gen_pku_sandwich.icon = "develop"
tweak_data.interaction.place_flare.icon = "develop"
tweak_data.interaction.ignite_flare.icon = "develop"
tweak_data.interaction.hold_open_xmas_present.icon = "interaction_christmas_present"
tweak_data.interaction.cut_glass.icon = "equipment_glasscutter"
tweak_data.interaction.mus_hold_open_display.icon = "develop"
tweak_data.interaction.mus_take_diamond.icon = "develop"
tweak_data.interaction.rewire_electric_box.icon = "interaction_powerbox"
tweak_data.interaction.timelock_hack.icon = "equipment_hack_ipad"