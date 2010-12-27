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
#import "GitHubServiceSettings.h"
#import "GitHubObjectServiceFactory.h"
#import "BranchPickerTableViewController.h"
#import "GitHubIssueServiceFactory.h"

@implementation FileBrowserTableViewController

@synthesize repository;
@synthesize branch;
@synthesize tableData;
@synthesize branchPicker;
@synthesize contentPicker;

#pragma mark -
#pragma mark Initialization

- (id)initWithRepository:(NSString *)repo {
    self = [super init];
    if (self) {
		[self setRepository:repo];
		[self setBranch:@"master"];
		[self setTableData:[NSMutableArray array]];

		[self setTitle:self.repository];
		[self.tableView setRowHeight:50];
		[self.tableView setBackgroundColor:[UIColor colorWithRed:0.89 green:0.87 blue:0.81 alpha:1.0]];
		[self.tableView setSeparatorColor:[UIColor colorWithRed:0.71 green:0.70 blue:0.65 alpha:1.0]];
		
		[[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
																								   target:self 
																								   action:@selector(chooseBranch:)]];
		
		BranchPickerTableViewController *branchPickerTableView = [[BranchPickerTableViewController alloc] initWithRepository:self.repository];
		branchPicker = [[UIPopoverController alloc] initWithContentViewController:branchPickerTableView];
		[branchPickerTableView release];
		
		contentPicker = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
																   @"Source", 
																   @"Commits", 
																   @"Issues", 
																   nil]];
		[contentPicker setSelectedSegmentIndex:0];
		[contentPicker setSegmentedControlStyle:UISegmentedControlStyleBar];
		[contentPicker addTarget:self action:@selector(tableDataWillChange:) forControlEvents:UIControlEventValueChanged];
		[[self navigationItem] setTitleView:contentPicker];
		
		[self getSource];
	}
    return self;
}

- (void)getSource  {
	[tableData removeAllObjects];
	[GitHubCommitServiceFactory requestCommitsOnBranch:self.branch
											repository:self.repository 
												  user:[[GitHubServiceSettings credential] user] 
											  delegate:self];
}

- (void)getCommits  {
	[tableData removeAllObjects];
	[GitHubCommitServiceFactory requestCommitsOnBranch:self.branch
											repository:self.repository 
												  user:[[GitHubServiceSettings credential] user] 
											  delegate:self];
}

- (void)getIssues  {
	[tableData removeAllObjects];
	[GitHubIssueServiceFactory requestIssuesForState:GitHubIssueOpen 
												user:[[GitHubServiceSettings credential] user] 
										  repository:self.repository 
											delegate:self];
}

- (void)tableDataWillChange:(id)sender  {
	if([sender selectedSegmentIndex] == 0)  {
		[self getSource];
	}
	else if([sender selectedSegmentIndex] == 1)  {
		[self getCommits];
	}
	else if([sender selectedSegmentIndex] == 2)  {
		[self getIssues];
	}
}


- (void)chooseBranch:(id)sender  {
	[branchPicker presentPopoverFromBarButtonItem:[self.navigationItem rightBarButtonItem] 
					permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


-(void)gitHubService:(id<GitHubService>)gitHubService gotCommit:(id<GitHubCommit>)commit  {
	if([contentPicker selectedSegmentIndex] == 0)  {
		[gitHubService cancelRequest];
		[GitHubObjectServiceFactory requestTreeItemsByTreeSha:[commit sha] 
														 user:[[GitHubServiceSettings credential] user] 
												   repository:self.repository 
													 delegate:self];
	}
	else if([contentPicker selectedSegmentIndex] == 1)  {
		[tableData addObject:commit];
	}
}

-(void)gitHubService:(id<GitHubService>)gitHubService gotTreeItem:(id<GitHubTreeItem>)treeItem  {
	if([contentPicker selectedSegmentIndex] == 0)  {
		[tableData addObject:treeItem];
	}
}

-(void)gitHubService:(id<GitHubService>)gitHubService gotIssue:(id<GitHubIssue>)issue  {
	if([contentPicker selectedSegmentIndex] == 2)  {
		[tableData addObject:issue];
	}
}

-(void)gitHubService:(id<GitHubService>)gitHubService didFailWithError:(NSError *)error  {
	NSLog(@"%@", [error description]);
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	if([contentPicker selectedSegmentIndex] == 0)  {
		[[cell textLabel] setText:[[tableData objectAtIndex:indexPath.row] name]];
		if([[[tableData objectAtIndex:indexPath.row] type] isEqualToString:@"tree"])  {
			[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
			[[cell imageView] setImage:[UIImage imageNamed:@"dir.png"]];
		}
		else  {
			[cell setAccessoryType:UITableViewCellAccessoryNone];
			[[cell imageView] setImage:[UIImage imageNamed:@"txt.png"]];
		}
	}
	else if([contentPicker selectedSegmentIndex] == 1)  {
		[[cell textLabel] setText:[[tableData objectAtIndex:indexPath.row] message]];
		[cell setAccessoryType:UITableViewCellAccessoryNone];
		[[cell imageView] setImage:nil];
	}
	else if([contentPicker selectedSegmentIndex] == 2)  {
		[[cell textLabel] setText:[[tableData objectAtIndex:indexPath.row] title]];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		[[cell imageView] setImage:nil];
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
	[branch release];
	[tableData release];
	[branchPicker release];
	[contentPicker release];
    [super dealloc];
}


@end

