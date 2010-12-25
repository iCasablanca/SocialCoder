//
//  FileBrowserTableViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 25.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FileBrowserTableViewController.h"
#import "GitHubCommitServiceFactory.h"
#import "GitHubService.h"
#import "GitHubObjectServiceFactory.h"

@implementation FileBrowserTableViewController

@synthesize repository;
@synthesize tableData;

#pragma mark -
#pragma mark Initialization

- (id)initWithRepository:(NSString *)repo {
    self = [super init];
    if (self) {
		self.repository = repo;
		[self setTitle:self.repository];
		[self.tableView setRowHeight:50];
		[self.tableView setBackgroundColor:[UIColor colorWithRed:0.89 green:0.87 blue:0.81 alpha:1.0]];
		[self.tableView setSeparatorColor:[UIColor colorWithRed:0.71 green:0.70 blue:0.65 alpha:1.0]];
		
		[GitHubCommitServiceFactory requestCommitsOnBranch:@"master" 
												repository:self.repository 
													  user:@"tonisuter" 
												  delegate:self];
				
		self.tableData = [[NSMutableArray alloc] init];
	}
    return self;
}


-(void)gitHubService:(id<GitHubService>)gitHubService gotCommit:(id<GitHubCommit>)commit  {
	[gitHubService cancelRequest];
	[GitHubObjectServiceFactory requestTreeItemsByTreeSha:[commit sha] 
													 user:@"tonisuter" 
											   repository:self.repository
												 delegate:self];
}

-(void)gitHubService:(id<GitHubService>)gitHubService gotTreeItem:(id<GitHubTreeItem>)treeItem  {
	[tableData addObject:treeItem];
}

-(void)gitHubService:(id<GitHubService>)gitHubService didFailWithError:(NSError *)error  {
	
}

-(void)gitHubServiceDone:(id<GitHubService>)gitHubService  {
	[self.tableView reloadData];
}


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

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
    return [tableData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	[[cell textLabel] setText:[[tableData objectAtIndex:indexPath.row] name]];
	if([[[tableData objectAtIndex:indexPath.row] type] isEqualToString:@"tree"])  {
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
	else  {
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
	
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
	[repository release];
	[tableData release];
    [super dealloc];
}


@end

