//
//  MenuTableViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 17.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuTableViewController.h"


@implementation MenuTableViewController

@synthesize menuDelegate;

#pragma mark -
#pragma mark Initialization


- (id)init  {
    self = [super init];
    if (self) {
		[self.view setBackgroundColor:[UIColor clearColor]];
		UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.tableView.frame.size.width, 70)];
		[self.tableView setTableHeaderView:headerView];
	
		[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
	//self.clearsSelectionOnViewWillAppear = NO;
	[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

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
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	
	UIImageView *bg = [[UIImageView alloc] initWithFrame:[cell bounds]];
	[bg setImage:[UIImage imageNamed:@"rowBackground.png"]];
	[cell setBackgroundView:bg];
	[bg release];
	
	UIImageView *bgSelected = [[UIImageView alloc] initWithFrame:[cell bounds]];
	[bgSelected setImage:[UIImage imageNamed:@"rowBackgroundSelected.png"]];
	[cell setSelectedBackgroundView:bgSelected];
	[bgSelected release];
	

	
	if(indexPath.row == 0)  {
		[[cell textLabel] setText:@"Feed"];
	}
	else  if(indexPath.row == 1)  {
		[[cell textLabel] setText:@"Repositories"];
	}
	else  if(indexPath.row == 2)  {
		[[cell textLabel] setText:@"Gists"];
	}
	else  if(indexPath.row == 3)  {
		[[cell textLabel] setText:@"Search"];
	}
	
	//[[cell textLabel] setTextColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
    
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
	[menuDelegate menuDidChange:indexPath.row];
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
    [super dealloc];
}


@end
