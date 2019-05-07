--luacheck:no self

local NewRoomView = {}

local fairy = require "lobby/lcore/fairygui"
local logger = require "lobby/lcore/logger"
local urlpathsCfg = require "lobby/lcore/urlpathsCfg"
local httpHelper = require "lobby/lcore/httpHelper"
local proto = require "lobby/scripts/proto/proto"
local urlEncoder = require "lobby/lcore/urlEncode"
local rapidJson = require("rapidjson")
local updateProgress = require "lobby/scripts/newRoom/updateProgress"
local lenv = require "lobby/lenv"
local dialog = require "lobby/lcore/dialog"
local CS = _ENV.CS

function NewRoomView.new()
    if NewRoomView.unityViewNode then
        logger.debug("CreateRoomView ---------------------")
    else
        _ENV.thisMod:AddUIPackage("lobby/fui_create_room/lobby_create_room")
        local viewObj = _ENV.thisMod:CreateUIObject("lobby_create_room", "createRoom")

        NewRoomView.unityViewNode = viewObj

        local win = fairy.Window()
        win.contentPane = NewRoomView.unityViewNode
        NewRoomView.win = win

        --初始化View
        NewRoomView:initAllView()

        -- 由于win隐藏，而不是销毁，隐藏后和GRoot脱离了关系，因此需要
        -- 特殊销毁
        _ENV.thisMod:RegisterCleanup(
            function()
                win:Dispose()
            end
        )
    end

    local clostBtn = NewRoomView.unityViewNode:GetChild("closeBtn")
    clostBtn.onClick:Set(
        function()
            NewRoomView:destroy()
        end
    )

    NewRoomView.win:Show()
end

function NewRoomView:initAllView()
    self.progressBar = self.unityViewNode:GetChild("downloadProgress")
    self.progressBar.visible = false

    local gzRuleView = self.unityViewNode:GetChild("gzRule")
    local runFastRuleView = require "lobby/scripts/newRoom/runFastRuleView"
    runFastRuleView.bindView(gzRuleView, self)

    -- local viewObj = self.unityViewNode:GetChild("dfmjRule")
    -- local dfRuleView = require "lobby/scripts/newRoom/dfRuleView"
    -- dfRuleView.bindView(viewObj)
end

function NewRoomView:enterGame(roomInfo)
    local mylobbyView = fairy.GRoot.inst:GetChildAt(0)
    fairy.GRoot.inst:RemoveChild(mylobbyView)
    fairy.GRoot.inst:CleanupChildren()

    local parameters = {
        gameType = "4",
        roomInfo = roomInfo
    }

    local jsonString = rapidJson.encode(parameters)
    _ENV.thisMod:LaunchGameModule("game1", jsonString)
end

function NewRoomView:reEnterGame(roomInfo)
    self:enterGame(roomInfo)
end

function NewRoomView:doUpgrade(ruleJson)
    logger.debug("doUpgrade")

    local upgradeComplete = function(err)
        if err == nil then
            self:createRoom(ruleJson)
        else
            dialog.showDialog(err.msg,function() end)
        end
    end

    local progress = updateProgress:new(self.unityViewNode, ruleJson.modName, self.progressBar, upgradeComplete)
    progress:updateView()
end

function NewRoomView:constructQueryString(ruleJson)
    local modName = ruleJson.modName
    local lobbyVersion = require "lobby/version"
    local modVersionStr = CS.NetHelper.GetModVersion(modName)
    logger.debug("modVersionStr:"..modVersionStr)
	local qs = "qMod=" .. urlEncoder.encode(modName) -- current module name
	qs = qs .. "&modV=" .. urlEncoder.encode(modVersionStr) -- current module version
	qs = qs .. "&csVer=" .. urlEncoder.encode(CS.Version.VER_STR) -- csharp core version
	qs = qs .. "&lobbyVer=" .. urlEncoder.encode(lobbyVersion.VER_STR) -- lobby version
	qs = qs .. "&operatingSystem=" .. urlEncoder.encode(CS.UnityEngine.SystemInfo.operatingSystem) -- system name
	qs = qs .. "&operatingSystemFamily=" .. urlEncoder.encode(CS.UnityEngine.SystemInfo.operatingSystemFamily:ToString())
	-- system family
	qs = qs .. "&deviceUniqueIdentifier=" .. urlEncoder.encode(CS.UnityEngine.SystemInfo.deviceUniqueIdentifier)
	-- mobile device id
	qs = qs .. "&deviceName=" .. urlEncoder.encode(CS.UnityEngine.SystemInfo.deviceName) -- device name
	qs = qs .. "&deviceModel=" .. urlEncoder.encode(CS.UnityEngine.SystemInfo.deviceModel) -- device mode
    qs = qs .. "&network=" .. urlEncoder.encode(CS.NetHelper.NetworkTypeString()) -- device network type
    qs = qs .. "&forceUpgrade="..urlEncoder.encode(tostring(lenv.forceUseUpgrade)) -- if force upgrade
    qs = qs .. "&tk=".. urlEncoder.encode(CS.UnityEngine.PlayerPrefs.GetString("token", ""))  -- tk
	return qs
end

function NewRoomView:createRoom(ruleJson)
    logger.debug("createRoom")

    -- local tk = CS.UnityEngine.PlayerPrefs.GetString("token", "")
    local queryString = self:constructQueryString(ruleJson)
    local url = urlpathsCfg.rootURL .. urlpathsCfg.createRoom .. "?"..queryString
    local jsonString = rapidJson.encode(ruleJson)
    local createRoomReq = {
        config = jsonString
    }
    local body = proto.encodeMessage("lobby.MsgCreateRoomReq", createRoomReq)
    httpHelper.post(
        self.unityViewNode,
        url,
        body,
        function(req, resp)
            if req.State == CS.BestHTTP.HTTPRequestStates.Finished then
                local createRoomRsp = proto.decodeMessage("lobby.MsgCreateRoomRsp", resp.Data)
                logger.debug("create room ok createRoomRsp--------: ", createRoomRsp)
                if createRoomRsp.result == proto.lobby.MsgError.ErrSuccess then
                    self:enterGame(createRoomRsp.roomInfo)
                elseif createRoomRsp.result == proto.lobby.MsgError.ErrUserInOtherRoom then
                    self:reEnterGame(createRoomRsp.roomInfo)
                elseif createRoomRsp.result == proto.lobby.MsgError.ErrIsNeedUpdate then
                    self:doUpgrade(ruleJson)
                else
                    logger.debug("unknow error:"..createRoomRsp.result)
                end
            else
                logger.debug("create room error : ", req.State)
            end
        end
    )
end

function NewRoomView:destroy()
    self.win:Hide()
    self.win:Dispose()
    self.unityViewNode = nil
    self.win = nil
end

return NewRoomView
