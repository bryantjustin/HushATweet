//
//  HATAnnotation.h
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-22.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HATAnnotation : NSObject <MKAnnotation>

@property (strong, readonly, nonatomic) NSDictionary *tweet;
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;

+ (id) annotationWithTweet: (NSDictionary *)tweet andCoordinate: (CLLocationCoordinate2D )coordinate;
- (id) initWithTweet:(NSDictionary *)tweet andCoordinate: (CLLocationCoordinate2D )coordinate;


@end
