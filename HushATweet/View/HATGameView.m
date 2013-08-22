//
//  HATGameView.m
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-21.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import "HATGameView.h"

#import "OAMutableURLRequest.h"
#import "OARequestParameter.h"

#import "HATAnnotation.h"
#import "HATMapPinAnnotationView.h"

#pragma mark - Layout constants

#define HUD_PADDING 10
#define TOPIC_HEIGHT 60

#pragma mark -

@implementation HATGameView
{
    // UI components
    
    MKMapView *mapView;
    UILabel *hushTotalView;
    UILabel *scoreView;
    UILabel *topicView;
    
    // Data objects
    
    NSArray *geocodedStatuses;
    
    // Utility objects & components
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    int hushTotal;
    int score;
}

#pragma mark - Synthesized properties

@synthesize delegate = _delegate;
@synthesize shouldPromptSearch = _shouldPromptSearch;

#pragma mark - Dynamic properties

@dynamic hushTotal;
- (void) setHushTotal: (int)value
{
    hushTotal = value;
    if( hushTotalView ) {
        
        [hushTotalView setText: [NSString stringWithFormat: @"%d", hushTotal]];
        [hushTotalView sizeToFit];
        [self setNeedsLayout];

    }
}
- (int) hushTotal
{
    return hushTotal;
}

@dynamic score;
- (void) setScore: (int)value
{
    score = value;
    if( scoreView ) {
        
        [scoreView setText: [NSString stringWithFormat: @"%d", score]];
        [scoreView sizeToFit];
        [self setNeedsLayout];
        
    }
}
- (int) score
{
    return score;
}

#pragma mark - Constructors & Initializers

#pragma mark Convenience constructors

+ (id) viewWithFrame: (CGRect)frame withDelegate: (id<HATGameViewDelegate>)delegate andShouldPromptSearch: (BOOL)shouldPromptSearch
{
    return [[self alloc] initWithFrame: frame withDelegate: delegate andShouldPromptSearch: shouldPromptSearch];
}

#pragma mark Initializers

- (id) initWithFrame: (CGRect)frame withDelegate:(id<HATGameViewDelegate>)delegate andShouldPromptSearch: (BOOL)shouldPromptSearch;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = delegate;
        self.shouldPromptSearch = shouldPromptSearch;
        
        [self initMapView];
        [self initLocationManager];
        if( shouldPromptSearch ) {
            [self initSearchField];
        } else {
            [self initTrendingData];
        }
        
        [self initHushTotalView];
        [self initScoreView];
        [self initTopicView];
    }
    
    return self;
}

- (void) initMapView
{
    mapView = [[MKMapView alloc] initWithFrame: self.frame];
    mapView.delegate = self;
    mapView.mapType = MKMapTypeStandard;
    
    [self addSubview: mapView];
}

- (void) initLocationManager
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if( FEATURE_FLAG_USE_CURRENT_LOCATION ) {
        [locationManager startUpdatingLocation];
    }
}

- (void) initSearchField
{
    
}

- (void) initHushTotalView
{
    hushTotalView = [[UILabel alloc] init];
    hushTotalView.text = @"0";
    [hushTotalView setFont: [UIFont fontWithName: FONT_FAMILY_HELVETICA_BOLD size: FONT_SIZE_HUSH_TOTAL]];
    [hushTotalView setTextColor: [UIColor blackColor]];
    [hushTotalView setTextAlignment: NSTextAlignmentRight];
    [hushTotalView sizeToFit];
    
    [self addSubview: hushTotalView];
}

- (void) initScoreView
{
    scoreView = [[UILabel alloc] init];
    scoreView.text = @"0";
    [scoreView setFont: [UIFont fontWithName: FONT_FAMILY_HELVETICA_BOLD size: FONT_SIZE_SCORE]];
    [scoreView setTextColor: [UIColor blackColor]];
    [scoreView setTextAlignment: NSTextAlignmentRight];
    [scoreView sizeToFit];
    
    [self addSubview: scoreView];
}

