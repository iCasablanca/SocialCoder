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

@interface UserInfoViewController : UITableViewController<MFMailComposeViewControllerDelegate> {
@private
	UserInfoHeaderView *userInfoHeaderView_;
    NSMutableData *receivedData_;
    NSMutableArray *tableData_;
    NSArray *credentials_;
}

- (id)initWithCredentials:(NSArray *)credentials;

@end
