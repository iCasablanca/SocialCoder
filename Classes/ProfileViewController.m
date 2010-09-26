    //
//  ProfileViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 23.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserInfoViewController.h"
#import "NewsFeedViewController.h"

@implementation ProfileViewController

- (id)init {
    if((self = [super init])) {
		[self setTitle:@"Profile"];
    }
    return self;
}



- (void)loadView {
	[super loadView];
	
	[self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
	
	userInfoViewController_ = [[UserInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[userInfoViewController_.view setFrame:CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.height)];
	[userInfoViewController_.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin];
	[self.view addSubview:userInfoViewController_.view];
	
	newsFeedViewController_ = [[NewsFeedViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[newsFeedViewController_.view setFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, self.view.frame.size.height)];
	[newsFeedViewController_.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin];
	[self.view addSubview:newsFeedViewController_.view];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
	
	[userInfoViewController_ release];
	userInfoViewController_ = nil;
	
	[newsFeedViewController_ release];
	newsFeedViewController_ = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
