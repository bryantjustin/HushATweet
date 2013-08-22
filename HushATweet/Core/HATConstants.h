//
//  HATConstants.h
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-21.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#ifndef HushATweet_HATConstants_h
#define HushATweet_HATConstants_h

#pragma mark - Feature flags

#define FEATURE_FLAG_USE_CURRENT_LOCATION NO

#pragma mark - Twitter credentials

#define CONSUMER_KEY @"6wDbeb0FVvf9OGdBsuBeng"
#define CONSUMER_SECRET @"XzWbnYzTDRcUtITrOSX383CMZkDMUE1ALywYKHsaQ"

#pragma mark - Twitter query constants

#define QUERY_DEFAULT_GEOCODE @"46.0730555556,-100.546666667,3957mi" // This is the middle of North America, somewhere in North Dakota. Use the half the diameter of th earth as radius, it'll be overkill.
#define QUERY_DEFAULT_WOEID @"1"
#define QUERY_SEARCH_COUNT 100

#pragma mark - Game engine

#define GAME_ENGINE_ANNOTATION_SPAWN_RATE 1.5f
#define GAME_ENGINE_ANNOTATION_LIFE_SPAN 4.0f

#pragma mark - Thread retrieval

#define GCDMainThread dispatch_get_main_queue()
#define GCDBackgroundThread_High GCDBackgroundThreadWithPriority( DISPATCH_QUEUE_PRIORITY_HIGH )
#define GCDBackgroundThread_Default GCDBackgroundThreadWithPriority( DISPATCH_QUEUE_PRIORITY_DEFAULT )
#define GCDBackgroundThreadWithPriority( $priority ) dispatch_get_global_queue( $priority , 0 )

#pragma mark - Fonts

#define FONT_FAMILY_HELVETICA_BOLD @"Helvetica-Bold"
#define FONT_SIZE_BUTTON 18
#define FONT_SIZE_SCORE 18
#define FONT_SIZE_HUSH_TOTAL 28
#define FONT_SIZE_TOPIC 14

#endif
