//
//  FTFLoginView.h
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-20.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HATLoginViewDelegate <NSObject>

- (void) performLogin;

@end

@interface HATLoginView : UIView

@property (weak, nonatomic) id<HATLoginViewDelegate> delegate;

+ (id) view;
+ (id) viewWithFrame: (CGRect)frame andDelegate: (id<HATLoginViewDelegate>)delegate;
- (id) initWithFrame: (CGRect)frame andDelegate: (id<HATLoginViewDelegate>)delegate;

@end
