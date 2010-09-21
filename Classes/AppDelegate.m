//
//  SocialCoderAppDelegate.m
//  SocialCoder
//
//  Created by Toni Suter on 21.09.10.
//  Copyright 2010 Toni Suter. All rights reserved.
//

#import "AppDelegate.h"
#import "UserViewController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	TTNavigator* navigator = [TTNavigator navigator];
	navigator.persistenceMode = TTNavigatorPersistenceModeAll;
	TTURLMap* map = navigator.URLMap;
	[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"http://github.com/(initWithUsername:)" toViewController:[UserViewController class]];

	//if (![navigator restoreViewControllers]) {
	[navigator openURLAction:[TTURLAction actionWithURLPath:@"http://github.com/haefligs"]];
	//}
}

- (BOOL)navigator:(TTNavigator*)navigator shouldOpenURL:(NSURL*)URL {
	return YES;
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
	[[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
	return YES;
}

@end
