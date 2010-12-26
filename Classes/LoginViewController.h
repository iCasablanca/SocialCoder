//
//  LoginViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 12.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubServiceGotUserDelegate.h"

@class LoginFormTableViewController;
@class MenuTableViewController;
@class ContentViewController;
@class LoginView;

@interface LoginViewController : UIViewController<GitHubServiceGotUserDelegate> {
	LoginView *loginView;
	LoginFormTableViewController *loginForm;
	UIImageView *logo;	
	
	UIView *normalView;
	MenuTableViewController *menuTable;
	ContentViewController *contentView;
}

@property(nonatomic, retain)LoginView *loginView;
@property(nonatomic, retain)LoginFormTableViewController *loginForm;
@property(nonatomic, retain)UIImageView *logo;

@property(nonatomic, retain)UIView *normalView;
@property(nonatomic, retain)MenuTableViewController *menuTable;
@property(nonatomic, retain)ContentViewController *contentView;

@end