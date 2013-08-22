//
//  HATGameView.h
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-21.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol HATGameViewDelegate <NSObject>

- (void) endGameWithHushTotal: (int)hushTotal andScore: (int)score;

@end

@interface HATGameView : UIView <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) id<HATGameViewDelegate>delegate;
@property (nonatomic) int hushTotal;
@property (nonatomic) int score;
@property (nonatomic) BOOL shouldPromptSearch;

+ (id) viewWithFrame: (CGRect)frame withDelegate: (id<HATGameViewDelegate>)delegate andShouldPromptSearch: (BOOL)shouldPromptSearch;
- (id) initWithFrame: (CGRect)frame withDelegate: (id<HATGameViewDelegate>)delegate andShouldPromptSearch: (BOOL)shouldPromptSearch;

@end
