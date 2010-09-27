//
//  UserInfoViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 23.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoHeaderView.h"
#import "JSON/JSON.h"

@implementation UserInfoViewController


#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
		userInfoHeaderView_ = [[UserInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
		[self.tableView setTableHeaderView:userInfoHeaderView_];
        
        tableData_ = [[NSMutableArray alloc] initWithObjects:[NSMutableArray array], [NSMutableArray array], nil];
        receivedData_ = [[NSMutableData alloc] init];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        NSURL *url = [NSURL URLWithString:@"http://github.com/api/v2/json/user/show/tlrobinson"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
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
    [parser release];
    NSDictionary *user = [parsedJson objectForKey:@"user"];

    if([user objectForKey:@"blog"]!= nil && [user objectForKey:@"blog"] != [NSNull null] && ![[user objectForKey:@"blog"] isEqualToString:@""])  {
        [[tableData_ objectAtIndex:0] addObject:@"Blog"];
        [[tableData_ objectAtIndex:1] addObject:[user objectForKey:@"blog"]];
    }
    if([user objectForKey:@"company"]!= nil && [user objectForKey:@"company"] != [NSNull null] && ![[user objectForKey:@"company"] isEqualToString:@""] )  {
        [[tableData_ objectAtIndex:0] addObject:@"Company"];
        [[tableData_ objectAtIndex:1] addObject:[user objectForKey:@"company"]];
    }
    if([user objectForKey:@"created_at"]!= nil && [user objectForKey:@"created_at"] != [NSNull null] && ![[user objectForKey:@"created_at"] isEqualToString:@""])  {
        [[tableData_ objectAtIndex:0] addObject:@"Member Since"];
        [[tableData_ objectAtIndex:1] addObject:[user objectForKey:@"created_at"]];
    }
    if([user objectForKey:@"email"]!= nil && [user objectForKey:@"email"] != [NSNull null] && ![[user objectForKey:@"email"] isEqualToString:@""])  {
        [[tableData_ objectAtIndex:0] addObject:@"Email"];
        [[tableData_ objectAtIndex:1] addObject:[user objectForKey:@"email"]];
    }
    if([user objectForKey:@"followers_count"]!= nil && [user objectForKey:@"followers_count"] != [NSNull null])  {
        [[tableData_ objectAtIndex:0] addObject:@"Followers"];
        [[tableData_ objectAtIndex:1] addObject:[[user objectForKey:@"followers_count"] stringValue]];
    }
    if([user objectForKey:@"following_count"]!= nil && [user objectForKey:@"following_count"] != [NSNull null])  {
        [[tableData_ objectAtIndex:0] addObject:@"Following"];
        [[tableData_ objectAtIndex:1] addObject:[[user objectForKey:@"following_count"] stringValue]];
    }
    if([user objectForKey:@"location"]!= nil && [user objectForKey:@"location"] != [NSNull null] && ![[user objectForKey:@"location"] isEqualToString:@""])  {
        [[tableData_ objectAtIndex:0] addObject:@"Location"];
        [[tableData_ objectAtIndex:1] addObject:[user objectForKey:@"location"]];
    }
    if([user objectForKey:@"public_gist_count"]!= nil && [user objectForKey:@"public_gist_count"] != [NSNull null])  {
        [[tableData_ objectAtIndex:0] addObject:@"Gists"];
        [[tableData_ objectAtIndex:1] addObject:[[user objectForKey:@"public_gist_count"] stringValue]];
    }
    if([user objectForKey:@"public_repo_count"]!= nil && [user objectForKey:@"public_repo_count"] != [NSNull null])  {
        [[tableData_ objectAtIndex:0] addObject:@"Repos"];
        [[tableData_ objectAtIndex:1] addObject:[[user objectForKey:@"public_repo_count"] stringValue]];
    }
    if([user objectForKey:@"type"]!= nil && [user objectForKey:@"type"] != [NSNull null] && ![[user objectForKey:@"type"] isEqualToString:@""])  {
        [[tableData_ objectAtIndex:0] addObject:@"Type"];
        [[tableData_ objectAtIndex:1] addObject:[user objectForKey:@"type"]];
    }
    
    
    if([user objectForKey:@"login"]!= nil && [user objectForKey:@"login"] != [NSNull null] && ![[user objectForKey:@"login"] isEqualToString:@""])  {
        [userInfoHeaderView_ setNickname:[user objectForKey:@"login"]];
    }
    if([user objectForKey:@"name"]!= nil && [user objectForKey:@"name"] != [NSNull null] && ![[user objectForKey:@"name"] isEqualToString:@""])  {
        [userInfoHeaderView_ setFullname:[user objectForKey:@"name"]];
    }
    if([user objectForKey:@"gravatar_id"]!= nil && [user objectForKey:@"gravatar_id"] != [NSNull null] && ![[user objectForKey:@"gravatar_id"] isEqualToString:@""])  {
        UIImage *avatar = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@", [user objectForKey:@"gravatar_id"]]]]];
        [userInfoHeaderView_ setAvatar:avatar];
        [avatar release];
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
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[tableData_ objectAtIndex:0] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [[cell textLabel] setText:[[tableData_ objectAtIndex:1] objectAtIndex:indexPath.row]];
    [[cell detailTextLabel] setText:[[tableData_ objectAtIndex:0] objectAtIndex:indexPath.row]];
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
    if([[[tableData_ objectAtIndex:0] objectAtIndex:indexPath.row] isEqualToString:@"Email"])  {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        [mailController setMailComposeDelegate:self];
        [mailController setToRecipients:[NSArray arrayWithObject:[[tableData_ objectAtIndex:1] objectAtIndex:indexPath.row]]];
        [mailController setModalPresentationStyle:UIModalPresentationFormSheet];
        [self presentModalViewController:mailController animated:YES];
        [mailController release];   
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error  {
    [self becomeFirstResponder];
    [self dismissModalViewControllerAnimated:YES];
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
	[userInfoHeaderView_ release];
    [receivedData_ release];
    [tableData_ release];
    [super dealloc];
}


@end

