--
-- Front
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- 默认的前端控制器实现
-- 一般在入口app子类中创建并绑定phase执行

Func = require('mxlua.Base.Func')
Array = require('mxlua.Base.Array')
String = require('mxlua.Base.String')
local Cycle = require('mxlua.Http.Cycle')

local Front = {}

--[[
    构造函数
    @access public
    @return Front
]]
function Front:new()
    local instance = {}
    setmetatable(instance, {__index = self})
    return instance
end

--[[
    开始运行, 外部开始执行入口
    @access public
    @param config 配置内容
    @return nil
]]
function Front:run(config)
    local cycle = Cycle:new(config)

    Func.try {
        function()
            self:_runPhase(config.phases, cycle)
        end,
        function(e)
            if config.env == 'dev' then
                ngx.say(e.message)
            else
                error(e.message)
            end
        end
    }
end

--[[
    顺序执行注册的各个阶段步骤
    @access private
    @param phases 阶段类名数组
    @param cycle Cycle对象
    @return nil
]]
function Front:_runPhase(phases, cycle)
    table.foreach(phases, function(key, val)
        local phase = require(val)
        phase.run(cycle)
    end)
end

return Front
