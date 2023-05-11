package com.medallia.digital.mobilesdk.reactlibrary;

import android.app.Activity;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.medallia.digital.mobilesdk.MDAppearanceMode;
import com.medallia.digital.mobilesdk.MDCustomInterceptListenerData;
import com.medallia.digital.mobilesdk.MDExternalError;
import com.medallia.digital.mobilesdk.MDFeedbackListener;
import com.medallia.digital.mobilesdk.MDFeedbackListenerData;
import com.medallia.digital.mobilesdk.MDFormListener;
import com.medallia.digital.mobilesdk.MDFormListenerData;
import com.medallia.digital.mobilesdk.MDInterceptActionType;
import com.medallia.digital.mobilesdk.MDInterceptListener;
import com.medallia.digital.mobilesdk.MDInterceptListenerData;
import com.medallia.digital.mobilesdk.MDResultCallback;
import com.medallia.digital.mobilesdk.MDCallback;
import com.medallia.digital.mobilesdk.MDSdkFrameworkType;
import com.medallia.digital.mobilesdk.MedalliaDigital;
import com.medallia.digital.mobilesdk.MDLogLevel;
import com.medallia.digital.mobilesdk.MDFailureCallback;
import com.medallia.digital.mobilesdk.MDCustomInterceptListener;
import android.text.TextUtils;
import java.util.HashMap;

public class Medallia extends ReactContextBaseJavaModule {

    private ReactApplicationContext reactContext;

    Medallia(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "MedalliaDigitalModule";
    }

    @ReactMethod
    public void initialize(final String apiToken, final Promise promise) {
        Activity activity = reactContext.getCurrentActivity();
        if (activity != null) {
            MedalliaDigital.setActivity(activity);
            MedalliaDigital.setSdkFramework(MDSdkFrameworkType.RN);

            MedalliaDigital.init(activity.getApplication(), apiToken, new MDResultCallback() {
                @Override
                public void onSuccess() {
                    promise.resolve("Init success");
                }

                @Override
                public void onError(MDExternalError mdExternalError) {
                    promise.reject(mdExternalError.getMessage());
                }
            });

        }
    }

    @ReactMethod
    public void updateCustomLocale(String formId, final Promise promise) {
        MedalliaDigital.updateCustomLocale(formId, new MDCallback() {
            @Override
            public void onSuccess(String message) {
                promise.resolve(message);
            }

            @Override
            public void onError(MDExternalError mdExternalError) {
                promise.reject(mdExternalError.getMessage());
            }
        });
    }

    @ReactMethod
    public void closeEngagement(final Promise promise) {
        MedalliaDigital.closeEngagement(new MDResultCallback() {
            @Override
            public void onSuccess() {
                promise.resolve("Close Engagement success");
            }

            @Override
            public void onError(MDExternalError mdExternalError) {
                promise.reject(mdExternalError.getMessage());
            }
        });
    }

    @ReactMethod
    public void showForm(String formId, final Promise promise) {
        MedalliaDigital.showForm(formId, new MDResultCallback() {
            @Override
            public void onSuccess() {
                promise.resolve("Show Form success");
            }

            @Override
            public void onError(MDExternalError mdExternalError) {
                promise.reject(mdExternalError.getMessage());
            }
        });
    }

    @ReactMethod
    public void handleNotification(String formId, final Promise promise) {
        MedalliaDigital.handleNotification(formId, new MDResultCallback() {
            @Override
            public void onSuccess() {
                promise.resolve("Handle Notification success");
            }

            @Override
            public void onError(MDExternalError mdExternalError) {
                promise.reject(mdExternalError.getMessage());
            }
        });
    }

    @ReactMethod
    public void setCustomParameters(ReadableMap paramsMap) {
        HashMap<String, Object> customParameters = new HashMap<>();
        ReadableMapKeySetIterator it = paramsMap.keySetIterator();
        while (it.hasNextKey()) {
            String key = it.nextKey();
            customParameters.put(key, readableValueToObject(paramsMap, key));
        }

        MedalliaDigital.setCustomParameters(customParameters);
    }

