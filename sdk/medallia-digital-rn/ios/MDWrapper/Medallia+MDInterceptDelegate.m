//
//  Medallia+MDInterceptV3Delegate.m


#import "Medallia+MDInterceptDelegate.h"

@implementation Medallia (MDInterceptDelegate)

-(void)interceptDidDisplayWithInterceptDelegateData:(MDInterceptDelegateData *)interceptDelegateData {
    NSString *type = [interceptDelegateData engagementType] == MDEngagementTypeForm ? @"form" : @"appRating";
    NSString *appearanceSet = [interceptDelegateData appearanceSet] == MDAppearanceModeDark ? @"dark" : [interceptDelegateData appearanceSet] == MDAppearanceModeLight ? @"light" :  @"unknown";
    NSString *appearanceDisplay = [interceptDelegateData appearanceDisplay] == MDAppearanceModeDark ? @"dark" : [interceptDelegateData appearanceDisplay] == MDAppearanceModeLight ? @"light" :  @"unknown";
    [self sendEventWithName:kSetInterceptDelegate body:@{@"name" : @"onInterceptDisplayed",
                                                         @"timestamp" : @([interceptDelegateData timestamp]),
                                                         @"engagementId" : [interceptDelegateData engagementId],
                                                         @"engagementType" : type,
                                                         @"appearanceSet" : appearanceSet,
                                                         @"appearanceDisplay" : appearanceDisplay}];

}

- (void) interceptDidAcceptWithInterceptDelegateData:(MDInterceptDelegateData *)interceptDelegateData {
    NSString *type = [interceptDelegateData engagementType] == MDEngagementTypeForm ? @"form" : @"appRating";
    [self sendEventWithName:kSetInterceptDelegate body:@{@"name" : @"onInterceptAccepted",
                                                         @"timestamp" : @([interceptDelegateData timestamp]),
                                                         @"engagementId" : [interceptDelegateData engagementId],
                                                         @"engagementType" : type}];
}

- (void)interceptDidDeclineWithInterceptDelegateData:(MDInterceptDelegateData *)interceptDelegateData {
    NSString *type = [interceptDelegateData engagementType] == MDEngagementTypeForm ? @"form" : @"appRating";
    [self sendEventWithName:kSetInterceptDelegate body:@{@"name" : @"onInterceptDeclined",
                                                         @"timestamp" : @([interceptDelegateData timestamp]),
                                                         @"engagementId" : [interceptDelegateData engagementId],
                                                         @"engagementType" : type}];
}

- (void)interceptDidDeferWithInterceptDelegateData:(MDInterceptDelegateData *)interceptDelegateData {
    NSString *type = [interceptDelegateData engagementType] == MDEngagementTypeForm ? @"form" : @"appRating";
    [self sendEventWithName:kSetInterceptDelegate body:@{@"name" : @"onInterceptDeferred",
                                                         @"timestamp" : @([interceptDelegateData timestamp]),
                                                         @"engagementId" : [interceptDelegateData engagementId],
                                                         @"engagementType" : type}];
}

- (void)interceptDidCloseWithInterceptDelegateData:(MDInterceptDelegateData *)interceptDelegateData {
    NSString *type = [interceptDelegateData engagementType] == MDEngagementTypeForm ? @"form" : @"appRating";
    [self sendEventWithName:kSetInterceptDelegate body:@{@"name" : @"onInterceptClosed",
                                                         @"timestamp" : @([interceptDelegateData timestamp]),
                                                         @"engagementId" : [interceptDelegateData engagementId],
                                                         @"engagementType" : type}];
}

- (void)interceptDidTriggerSKStoreReviewControllerWithInterceptDelegateData:(MDInterceptDelegateData *)interceptDelegateData {
    [self sendEventWithName:kSetInterceptDelegate body:@{@"name" : @"onInterceptTriggerInAppReview",
                                                         @"timestamp" : @([interceptDelegateData timestamp]),
                                                         @"engagementId" : [interceptDelegateData engagementId]}];
}


@end
