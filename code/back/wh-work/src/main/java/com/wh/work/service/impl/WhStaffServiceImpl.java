package com.wh.work.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.wh.common.core.domain.entity.SysUser;
import com.wh.common.utils.DateUtils;
import com.wh.system.service.ISysUserService;
import com.wh.work.service.IWhSalaryDistributionService;
import com.wh.work.service.IWhTaskService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import com.wh.work.mapper.WhStaffMapper;
import com.wh.work.domain.WhStaff;
import com.wh.work.service.IWhStaffService;
import org.springframework.transaction.annotation.Transactional;

/**
 * 员工信息Service业务层处理
 * 
 * @author wxd
 * @date 2023-05-16
 */
@Service
public class WhStaffServiceImpl implements IWhStaffService 
{
    @Autowired
    private WhStaffMapper whStaffMapper;

    @Autowired
    private ISysUserService iSysUserService;

    @Autowired
    private IWhSalaryDistributionService iWhSalaryDistributionService;

    @Autowired
    private IWhTaskService iWhTaskService;


    /**
     * 查询员工信息
     * 
     * @param id 员工信息主键
     * @return 员工信息
     */
    @Override
    public WhStaff selectWhStaffById(Long id)
    {
        return whStaffMapper.selectWhStaffById(id);
    }

    /**
     * 查询员工信息列表
     * 
     * @param whStaff 员工信息
     * @return 员工信息
     */
    @Override
    public List<WhStaff> selectWhStaffList(WhStaff whStaff)
    {
        return whStaffMapper.selectWhStaffList(whStaff);
    }

    /**
     * 查询单个员工上下级列表
     *
     * @param whStaff 员工id
     * @return 员工信息
     */
    @Override
    public List<WhStaff> selectSingleList(WhStaff whStaff)
    {
        return whStaffMapper.selectAllRelatives(whStaff);
    }

    /**
     * 查询员工所有子级
     *
     * @param whStaff 员工信息
     * @return 员工信息
     */
    @Override
    public List<WhStaff> selectWhStaffListChildren(WhStaff whStaff)
    {
        return whStaffMapper.selectWhStaffListChildren(whStaff);
    }

    /**
     * 查询员工所有父级
     *
     * @param whStaff 员工信息
     * @return 员工信息
     */
    @Override
    public List<WhStaff> selectWhStaffListParents(WhStaff whStaff)
    {
        return whStaffMapper.selectWhStaffListParents(whStaff);
    }

    /**
     * 查询员工所有父级（除自己）
     *
     * @param whStaff 员工信息
     * @return 员工信息
     */
    @Override
    public List<WhStaff> selectAllParents(WhStaff whStaff)
    {
        return whStaffMapper.selectAllParents(whStaff);
    }

    /**
     * 新增员工信息
     * 
     * @param whStaff 员工信息
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertWhStaff(WhStaff whStaff)
    {
        whStaff.setCreateTime(DateUtils.getNowDate());
        //判断是否重复,如果之前已解除过，并且同一团队
        WhStaff sta = this.judgeExist(whStaff);

        int flag = 0;

        //判断添加的是否和上次同一团队
        if ((sta != null && (whStaff.getParentId() == null || sta.getParentId().equals(whStaff.getParentId())))){
            sta.setDelFlag("0");
            flag = whStaffMapper.updateWhStaff(sta);
        } else {
            //自动生成架构名称及编号
            String teamName = String.valueOf((char)(whStaff.getParticipationMethods()+64));
            whStaff.setTeamName(teamName);
            //查询系统中最大流水号+1
            whStaff.setTeamNo(genTeamNo(teamName));

            flag = whStaffMapper.insertWhStaff(whStaff);
            if (whStaff.getParticipationMethods() == 1){
                if (flag > 0) {
                    whStaff.setTeamId(whStaff.getId());
                    flag = whStaffMapper.updateWhStaff(whStaff);
                }
            } else if (whStaff.getParticipationMethods() == 3){
                //开发人员，默认状态开启
                SysUser sysUser = iSysUserService.selectUserByUserName(whStaff.getStaffNo());
                if (sysUser != null){
                    sysUser.setStatus("0");
                    iSysUserService.updateUserByUserName(sysUser);
                    //赋予工时申报权限角色
                    Long[] roleArray = new Long[]{102L};
                    try{
                        iSysUserService.insertUserRole(sysUser.getUserId(), roleArray);
                    }catch (DuplicateKeyException e){
                        throw new RuntimeException("需将该人员全部对应角色删除后，才能创建组队关系");
                    }
                }

            }
        }

        return flag;
    }

    private WhStaff judgeExist(WhStaff whStaff){
        WhStaff staff = new WhStaff();
        staff.setStaffNo(whStaff.getStaffNo());
        staff.setParticipationMethods(whStaff.getParticipationMethods());
        //staff.setDelFlag("0");
        List<WhStaff> staffList = whStaffMapper.selectWhStaffList(staff);
        if (CollectionUtils.isEmpty(staffList)){
            return null;
        }
        WhStaff sta =  staffList.get(0);
        if (sta.getDelFlag().equals("0")){
            throw new RuntimeException("员工已组队，请勿重复配置");
        }
        return sta;
    }

    /**
     * 修改员工信息
     * 
     * @param whStaff 员工信息
     * @return 结果
     */
    @Override
    public int updateWhStaff(WhStaff whStaff)
    {
        whStaff.setUpdateTime(DateUtils.getNowDate());
        return whStaffMapper.updateWhStaff(whStaff);
    }

