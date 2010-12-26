    //
//  ContentViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 17.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ContentViewController.h"
#import "FeedTableViewController.h"
#import "RepositoriesTableViewController.h"
#import "GistsTableViewController.h"
#import "SearchTableViewController.h"

@implementation ContentViewController

@synthesize navController;
@synthesize feedTable;
@synthesize repositoriesTable;
@synthesize gistsTable;
@synthesize searchTable;

- (id)init  {
    self = [super init];
    if (self) {

		
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	CGRect rect = [[UIScreen mainScreen] bounds];
	self.view = [[UIView alloc] initWithFrame:CGRectMake(210,10,rect.size.width-220, rect.size.height-20)];
	[self.view.layer setCornerRadius:10];
	[self.view setClipsToBounds:YES];
	[self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	
	feedTable = [[FeedTableViewController alloc] init];
	repositoriesTable = [[RepositoriesTableViewController alloc] init];
	gistsTable = [[GistsTableViewController alloc] init];
	searchTable = [[SearchTableViewController alloc] init];
	
	navController = [[UINavigationController alloc] initWithRootViewController:feedTable];
	[navController.view setFrame:[self.view bounds]];
	[self.view addSubview:navController.view];
}

-(void)menuDidChange:(int)number  {	
	if(number == 0)  {
		[navController setViewControllers:[NSArray arrayWithObject:feedTable]];
	}
	else if(number == 1)  {
		[navController setViewControllers:[NSArray arrayWithObject:repositoriesTable]];
		[repositoriesTable loadContent];
	}
	else if(number == 2)  {
		[navController setViewControllers:[NSArray arrayWithObject:gistsTable]];
	}
	else if(number == 3)  {
		[navController setViewControllers:[NSArray arrayWithObject:searchTable]];
	}
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[navController release];
	[feedTable release];
	[repositoriesTable release];
	[gistsTable release];
	[searchTable release];
    [super dealloc];
}


@end
