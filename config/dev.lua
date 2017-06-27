-- dev
-- @author renzhenguo <renzhenguo@moxiu.net>
--
-- 开发环境的配置


local config = dofile(APP_PATH .. 'config/prod.lua')

config.env = 'dev'

return config
