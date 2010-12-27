//
//  MenuTableViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 17.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GitHubUser.h"

@interface MenuTableViewController : UITableViewController {
	id menuDelegate;
	id<GitHubUser> user;
}

@property(nonatomic, assign)id menuDelegate;
@property(nonatomic, retain)id<GitHubUser> user;

@end
