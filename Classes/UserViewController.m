//
//  UserViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 21.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserViewController.h"
#import "UserDataSource.h"

@implementation UserViewController

@synthesize username = _username;

- (id)initWithUsername:(NSString*)username {
	// Note the [self init] here instead of [super init].
	if (self = [self init]) {
		self.username = username;
		self.title = username;
	}
	
	return self;
}

- (id)init {
	if (self = [super init]) {
		self.tableViewStyle = UITableViewStyleGrouped;
		self.variableHeightRows = YES;
		self.title = @"User Info";
	}
	
	return self;
}

- (void)createModel {
	self.dataSource = [[[UserDataSource alloc] initWithUsername:_username]
					   autorelease];
}


- (void)dealloc {
	TT_RELEASE_SAFELY(_username);
	[super dealloc];
}

@end

