package org.example;

import com.alibaba.nacos.api.NacosFactory;
import com.alibaba.nacos.api.config.ConfigChangeEvent;
import com.alibaba.nacos.api.config.ConfigService;
import com.alibaba.nacos.client.config.listener.impl.AbstractConfigChangeListener;

import java.util.Properties;

public class Client {
    public static void main(String[] args) throws Exception {
        String serverAddr = "127.0.0.1:8848";
        String dataId = "test.yaml";
        String group = "DEFAULT_GROUP";
        Properties properties = new Properties();
        properties.put("serverAddr", serverAddr);
        properties.put("username", "nacos");
        properties.put("password", "nacos");
        ConfigService configService = NacosFactory.createConfigService(properties);
        String content = configService.getConfig(dataId, group, 5000);
        System.out.println(content);

        configService.addListener(dataId, group, new AbstractConfigChangeListener() {
            @Override
            public void receiveConfigChange(ConfigChangeEvent configChangeEvent) {
                System.out.println(configChangeEvent);
            }
        });

        while (true) {
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
