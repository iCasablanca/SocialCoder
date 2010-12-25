//
//  ContentViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 17.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class FeedTableViewController;
@class RepositoriesTableViewController;
@class GistsTableViewController;
@class SearchTableViewController;

@interface ContentViewController : UIViewController {
	UINavigationController *navController;
	FeedTableViewController *feedTable;
	RepositoriesTableViewController *repositoriesTable;
	GistsTableViewController *gistsTable;
	SearchTableViewController *searchTable;
}

@property(nonatomic, retain)UINavigationController *navController;
@property(nonatomic, retain)FeedTableViewController *feedTable;
@property(nonatomic, retain)RepositoriesTableViewController *repositoriesTable;
@property(nonatomic, retain)GistsTableViewController *gistsTable;
@property(nonatomic, retain)SearchTableViewController *searchTable;

-(void)menuDidChange:(int)number;

@end
