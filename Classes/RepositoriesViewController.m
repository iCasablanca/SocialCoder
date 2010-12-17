//
//  RepositoriesViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 27.09.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "RepositoriesViewController.h"
#import "RepositoryListViewController.h"
#import "FileBrowserViewController.h"

@implementation RepositoriesViewController

@synthesize fileBrowserViewController_;

- (id)initWithCredentials:(NSArray *)credentials {
    if ((self = [super init])) {
        [self setTitle:@"Repositories"];
        credentials_ = [credentials retain];
    }
    return self;
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.22 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0]];

	repositoryListViewController_ = [[RepositoryListViewController alloc] initWithCredentials:credentials_];
	[repositoryListViewController_.view setFrame:CGRectMake(0, 0, 250, self.view.frame.size.height)];
	[repositoryListViewController_.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin];
	[self.view addSubview:repositoryListViewController_.view];
    
    fileBrowserViewController_ = [[FileBrowserViewController alloc] initWithCredentials:credentials_];
	[fileBrowserViewController_ setRepository:@"codeinbrackets"];
	[fileBrowserViewController_.view setFrame:CGRectMake(250, 0, self.view.frame.size.width-250, self.view.frame.size.height)];
	[fileBrowserViewController_.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin];
	[self.view addSubview:fileBrowserViewController_.view];
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
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];

    [repositoryListViewController_ release];
    repositoryListViewController_ = nil;
    
    [fileBrowserViewController_ release];
    fileBrowserViewController_ = nil;
}


- (void)dealloc {
    [credentials_ release];
    [super dealloc];
}


@end
