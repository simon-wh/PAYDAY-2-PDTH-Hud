Hooks:PostHook(MenuComponentManager, "init", "PDTHHudAddComponents", function(self)
    self._active_components.portrait = {create = callback(self, self, "_create_portrait_gui"), close = callback(self, self, "close_portrait_gui")}
end)

function MenuComponentManager:_create_portrait_gui()
	if self._portrait_gui then
		return
	end
    self:close_portrait_gui()
	self._portrait_gui = PortraitPreviewGUI:new(self._ws)
end

function MenuComponentManager:close_portrait_gui()
    if self._portrait_gui then
		self._portrait_gui:close()
		self._portrait_gui = nil
	end
end

function MenuComponentManager:refresh_portrait_gui()
    if self._portrait_gui then
		self._portrait_gui:refresh()
	end
end


Hooks:PostHook(MenuComponentManager, "update", "PDTHHudUpdateComponents", function(self, t, dt)
    if self._portrait_gui then
		self._portrait_gui:update(t, dt)
	end
end)