    /**
     * 批量删除员工信息
     * 
     * @param ids 需要删除的员工信息主键
     * @return 结果
     */
    @Override
    public int deleteWhStaffByIds(Long[] ids)
    {
        return whStaffMapper.deleteWhStaffByIds(ids);
    }

    /**
     * 删除员工信息信息
     * 
     * @param id 员工信息主键
     * @return 结果
     */
    @Override
    public int deleteWhStaffById(Long id)
    {
        return whStaffMapper.deleteWhStaffById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int dismiss(WhStaff whStaff) {
        //判断是否终止与公司合作
        if ("1".equals(whStaff.getDismissFlag())){
            //判断当前人是否存在其他组队配置
            WhStaff staff = new WhStaff();
            staff.setStaffNo(whStaff.getStaffNo());
            staff.setDelFlag("0");
            List<WhStaff> staffList = whStaffMapper.selectWhStaffList(staff);
            if (CollectionUtils.isNotEmpty(staffList) && staffList.size() != 1){
                throw new RuntimeException("人员尚存在其他参与方式的父级组队配置信息,不能终止合作");
            }

            //停用人员信息
            SysUser user = new SysUser();
            user.setUserName(whStaff.getStaffNo());
            user.setEndCooperationTime(new Date());
            user.setStatus("1");//停用
            if(iSysUserService.updateUserByUserName(user)<  0){
                throw new RuntimeException("停用人员失败");
            }
        }
        return whStaffMapper.deleteWhStaffById(whStaff.getId());
    }

    @Override
    public boolean checkExistRelation(WhStaff whStaff) {
        boolean flag = false;
        //if (whStaff.getParticipationMethods() == 4){ // 领薪人员，判断是否发放完成
        //    flag =  iWhSalaryDistributionService.checkExistByStaffId(whStaff.getId()) > 0;
        //} else
        if(whStaff.getParticipationMethods() == 3){// 开发人员，判断是否申报
            flag = iWhTaskService.checkExistByStaffId(whStaff.getId()) > 0;
        }
        return flag;
    }

    @Override
    public List<WhStaff> listSalaryNames(WhStaff whStaff) {

        return whStaffMapper.selectSalaryNames(whStaff);
    }

    @Override
    public List<WhStaff> selectWhStaffListByParent(WhStaff whStaff) {
        return whStaffMapper.selectWhStaffListByParent(whStaff);
    }

    @Override
    public WhStaff selectMaxStaff(String staffNo) {
        return whStaffMapper.selectMaxStaff(staffNo);
    }

    @Override
    public List<WhStaff> selectAllDevChildren(WhStaff whStaff) {
        return whStaffMapper.selectAllChildren(whStaff);
    }

    @Override
    public Integer getTeamAmount(Long staffId) {
        return whStaffMapper.selectTeamAmount(staffId);
    }

    /**
     * 生成架构编号/流水号
     * @return
     */
    private String genTeamNo(String teamName){
        String teamNo = "";
        //查询库中最大值
        String maxTeamNo = whStaffMapper.selectMaxTeamNo(teamName);
        if (null != maxTeamNo){
            int number = Integer.parseInt(maxTeamNo.substring(1)) + 1;
            teamNo += teamName + String.format("%04d", number);
        }else{
            teamNo += teamName + "0001";
        }

        return teamNo;

    }
}
