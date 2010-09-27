//
//  UserInfoHeaderView.m
//  SocialCoder
//
//  Created by Toni Suter on 23.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserInfoHeaderView.h"


@implementation UserInfoHeaderView

@synthesize avatar;
@synthesize nickname;
@synthesize fullname;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		avatar = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], @"default_avatar.png"]];
		avatarView_ = [[UIImageView alloc] initWithImage:avatar];
		[avatarView_ setFrame:CGRectMake(50,self.frame.size.height/2-25,50,50)];
		[self addSubview:avatarView_];
		
		nickname = @"";
		nicknameLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(110,self.frame.size.height/2-25,self.frame.size.width-110, 30)];
		[nicknameLabel_ setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
		[nicknameLabel_ setFont:[UIFont boldSystemFontOfSize:20.0]];
		[nicknameLabel_ setBackgroundColor:[UIColor clearColor]];
		[nicknameLabel_ setTextColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.6 alpha:1.0]];
		[nicknameLabel_ setText:nickname];
		[self addSubview:nicknameLabel_];
		
		fullname = @"";
		fullnameLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(110,self.frame.size.height/2+5,self.frame.size.width-110, 20)];
		[fullnameLabel_ setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
		[fullnameLabel_ setFont:[UIFont systemFontOfSize:14.0]];
		[fullnameLabel_ setBackgroundColor:[UIColor clearColor]];
		[fullnameLabel_ setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.5 alpha:1.0]];
		[fullnameLabel_ setText:fullname];
		[self addSubview:fullnameLabel_];
    }
    return self;
}

- (void)setAvatar:(UIImage *)anAvatar  {
    if(avatar != anAvatar)  {
        [avatar release];
        avatar = [anAvatar retain];
        [avatarView_ setImage:avatar];
    }
}

- (void)setNickname:(NSString *)aNickname  {
    if(nickname != aNickname)  {
        [nickname release];
        nickname = [aNickname retain];
        [nicknameLabel_ setText:nickname];
    }
}

- (void)setFullname:(NSString *)aFullname  {
    if(fullname != aFullname)  {
        [fullname release];
        fullname = [aFullname retain];
        [fullnameLabel_ setText:fullname];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[avatar release];
	[nickname release];
	[fullname release];
	[avatarView_ release];
	[nicknameLabel_ release];
	[fullnameLabel_ release];
    [super dealloc];
}


@end
