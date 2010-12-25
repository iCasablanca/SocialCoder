//
//  RepositoriesTableViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 18.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubServiceGotRepositoryDelegate.h"

@interface RepositoriesTableViewController : UITableViewController<GitHubServiceGotRepositoryDelegate> {
	NSMutableArray *tableData;
}

@property(nonatomic, retain)NSMutableArray *tableData;

- (void)loadContent;

@end
