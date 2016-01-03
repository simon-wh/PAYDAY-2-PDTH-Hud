--[[CloneClass(BlackMarketManager)
function BlackMarketManager.save(self, data)
	self.orig.save(self, data)
	managers.challenges:save(data)
end

function BlackMarketManager.load(self, data)
	self.orig.load(self, data)
	managers.challenges:load(data)
end]]--

