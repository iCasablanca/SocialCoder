//
//  SocialCoderAppDelegate.h
//  SocialCoder
//
//  Created by Toni Suter on 23.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


@class ProfileViewController;
@class RepositoriesViewController;
@class GistsViewController;

@interface SocialCoderAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	RepositoriesViewController *repositoriesViewController_;
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
	UITabBarController *tabBarController_;
	ProfileViewController *profileViewController_;
    GistsViewController *gistsViewController_;

}

@property (nonatomic, retain) UIWindow *window;
@property(nonatomic, retain)RepositoriesViewController *repositoriesViewController_;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@end

