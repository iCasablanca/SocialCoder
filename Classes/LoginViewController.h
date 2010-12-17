//
//  LoginViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 12.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginFormTableViewController;

@interface LoginViewController : UIViewController {
	LoginFormTableViewController *loginForm;
}

@property(nonatomic, retain)LoginFormTableViewController *loginForm;

@end