- (void) initTopicView
{
    topicView = [[UILabel alloc] init];
    [topicView setFont: [UIFont fontWithName: FONT_FAMILY_HELVETICA_BOLD size: FONT_SIZE_TOPIC]];
    [topicView setTextColor: [UIColor whiteColor]];
    [topicView setBackgroundColor: [UIColor blackColor]];
    [topicView setTextAlignment: NSTextAlignmentCenter];
    [topicView setText: @""];
    [topicView setNeedsLayout];
    
    [self addSubview: topicView];
}

#pragma mark Data initialization

- (void) initTrendingData
{
    [self initTrendingData: nil];
}

- (void) initTrendingData: (NSString *)woeid
{
    if( woeid == nil ) {
        woeid = QUERY_DEFAULT_WOEID;
    }
    
    // Fetch trending data and pick randomly from the returned list.
    
    if( [[FHSTwitterEngine sharedEngine] isAuthorized] ) {
        dispatch_async( GCDBackgroundThread_Default, ^{
            @autoreleasepool {
                
                id trendingData = [[FHSTwitterEngine sharedEngine] getTrendsForLocation: woeid];
                if( [trendingData isKindOfClass: [NSError class]]) {
                    [self performSelector: @selector( onFetchTrendingDataFailed ) onThread: [NSThread mainThread] withObject: self waitUntilDone: NO];
                    return;
                }
                
                dispatch_sync( GCDMainThread, ^{
                    @autoreleasepool {
                        [self onFetchTrendingDataComplete: trendingData];
                    }
                });
            }
        });
    } else {
        
        NSLog( @"WARNING: User is not authenticated. Trending data cannot be fetched." );
        
    }
}

- (void) onFetchTrendingDataComplete: (NSArray *)trendingData
{
    NSDictionary *trendingTopic = [self selectTrendingTopicFromTrendList: trendingData];
    NSString *query = [trendingTopic objectForKey: @"query"];
    
    [topicView setText: [trendingTopic objectForKey: @"name"]];
    [topicView setNeedsLayout];
    
    [self initStatusListFromQuery: query];
}

- (void) onFetchTrendingDataFailed
{
    NSLog( @"ERROR: Trending data could not be retrieved." );
}

- (void) initStatusListFromQuery: (NSString *)query
{
    if( [[FHSTwitterEngine sharedEngine] isAuthorized] ) {
        dispatch_async( GCDBackgroundThread_Default, ^{
            @autoreleasepool {
                
                id searchResults = [[FHSTwitterEngine sharedEngine] searchTweetsWithQuery: query count: QUERY_SEARCH_COUNT resultType: FHSTwitterEngineResultTypeRecent until: [NSDate date] sinceID: nil maxID: nil fromLocation: QUERY_DEFAULT_GEOCODE];
                if( [searchResults isKindOfClass: [NSError class]]) {
                    [self performSelector: @selector( onSearchDataFailed ) onThread: [NSThread mainThread] withObject: self waitUntilDone: NO];
                    return;
                }
                
                dispatch_sync( GCDMainThread, ^{
                    @autoreleasepool {
                        [self onSearchDataComplete: searchResults];
                    }
                });
            }
        });
        
    } else {
        
        NSLog( @"WARNING: User is not authenticated. Search query cannot be performed." );
        
    }
}

- (void) onSearchDataFailed
{
    NSLog( @"ERROR: Search query was not successful." );
}

- (void) onSearchDataComplete: (NSDictionary *)searchData
{
    NSArray  *statuses = [searchData objectForKey: @"statuses"];
    NSLog( @"statuses = %@", statuses );
    
    geocodedStatuses = statuses; //[self filterForGeocodedStatuses: statuses];
    
    NSLog( @"geo filtered length = %d", geocodedStatuses.count );
    [self startPlacingAnnotations];
    
}

#pragma mark - Map Annotation rendering methods

