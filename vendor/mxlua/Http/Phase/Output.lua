--
-- Output
-- @author renzhenguo <renzhenguo@moxiu.net>
-- 
-- 内容输出阶段
-- 对输入内容对象 输出内容对象及输出格式进行初始化设置


local cjson = require('cjson')

local Phase = {
    -- cycle对象
    -- @access private
    -- @var Cycle
    _cycle = {},
}

function Phase.run(cycle)
    Phase._cycle = cycle;

    Phase:genHeaders()
    Phase:genData()
end

--[[
    输出头信息
    @access public
    @return nil
]]
function Phase:genHeaders()
    local headers = self._cycle:getResponse():getHeaders()

    table.foreach(headers, function(key, val)
        ngx.header[key] = val
    end)
end

--[[
    输出数据内容
    @access public
    @return nil
]]
function Phase:genData()
    local format = self._cycle:getResponse():getFormat()
    local method = 'output' .. String.ucfirst(string.lower(format))

    if self[method] then
        self[method](self)
    else
        error('format not support')
    end
end

--[[
    json格式数据输出
    @access public
    @return nil
]]
function Phase:outputJson()
    ngx.header['Content_type'] = 'application/json; charset=UTF-8'

    local data = self._cycle:getResponse():getData()
    data = cjson.encode(data)

    ngx.say(data)
end

--[[
    二进制内容输出
    @access public
    @return nil
]]
function Phase:outputBinary()
    ngx.header['Content_type'] = 'text/plain; charset=UTF-8'

    local data = self._cycle:getResponse():getData()

    if data.code == 200 then
        ngx.say(data.data)
    else
        ngx.status = data.code
        ngx.say(data.message)
    end
end

return Phase
