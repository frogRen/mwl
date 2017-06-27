--
-- Array 模块
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- 对数组深度使用, 扩展table


local Array = {}

--[[
    多个数组合并.
    如果两个或更多个数组元素有相同的键名，则最后的元素会覆盖其他元素. 索引数组会从1重新索引
    @access public
    @param ... 多个数组参数
    @return table
]]
function Array.merge(...)
    local result = {}

    table.foreach({...}, function(index, array)
        table.foreach(array, function(key, val)
            if (type(key) == 'number') then
                table.insert(result, val)
            else
                result[key] = val
            end
        end)
    end)

    return result
end

--[[
    读取数组元素值,在特殊场景需要用到的
    @access public
    @param array 数组
    @param key 键名
    @return mixed
]]
function Array.get(array, key)
    table.foreach(String.split(key, '.'), function(index, segment)
        array = array[segment]
    end)

    return array
end

return Array
