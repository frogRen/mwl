--
-- Request
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- http请求参数封装
-- request 管理请求的来源参数 GET、POST,在init的处理阶段cycle中实例化


local cjson = require('cjson.safe')

local Request = {
    -- 来源参数表
    -- @access private
    -- @var table
    _raw = {}
}

--[[
    构造函数
    @access public
    @return Request
]]
function Request:new()
    local instance = {
        _raw = self:buildRaw()
    }
    setmetatable(instance, {__index = self})
    return instance
end

--[[
    构建来源参数
    @access private
    @return table
]]
function Request:buildRaw()
    local get = ngx.req.get_uri_args()
    local post = {}
    local content_type = ngx.var.content_type

    if content_type == nil then
    else
        ngx.req.read_body()
        post = ngx.req.get_post_args()
        if string.sub(content_type, 1, 16) == 'application/json' then
            post = cjson.decode(post) or {}
        end
    end

    return {GET = get, POST = post}
end

--[[
    获取传入的参数
    @access public
    @param key 参数key
    @return mxied
]]
function Request:getInput(key)
    return self._raw.POST[key] or self._raw.GET[key]
end

--[[
    获取GET参数
    @access public
    @return table
]]
function Request:getGET()
    return self._raw.GET
end

--[[
    获取POST参数
    @access public
    @return table
]]
function Request:getPOST()
    return self._raw.POST
end

--[[
    获取请求头信息内容
    @access public
    @return table
]]
function Request:getHeaders()
    return ngx.req.get_headers()
end

--[[
    获取请求类型 GET/POST/..
    @access public
    @return string
]]
function Request:getMethod()
    return ngx.req.get_method()
end

--[[
    获取请求ip
    @access public
    @return string
]]
function Request:getIp()
    local headers = self.getHeaders()
    local ip = headers['X-REAL-IP'] or headers['X_FORWARDED_FOR'] or ngx.var.remote_addr or '0.0.0.0'
    return ip
end

--[[
    获取所有来源cookie
    @access public
    @return table
]]
function Request:getCookies()
    local cookie = {}

    local array = String.split(ngx.unescape_uri(ngx.var.http_cookie), ';')
    table.foreach(array, function(key, val)
        local item = String.split(val, '=', 2)
        cookie[item[1]] = item[2]
    end)

    return cookie
end

--[[
    获取单个cookie
    @access public
    @return string
]]
function Request:getCookie(key)
    local val = ngx.unescape_uri(ngx.var['cookie_' .. key])
    return val
end

return Request
