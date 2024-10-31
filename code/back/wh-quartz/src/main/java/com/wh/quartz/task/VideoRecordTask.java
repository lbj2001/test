package com.wh.quartz.task;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateUtil;
import com.wh.work.domain.WhVideoRecord;
import com.wh.work.domain.WhVideoRecordDetail;
import com.wh.work.domain.vo.WhVideoDetailSyncVO;
import com.wh.work.domain.vo.WhVideoSyncVO;
import com.wh.work.service.IWhVideoRecordDetailService;
import com.wh.work.service.IWhVideoRecordService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

/**
 * 项目定时任务
 * 
 * @author wh
 */
@Component("videoRecordTask")
@Slf4j
public class VideoRecordTask
{

    @Autowired
    private IWhVideoRecordService videoRecordService;

    public void syncVideoRecord(){

        log.info("sync video start....");

        //查询记录列表
        WhVideoSyncVO videoSyncVO = new WhVideoSyncVO();
        videoSyncVO.setEndTime(new Date());

        //当前时间前一天
        Date yesterday = DateUtil.offsetDay(DateUtil.date(), -1);
        videoSyncVO.setStartTime(yesterday);
        //查询上次同步时间
//        WhVideoRecord latestRecord = videoRecordService.selectLastestSync();
//        if (latestRecord != null){
//            videoSyncVO.setStartTime(latestRecord.getSyncTime());
//        }

        videoRecordService.syncVideoRecordList(videoSyncVO);

        log.info("sync video end....");

    }

}