- (void) startPlacingAnnotations
{
    if( geocodedStatuses.count > 0 ) {
        
        [self placeAnnotationFrom: [NSMutableArray arrayWithArray: geocodedStatuses]];
    
    } else {
        
        // TODO: If no geocoded tweets were found, try a different trending topic.
        
        NSLog( @"WARN: No geocoded tweets were found. Try a different trending topic." );
        
    }
}
                              
- (void) placeAnnotationFrom: (NSMutableArray *)annotations
{
    NSDictionary *tweet = [annotations lastObject];
    [annotations removeLastObject];
    
    
    
    // Try pulling geo coordinates.
    
    id geo = [tweet objectForKey: @"geo"];
    
    if( [geo isKindOfClass: [NSDictionary class]] ) {
        
        NSArray *coordinates = [((NSDictionary *)geo) objectForKey: @"coordinates"];
        HATAnnotation *point = [self placeAnnotationWithTweet: tweet andCoordinates: CLLocationCoordinate2DMake( [[coordinates objectAtIndex: 0] floatValue], [[coordinates objectAtIndex: 1] floatValue] )];
        [self finishPlacingAnnotationFrom: annotations withAnnotiationPoint: point];
    
    // If none is found, use geo coder to query using text string from location of user.
        
    } else {
        
        NSDictionary *user = [tweet objectForKey: @"user"];
        NSString *location = [user objectForKey: @"location"];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        
        [geocoder geocodeAddressString: location completionHandler: ^(NSArray *placemarks, NSError *error) {
            
            HATAnnotation *point = nil;
            if( placemarks > 0 ) {
                    
                CLPlacemark *placemark = [placemarks lastObject];
                point = [self placeAnnotationWithTweet: tweet andCoordinates: placemark.region.center];
            
            } else {
            
                NSLog( @"WARNING: No placemarks were found for %@. Finish placing.", location );
            
            }
            
            [self finishPlacingAnnotationFrom: annotations withAnnotiationPoint: point];
        }];
    }
}

- (HATAnnotation *) placeAnnotationWithTweet: (NSDictionary *)tweet andCoordinates: (CLLocationCoordinate2D)coordinates
{
    HATAnnotation *point = [HATAnnotation annotationWithTweet: tweet andCoordinate: coordinates];
    [mapView addAnnotation: point];
    return point;
}
         
- (void) finishPlacingAnnotationFrom: (NSMutableArray *)annotations withAnnotiationPoint: (HATAnnotation *)point
{
    // Hide annotation once the life span is up.

    if( point ) {
        [self performSelector: @selector( displaceAnnotation: ) withObject: point afterDelay: GAME_ENGINE_ANNOTATION_LIFE_SPAN];
    }

    // If no annotations are left, end game after the life span of the last item is up.

    if( annotations.count > 0 ) {
        [self performSelector: @selector( placeAnnotationFrom: ) withObject: annotations afterDelay: ( point ? GAME_ENGINE_ANNOTATION_SPAWN_RATE : 0 )];
    } else {
        [self performSelector: @selector( endGame ) withObject: nil afterDelay: GAME_ENGINE_ANNOTATION_LIFE_SPAN];
    }
}

- (void) displaceAnnotation: (MKPointAnnotation *)point
{
    [mapView removeAnnotation: point];
}

- (void) endGame
{
    NSLog( @"INFO: Game has concluded" );
}

#pragma mark - MKMapViewDelegate methods

static NSString *identifier = @"TweetLocation";

