//
//  BranchPickerTableViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 26.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubServiceGotBranchDelegate.h"

@interface BranchPickerTableViewController : UITableViewController<GitHubServiceGotBranchDelegate> {
	NSMutableArray *tableData;
}

@property(nonatomic, retain)NSMutableArray *tableData;

- (id)initWithRepository:(NSString *)repo;


@end