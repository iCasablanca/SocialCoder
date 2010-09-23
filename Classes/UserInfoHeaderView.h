//
//  UserInfoHeaderView.h
//  SocialCoder
//
//  Created by Toni Suter on 23.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserInfoHeaderView : UIView {
	UIImage *avatar;
	NSString *nickname;
	NSString *fullname;
@private
	UIImageView *avatarView_;
	UILabel *nicknameLabel_;
	UILabel *fullnameLabel_;
}

@property(nonatomic, retain)UIImage *avatar;
@property(nonatomic, retain)NSString *nickname;
@property(nonatomic, retain)NSString *fullname;

@end
