package com.wh.work.mapper;

import java.util.List;

import com.wh.work.domain.WhProject;
import com.wh.work.domain.WhProjectOrigin;
import org.apache.ibatis.annotations.Param;

/**
 * 项目来源Mapper接口
 * 
 * @author wh
 * @date 2023-10-13
 */
public interface WhProjectOriginMapper 
{
    /**
     * 查询项目来源
     * 
     * @param id 项目来源主键
     * @return 项目来源
     */
    public WhProjectOrigin selectWhProjectOriginById(Long id);

    /**
     * 查询项目来源列表
     * 
     * @param whProjectOrigin 项目来源
     * @return 项目来源集合
     */
    public List<WhProjectOrigin> selectWhProjectOriginList(WhProjectOrigin whProjectOrigin);

    /**
     * 新增项目来源
     * 
     * @param whProjectOrigin 项目来源
     * @return 结果
     */
    public int insertWhProjectOrigin(WhProjectOrigin whProjectOrigin);

    /**
     * 修改项目来源
     * 
     * @param whProjectOrigin 项目来源
     * @return 结果
     */
    public int updateWhProjectOrigin(WhProjectOrigin whProjectOrigin);

    /**
     * 删除项目来源
     * 
     * @param id 项目来源主键
     * @return 结果
     */
    public int deleteWhProjectOriginById(Long id);

    /**
     * 批量删除项目来源
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWhProjectOriginByIds(Long[] ids);

    /**
     * 根据编号更新项目来源
     * @param whProjectOrigin
     * @return
     */
    int updateProjectOriginByNo(WhProjectOrigin whProjectOrigin);

    /**
     * 查询项目来源
     *
     * @param syncId 项目来源同步主键
     * @return 项目来源
     */
    public WhProjectOrigin selectWhProjectOriginBySyncId(@Param("syncId") Long syncId);
}
