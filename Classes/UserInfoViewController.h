//
//  UserInfoViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 23.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class UserInfoHeaderView;
@class ProfileViewController;

@interface UserInfoViewController : UITableViewController<MFMailComposeViewControllerDelegate> {
    ProfileViewController *profileViewController;
@private
	UserInfoHeaderView *userInfoHeaderView_;
    NSMutableData *receivedData_;
    NSMutableArray *tableData_;
    NSArray *credentials_;
}

@property(nonatomic, assign)ProfileViewController *profileViewController;

- (id)initWithCredentials:(NSArray *)credentials;

@end
