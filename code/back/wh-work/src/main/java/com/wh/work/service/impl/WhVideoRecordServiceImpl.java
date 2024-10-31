package com.wh.work.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.function.Function;
import java.util.stream.Collectors;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.wh.common.exception.ServiceException;
import com.wh.common.utils.DateUtils;
import com.wh.common.utils.StringUtils;
import com.wh.system.service.ISysConfigService;
import com.wh.work.domain.WhVideoRecordDetail;
import com.wh.work.domain.vo.WhVideoDetailSyncVO;
import com.wh.work.domain.vo.WhVideoSyncVO;
import com.wh.work.service.IWhVideoRecordDetailService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import com.wh.work.mapper.WhVideoRecordMapper;
import com.wh.work.domain.WhVideoRecord;
import com.wh.work.service.IWhVideoRecordService;
import org.springframework.transaction.annotation.Transactional;

/**
 * 工时视频记录Service业务层处理
 * 
 * @author wxd
 * @date 2024-03-09
 */
@Slf4j
@Service
public class WhVideoRecordServiceImpl implements IWhVideoRecordService 
{
    @Autowired
    private WhVideoRecordMapper whVideoRecordMapper;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private IWhVideoRecordDetailService whVideoRecordDetailService;

    private String videoInterfaceUsername;

    private String videoInterfacePassword;

    private String videoInterfaceLogon;

    private String videoInterfaceSearch;

    private String videoInterfaceSessions;

    private String videoUrlAddress;

    /**
     * 查询工时视频记录
     * 
     * @param id 工时视频记录主键
     * @return 工时视频记录
     */
    @Override
    public WhVideoRecord selectWhVideoRecordById(Long id)
    {
        return whVideoRecordMapper.selectWhVideoRecordById(id);
    }

    /**
     * 查询工时视频记录列表
     * 
     * @param whVideoRecord 工时视频记录
     * @return 工时视频记录
     */
    @Override
    public List<WhVideoRecord> selectWhVideoRecordList(WhVideoRecord whVideoRecord)
    {
        List<WhVideoRecord> recordList = whVideoRecordMapper.selectWhVideoRecordList(whVideoRecord);
        if (CollectionUtils.isNotEmpty(recordList)){
            List<Long> recordIds = recordList.stream().map(WhVideoRecord::getId).collect(Collectors.toList());
            WhVideoRecordDetail recordDetail = new WhVideoRecordDetail();
            recordDetail.setRecordIds(recordIds);
            recordDetail.setClaimStatus(0);
            recordDetail.setTimeLimit(1);
            List<WhVideoRecordDetail> detailList = whVideoRecordDetailService.selectWhVideoRecordDetailList(recordDetail);
            Map<Long,List<WhVideoRecordDetail>> detailMap = new HashMap<>();
            if (CollectionUtils.isNotEmpty(detailList)){
                detailMap = detailList.stream().collect(Collectors.groupingBy(WhVideoRecordDetail::getRecordId));
            }
            for (WhVideoRecord record : recordList){
                if (detailMap.containsKey(record.getId())){
                    record.setRecordDetailList(detailMap.get(record.getId()));
                }
            }
        }
        return recordList;
    }

    /**
     * 新增工时视频记录
     * 
     * @param whVideoRecord 工时视频记录
     * @return 结果
     */
    @Override
    public int insertWhVideoRecord(WhVideoRecord whVideoRecord)
    {
        whVideoRecord.setCreateTime(DateUtils.getNowDate());
        return whVideoRecordMapper.insertWhVideoRecord(whVideoRecord);
    }

    /**
     * 修改工时视频记录
     * 
     * @param whVideoRecord 工时视频记录
     * @return 结果
     */
    @Override
    public int updateWhVideoRecord(WhVideoRecord whVideoRecord)
    {
        whVideoRecord.setUpdateTime(DateUtils.getNowDate());
        return whVideoRecordMapper.updateWhVideoRecord(whVideoRecord);
    }

    /**
     * 批量删除工时视频记录
     * 
     * @param ids 需要删除的工时视频记录主键
     * @return 结果
     */
    @Override
    public int deleteWhVideoRecordByIds(Long[] ids)
    {
        return whVideoRecordMapper.deleteWhVideoRecordByIds(ids);
    }

