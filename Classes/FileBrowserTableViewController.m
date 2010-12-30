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
#import "CommitCell.h"

@implementation FileBrowserTableViewController

@synthesize repository;
@synthesize sha;
@synthesize branch;
@synthesize tableData;
@synthesize branchPicker;
@synthesize contentPicker;
@synthesize branchButton;
@synthesize tagButton;

#pragma mark -
#pragma mark Initialization

- (id)initWithRepository:(NSString *)repo andSha:(NSString *)s  {
    self = [super init];
    if (self) {
		[self setRepository:repo];
		[self setSha:s];
		[self setBranch:@"master"];
		[self setTableData:[NSMutableArray array]];

		[self.tableView setBackgroundColor:[UIColor colorWithRed:0.89 green:0.87 blue:0.81 alpha:1.0]];
		[self.tableView setSeparatorColor:[UIColor colorWithRed:0.71 green:0.70 blue:0.65 alpha:1.0]];
		
        branchButton = [[UIBarButtonItem alloc]
                        initWithImage:[UIImage imageNamed:@"branch.png"] 
                                style:UIBarButtonItemStylePlain 
                               target:self
                               action:@selector(chooseBranch:)];
		
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace 
																					 target:nil 
																					 action:nil];
		[spaceButton setWidth:12.0];
        
        tagButton = [[UIBarButtonItem alloc]
                     initWithImage:[UIImage imageNamed:@"tag.png"] 
                            style:UIBarButtonItemStylePlain 
                            target:self
                            action:@selector(chooseTag:)];

		UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 45)];
		[toolbar setBarStyle:-1];
		[toolbar setItems:[NSArray arrayWithObjects:branchButton, spaceButton, tagButton, nil]];
		[[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:toolbar]];
        [spaceButton release];
        [toolbar release];
		
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
	[self.tableView setRowHeight:50];
	[GitHubObjectServiceFactory requestTreeItemsByTreeSha:self.sha
													 user:[[GitHubServiceSettings credential] user] 
											   repository:self.repository 
												 delegate:self];
}

- (void)getCommits  {
	[tableData removeAllObjects];
	[self.tableView setRowHeight:100];
	[GitHubCommitServiceFactory requestCommitsOnBranch:self.branch
											repository:self.repository 
												  user:[[GitHubServiceSettings credential] user] 
											  delegate:self];
}

- (void)getIssues  {
	[tableData removeAllObjects];
	[self.tableView setRowHeight:50];
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
	[branchPicker presentPopoverFromBarButtonItem:branchButton
					permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)chooseTag:(id)sender  {
	[branchPicker presentPopoverFromBarButtonItem:tagButton
						 permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)gitHubService:(id<GitHubService>)gitHubService gotCommit:(id<GitHubCommit>)commit  {
	if([contentPicker selectedSegmentIndex] == 1)  {
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
	static NSString *CommitCellIdentifier = @"CommitCell";
	
	UITableViewCell *cell;
	
	if([contentPicker selectedSegmentIndex] == 0)  {		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
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
		cell = (CommitCell *)[tableView dequeueReusableCellWithIdentifier:CommitCellIdentifier];
		if (cell == nil) {
			cell = [[[CommitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommitCellIdentifier] autorelease];
		}
		
		[cell setCommit:[tableData objectAtIndex:indexPath.row]];
		[cell setAccessoryType:UITableViewCellAccessoryNone];
		[[cell imageView] setImage:nil];
	}
	else if([contentPicker selectedSegmentIndex] == 2)  {		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
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
	if([contentPicker selectedSegmentIndex] == 0)  {
		if([[[tableData objectAtIndex:indexPath.row] type] isEqualToString:@"tree"])  {
			 FileBrowserTableViewController *detailViewController = [[FileBrowserTableViewController alloc] initWithRepository:self.repository
																														andSha:[[tableData objectAtIndex:indexPath.row] sha]];
			 [detailViewController setTitle:[[tableData objectAtIndex:indexPath.row] name]];
			 [self.navigationController pushViewController:detailViewController animated:YES];
			 [detailViewController release];
		}
		else  {
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
		}
	}
	else if([contentPicker selectedSegmentIndex] == 1)  {		

	}
	else if([contentPicker selectedSegmentIndex] == 2)  {		
		
	}
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
	[sha release];
	[branch release];
	[tableData release];
	[branchPicker release];
	[contentPicker release];
    [branchButton release];
    [tagButton release];
    [super dealloc];
}


@end

