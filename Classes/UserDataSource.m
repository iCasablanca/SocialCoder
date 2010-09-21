//
//  UserDataSource.m
//  SocialCoder
//
//  Created by Toni Suter on 21.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserDataSource.h"
#import "UserModel.h"

@implementation UserDataSource

- (id)initWithUsername:(NSString*)username {
	if (self = [self init]) {
		_usermodel = [[UserModel alloc] initWithUsername:username];
	}
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_usermodel);
	
	[super dealloc];
}

- (id<TTModel>)model {
	return _usermodel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* sections = [[NSMutableArray alloc] init];
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	self.sections = sections;
	self.items = items;
	
	TT_RELEASE_SAFELY(sections);
	TT_RELEASE_SAFELY(items);
}


@end