    /**
     * 删除工时视频记录信息
     * 
     * @param id 工时视频记录主键
     * @return 结果
     */
    @Override
    public int deleteWhVideoRecordById(Long id)
    {
        return whVideoRecordMapper.deleteWhVideoRecordById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public List<WhVideoSyncVO> selectThirdPartyRecordList(WhVideoSyncVO videoSyncVO){
        // 视频录制地址
        String videoAddress = configService.selectConfigByKey("sys.video.address");
        if (StringUtils.isEmpty(videoAddress)){
            throw new ServiceException("虚拟桌面录制服务器IP地址或域名尚未配置");
        }
        // 1、获取token
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("username", videoInterfaceUsername);
        paramMap.put("password", videoInterfacePassword);
        log.info("视频接口登录参数{}", paramMap);
        HttpResponse responseLogon;
        JSONObject jsonObject;
        try{
            responseLogon = HttpRequest.post(videoAddress + videoInterfaceLogon)
                    .header("Content-Type", "application/json")
                    .body(JSON.toJSONString(paramMap))
                    .execute();
            jsonObject = JSONObject.parseObject(responseLogon.body());
        }catch (Exception e){
            throw new ServiceException("虚拟桌面录制服务器IP地址或域名配置错误");
        }
        log.info("视频接口登录结果{}", responseLogon.body());
        if (jsonObject == null || jsonObject.get("jwt") == null){
            throw new ServiceException("视频配置接口登录授权失败");
        }
        String token = (String)jsonObject.get("jwt");

        // 2、查询列表
        HashMap<String, Object> searchMap = new HashMap<>();
        List<HashMap<String, Object>> filterList = new ArrayList<>();
        HashMap<String, Object> filterMap = new HashMap<>();
        filterMap.put("filterType", 0);
        filterMap.put("value", "");
        filterList.add(filterMap);
        searchMap.put("filter", filterList);
        searchMap.put("external", true);
        searchMap.put("internal", true);
        if (videoSyncVO.getStartTime() != null){
            searchMap.put("startTime", DateUtil.format(videoSyncVO.getStartTime(), "yyyy/MM/dd"));
        }
        if (videoSyncVO.getEndTime() != null){
            searchMap.put("endTime", DateUtil.format(videoSyncVO.getEndTime(), "yyyy/MM/dd"));
        }
//        searchMap.put("startTime", "2024/09/01");
//        searchMap.put("endTime", "2024/06/28");
        log.info("视频接口查询参数{}", searchMap);
        HttpResponse responseSearch = HttpRequest.post(videoAddress + videoInterfaceSearch)
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + token)
                .body(JSON.toJSONString(searchMap))
                .execute();
//        log.info("视频接口查询结果{}", responseSearch.body());
        List<WhVideoSyncVO> sessionList = new ArrayList<>();
        try {
            JSONArray sessionArray = JSONUtil.parseArray(responseSearch.body());
            log.info("视频接口查询结果数量{}", sessionArray.size());
            // 遍历数组
            Iterator<Object> iterator = sessionArray.iterator();
            WhVideoSyncVO syncVO;
            while(iterator.hasNext()){
                syncVO = new WhVideoSyncVO();
                Object obj = iterator.next();
                JSONObject jsonObj = JSONObject.parseObject(obj.toString());
                String state = (String)jsonObj.get("state");
                // 过滤已完成状态
                if ("已完成".equals(state)){
                    Integer id = (Integer)jsonObj.get("id");
                    String userName = (String)jsonObj.get("userName");
                    String startTime = (String)jsonObj.get("startTime");
                    String endTime = (String)jsonObj.get("endTime");
                    String duration = (String)jsonObj.get("duration");
                    Integer totalRecordings = (Integer)jsonObj.get("totalRecordings");
                    syncVO.setId(id);
                    syncVO.setUserName(userName);
                    syncVO.setStartTime(processUtcTime(startTime));
                    syncVO.setEndTime(processUtcTime(endTime));
                    syncVO.setDuration(processTime(duration));
                    syncVO.setTotalRecordings(totalRecordings);

                    //视频记录详情
                    HttpResponse responseSession = HttpRequest.get(videoAddress + videoInterfaceSessions + "/" + id)
                            .header("Content-Type", "application/json")
                            .header("Authorization", "Bearer " + token)
                            .execute();

                    JSONObject jsonSession = JSONObject.parseObject(responseSession.body());
                    JSONArray recordingArray = JSONUtil.parseArray(jsonSession.get("recordings"));
                    log.info("视频记录详情接口查询结果{}", recordingArray.size());
                    List<WhVideoDetailSyncVO> recordingList = new ArrayList<>();
                    // 遍历数组
                    Iterator<Object> iter = recordingArray.iterator();
                    WhVideoDetailSyncVO detailSyncVO;
                    while(iter.hasNext()){
                        detailSyncVO = new WhVideoDetailSyncVO();
                        Object objDetail = iter.next();
                        JSONObject jsonDetail = JSONObject.parseObject(objDetail.toString());
                        Integer idRecord = (Integer)jsonDetail.get("id");
                        Integer sessionId = (Integer)jsonDetail.get("sessionID");
                        Integer segmentId = (Integer)jsonDetail.get("segmentID");
                        Integer screenId = (Integer)jsonDetail.get("screenID");
                        String startTimeRecord = (String)jsonDetail.get("startTime");
                        String endTimeRecord = (String)jsonDetail.get("endTime");
                        String durationRecord = (String)jsonDetail.get("duration");

                        detailSyncVO.setId(idRecord);
                        detailSyncVO.setSessionID(sessionId);
                        detailSyncVO.setSegmentID(segmentId);
                        detailSyncVO.setScreenID(screenId);
                        detailSyncVO.setStartTime(processUtcTime(startTimeRecord));
                        detailSyncVO.setEndTime(processUtcTime(endTimeRecord));
                        detailSyncVO.setDuration(processTime(durationRecord));
                        recordingList.add(detailSyncVO);
                    }
                    syncVO.setRecordings(recordingList);
                    sessionList.add(syncVO);
                }

            }
        }catch (Exception e){
            log.error("视频接口查询失败,错误信息{}", e.getMessage());
        }

        if(CollectionUtils.isNotEmpty(sessionList)){
            sessionList.sort(Comparator.comparing(WhVideoSyncVO::getId));
        }

        return sessionList;
    }

