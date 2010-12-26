//
//  BranchPickerTableViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 26.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BranchPickerTableViewController.h"
#import "GitHubRepositoryServiceFactory.h"
#import "GitHubServiceSettings.h"

@implementation BranchPickerTableViewController

@synthesize tableData;

#pragma mark -
#pragma mark Initialization

- (id)initWithRepository:(NSString *)repo  {
	self = [super init];
	if(self)  {
		[self.view setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.9 alpha:1.0]];
		[self setContentSizeForViewInPopover:CGSizeMake(200, 135)];

		
		tableData = [[NSMutableArray alloc] initWithObjects:
					 [NSMutableArray array],
					 [NSMutableArray array],
					 nil];
		[GitHubRepositoryServiceFactory requestBranchesByName:repo 
														 user:[[GitHubServiceSettings credential] user] 
													 delegate:self];
	}
	return self;
}

-(void)gitHubService:(id<GitHubService>)gitHubService gotBranch:(id<GitHubBranch>)branch  {
	[[tableData objectAtIndex:0] addObject:branch];
	if([[tableData objectAtIndex:1] count] == 0)  {
		[[tableData objectAtIndex:1] addObject:[NSNumber numberWithBool:YES]];
	}
	else  {
		[[tableData objectAtIndex:1] addObject:[NSNumber numberWithBool:NO]];
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
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[tableData objectAtIndex:0] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	[[cell textLabel] setText:[[[tableData objectAtIndex:0] objectAtIndex:indexPath.row] name]];
	if([[[tableData objectAtIndex:1] objectAtIndex:indexPath.row] boolValue])  {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
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
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	for(int i = 0; i < [[tableData objectAtIndex:1] count]; i++)  {
		[[tableData objectAtIndex:1] replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
	}
	[[tableData objectAtIndex:1] replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
	[tableView reloadData];
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
	[tableData release];
    [super dealloc];
}


@end

