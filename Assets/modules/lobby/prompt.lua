--[[
    Prompt 提示框
]]
local Prompt = {}
local logger = require "lobby/lcore/logger"
local fairy = require "lobby/lcore/fairygui"

_ENV.thisMod:AddUIPackage("lobby/fui_dialog/lobby_dialog")

function Prompt.showPrompt(msg)
	local view = fairy.UIPackage.CreateObject("lobby_dialog", "prompt")
    local label = view:GetChild("text")
    label.text = msg

    local screenWidth = CS.UnityEngine.Screen.width
    local screenHeight = CS.UnityEngine.Screen.height
	local x = screenWidth / 2
	local y = screenHeight / 2
    view:SetXY(x, y)

	local trans = view:GetTransition('t1');
	trans:Play(1, 0, function()
		view:Dispose()
	end)

	fairy.GRoot.inst:AddChild(view)
end

return Prompt
