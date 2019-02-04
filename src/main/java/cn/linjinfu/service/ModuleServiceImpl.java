package cn.linjinfu.service;

import cn.linjinfu.mapper.ModuleMapper;
import cn.linjinfu.pojo.Module;
import cn.linjinfu.pojo.ModuleExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ModuleServiceImpl implements ModuleService{
    @Autowired
    private ModuleMapper moduleMapper;

    //查询所有版块
    @Override
    public List<Module> seleteModule() {
        List<Module> moduleList = moduleMapper.selectByExample(null);
        return moduleList;
    }
}
