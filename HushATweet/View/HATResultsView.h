//
//  HATResultsView.h
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-22.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HATResultsViewDelegate <NSObject>


@end

@interface HATResultsView : UIView

@property (weak, nonatomic) id<HATResultsViewDelegate> delegate;

+ (id) viewWithFrame: (CGRect)frame andDelegate: (id<HATResultsViewDelegate>)delegate withHushTotal: (int)hushTotal andScore: (int)score;
- (id) initWithFrame: (CGRect)frame andDelegate: (id<HATResultsViewDelegate>)delegate withHushTotal: (int)hushTotal andScore: (int)score;

@end
