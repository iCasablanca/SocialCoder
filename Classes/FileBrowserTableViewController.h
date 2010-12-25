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

@interface FileBrowserTableViewController : UITableViewController<GitHubServiceGotCommitDelegate, GitHubServiceGotTreeItemDelegate> {
	NSString *repository;
	NSMutableArray *tableData;
}

@property(nonatomic, retain)NSString *repository;
@property(nonatomic, retain)NSMutableArray *tableData;

- (id)initWithRepository:(NSString *)repo;

@end
