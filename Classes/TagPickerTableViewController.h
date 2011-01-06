//
//  TagPickerTableViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 06.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubServiceGotTagDelegate.h"


@interface TagPickerTableViewController : UITableViewController<GitHubServiceGotTagDelegate> {
	NSMutableArray *tableData;
}

@property(nonatomic, retain)NSMutableArray *tableData;

- (id)initWithRepository:(NSString *)repo;

@end
