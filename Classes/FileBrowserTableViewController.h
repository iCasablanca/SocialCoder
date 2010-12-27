//
//  FileBrowserTableViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 25.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubServiceGotCommitDelegate.h"
#import "GitHubServiceGotTreeItemDelegate.h"
#import "GitHubServiceGotIssueDelegate.h"

@interface FileBrowserTableViewController : UITableViewController<GitHubServiceGotCommitDelegate, 
																  GitHubServiceGotTreeItemDelegate,
																  GitHubServiceGotIssueDelegate> {
	NSString *repository;
	NSString *branch;
	NSMutableArray *tableData;
	UIPopoverController *branchPicker;
	UISegmentedControl *contentPicker;
}

@property(nonatomic, retain)NSString *repository;
@property(nonatomic, retain)NSString *branch;
@property(nonatomic, retain)NSMutableArray *tableData;
@property(nonatomic, retain)UIPopoverController *branchPicker;
@property(nonatomic, retain)UISegmentedControl *contentPicker;

- (id)initWithRepository:(NSString *)repo;
- (void)getSource;
- (void)getCommits; 
- (void)getIssues; 
- (void)tableDataWillChange:(id)sender; 
- (void)chooseBranch:(id)sender;  

@end
