//
//  Medallia.m
//  LightApp
//
//  Created by Nir Lachman on 25/02/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "Medallia.h"
#import "Medallia+MDFormDelegate.h"
#import "Medallia+MDFeedbackDelegate.h"
#import "Medallia+MDInterceptDelegate.h"
#import "Medallia+MDCustomInterceptDelegate.h"

@implementation Medallia
RCT_EXPORT_MODULE(MedalliaDigitalModule)
NSString *const kSetFormDelegate = @"setFormCallback";
NSString *const kSetFeedbackDelegate = @"setFeedbackCallback";
NSString *const kSetInterceptDelegate = @"setInterceptCallback";
NSString *const kSetCustomInterceptDelegate = @"setCustomInterceptCallback";

#pragma mark - LifeCycle
+ (Medallia *)sharedInstance {
  static dispatch_once_t onceToken;
  static Medallia *instance;
  dispatch_once(&onceToken, ^{
    instance = [[Medallia alloc] init];
  });
  return instance;
}

- (void)sendEventWithName:(NSString *)name body:(id)body {
  // check if hasListeners
  [super sendEventWithName:name body:body];
}

- (NSArray<NSString *> *)supportedEvents {
  return @[kSetFormDelegate, kSetFeedbackDelegate, kSetInterceptDelegate, kSetCustomInterceptDelegate];
}

#pragma mark - SDK API
RCT_REMAP_METHOD(initialize, initialize:(NSString *)token resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  [MedalliaDigital setSdkFramework:MDSDKFrameworkTypeReactNative];
  [MedalliaDigital sdkInitWithToken:token success:^{
    resolve(@[@"Init success"]);
  } failure:^(MDExternalError * _Nonnull mdError) {
    NSError *error = [self getErrorFromMDExternalError:mdError];
    reject(@"INIT SDK ERROR", mdError.message, error);
  }];
}

RCT_REMAP_METHOD(showForm, showForm:(NSString *)formId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  [MedalliaDigital showForm:formId success:^{
    resolve(@[@"Show Form success"]);
  } failure:^(MDExternalError * _Nonnull mdError) {
    NSError *error = [self getErrorFromMDExternalError:mdError];
    reject(@"SHOW FORM SDK ERROR", mdError.message, error);
  }];
}

RCT_EXPORT_METHOD(setCustomParameters: (NSDictionary *)parameters) {
  [MedalliaDigital setCustomParameters:parameters];
}

RCT_REMAP_METHOD(handleNotification, handleNotification: (NSString *)formId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  [MedalliaDigital handleNotification:formId success:^{
    resolve(@[@"Handle Notification success"]);
  } failure:^(MDExternalError * _Nonnull mdError) {
    NSError *error = [self getErrorFromMDExternalError:mdError];
    reject(@"HANDLE NOTIFICATION ERROR", mdError.message, error);
  }];
}

#pragma mark - SDK API
RCT_REMAP_METHOD(updateCustomLocale, updateCustomLocale:(NSString *)locale resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [MedalliaDigital updateCustomLocale:locale success:^(NSString * _Nonnull message){
        if (message == nil) {
            resolve(@[@"Update Custom Locale success: %@"]);
        } else {
            resolve(@[message]);
        }
    } failure:^(MDExternalError * _Nonnull mdError) {
        NSError *error = [self getErrorFromMDExternalError:mdError];
        reject(@"UPDATE CUSTOM LOCALE ERROR", mdError.message, error);
    }];
}

RCT_EXPORT_METHOD(enableIntercept) {
  [MedalliaDigital enableIntercept];
}

RCT_EXPORT_METHOD(disableIntercept) {
  [MedalliaDigital disableIntercept];
}

RCT_EXPORT_METHOD(stopSDK: (BOOL) clearData) {
  if (clearData == nil) {
    clearData = NO;
  }

  [MedalliaDigital stopSDKWithClearData:clearData];
}

RCT_EXPORT_METHOD(revertStopSDK) {
  [MedalliaDigital revertStopSDK];
}