    @ReactMethod
    public void setLogLevel(String logLevel) {
        if (TextUtils.isEmpty(logLevel)) {
            MedalliaDigital.setLogLevel(MDLogLevel.OFF);
        }

        MDLogLevel mdLogLevel = MDLogLevel.OFF;

        for (MDLogLevel level : MDLogLevel.values()) {
            if (level.toString().equals(logLevel)) {
                mdLogLevel = level;
                break;
            }
        }

        MedalliaDigital.setLogLevel(mdLogLevel);
    }

    @ReactMethod
    public void setFormCallback() {
        MedalliaDigital.setFormListener(new MDFormListener() {
            @Override
            public void onFormSubmitted(MDFormListenerData mdFormListenerData) {
                WritableMap payload = new WritableNativeMap();
                payload.putString("name", "onFormSubmitted");
                payload.putString("timestamp", String.valueOf(mdFormListenerData.getTimestamp()));
                payload.putString("engagementId", mdFormListenerData.getEngagementId());
                payload.putString("formTriggerType", mdFormListenerData.getFormTriggerType().toString());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setFormCallback", payload);
            }

            @Override
            public void onFormDismissed(MDFormListenerData mdFormListenerData) {
                WritableMap payload = new WritableNativeMap();
                payload.putString("name", "onFormDismissed");
                payload.putString("timestamp", String.valueOf(mdFormListenerData.getTimestamp()));
                payload.putString("engagementId", mdFormListenerData.getEngagementId());
                payload.putString("formTriggerType", mdFormListenerData.getFormTriggerType().toString());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setFormCallback", payload);
            }

            @Override
            public void onFormClosed(MDFormListenerData mdFormListenerData) {
                WritableMap payload = new WritableNativeMap();
                payload.putString("name", "onFormClosed");
                payload.putString("timestamp", String.valueOf(mdFormListenerData.getTimestamp()));
                payload.putString("engagementId", mdFormListenerData.getEngagementId());
                payload.putString("formTriggerType", mdFormListenerData.getFormTriggerType().toString());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setFormCallback", payload);
            }

            @Override
            public void onFormDisplayed(MDFormListenerData mdFormListenerData) {
                WritableMap payload = new WritableNativeMap();
                payload.putString("name", "onFormDisplayed");
                payload.putString("timestamp", String.valueOf(mdFormListenerData.getTimestamp()));
                payload.putString("engagementId", mdFormListenerData.getEngagementId());
                payload.putString("formTriggerType", mdFormListenerData.getFormTriggerType().toString());
                payload.putString("formLocaleSet", mdFormListenerData.getFormLocaleSet());
                payload.putString("formLocaleDisplay", mdFormListenerData.getFormLocaleDisplay());
                payload.putString("formHeaderAppearanceSet", mdFormListenerData.getFormHeaderAppearanceSet().toString());
                payload.putString("formHeaderAppearanceDisplay", mdFormListenerData.getFormHeaderAppearanceDisplay().toString());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setFormCallback", payload);
            }

            @Override
            public void onFormLinkSelected(MDFormListenerData mdFormListenerData) {
                WritableMap payload = new WritableNativeMap();
                payload.putString("name", "onFormLinkSelected");
                payload.putString("timestamp", String.valueOf(mdFormListenerData.getTimestamp()));
                payload.putString("engagementId", mdFormListenerData.getEngagementId());
                payload.putString("formTriggerType", mdFormListenerData.getFormTriggerType().toString());
                payload.putString("url", mdFormListenerData.getUrl());
                payload.putString("isBlocked", String.valueOf(mdFormListenerData.isBlocked()));

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setFormCallback", payload);
            }

            @Override
            public void onFormThankYouPrompt(MDFormListenerData mdFormListenerData) {

                WritableMap payload = new WritableNativeMap();
                payload.putString("name", "onFormThankYouPrompt");
                payload.putString("timestamp", String.valueOf(mdFormListenerData.getTimestamp()));
                payload.putString("engagementId", mdFormListenerData.getEngagementId());
                payload.putString("formTriggerType", mdFormListenerData.getFormTriggerType().toString());
                payload.putString("formHeaderAppearanceSet", mdFormListenerData.getFormHeaderAppearanceSet().toString());
                payload.putString("formHeaderAppearanceDisplay", mdFormListenerData.getFormHeaderAppearanceDisplay().toString());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setFormCallback", payload);
            }
        });
    }

