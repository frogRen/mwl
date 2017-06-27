--
-- String 函数
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- 对字符串的处理扩展


local String = {}

--[[
    将字符串分割为数组
    @access public
    @param string 要分割的字符串
    @param delimiter 分割符
    @param limit 限制
    @return table
]]
function String.split(string, delimiter, limit)
    if string == nil or string == '' or delimiter == nil then
        return {}
    end

    local result = {}
    while (true) do
        local index = string.find(string, delimiter, 1, true)

        if (index == nil) or (limit and limit > 0 and #result >= limit - 1) then
            table.insert(result, string)
            break
        else
            table.insert(result, string.sub(string, 1, index - 1))
            string = string.sub(string, index + 1)
        end
    end

    return result
end

--[[
    将字符串首字母大写
    @access public
    @param string 要处理的字符串
    @return string
]]
function String.ucfirst(string)
    if string == nil or string == '' then return '' end

    local last = string.sub(string, 1, 1)
    string = string.gsub(string, last, string.upper(last), 1)

    return string
end

return String
