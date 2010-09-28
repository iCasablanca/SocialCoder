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

@implementation RepositoryListViewController


#pragma mark -
#pragma mark Initialization


- (id)initWithCredentials:(NSArray *)credentials  {
    if ((self = [super initWithStyle:UITableViewStylePlain])) {
        credentials_ = [credentials retain];
        
        [self.tableView setRowHeight:100.0];
        
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
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedJson = [parser objectWithString:jsonString];
    [jsonString release];
    [parser release];
    NSArray *repositories = [parsedJson objectForKey:@"repositories"];
    for(NSDictionary *repository in repositories)  {
        [tableData_ addObject:[repository objectForKey:@"name"]];
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
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [[cell textLabel] setText:[tableData_ objectAtIndex:indexPath.row]];
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    
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
