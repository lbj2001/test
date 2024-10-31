package com.wh.quartz.task;/**
 * @author wxd
 * @date 2024/3/15
 * @desc
 */

import com.wh.common.utils.DateUtils;
import lombok.extern.slf4j.Slf4j;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

/**
 * @Desc: 功能描述
 * @author: Mr.dong
 * @date: 2024 03 15
 */
@Slf4j
public class Hello {

    public static void main(String[] args) throws ParseException {
        //Date date = processUtcTime("2024-03-15T11:45:09.8617966Z");
        //log.info("date-->{}", date);
        //log.info("nowdate-->{}",new Date());

        String dt = "2024-03-15T03:45:09.8617966Z";
        Instant instant = Instant.parse(dt);
        ZoneId zoneId = ZoneId.systemDefault();
        LocalDateTime localDateTime = LocalDateTime.ofInstant(instant,zoneId);

        Date date = DateUtils.toDate(localDateTime);
        log.info("localDateTime-->{}", localDateTime);
        log.info("date-->{}", date);

        //String utcTimeString = "2023-04-01T10:00:00Z"; // 假设这是UTC时间的字符串表示
        //SimpleDateFormat utcFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
        //utcFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // 设置时区为UTC
        //Date date = utcFormat.parse(utcTimeString);
        //
        //SimpleDateFormat localFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //localFormat.setTimeZone(TimeZone.getDefault()); // 设置为本地时区
        //String localTimeString = localFormat.format(date);
        //
        //System.out.println("UTC Time: " + utcTimeString);
        //System.out.println("Local Time: " + localTimeString);
    }

    public static Date processUtcTime(String utcTime) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        //sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
        return sdf.parse(utcTime);
    }
}
