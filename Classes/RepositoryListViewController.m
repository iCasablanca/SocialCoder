//
//  RepositoryListViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 27.09.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "RepositoryListViewController.h"
#import "JSON/JSON.h"
#import "Base64.h"
#import "SocialCoderAppDelegate.h"
#import "RepositoriesViewController.h"
#import "FileBrowserViewController.h"

@implementation RepositoryListViewController


#pragma mark -
#pragma mark Initialization


- (id)initWithCredentials:(NSArray *)credentials  {
    if ((self = [super initWithStyle:UITableViewStylePlain])) {
        credentials_ = [credentials retain];
        
        [self.tableView setRowHeight:100.0];
		
		UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.tableView.frame.size.width,50)];
		[tableHeaderView setBackgroundColor:[UIColor colorWithRed:0.7 green:0.6 blue:0.6 alpha:1.0]];
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:[tableHeaderView bounds]];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setText:@"   Repositories (4)"];
		//[titleLabel setTextAlignment:UITextAlignmentCenter];
		[titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:18]];
		[tableHeaderView addSubview:titleLabel];
		
		[self.tableView setTableHeaderView:tableHeaderView];
		[tableHeaderView release];
        
        tableData_ = [[NSMutableArray alloc] init];
        receivedData_ = [[NSMutableData alloc] init];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"http://github.com/api/v2/json/repos/show/", [credentials_ objectAtIndex:0]]];
        NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", [credentials_ objectAtIndex:0], [credentials_ objectAtIndex:1]];  
        char *encodedLoginData = [Base64 encode:[loginString dataUsingEncoding:NSUTF8StringEncoding]];  
        NSString *authHeader = [NSString stringWithFormat:@"Basic %@", [NSString stringWithUTF8String:encodedLoginData]];  
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3];     
        [request addValue:authHeader forHTTPHeaderField:@"Authorization"];  
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection release];
    }
    return self;
}

#pragma mark -
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data  {
    [receivedData_ appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection  {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSString *jsonString = [[NSString alloc] initWithData:receivedData_ encoding:NSISOLatin1StringEncoding];
	NSLog(@"%@", jsonString);
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedJson = [parser objectWithString:jsonString];
    [jsonString release];
    [parser release];
    NSArray *repositories = [parsedJson objectForKey:@"repositories"];
    for(NSDictionary *repository in repositories)  {
		NSMutableArray *datapoint = [NSMutableArray arrayWithObjects:[repository objectForKey:@"name"], [repository objectForKey:@"description"], nil];
        [tableData_ addObject:datapoint];
    }

    [self.tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error  {
    if([error code])  {
        NSLog(@"%@ %d %@", [error domain], [error code], [error localizedDescription]);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response  {
    
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.63 green:0.6 blue:0.6 alpha:1.0]];
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData_ count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [[cell textLabel] setText:[[tableData_ objectAtIndex:indexPath.row] objectAtIndex:0]];
	[[cell detailTextLabel] setTextColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0]];
	[[cell detailTextLabel] setHighlightedTextColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]];
	[[cell detailTextLabel] setText:[[tableData_ objectAtIndex:indexPath.row] objectAtIndex:1]];
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
	[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
	[[cell textLabel] setTextColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0]];
	[[cell textLabel] setHighlightedTextColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]];
	[[cell textLabel] setFont:[UIFont fontWithName:@"Chalkduster" size:16]];
    
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
	[[(RepositoriesViewController*)[(SocialCoderAppDelegate*)[[UIApplication sharedApplication] delegate] repositoriesViewController_] fileBrowserViewController_] setRepository:@"socialcoder"];
	//f[(FileBrowserViewController*)[(RepositoriesViewController*)[[[UIApplication sharedApplication] delegate] rep] fileBrowserViewController_] setRepository:@"socialcoder"];
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
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [receivedData_ release];
    [tableData_ release];
    [credentials_ release];
    [super dealloc];
}


@end

