//
//  Medallia+MDFormDelegate.m
//
//  Created by Nir Lachman on 27/02/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "Medallia+MDFormDelegate.h"

@implementation Medallia (MDFormDelegate)

-(void)formDidSubmitWithFormDelegateData:(MDFormDelegateData *)formDelegateData {
    [self sendEventWithName:kSetFormDelegate body:@{@"name" : @"onFormSubmitted",
                                                    @"timestamp" : @([formDelegateData timestamp]),
                                                    @"formId" : [formDelegateData engagementId],
                                                    @"formTriggerType" : @([formDelegateData formTriggerType])}];
}

- (void)formDidDismissWithFormDelegateData:(MDFormDelegateData *)formDelegateData {
    [self sendEventWithName:kSetFormDelegate body:@{@"name" : @"onFormDismissed",
                                                    @"timestamp" : @([formDelegateData timestamp]),
                                                    @"formId" : [formDelegateData engagementId],
                                                    @"formTriggerType" : @([formDelegateData formTriggerType])}];
}

- (void)formDidCloseWithFormDelegateData:(MDFormDelegateData *)formDelegateData {
    [self sendEventWithName:kSetFormDelegate body:@{@"name" : @"onFormClosed",
                                                    @"timestamp" : @([formDelegateData timestamp]),
                                                    @"formId" : [formDelegateData engagementId],
                                                    @"formTriggerType" : @([formDelegateData formTriggerType])}];
}

- (void)formDidDisplayWithFormDelegateData:(MDFormDelegateData *)formDelegateData {
    NSString *appearanceSet = [formDelegateData formHeaderAppearanceSet] == MDAppearanceModeDark ? @"dark" : [formDelegateData formHeaderAppearanceSet] == MDAppearanceModeLight ? @"light" :  @"unknown";
    NSString *appearanceDisplay = [formDelegateData formHeaderAppearanceDisplay] == MDAppearanceModeDark ? @"dark" : [formDelegateData formHeaderAppearanceDisplay] == MDAppearanceModeLight ? @"light" :  @"unknown";
    [self sendEventWithName:kSetFormDelegate body:@{@"name" : @"onFormDisplayed",
                                                    @"timestamp" : @([formDelegateData timestamp]),
                                                    @"formId" : [formDelegateData engagementId],
                                                    @"formTriggerType" : @([formDelegateData formTriggerType]),
                                                    @"formLocaleSet" : [formDelegateData formLocaleSet] != nil ? [formDelegateData formLocaleSet] : @"",
                                                    @"formLocaleDisplay" : [formDelegateData formLocaleDisplay] != nil ?[formDelegateData formLocaleDisplay] : @"",
                                                    @"appearanceSet" : appearanceSet,
                                                    @"appearanceDisplay" : appearanceDisplay}];
}

- (void)formDidBlockExternalUrlWithFormDelegateData:(MDFormDelegateData *)formDelegateData {
    [self sendEventWithName:kSetFormDelegate body:@{@"name" : @"onFormExternalUrlBlocked",
                                                    @"timestamp" : @([formDelegateData timestamp]),
                                                    @"formId" : [formDelegateData engagementId],
                                                    @"formTriggerType" : @([formDelegateData formTriggerType]),
                                                    @"blockedUrl" : [formDelegateData url]}];
}

- (void)formDidLinkSelectWithFormDelegateData:(MDFormDelegateData *)formDelegateData {
    [self sendEventWithName:kSetFormDelegate body:@{@"name" : @"onFormLinkSelected",
                                                    @"timestamp" : @([formDelegateData timestamp]),
                                                    @"formId" : [formDelegateData engagementId],
                                                    @"formTriggerType" : @([formDelegateData formTriggerType]),
                                                    @"url" : [formDelegateData url],
                                                    @"isBlocked" : @([formDelegateData isBlocked])}]; 
}

-(void)formDidThankYouPromptWithFormDelegateData:(MDFormDelegateData *)formDelegateData {
    NSString *appearanceSet = [formDelegateData formHeaderAppearanceSet] == MDAppearanceModeDark ? @"dark" : [formDelegateData formHeaderAppearanceSet] == MDAppearanceModeLight ? @"light" :  @"unknown";
    NSString *appearanceDisplay = [formDelegateData formHeaderAppearanceDisplay] == MDAppearanceModeDark ? @"dark" : [formDelegateData formHeaderAppearanceDisplay] == MDAppearanceModeLight ? @"light" :  @"unknown";
    [self sendEventWithName:kSetFormDelegate body:@{@"name" : @"onFormThankYouPrompt",
                                                    @"timestamp" : @([formDelegateData timestamp]),
                                                    @"formId" : [formDelegateData engagementId],
                                                    @"formTriggerType" : @([formDelegateData formTriggerType]),
                                                    @"appearanceSet" : appearanceSet,
                                                    @"appearanceDisplay" : appearanceDisplay}];

}

@end
