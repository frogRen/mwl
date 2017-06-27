--
-- Action
-- @author renzhenguo <renzhenguo@moxiu.net>
--
-- Action抽象类 封装的常用的方法
-- PhaseAdapter中设置 PhaseDispatc中执行


local Action = {
    -- 项目配置内容
    -- @access private
    -- @var table
    _config = {},

    -- 输出内容对象
    -- @access private
    -- @var Response
    _response = {},

    -- 来源参数对象
    -- @access public
    -- @var Request
    request = {},

}

--[[
    构造函数
    @access public
    @param cycle Cycle对象
    @return Action
]]
function Action:new(cycle)
    local instance = {
        _config = cycle:getConfig(),
        _response = cycle:getResponse(),
        request = cycle:getRequest(),
    }
    setmetatable(instance, {__index = self})
    return instance
end

--[[
    前置处理
    @access public
    @return nil
]]
function Action:preExecute()
end

--[[
    后置处理
    @access public
    @return nil
]]
function Action:postExecute()
end

--[[
    action中需要实现execute 完成一次处理
    @access public
    @return nil
]]
function Action:execute()
    local method = self.request:getMethod()
    method = 'handle' .. String.ucfirst(string.lower(method))

    -- handleGet、handlePost、handleXxx
    if self[method] then
        self[method](self)
    else
        error('not support method')
    end
end

--[[
    获取配置
    @access protected
    @return mxied
]]
function Action:config(key)
    if key == nil then
        return self._config
    end

    return Array.get(self._config, key)
end

--[[
    设定输出格式
    @access protected
    @param format 输出格式
    @return nil
]]
function Action:format(format)
    self._response:setFormat(format)
end

--[[
    设置输出内容
    @access protected
    @param key 输出内容的健名
    @param val 输出内容的值
    @return nil
]]
function Action:response(key, val)
    if val == nil then
        self._response:setData(key)
    else
        self._response:addData(key, val)
    end
end

--[[
    设置异常输出
    @access protected
    @param code 错误码
    @param message 错误信息描述
    @return nil
]]
function Action:fault(code, message)
    if code and code == 200 then
        error('fault code 200 error')
    end
    self._response:setFault(code, message)
end

--[[
    设置输出头
    @access protected
    @param key 头信息名称
    @param val 头信息内容
    @return nil
]]
function Action:header(key, val)
    if key == nil then
        return nil
    end
    self._response:addHeader(key, val)
end

--[[
    url重定向 快捷方法
    @access protected
    @param url 重定向到的url
    @return nil
]]
function Action:redirect(url)
    ngx.redirect(url, 301)
end

--[[
    设置输出cookie
    @access protected
    @return nil
]]
function Action:cookie()
    -- todo
end

return Action
