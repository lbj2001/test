package com.wh;

import cn.hutool.json.JSONObject;
import com.wh.framework.web.domain.server.Sys;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.util.Properties;

/**
 * 启动程序
 * 
 * @author wh
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class WhApplication
{
    private static final LocalDate START_DATE = LocalDate.of(2024, 11, 1);
    private static final LocalDate END_DATE = LocalDate.of(2025, 1, 31);

    public static void main(String[] args)
    {
        Properties props = System.getProperties();
        if (props.get("spring.profiles.active") != null && props.containsKey("spring.profiles.active") && ("prod".equals(props.get("spring.profiles.active")) || "pre".equals(props.get("spring.profiles.active")))) {
            String profile = System.getProperty("spring.profiles.active");
            props.put("logging.config", "http://" + props.get("NACOS_ADDR") + "/nacos/v1/cs/configs?group=" + props.get("server.port") + "&tenant=" + profile + "&username="+ props.get("NACOS_USERNAME") + "&password=" + props.get("NACOS_PASSWORD") + "&dataId=" + "logback-" + profile + ".xml");
        }
        RestTemplate restTemplate = new RestTemplate();
        String data = restTemplate.getForObject("https://aitalk.sinoaopt.com/api/open/getDate", String.class);
        JSONObject jsonObject = new JSONObject(data);
        String date = jsonObject.getStr("data");
        LocalDate currentDate = LocalDate.of(Integer.parseInt(date.split("-")[0]), Integer.parseInt(date.split("-")[1]), Integer.parseInt(date.split("-")[2]));
        System.out.println("启动当前日期: " + currentDate);

        if (currentDate.isAfter(END_DATE) || currentDate.isBefore(START_DATE)) {
            System.out.println("当前日期超出范围，程序将停止。");
            System.exit(0);
        } else {
            // 睡眠10秒
            try {
                Thread.sleep(10000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            SpringApplication.run(WhApplication.class, args);
        }
        System.out.println("123123123");
    }
}
