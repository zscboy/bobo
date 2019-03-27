--[[
    一些用于和服务器通讯消息相关的辅助函数
]]
local protobuf = require "lobby/lcore/protobuf"
local logger = require "lobby/lcore/logger"

local PROTO = {}

local function loadProtofile()
    local pbfile = "scripts/proto/runfast.pb"
    logger.debug("begin to load protocolbuf descriptor file:", pbfile)

    local buffer = _ENV.thisMod.loader:LoadTextAsset(pbfile)
    protobuf.register(buffer)

    -- 下面这些代码是为了把枚举提取出来，放到PROTO表中方便访问
    -- 如果可以提前提取做成一个lua文件，就不需要下面这样提取了，只需要require
    -- 那个提前做好的lua文件就可以了
    local t = protobuf.decode("google.protobuf.FileDescriptorSet", buffer)
    for _, proto in ipairs(t.file) do
        --logger.debug("proto file:", proto.name, ", package:", proto.package)

        local packageEnumSet = PROTO[proto.package]
        if packageEnumSet == nil then
            packageEnumSet = {}
            PROTO[proto.package] = packageEnumSet
        end

        local enum = proto.enum_type

        for _, v in ipairs(enum) do
            local eset = {}
            packageEnumSet[v.name] = eset

            for _, v1 in ipairs(v.value) do
                --print("\t" .. v1.name .. "," .. v1.number, ", t:", type(v1.number))
                eset[v1.name] = v1.number
            end
        end
    end
end

function PROTO.decodeGameMessageData(t, gmsgData)
    return protobuf.decode(t, gmsgData)
end

function PROTO.decodeGameMessage(msgData)
    return protobuf.decode("pokerface.GameMessage", msgData)
end

function PROTO.actionsHasAction(actions, action)
    return (actions & action) ~= 0
end

function PROTO.selectMeldFromMeldsForAction(meldsForAction, ty)
    local r = {}
    for _, m in ipairs(meldsForAction) do
        if m.meldType == ty then
            table.insert(r, m)
        end
    end

    return r
end

--加载pb文件
loadProtofile()

return PROTO
