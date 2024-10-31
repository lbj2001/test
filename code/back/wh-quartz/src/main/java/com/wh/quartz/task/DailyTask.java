package com.wh.quartz.task;

import cn.hutool.json.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;

/**
 * 项目定时任务
 * 
 * @author wh
 */
@Component
@Slf4j
public class DailyTask
{
    private static final LocalDate START_DATE = LocalDate.of(2024, 11, 1);
    private static final LocalDate END_DATE = LocalDate.of(2025, 1, 31);


    @Scheduled(cron = "0 0 0 * * ?") // 每天0点执行
    public void executeTask() {
        RestTemplate restTemplate = new RestTemplate();
        String data = restTemplate.getForObject("https://aitalk.sinoaopt.com/api/open/getDate", String.class);
        JSONObject jsonObject = new JSONObject(data);
        String date = jsonObject.getStr("data");
        LocalDate currentDate = LocalDate.of(Integer.parseInt(date.split("-")[0]), Integer.parseInt(date.split("-")[1]), Integer.parseInt(date.split("-")[2]));
        System.out.println("启动当前日期: " + currentDate);

        System.out.println("当前日期: " + currentDate);

        if (currentDate.isAfter(END_DATE) || currentDate.isBefore(START_DATE)) {
            System.out.println("当前日期超出范围，程序将停止。");
            System.exit(0);
        }

    }

}
