//
//  HATMapPinAnnotation.h
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-22.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol HATMapPinDelegate <NSObject>

- recordTouchedPinForTweet: (NSDictionary *)tweet;

@end

@interface HATMapPinAnnotationView : MKAnnotationView

@property (weak, nonatomic) id<HATMapPinDelegate> delegate;
@property (weak, nonatomic) NSDictionary *tweet;
@property (readonly, nonatomic) NSString *profileImageUrl;

@end
