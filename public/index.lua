-- index
-- @author renzhenguo <renzhenguo@moxiu.net>
-- Wed Feb  8 03:42:39 Local time zone must be set--see zic manual page 2017
--
-- 入口文件
-- ngx.say('hello index <br>');


APP_PATH = ngx.var.document_root .. '/../'
package.path = APP_PATH .. 'vendor/?.lua;' .. package.path

local Front = require('mxlua.Http.Front')
local config = dofile(APP_PATH .. 'config/current.lua')

-- 可以通过修改config进行特殊控制
-- config.** = **

Front:new():run(config)
