//
//  FileBrowserTableViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 25.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubServiceGotCommitDelegate.h"
#import "GitHubServiceGotBlobDelegate.h"

@interface FileBrowserTableViewController : UITableViewController<GitHubServiceGotCommitDelegate, GitHubServiceGotBlobDelegate> {
	NSString *repository;
	NSMutableArray *tableData;
	UIPopoverController *branchPicker;
}

@property(nonatomic, retain)NSString *repository;
@property(nonatomic, retain)NSMutableArray *tableData;
@property(nonatomic, retain)UIPopoverController *branchPicker;

- (id)initWithRepository:(NSString *)repo;

@end