    @ReactMethod
    public void setFeedbackCallback() {
        MedalliaDigital.setFeedbackListener(new MDFeedbackListener() {
            @Override
            public void onFeedbackSubmitted(MDFeedbackListenerData mdFeedbackListenerData) {
                WritableMap writableMap = new WritableNativeMap();
                writableMap.putString("name", "onFeedbackSubmitted");
                writableMap.putString("timestamp", String.valueOf(mdFeedbackListenerData.getTimestamp()));
                writableMap.putString("engagementId", mdFeedbackListenerData.getEngagementId());
                writableMap.putString("feedbackClientCorrelationId", mdFeedbackListenerData.getFeedbackClientCorrelationId());
                writableMap.putString("payload", mdFeedbackListenerData.getFeedbackPayload());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setFeedbackCallback", writableMap);
            }
        });
    }

    @ReactMethod
    public void setInterceptCallback() {
        MedalliaDigital.setInterceptListener(new MDInterceptListener() {
            @Override
            public void onInterceptDisplayed(MDInterceptListenerData mdInterceptListenerData) {
                WritableMap writableMap = new WritableNativeMap();
                writableMap.putString("name", "onInterceptDisplayed");
                writableMap.putString("timestamp", String.valueOf(mdInterceptListenerData.getTimestamp()));
                writableMap.putString("engagementId", mdInterceptListenerData.getEngagementId());
                writableMap.putString("engagementType", mdInterceptListenerData.getEngagementType().toString());
                writableMap.putString("formHeaderAppearanceSet", mdInterceptListenerData.getInterceptAppearanceSet().toString());
                writableMap.putString("formHeaderAppearanceDisplay", mdInterceptListenerData.getInterceptAppearanceDisplay().toString());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setInterceptCallback", writableMap);
            }

            @Override
            public void onInterceptAccepted(MDInterceptListenerData mdInterceptListenerData) {
                WritableMap writableMap = new WritableNativeMap();
                writableMap.putString("name", "onInterceptAccepted");
                writableMap.putString("timestamp", String.valueOf(mdInterceptListenerData.getTimestamp()));
                writableMap.putString("engagementId", mdInterceptListenerData.getEngagementId());
                writableMap.putString("engagementType", mdInterceptListenerData.getEngagementType().toString());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setInterceptCallback", writableMap);
            }

            @Override
            public void onInterceptDeclined(MDInterceptListenerData mdInterceptListenerData) {
                WritableMap writableMap = new WritableNativeMap();
                writableMap.putString("name", "onInterceptDeclined");
                writableMap.putString("timestamp", String.valueOf(mdInterceptListenerData.getTimestamp()));
                writableMap.putString("engagementId", mdInterceptListenerData.getEngagementId());
                writableMap.putString("engagementType", mdInterceptListenerData.getEngagementType().toString());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setInterceptCallback", writableMap);
            }

            @Override
            public void onInterceptDeferred(MDInterceptListenerData mdInterceptListenerData) {
                WritableMap writableMap = new WritableNativeMap();
                writableMap.putString("name", "onInterceptDeferred");
                writableMap.putString("timestamp", String.valueOf(mdInterceptListenerData.getTimestamp()));
                writableMap.putString("engagementId", mdInterceptListenerData.getEngagementId());
                writableMap.putString("engagementType", mdInterceptListenerData.getEngagementType().toString());
                writableMap.putString("reason", mdInterceptListenerData.getReason());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setInterceptCallback", writableMap);
            }

            @Override
            public void onInterceptClosed(MDInterceptListenerData mdInterceptListenerData) {
                WritableMap writableMap = new WritableNativeMap();
                writableMap.putString("name", "onInterceptClosed");
                writableMap.putString("timestamp", String.valueOf(mdInterceptListenerData.getTimestamp()));
                writableMap.putString("engagementId", mdInterceptListenerData.getEngagementId());
                writableMap.putString("engagementType", mdInterceptListenerData.getEngagementType().toString());
                writableMap.putString("reason", mdInterceptListenerData.getReason());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setInterceptCallback", writableMap);
            }

            @Override
            public void onInterceptTriggerInAppReview(MDInterceptListenerData mdInterceptListenerData) {
                WritableMap writableMap = new WritableNativeMap();
                writableMap.putString("name", "onInterceptTriggerInAppReview");
                writableMap.putString("timestamp", String.valueOf(mdInterceptListenerData.getTimestamp()));
                writableMap.putString("engagementId", mdInterceptListenerData.getEngagementId());

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setInterceptCallback", writableMap);
            }
        });

    }

