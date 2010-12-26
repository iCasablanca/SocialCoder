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

@synthesize loginForm;
@synthesize logo;
@synthesize loginButton;

@synthesize menuTable;
@synthesize contentView;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[LoginView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	loginForm = [[LoginFormTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[self.view addSubview:loginForm.view];
	
	logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"github.png"]];
	[logo setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
	[logo setCenter:CGPointMake(self.view.frame.size.width/2-140, self.view.frame.size.height/2)];
	[self.view addSubview:logo];
	
	loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[loginButton setTitle:@"Login" forState:UIControlStateNormal];
	[loginButton sizeToFit];
	[loginButton setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2+100)];
	[loginButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
	[loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:loginButton];
	
	menuTable = [[MenuTableViewController alloc] init];
	[menuTable.view setFrame:CGRectMake(0,0,200,self.view.frame.size.height)];
	[menuTable.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
	[menuTable.view setHidden:YES];
	[menuTable.view setAlpha:0.0];
	
	contentView = [[ContentViewController alloc] init];
	[self.view addSubview:contentView.view];
	
	[menuTable setMenuDelegate:contentView];
}

- (void)login:(id)sender  {
	NSURLCredential *credential = [NSURLCredential credentialWithUser:[[loginForm username] text] 
															 password:[[loginForm password] text]
														  persistence:NSURLCredentialPersistenceNone];
	[GitHubServiceSettings setCredential:credential];
	[GitHubUserServiceFactory requestUserByName:[[loginForm username] text] 
									   delegate:self];
	
	[self.view addSubview:menuTable.view];
	[menuTable.view setHidden:NO];
	[contentView.view setHidden:NO];
	
	[UIView beginAnimations:@"test" context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(loggedIn:)];
	[loginForm.view setAlpha:0.0];
	[logo setAlpha:0.0];
	[loginButton setAlpha:0.0];
	[menuTable.view setAlpha:1.0];
	[contentView.view setAlpha:1.0];
	[UIView commitAnimations];
}

- (void)loggedIn:(id)sender  {
	[loginForm.view removeFromSuperview];
	[logo removeFromSuperview];
	[loginButton removeFromSuperview];
	[menuTable.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
	NSLog(@"LoggedIn");
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
	[loginForm release];
	[logo release];
	[loginButton release];
	[menuTable release];
	[contentView release];
    [super dealloc];
}


@end
