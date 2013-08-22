//
//  HATMapPinAnnotation.m
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-22.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import "HATMapPinAnnotation.h"
#import "HATAnnotation.h"
@implementation HATMapPinAnnotation
{
    NSString *profileImageUrl;
}

#pragma mark - Synthesized properties

@synthesize tweet = _tweet;
@synthesize delegate = _delegate;

#pragma mark - Dynamic properties

@dynamic profileImageUrl;
- (NSString *) profileImageUrl
{
    if( profileImageUrl == nil ) {
        
        if( self.tweet ) {
        
            NSDictionary * user = [self.tweet objectForKey: @"user"];
            if( user ) {
                profileImageUrl = [user objectForKey: @"profile_image_url"];
            }
            
        }
        
    }
    
    return profileImageUrl;
}

#pragma mark - MKAnnotationView methods

- (void) setAnnotation: (id<MKAnnotation>)annotation
{
    self.tweet = ((HATAnnotation *)annotation).tweet;
    self.image = nil;
    
    NSURL *url = [NSURL URLWithString: self.profileImageUrl];
    NSData *data = [NSData dataWithContentsOfURL: url];
    self.image = [[UIImage alloc] initWithData: data];
    
    [self sizeToFit];
    [self.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.layer setBorderWidth: 5.0];
    
    self.tweet = ((HATAnnotation *)annotation).tweet;
    [super setAnnotation: annotation];
}

@end
