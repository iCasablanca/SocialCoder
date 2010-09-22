//
//  AppDelegate.m
//  SocialCoder
//
//  Created by Toni Suter on 21.09.10.
//  Copyright 2010 Toni Suter. All rights reserved.
//

#import "AppDelegate.h"
#import "UserViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	_tabBarController = [[UITabBarController alloc] init];
	
	UserViewController *userViewController = [[UserViewController alloc] initWithUsername:@"tonisuter"];
	UINavigationController *userNavigationController = [[UINavigationController alloc] initWithRootViewController:userViewController];
	[_tabBarController setViewControllers:[NSArray arrayWithObjects:userNavigationController, nil]];
	[userViewController release];
	[userNavigationController release];
    [_window addSubview:_tabBarController.view];
    [_window makeKeyAndVisible];
    return YES;
}

- (void)dealloc {
    [_window release];
	[_tabBarController release];
    [super dealloc];
}

@end
