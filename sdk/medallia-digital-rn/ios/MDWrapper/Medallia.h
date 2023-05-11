//
//  Medallia.h
//  LightApp
//
//  Created by Nir Lachman on 25/02/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import <React/RCTEventEmitter.h>
#import "MedalliaDigitalSDK-Swift.h"
#import <MedalliaDigitalSDK-Swift.h>
#import <MedalliaDigitalSDK/MedalliaDigitalSDK-Swift.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kSetFormDelegate;
extern NSString *const kSetFeedbackDelegate;
extern NSString *const kSetInterceptDelegate;
extern NSString *const kSetCustomInterceptDelegate; 

@interface Medallia : RCTEventEmitter <RCTBridgeModule>
+ (Medallia *)sharedInstance;
@end

NS_ASSUME_NONNULL_END