- (MKAnnotationView *) mapView:(MKMapView *)map viewForAnnotation: (id <MKAnnotation>)annotation
{
    if( [annotation isKindOfClass: [HATAnnotation class]] ) {
     
        HATMapPinAnnotationView *annotationView = (HATMapPinAnnotationView *) [map dequeueReusableAnnotationViewWithIdentifier: identifier];
        if (annotationView == nil) {
            annotationView = [[HATMapPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: identifier];
        } else {
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        return annotationView;
        
    }
    
    return nil;
}

- (void) mapView: (MKMapView *)map didSelectAnnotationView: (MKAnnotationView *)view
{
    if( [view isKindOfClass: [HATMapPinAnnotationView class]] ) {
        
        HATMapPinAnnotationView *pinAnnotationView = (HATMapPinAnnotationView *)view;
        
        // Calculate score providing bonuses for retweets and favourites.
        
        NSDictionary *tweet = pinAnnotationView.tweet;
        NSString *text = [tweet objectForKey: @"text"];
        int retweetBonus = [[tweet objectForKey: @"retweet_count"] intValue] * 20;
        int favoriteBonus = [[tweet objectForKey: @"favourites_count"] intValue] * 10;
        
        self.score += ( text.length + retweetBonus + favoriteBonus );
        self.hushTotal++;
        
        [self displaceAnnotation: view.annotation];
        
    }
}

- (void)mapView: (MKMapView *)map didAddAnnotationViews: (NSArray *)views {
    
    for( MKAnnotationView *annotationView in views) {

        CGRect endFrame = annotationView.frame;
        annotationView.frame = CGRectMake( annotationView.frame.origin.x, CGRectGetMinY( annotationView.frame ) - CGRectGetHeight( self.frame ), CGRectGetWidth( annotationView.frame ), CGRectGetHeight( annotationView.frame ));
        
        [UIView beginAnimations: nil context:NULL];
        [UIView setAnimationDuration: 0.45];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [annotationView setFrame: endFrame];
        [UIView commitAnimations];
        
    }
}

#pragma mark - Data utility methods

- (NSDictionary *) selectTrendingTopicFromTrendList: (NSArray *)trendingData
{
    NSArray *trends = [[trendingData lastObject] objectForKey: @"trends"];
    
    // Select a trending topic randomly from trending data.
    
    return [trends objectAtIndex: arc4random() % trends.count];
}

- (NSArray *) filterForGeocodedStatuses: (NSArray *)statuses {
    
    return [statuses filteredArrayUsingPredicate: [NSPredicate predicateWithFormat: @"(geo != '')"]];
}

#pragma mark - CLLocationManager methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    currentLocation = newLocation;

    NSLog(@"New location %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    // We only need to obtain the location once, so we disable the manager after.
    
    manager.delegate = nil;
    
    if( currentLocation != nil ) {
        
        // TODO: Obtain a WOEID using Yahoo's API based on a user's location to obtain trending topics from that location;
        
        [self initTrendingData];
        
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations: (NSArray *)locations
{
    currentLocation = (CLLocation *) [locations lastObject];

    // We only need to obtain the location once, so we disable the manager after.
    
    manager.delegate = nil;
    
    if( currentLocation != nil ) {
        
        // TODO: Obtain a WOEID using Yahoo's API based on a user's location to obtain trending topics from that location;
        
        [self initTrendingData];
        
    }
}

#pragma mark - Layout subviews

- (void) layoutSubviews
{
    scoreView.frame = CGRectMake( CGRectGetMaxX( self.frame ) - CGRectGetWidth( scoreView.frame ) - HUD_PADDING , CGRectGetMaxY( self.frame ) - CGRectGetHeight( scoreView.frame ) - HUD_PADDING, CGRectGetWidth( scoreView.frame ) , CGRectGetHeight( scoreView.frame ));
    hushTotalView.frame = CGRectMake( CGRectGetMaxX( self.frame ) - CGRectGetWidth( hushTotalView.frame ) - HUD_PADDING, CGRectGetMinY( scoreView.frame ) - CGRectGetHeight( hushTotalView.frame ), CGRectGetWidth( hushTotalView.frame ), CGRectGetHeight( hushTotalView.frame ));
    topicView.frame = CGRectMake( 0, 0, CGRectGetWidth( self.frame ), TOPIC_HEIGHT );
}

@end