RCT_EXPORT_METHOD(setLogLevel: (NSString *)logLevelString) {
    MDLogLevel logLevel = MDLogLevelOff;
    if ([logLevelString isEqualToString:@"FATAL"]) {
        logLevel = MDLogLevelFatal;
    } else if ([logLevelString isEqualToString:@"ERROR"]) {
        logLevel = MDLogLevelError;
    } else if ([logLevelString isEqualToString:@"WARN"]) {
        logLevel = MDLogLevelWarn;
    } else if ([logLevelString isEqualToString:@"INFO"]) {
        logLevel = MDLogLevelInfo;
    } else if ([logLevelString isEqualToString:@"DEBUG"]) {
        logLevel = MDLogLevelDebug;
    }
    [MedalliaDigital setLogLevel: logLevel];
}

RCT_REMAP_METHOD(customInterceptTrigger, customInterceptTrigger:(NSString *)engagementId actionType:(NSString *)actionTypeString resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    MDInterceptActionType actionType = MDInterceptActionTypeDeclined;
    if ([actionTypeString.uppercaseString isEqualToString:@"ACCEPTED"]) {
        actionType = MDInterceptActionTypeAccepted;
    } else if ([actionTypeString.uppercaseString isEqualToString:@"SKIPPED"]) {
        actionType = MDInterceptActionTypeSkipped;
    } else if ([actionTypeString.uppercaseString isEqualToString:@"DEFERRED"]) {
        actionType = MDInterceptActionTypeDeferred;
    }

    [MedalliaDigital customInterceptTriggerWithEngagementId:engagementId actionType:actionType failure:^(MDExternalError * _Nonnull mdError) {
        NSError *error = [self getErrorFromMDExternalError:mdError];
        reject(@"CUSTOM INTERCEPT TRIGGER ERROR" , mdError.message, error);
    }];
}

RCT_EXPORT_METHOD(setCustomAppearance: (NSString *)appearanceMode) {
    MDAppearanceMode appearanceModeType = MDAppearanceModeUnknown;
    if ([appearanceMode.uppercaseString isEqualToString:@"DARK"]) {
        appearanceModeType = MDAppearanceModeDark;
    } else if ([appearanceMode.uppercaseString isEqualToString:@"LIGHT"]) {
        appearanceModeType = MDAppearanceModeLight;
    }
    [MedalliaDigital setCustomAppearance: appearanceModeType];
}

RCT_EXPORT_METHOD(setDebugForm: (BOOL)debug) {
    [MedalliaDigital setDebugForm: debug];
}

RCT_REMAP_METHOD(closeEngagement, resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [MedalliaDigital closeEngagementWithSuccess:^{
        resolve(@[@"Close Engagement success"]);
    } failure:^(MDExternalError * _Nonnull mdError) {
        NSError *error = [self getErrorFromMDExternalError:mdError];
        reject(@"CLOSE ENGAGEMENT SDK ERROR", mdError.message, error);
    }];
}

RCT_EXPORT_METHOD(setUserId: (NSString *)userId) {
    [MedalliaDigital setUserId: userId];
}

#pragma mark - SDK Callbacks API
RCT_EXPORT_METHOD(setFormCallback) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MedalliaDigital setFormDelegate:self];
    });
}

RCT_EXPORT_METHOD(setInterceptCallback) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MedalliaDigital setInterceptDelegate:self];
    });
}

RCT_EXPORT_METHOD(setFeedbackCallback) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MedalliaDigital setFeedbackDelegate:self];
    });
}

RCT_EXPORT_METHOD(setCustomInterceptCallback) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MedalliaDigital setCustomInterceptDelegate:self];
    });
}

#pragma mark - Helper
 - (NSError *)getErrorFromMDExternalError: (MDExternalError *)error {
   return [NSError errorWithDomain:@"com.medallia.digital"
                              code:error.statusCode
                          userInfo:@{@"message" : error.message}];
 }

@end