    @ReactMethod
    public void setCustomInterceptCallback() {
        MedalliaDigital.setCustomInterceptListener(new MDCustomInterceptListener() {
            @Override
            public void onTargetEvaluationSuccess(MDCustomInterceptListenerData mdCustomInterceptData) {
                WritableMap writableMap = new WritableNativeMap();
                WritableMap payloadJson = new WritableNativeMap();

                writableMap.putString("name", "onTargetEvaluationSuccess");
                writableMap.putString("formPreloadTimestamp", String.valueOf(mdCustomInterceptData.getFormPreloadTimestamp()));
                writableMap.putString("targetingEvaluationTimestamp", String.valueOf(mdCustomInterceptData.getTargetingEvaluationTimestamp()));
                writableMap.putString("engagementId", mdCustomInterceptData.getEngagementId());
                writableMap.putString("engagementType", mdCustomInterceptData.getEngagementType().toString());

                payloadJson.putString("titleText", mdCustomInterceptData.getCustomInterceptPayload().getTitleText());
                payloadJson.putString("subtitleText", mdCustomInterceptData.getCustomInterceptPayload().getSubtitleText());
                payloadJson.putString("provideFeedbackText", mdCustomInterceptData.getCustomInterceptPayload().getProvideFeedbackText());
                payloadJson.putString("declineText", mdCustomInterceptData.getCustomInterceptPayload().getDeclineText());
                payloadJson.putString("deferText", mdCustomInterceptData.getCustomInterceptPayload().getDeferText());
                writableMap.putMap("payload", payloadJson);

                reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("setCustomInterceptCallback", writableMap);
            }
        });
    }

    @ReactMethod
    public void customInterceptTrigger(String engagementId, String actionType, final Promise promise) {
        MDInterceptActionType action = MDInterceptActionType.declined;
        switch(actionType.toUpperCase()) {
            case "ACCEPTED": {
                action = MDInterceptActionType.accepted;
                break;
            }
            case "SKIPPED": {
                action = MDInterceptActionType.skipped;
                break;
            }
            case "DEFERRED": {
                action = MDInterceptActionType.deferred;
                break;
            }
        }
        MedalliaDigital.customInterceptTrigger(engagementId, action,
                new MDFailureCallback() {
                    @Override
                    public void onError(MDExternalError mdExternalError) {
                        promise.reject(mdExternalError.getMessage());
                    }
                });
    }

    @ReactMethod
    public void enableIntercept() {
        MedalliaDigital.enableIntercept();
    }

    @ReactMethod
    public void disableIntercept() {
        MedalliaDigital.disableIntercept();
    }

    @ReactMethod
    public void setCustomAppearance(String appearance) {
        MDAppearanceMode mdAppearanceMode = MDAppearanceMode.unknown;

        switch(appearance.toUpperCase()) {
            case "LIGHT": {
                mdAppearanceMode = MDAppearanceMode.light;
                break;
            }
            case "DARK": {
                mdAppearanceMode = MDAppearanceMode.dark;
                break;
            }
        }
        MedalliaDigital.setCustomAppearance(mdAppearanceMode);
    }

    @ReactMethod
    public void setUserId(String userId) {
        MedalliaDigital.setUserId(userId);
    }

    @ReactMethod
    public void stopSDK(Boolean clearData) {
        if (clearData == null) {
            clearData = false;
        }

        MedalliaDigital.stopSDK(clearData);
    }

    @ReactMethod
    public void revertStopSDK() {
        MedalliaDigital.revertStopSDK();
    }

    private Object readableValueToObject(ReadableMap paramsMap, String key) {
        if (paramsMap == null || key == null) {
            return null;
        }
        ReadableType type = paramsMap.getType(key);
        Object value = null;

        switch (type) {
            case Boolean: {
                value = paramsMap.getBoolean(key);
                break;
            }
            case Number: {
                value = paramsMap.getInt(key);
                break;
            }
            case String: {
                value = paramsMap.getString(key);
                break;
            }
        }

        return value;
    }
}