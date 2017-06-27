-- test
-- @author renzhenguo <renzhenguo@moxiu.net>
--
-- 测试环境的配置


local config = dofile(APP_PATH .. 'config/prod.lua')

config.env = 'test'

return config
