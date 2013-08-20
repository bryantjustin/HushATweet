//
//  FTFAppDelegate.h
//  FoodTruckFinder
//
//  Created by Bryant Balatbat on 2013-08-20.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