    /**
     * 处理UTC时间格式->java8 处理
     * @param utcTime
     * @return
     */
    private Date processUtcTime(String utcTime){
        LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.parse(utcTime), ZoneId.systemDefault());
        return DateUtils.toDate(localDateTime);
    }

    /**
     * 处理UTC时间格式
     * @param timeString
     * @return
     */
    private Date processTime(String timeString) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        return sdf.parse(timeString);
    }

    @Override
    public WhVideoRecord selectLastestSync() {
        return whVideoRecordMapper.selectLastestSync();
    }

    @Override
    public boolean checkVideoAddress() {
        // 视频录制地址
        String videoAddress = configService.selectConfigByKey("sys.video.address");
        if (StringUtils.isEmpty(videoAddress)){
            throw new ServiceException("虚拟桌面录制服务器IP地址或域名尚未配置");
        }
        // 1、获取token
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("username", videoInterfaceUsername);
        paramMap.put("password", videoInterfacePassword);
        log.info("视频接口登录参数{}", paramMap);
        return true;
    }

    @Override
//    @Transactional(rollbackFor = Exception.class)
    public boolean ayncVideoRecordList(WhVideoSyncVO videoSyncVO) {

        //TODO 禁止重复进入
        CompletableFuture<String> future = CompletableFuture.supplyAsync(()->{
            this.syncVideoRecordList(videoSyncVO);
            return "aysnc success";
        });

        try {
            String result = future.get(3, TimeUnit.SECONDS);
            log.info("超时结果{}", result);
        } catch (InterruptedException | ExecutionException | TimeoutException e) {
//            future.cancel(true);
            log.info("Async video timeout or interrupted.");
            return true;
        }

        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void syncVideoRecordList(WhVideoSyncVO videoSyncVO) {
        log.info("sync start...");
        long start = System.currentTimeMillis();
        List<WhVideoSyncVO> syncVOList = this.selectThirdPartyRecordList(videoSyncVO);

        // 判断是否已同步过
        List<Long> sessionIds = syncVOList.stream().map(i->i.getId().longValue()).collect(Collectors.toList());

        //查询是否含有
        List<WhVideoRecord> existList = whVideoRecordMapper.selectWhVideoRecordBySessionIds(sessionIds);
        List<Integer> existSessionIds;
        if (CollectionUtils.isNotEmpty(existList)){
            existSessionIds = existList.stream().map(i->i.getSessionId().intValue()).collect(Collectors.toList());
        }else{
            existSessionIds = new ArrayList<>();
        }
        if (CollectionUtils.isNotEmpty(syncVOList)){
            //遍历保存
            WhVideoRecord videoRecord;
            for(WhVideoSyncVO syncVO : syncVOList){
                if (existSessionIds.contains(syncVO.getId())){
                    log.info("syncVideo{}已存在....", syncVO.getId());
                }else{
                    videoRecord = new WhVideoRecord();
                    BeanUtil.copyProperties(syncVO, videoRecord);
                    videoRecord.setSessionId(syncVO.getId().longValue());
                    String videoUrl = videoUrlAddress + syncVO.getUserName()+"/"+syncVO.getId();
                    videoRecord.setVideoUrl(videoUrl);
                    videoRecord.setSyncTime(new Date());
                    videoRecord.setCreateBy("admin");
                    //判断时长
                    LocalTime durationTime = videoRecord.getDuration().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
                    Duration dura = Duration.between(LocalTime.MIN, durationTime);
                    if (dura.toMinutes() >= 1){
                        videoRecord.setTimeLimit(1);
                    }
                    try{
                        whVideoRecordMapper.insertWhVideoRecord(videoRecord);
                        // 遍历保存详情
                        WhVideoRecordDetail videoRecordDetail;
                        // 时长统计
                        int limitAmounts = 0;
                        for (WhVideoDetailSyncVO detailSyncVO: syncVO.getRecordings()){
                            videoRecordDetail = new WhVideoRecordDetail();
                            BeanUtil.copyProperties(detailSyncVO, videoRecordDetail);
                            videoRecordDetail.setRecordId(videoRecord.getId());
                            videoRecordDetail.setSessionId(detailSyncVO.getSessionID().longValue());
                            videoRecordDetail.setRecordingId(detailSyncVO.getId().longValue());
                            videoRecordDetail.setSegmentId(detailSyncVO.getSegmentID().longValue());
                            videoRecordDetail.setScreenId(detailSyncVO.getScreenID().longValue());
                            String videoDetailUrl = videoRecord.getVideoUrl() + "/Segment"+ detailSyncVO.getSegmentID()
                                    + "-Screen"+ detailSyncVO.getScreenID()+ ".mp4";
                            videoRecordDetail.setVideoUrl(videoDetailUrl);
                            videoRecordDetail.setSyncTime(new Date());
                            videoRecordDetail.setCreateBy("admin");
                            //判断时长
                            LocalTime durationItem = videoRecordDetail.getDuration().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
                            Duration duraItem = Duration.between(LocalTime.MIN, durationItem);
                            if (duraItem.toMinutes() >= 1){
                                videoRecordDetail.setTimeLimit(1);
                                limitAmounts++;
                            }
                            try{
                                whVideoRecordDetailService.insertWhVideoRecordDetail(videoRecordDetail);
                            }catch (Exception e){
                                log.info("syncVideoDetail {" + detailSyncVO.getId() +"}出现异常...." + e.getMessage());
                            }
                        }

                        // 判断时长是否符合
                        if (limitAmounts == 0){
                            videoRecord.setTimeLimit(0);
                            whVideoRecordMapper.updateWhVideoRecord(videoRecord);
                        }

                    }catch (Exception e){
                        log.info("syncVideo {" + syncVO.getId() +"}出现异常...." + e.getMessage());
                    }
                }
            }
        }else{
            log.info("暂未有视频记录数据，当前时间{}....", new Date());
        }

                long end = System.currentTimeMillis();
        log.info("sync video end... 耗时{}s", (end - start)/1000 );

    }
}
