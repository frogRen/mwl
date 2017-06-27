--
-- Response
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- 输出内容的封装
-- 管理所有输出的信息,包括格式 内容 头信息等


local Response = {
    -- 输出的数据内容
    -- @access private
    -- @var table
    _data = {},

    -- 异常输出内容
    -- @access private
    -- @var table
    _fault = nil,

    -- 输出内容的格式
    -- @access private
    -- @var string
    _format = '',

    -- 输出头信息
    -- @access private
    -- @var table
    _headers = {},
}

--[[
    构造函数
    @access public
    @return Response
]]
function Response:new()
    local instance = {}
    setmetatable(instance, {__index = self})
    return instance
end

--[[
    设定输出格式
    @access public
    @param format 输出格式
    @return nil
]]
function Response:setFormat(format)
    self._format = format or ''
end

--[[
    获取输出格式
    @access public
    @return string
]]
function Response:getFormat()
    return self._format
end

--[[
    设置初始化所有要输出的内容
    @access public
    @param data table数据内容
    @return nil
]]
function Response:setData(data)
    self._data = data
end

--[[
    增加要输出的内容
    @access public
    @param key 键
    @param val 值
    @return nil
]]
function Response:addData(key, val)
    self._data[key] = val
end

--[[
    获取所有要输出的数据内容
    @access public
    @return table
]]
function Response:getData()
    if self._fault == nil then
        return {
            code = 200,
            data = self._data
        }
    else
        return self._fault
    end
end

--[[
    设置异常输出
    @access public
    @param code 错误码
    @param message 错误信息描述
    @return nil
]]
function Response:setFault(code, message)
    self._fault = {
        code = tonumber(code) or 0,
        message = message,
    }
end

--[[
    增加要输出的header头
    @access public
    @param key 键
    @param val 值
    @return nil
]]
function Response:addHeader(key, val)
    self._headers[key] = val
end

--[[
    获取要输出的header头
    @access public
    @return table
]]
function Response:getHeaders(key, val)
    return self._headers
end

return Response
