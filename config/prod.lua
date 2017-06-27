-- prod
-- @author renzhenguo <renzhenguo@moxiu.net>
--
-- 正式环境的配置


local config = {
    env = 'prod', --识别当前部署环境,需在dev/test中覆写
    root = APP_PATH,
}

-- 默认执行阶段类配置
config.phases = {
    'mxlua.Http.Phase.Init', 'mxlua.Http.Phase.Dispatch', 'mxlua.Http.Phase.Output'
}

-- action配置
config.action = {
    format = 'json', -- 默认输出格式
    default = 'Main', -- 默认Action
    namespace = 'app/Action/' -- 访问目录
}

--[[以下为业务配置]]--

return config
