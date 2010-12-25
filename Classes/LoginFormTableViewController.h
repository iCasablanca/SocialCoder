//
//  LoginFormTableViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 12.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginFormTableViewController : UITableViewController {
	UITextField *username;
	UITextField *password;
}

@property(nonatomic, retain)UITextField *username;
@property(nonatomic, retain)UITextField *password;

@end
