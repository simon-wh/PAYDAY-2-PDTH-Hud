log("SentryGunBase Hook loaded")

function SentryGunBase.spawn(owner, pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier, peer_id)
	local attached_data = SentryGunBase._attach(pos, rot)
	if not attached_data then
		return
	end
	local spread_multiplier, rot_speed_multiplier, has_shield
	if owner and owner:base().upgrade_value then
		spread_multiplier = owner:base():upgrade_value("sentry_gun", "spread_multiplier") or 1
		rot_speed_multiplier = owner:base():upgrade_value("sentry_gun", "rot_speed_multiplier") or 1
		has_shield = owner:base():upgrade_value("sentry_gun", "shield")
	else
		spread_multiplier = managers.player:upgrade_value("sentry_gun", "spread_multiplier", 1)
		rot_speed_multiplier = managers.player:upgrade_value("sentry_gun", "rot_speed_multiplier", 1)
		has_shield = managers.player:has_category_upgrade("sentry_gun", "shield")
	end
	local unit = World:spawn_unit(Idstring("units/payday2/equipment/gen_equipment_sentry/gen_equipment_sentry"), pos, rot)
	managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, 0, peer_id or 0)
	unit:base():setup(owner, ammo_multiplier, armor_multiplier, damage_multiplier, spread_multiplier, rot_speed_multiplier, has_shield, attached_data)
	unit:brain():set_active(true)
	SentryGunBase.deployed = (SentryGunBase.deployed or 0) + 1
	if SentryGunBase.deployed >= 4 then
		managers.challenges:set_flag( "sentry_gun_resources" )
	end
	return unit
end