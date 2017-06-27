--
-- Cycle
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- 贯穿App生命周期各执行阶段的变量管理
-- 在Front进行创建,传递给各执行Phase做为执行流的变量管理


local Cycle = {
    -- 项目配置内容
    -- @access private
    -- @var table
    _config = {},

    -- 来源参数对象
    -- @access private
    -- @var Request
    _request = {},

    -- 输出内容对象
    -- @access private
    -- @var Response
    _response = {},

    -- 当前执行的action
    -- @access private
    -- @var Action
    _action = {},
}

--[[
    构造函数
    @access public
    @param config 配置数组
    @return Cycle
]]
function Cycle:new(config)
    local instance = {
        _config = config,
    }
    setmetatable(instance, {__index = self})
    return instance
end

--[[
    获取config配置
    @return table
]]
function Cycle:getConfig()
    return self._config
end

--[[
    设置request来源参数对象
    @access public
    @param request
    @return nil
]]
function Cycle:setRequest(request)
    self._request = request
end

--[[
    获取request来源参数对象
    @access public
    @return Request
]]
function Cycle:getRequest()
    return self._request
end

--[[
    设置response输出内容对象
    @access public
    @param response
    @return nil
]]
function Cycle:setResponse(response)
    self._response = response
end

--[[
    获取response输出内容对象
    @access public
    @return Response
]]
function Cycle:getResponse()
    return self._response
end

--[[
    设置当前需要执行的action
    @access public
    @param action
    @return nil
]]
function Cycle:setAction(action)
    self._action = action
end

--[[
    获取当前需要执行的action
    @access public
    @return Action
]]
function Cycle:getAction()
    return self._action
end

return Cycle
