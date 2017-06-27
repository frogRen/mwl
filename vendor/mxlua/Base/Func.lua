--
-- Func
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- 定义一些常用的方法, 在Front中引入 框架内可全局使用

local Func = {}

--[[
    try方法的封装
    @access public
    @param params 参数数组,包含try、catch内容
    @return nil
]]
function Func.try(params)
    local try = params[1]
    local catch = params[2]

    local ok, errors = pcall(try)

    if ok then
    else
        local data = {}
        data.message = errors
        if catch then
            catch(data)
        end
    end
end

return Func
