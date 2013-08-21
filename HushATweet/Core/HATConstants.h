//
//  HATConstants.h
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-21.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#ifndef HushATweet_HATConstants_h
#define HushATweet_HATConstants_h

#pragma mark - Twitter credentials

#define CONSUMER_KEY @"6wDbeb0FVvf9OGdBsuBeng"
#define CONSUMER_SECRET @"XzWbnYzTDRcUtITrOSX383CMZkDMUE1ALywYKHsaQ"

#pragma mark - Thread retrieval

#define GCDMainThread dispatch_get_main_queue()
#define GCDBackgroundThread_High GCDBackgroundThreadWithPriority( DISPATCH_QUEUE_PRIORITY_HIGH )
#define GCDBackgroundThread_Default GCDBackgroundThreadWithPriority( DISPATCH_QUEUE_PRIORITY_DEFAULT )
#define GCDBackgroundThreadWithPriority( $priority ) dispatch_get_global_queue( $priority , 0 )

#endif
