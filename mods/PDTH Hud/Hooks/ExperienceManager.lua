--[[CloneClass(ExperienceManager)
function ExperienceManager._level_up(self)
	self.orig._level_up(self)
	managers.challenges:check_active_challenges()
end]]--