--
-- Main
-- @package Action
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- 默认主action


local Main = {}

--[[
    处理GET请求
    @return nil
]]
function Main:handleGet(aa)
    local user = self.request:getInput('user')
    local mxauth = self.request:getCookie('mxauth')
    local config = self:config('action.default')

    --self:format('binary')
    --self:fault(404, '错误了')
    self:response(1)
end

--[[
    处理POST请求
    @return nil
]]
function Main:handlePost()
end

return Main
