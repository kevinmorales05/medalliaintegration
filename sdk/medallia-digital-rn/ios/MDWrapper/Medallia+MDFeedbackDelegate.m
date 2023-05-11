//
//  Medallia+MDFeedbackDelegate.m
//
//  Created by Nir Lachman on 28/02/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "Medallia+MDFeedbackDelegate.h"

@implementation Medallia (MDFeedbackDelegate)

-(void)feedbackDidSubmitWithFeedbackDelegateData:(MDFeedbackDelegateData *)feedbackDelegateData {
    [self sendEventWithName:kSetFeedbackDelegate body:@{@"name" : @"onFeedbackSubmitted",
                                                        @"timestamp" : @([feedbackDelegateData timestamp]),
                                                        @"engagementId" : [feedbackDelegateData engagementId],
                                                        @"feedbackClientCorrelationId" : [feedbackDelegateData feedbackClientCorrelationId],
                                                        @"payload" : [feedbackDelegateData payload]}];
}

@end
