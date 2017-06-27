--
-- Init
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- 初始化阶段
-- 对输入内容对象 输出内容对象及输出格式进行初始化设置
-- 完成根据$_GET['do']或默认设置 选择对应的action类.路由功能的实现,仅使用参数do=** 的方式


local Request = require('mxlua.Http.Message.Request')
local Response = require('mxlua.Http.Message.Response')

local Phase = {}

function Phase.run(cycle)
    local request = Request:new()
    local response = Response:new()
    local config = cycle:getConfig().action

    -- 路由选择
    local name = request:getGET()['do'] or config.default
    name = string.gsub(name, '%.', '/') .. '.lua'
    local action = dofile(APP_PATH .. config.namespace .. name)

    response:setFormat(config.format)
    cycle:setRequest(request)
    cycle:setResponse(response)
    cycle:setAction(action)
end

return Phase
