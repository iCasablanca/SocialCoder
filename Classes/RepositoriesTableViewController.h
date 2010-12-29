//
//  RepositoriesTableViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 18.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubServiceGotRepositoryDelegate.h"
#import "GitHubServiceGotCommitDelegate.h"

@interface RepositoriesTableViewController : UITableViewController<GitHubServiceGotRepositoryDelegate,
																   GitHubServiceGotCommitDelegate> {
	NSMutableArray *tableData;
}

@property(nonatomic, retain)NSMutableArray *tableData;

- (void)loadContent;
- (void)loadNextCommit;

@end
