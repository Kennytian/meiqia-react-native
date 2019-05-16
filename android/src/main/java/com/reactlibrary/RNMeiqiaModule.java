
package com.reactlibrary;

import android.content.Intent;
import com.facebook.react.bridge.*;
import com.meiqia.core.MQScheduleRule;
import com.meiqia.meiqiasdk.imageloader.MQGlideImageLoader4;
import com.meiqia.meiqiasdk.imageloader.MQImage;
import com.meiqia.meiqiasdk.util.MQConfig;
import com.meiqia.core.callback.OnInitCallback;
import com.meiqia.meiqiasdk.util.MQIntentBuilder;

import java.util.HashMap;

public class RNMeiqiaModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public RNMeiqiaModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "RNMeiqia";
    }

    @ReactMethod // 初始化SDK ----传入AppKey
    public void initSDK(final ReadableMap data, final Promise p) {
        String AppKey = data.getString("appKey");
        if (!AppKey.equals("")) {
            MQConfig.init(reactContext, AppKey, new OnInitCallback() {
                @Override
                public void onSuccess(String clientId) {
                    WritableMap map = Arguments.createMap();
                    map.putString("message", "success");
                    map.putString("clientId", clientId);
                    map.putString("code", Integer.toString(0));
                    p.resolve(map);
                }

                @Override
                public void onFailure(int code, String message) {
                    WritableMap map = Arguments.createMap();
                    map.putString("message", message);
                    map.putString("code", Integer.toString(code));
                    p.resolve(map);
                }
            });
        } else {
            WritableMap map = Arguments.createMap();
            map.putString("message", "AppKey");
            map.putString("code", Integer.toString(1));
            p.resolve(map);
        }
    }

    @ReactMethod
    public void show(final ReadableMap data, final Promise p) {

        if (data.hasKey("titleColor") && !data.getString("titleColor").equals("")) {

        }

        if (data.hasKey("titleBarColor") && !data.getString("titleBarColor").equals("")) {
        }

        if (data.hasKey("naviColor") && !data.getString("naviColor").equals("")) {

        }

        HashMap<String, Object> mapTemp = data.getMap("clientInfo").toHashMap();
        HashMap<String, String> clientInfo = new HashMap<String, String>();
        for (HashMap.Entry<String, Object> entry : mapTemp.entrySet()) {
            if (entry.getValue() instanceof String) {
                clientInfo.put(entry.getKey(), (String) entry.getValue());
            }
        }

        MQIntentBuilder intentConfig = new MQIntentBuilder(reactContext);
        intentConfig.setClientInfo(clientInfo); // 设置顾客信息 PS: 这个接口只会生效一次,如果需要更新顾客信息,需要调用更新接口

        if (data.hasKey("customId") && data.getMap("customId").hasKey("id") && !data.getMap("customId").getString("id").equals("")) {
            intentConfig.setCustomizedId(data.getMap("customId").getString("id")); // 相同的 id 会被识别为同一个顾客
        }
        if (data.hasKey("clientId") && data.getMap("clientId").hasKey("id") && !data.getMap("clientId").getString("id").equals("")) {
            intentConfig.setClientId(data.getMap("clientId").getString("id"));
        }
        if (data.hasKey("scheduledInfo")) {
            if (data.getMap("scheduledInfo").hasKey("agentId") && !data.getMap("scheduledInfo").getString("agentId").equals("")) {
                intentConfig.setScheduledAgent(data.getMap("scheduledInfo").getString("agentId")); // agentId 可以从工作台查询
            }
            if (data.getMap("scheduledInfo").hasKey("agentGroup") && !data.getMap("scheduledInfo").getString("agentGroup").equals("")) {
                intentConfig.setScheduledGroup(data.getMap("scheduledInfo").getString("agentGroup")); // agentId 可以从工作台查询
            }
            if (data.getMap("scheduledInfo").hasKey("scheduleRule") && !data.getMap("scheduledInfo").getString("scheduleRule").equals("")) {
                String ruleStr = data.getMap("scheduledInfo").getString("scheduleRule");
                if (ruleStr.equals("none")) {
                    intentConfig.setScheduleRule(MQScheduleRule.REDIRECT_NONE);
                }
                if (ruleStr.equals("group")) {
                    intentConfig.setScheduleRule(MQScheduleRule.REDIRECT_GROUP);
                }
                if (ruleStr.equals("enterprise")) {
                    intentConfig.setScheduleRule(MQScheduleRule.REDIRECT_ENTERPRISE);
                }
            } else {
                intentConfig.setScheduleRule(MQScheduleRule.REDIRECT_ENTERPRISE);
            }
        }
        MQImage.setImageLoader(new MQGlideImageLoader4());
        Intent intent = intentConfig.build();
        reactContext.startActivity(intent);
    }
}
