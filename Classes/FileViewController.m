    //
//  FileViewController.m
//  SocialCoder
//
//  Created by Toni Suter on 31.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FileViewController.h"
#import "GitHubServiceSettings.h"
#import "GitHubObjectServiceFactory.h"
#import "NSData+Base64.h"


@implementation FileViewController

- (id)initWithTreeSha:(NSString *)sha_ repository:(NSString *)repository_ treeItem:(id<GitHubTreeItem>)treeItem_  {
    self = [super init];
    if(self)  {
        [self setTitle:[treeItem_ name]];
        [GitHubObjectServiceFactory requestBlobWithDataByTreeSha:sha_
                                                            user:[[GitHubServiceSettings credential] user] 
                                                      repository:repository_
                                                            path:[treeItem_ name]
                                                        delegate:self];
        

    }
    return self;
}

- (void)gitHubService:(id <GitHubService>)gitHubService gotBlob:(id <GitHubBlob>)blob  {
    if([[blob mime] rangeOfString:@"image"].location != NSNotFound)  {        
        NSMutableString *path = [NSMutableString stringWithFormat:@"https://github.com/tonisuter/%@/raw/master", [[[self.navigationController viewControllers] objectAtIndex:1] title]];
        for(int i = 2; i < [[self.navigationController viewControllers] count]; i++)  {
            [path appendFormat:@"/%@", [[[self.navigationController viewControllers] objectAtIndex:i] title]];
        }

        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]]];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,imgView.frame.size.width+10, imgView.frame.size.height+10)];
        [imgView setCenter:bgView.center];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [bgView addSubview:imgView];
        [bgView setCenter:self.view.center];
        [bgView.layer setCornerRadius:5.0];
        [bgView.layer setShadowColor:[UIColor blackColor].CGColor];
        [bgView.layer setShadowOffset:CGSizeMake(5,10)];
        [bgView.layer setShadowOpacity:1.0];
        [bgView.layer setShadowRadius:5.0];
        [bgView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [self.view addSubview:bgView];
        
        [self.view setBackgroundColor:[UIColor grayColor]];

    }
    else  {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        [textView setBackgroundColor:[UIColor grayColor]];
        [textView setText:[blob data]];
        [textView setFont:[UIFont systemFontOfSize:16.0]];

        [textView setTextColor:[UIColor colorWithRed:0.89 green:0.87 blue:0.81 alpha:1.0]];
        [self.view addSubview:textView];
        [textView release];
    }
}

-(void)gitHubService:(id<GitHubService>)gitHubService didFailWithError:(NSError *)error  {
	NSLog(@"%@", [error description]);
}

-(void)gitHubServiceDone:(id<GitHubService>)gitHubService  {
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

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
    [super dealloc];
}


@end
