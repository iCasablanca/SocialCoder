//
//  RepositoriesViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 27.09.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "RepositoriesViewController.h"


@implementation RepositoriesViewController


- (id)init {
    if ((self = [super init])) {
        [self setTitle:@"Repositories"];
    }
    return self;
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.22 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0]];
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
