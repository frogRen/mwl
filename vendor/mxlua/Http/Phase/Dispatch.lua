--
-- Dispatch
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- action分发阶段
-- 对Action进行调用执行 并且默认处理异常


local ActionAbstract = require('mxlua.Application.Action')

local Phase = {}

function Phase.run(cycle)
    local action = cycle:getAction();
    if action == nil then
        error('action not found')
    end

    -- 不在具体action中继承Action,而是在这里处理
    setmetatable(action, {__index = ActionAbstract:new(cycle)})

    Func.try {
        function()
            action:preExecute()
            action:execute()
            action:postExecute()
        end,
        function(e)
            cycle:getResponse():setFault(500, e.message)
        end
    }
end

return Phase
