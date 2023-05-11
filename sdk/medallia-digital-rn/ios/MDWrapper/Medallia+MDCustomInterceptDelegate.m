//
//  Medallia+MDCustomInterceptDelegate.m
//  medallia-digital-rn
//
//  Created by Ori Sarig on 23/11/2020.
//

#import "Medallia+MDCustomInterceptDelegate.h"

@implementation Medallia (MDCustomInterceptDelegate)

-(void)targetEvaluationDidSuccessWithCustomInterceptDelegateData:(MDCustomInterceptDelegateData *)customInterceptDelegateData {
    NSNumber *formPreloadTimeStamp = [NSNumber numberWithDouble: [customInterceptDelegateData formPreloadTimestamp]];
    NSNumber *targetingEvaluationTimeStamp = [NSNumber numberWithDouble: [customInterceptDelegateData targetingEvaluationTimestamp]];
    NSString *type = [customInterceptDelegateData engagementType] == MDEngagementTypeForm ? @"form" : @"appRating" ;
    MDCustomInterceptPayload *payload = [customInterceptDelegateData payload];
    NSDictionary *payLoad = @{@"titleText": [payload titleText],
                              @"subtitleText": [payload subtitleText],
                              @"provideFeedbackText": [payload provideFeedbackText],
                              @"deferText": [payload deferText],
                              @"declineText": [payload declineText],
    };
    
    NSDictionary *parameters =  @{@"name" : @"onTargetEvaluationSuccess",
                                  @"formPreloadTimestamp": formPreloadTimeStamp,
                                  @"targetingEvaluationTimestamp": targetingEvaluationTimeStamp,
                                  @"engagementId": [customInterceptDelegateData engagementId],
                                  @"engagementType": type,
                                  @"payload": payLoad
    };
    [self sendEventWithName:kSetCustomInterceptDelegate body:parameters];
}

@end
