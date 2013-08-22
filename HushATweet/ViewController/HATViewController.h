//
//  FTFViewController.h
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-20.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHSTwitterEngine.h"
#import "HATLoginView.h"
#import "HATLaunchView.h"
#import "HATGameView.h"
#import "HATResultsView.h"

@interface HATViewController : UIViewController <HATLoginViewDelegate, HATLaunchViewDelegate, HATGameViewDelegate>

@end
