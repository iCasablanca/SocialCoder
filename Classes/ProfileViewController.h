//
//  ProfileViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 23.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfoViewController;
@class NewsFeedViewController;

@interface ProfileViewController : UIViewController {
@private
	UserInfoViewController *userInfoViewController_;
	NewsFeedViewController *newsFeedViewController_;
}

@end
