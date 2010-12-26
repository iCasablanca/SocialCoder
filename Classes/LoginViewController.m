    //
//  LoginViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 12.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginFormTableViewController.h"
#import "GitHubServiceSettings.h"
#import "MenuTableViewController.h"
#import "ContentViewController.h"
#import "GitHubUserServiceFactory.h"

@implementation LoginViewController

@synthesize loginView;
@synthesize loginForm;
@synthesize logo;
@synthesize normalView;
@synthesize menuTable;
@synthesize contentView;


- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	
	loginView = [[LoginView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[loginView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	[self.view addSubview:loginView];
	
	loginForm = [[LoginFormTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[loginForm setFormDelegate:self];
	[loginView addSubview:loginForm.view];
	
	logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"github.png"]];
	[logo setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
	[logo setCenter:CGPointMake(self.view.frame.size.width/2-140, self.view.frame.size.height/2)];
	[loginView addSubview:logo];
	
	CGRect b = [[UIScreen mainScreen] bounds];
	normalView = [[UIView alloc] initWithFrame:CGRectMake(0,-b.size.height, b.size.width, b.size.height)];
	[normalView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	[normalView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"texture2.png"]]];
	[self.view addSubview:normalView];
	
	menuTable = [[MenuTableViewController alloc] init];
	[menuTable.view setFrame:CGRectMake(0,0,200,normalView.frame.size.height)];
	[menuTable.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
	[normalView addSubview:menuTable.view];
	
	contentView = [[ContentViewController alloc] init];
	[normalView addSubview:contentView.view];
	[menuTable setMenuDelegate:contentView];
}

- (void)login  {
	NSURLCredential *credential = [NSURLCredential credentialWithUser:[[loginForm username] text] 
															 password:[[loginForm password] text]
														  persistence:NSURLCredentialPersistenceNone];
	[GitHubServiceSettings setCredential:credential];
	[GitHubUserServiceFactory requestUserByName:[[loginForm username] text] 
									   delegate:self];
	
	[[loginForm password] resignFirstResponder];
	
	[UIView beginAnimations:@"test" context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(loggedIn:)];
	[loginView setCenter:CGPointMake(loginView.frame.size.width/2, loginView.frame.size.height*1.5)];
	[normalView setCenter:CGPointMake(normalView.frame.size.width/2, normalView.frame.size.height/2)];
	[UIView commitAnimations];
}

- (void)loggedIn:(id)sender  {
	[loginView removeFromSuperview];
	[menuTable.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

-(void)gitHubService:(id<GitHubService>)gitHubService gotUser:(id<GitHubUser>)user  {
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.gravatar.com/avatar.php?gravatar_id=%@", [user gravatarId]]];
	UIImage *avatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
	UIImageView *avatarView = [[UIImageView alloc] initWithImage:avatar];
	[avatarView setFrame:CGRectMake(10,10,50,50)];
	[avatarView.layer setCornerRadius:5];
	[avatarView setClipsToBounds:YES];
	[avatarView.layer setShadowColor:[UIColor whiteColor].CGColor];
		[avatarView.layer setShadowOffset:CGSizeMake(0,0)];
	[avatarView.layer setShadowRadius:5];
		[avatarView.layer setShadowOpacity:1.0];
	[menuTable.view addSubview:avatarView];
}

-(void)gitHubService:(id<GitHubService>)gitHubService didFailWithError:(NSError *)error  {
	
}

-(void)gitHubServiceDone:(id<GitHubService>)gitHubService  {
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
	[loginView release];
	[loginForm release];
	[logo release];
	[normalView release];
	[menuTable release];
	[contentView release];
    [super dealloc];
}


@end
