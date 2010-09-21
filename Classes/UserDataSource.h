//
//  UserDataSource.h
//  SocialCoder
//
//  Created by Toni Suter on 21.09.10.
//  Copyright 2010 Toni Suter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface UserDataSource : TTSectionedDataSource {
	UserModel* _usermodel;
}

- (id)initWithUsername:(NSString*)username;

@end
