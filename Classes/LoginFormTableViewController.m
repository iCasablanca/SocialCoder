//
//  LoginFormTableViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 12.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoginFormTableViewController.h"


@implementation LoginFormTableViewController

@synthesize username;
@synthesize password;
@synthesize formDelegate;


#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];

    if (self) {
		[self.tableView setBackgroundView:nil];
		[self.tableView setScrollEnabled:NO];
		
		username = [[UITextField alloc] initWithFrame:CGRectMake(0,0,200,22)];
		[username setPlaceholder:@"john.appleseed"];
		[username setAutocapitalizationType:UITextAutocapitalizationTypeNone];
		[username setAutocorrectionType:UITextAutocorrectionTypeNo];
		[username setText:@"tonisuter"]; //debug
		[username setReturnKeyType:UIReturnKeyNext];
		[username setClearButtonMode:UITextFieldViewModeWhileEditing];
		[username setDelegate:self];

		password = [[UITextField alloc] initWithFrame:CGRectMake(0,0,200,22)];
		[password setSecureTextEntry:YES];
		[password setPlaceholder:@"required"];
		[password setReturnKeyType:UIReturnKeyDone];
		[password setClearButtonMode:UITextFieldViewModeWhileEditing];
		[password setDelegate:self];
	}
    return self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField  {
	if(textField == username)  {
		[password becomeFirstResponder];
	}
	else if(textField == password)  {
		[formDelegate login];
	}
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField  {
	NSLog(@"move everything up");
	return YES;
}



#pragma mark -
#pragma mark View lifecycle

- (void)loadView  {
	[super loadView];
	[self.view setFrame:CGRectMake(self.view.frame.size.width-450,self.view.frame.size.height/2-55,350,110)];
	[self.view setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	if(indexPath.row == 0)  {
		[[cell textLabel] setText:@"Username"];
		[username setCenter:CGPointMake(220, cell.frame.size.height/2)];
		[cell addSubview:username];
	}
	else if(indexPath.row == 1)  {
		[[cell textLabel] setText:@"Password"];
		[password setCenter:CGPointMake(220, cell.frame.size.height/2)];
		[cell addSubview:password];
	}
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[username release];
	[password release];
    [super dealloc];
}


@end

