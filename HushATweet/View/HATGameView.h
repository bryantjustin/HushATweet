//
//  HATGameView.h
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-21.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HATGameView : UIView <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic) int hushTotal;
@property (nonatomic) int score;
@property (nonatomic) BOOL shouldPromptSearch;

+ (id) viewWithFrame: (CGRect)frame andShouldPromptSearch: (BOOL)shouldPromptSearch;
- (id) initWithFrame: (CGRect)frame andShouldPromptSearch: (BOOL)shouldPromptSearch;

@end
