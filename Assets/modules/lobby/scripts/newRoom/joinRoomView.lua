--luacheck:no self

local JoinRoomView = {}

local fairy = require "lobby/lcore/fairygui"
local logger = require "lobby/lcore/logger"

function JoinRoomView.new()
    if JoinRoomView.unityViewNode then
        logger.debug("CreateRoomView ---------------------")
    else
        _ENV.thisMod:AddUIPackage("lobby/fui_join_room/lobby_join_room")
        local viewObj = _ENV.thisMod:CreateUIObject("lobby_join_room", "joinRoom")

        JoinRoomView.unityViewNode = viewObj

        local win = fairy.Window()
        win.contentPane = JoinRoomView.unityViewNode
        JoinRoomView.win = win

        --初始化View
        JoinRoomView:initAllView()

        -- 由于win隐藏，而不是销毁，隐藏后和GRoot脱离了关系，因此需要
        -- 特殊销毁
        _ENV.thisMod:RegisterCleanup(
            function()
                win:Dispose()
            end
        )
    end

    JoinRoomView.win:Show()
end

function JoinRoomView:initAllView()

    local clostBtn = self.unityViewNode:GetChild("closeBtn")
    clostBtn.onClick:Set(
        function()
            self:destroy()
        end
    )


    for i = 0, 9 do
        local button = self.unityViewNode:GetChild("button" .. tostring(i))
        button.onClick:Set(
            function()
                self:onInputButton(i)
            end
        )

    end

end

function JoinRoomView:onInputButton(number)
    local numberLength = 0
    if self.roomNumber then
        numberLength = string.len(self.roomNumber)
    end

    if numberLength < 6 then
        local strIndex = numberLength + 1
        local num = self.unityViewNode:GetChild("number"..strIndex)
        num.text = tostring(number)

        if self.roomNumber then
            self.roomNumber= self.roomNumber .. tostring(number)
        else
            self.roomNumber=  tostring(number)
        end
    end

    self:joinRoomCheck(self.roomNumber)
end

function JoinRoomView:joinRoomCheck(str)
    if #str == 6 then
        logger.debug("number:"..str)
    end
end

function JoinRoomView:requetJoinRoom()
end

function JoinRoomView:destroy()
    self.win:Hide()
    self.win:Dispose()
    self.unityViewNode = nil
    self.win = nil
end

return JoinRoomView