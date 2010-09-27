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

- (id)initWithCredentials:(NSArray *)credentials {
    if((self = [super init])) {
		[self setTitle:@"Profile"];
        credentials_ = [credentials retain];
    }
    return self;
}



- (void)loadView {
	[super loadView];
	
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0]];
	
	userInfoViewController_ = [[UserInfoViewController alloc] initWithCredentials:credentials_];
	[userInfoViewController_.view setFrame:CGRectMake(0, 0, 300, self.view.frame.size.height)];
	[userInfoViewController_.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin];
	[self.view addSubview:userInfoViewController_.view];
	
	newsFeedViewController_ = [[NewsFeedViewController alloc] initWithCredentials:credentials_];
	[newsFeedViewController_.view setFrame:CGRectMake(300, 0, self.view.frame.size.width-300, self.view.frame.size.height)];
	[newsFeedViewController_.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
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
    [credentials_ release];
    [super dealloc];
}


@end
