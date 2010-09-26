//
//  UserInfoViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 23.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfoHeaderView;

@interface UserInfoViewController : UITableViewController {
@private
	UserInfoHeaderView *userInfoHeaderView_;
    NSMutableData *receivedData_;
    NSMutableArray *tableData_;
}

@end
