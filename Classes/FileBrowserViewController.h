//
//  FileBrowserViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 28.09.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


@interface FileBrowserViewController : UITableViewController {
@private
    NSMutableData *receivedData_;
    NSMutableArray *tableData_;
    NSArray *credentials_;
	bool gotSha_;
	
	NSString *repository;
}

@property(nonatomic, retain)NSString *repository;

- (id)initWithCredentials:(NSArray *)credentials;

@end
