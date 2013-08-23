//
//  HATAnnotation.m
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-22.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import "HATAnnotation.h"

@implementation HATAnnotation

@synthesize tweet = _tweet;
@synthesize coordinate = _coordinate;

+ (id) annotationWithTweet: (NSDictionary *)tweet andCoordinate: (CLLocationCoordinate2D)coordinate
{
    return [[self alloc] initWithTweet: tweet andCoordinate: coordinate];
}

- (id) initWithTweet: (NSDictionary *)tweet andCoordinate: (CLLocationCoordinate2D )coordinate
{
    self = [super init];
    if( self ) {
        _tweet = tweet;
        _coordinate = coordinate;
    }
    
    return self;
}

@end
