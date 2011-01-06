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
        UIImageView *v = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithBase64EncodedString:[blob data]]]];
    //    [v setFrame:CGRectMake(0,0,200,211)];
    //    [v setAlpha:1.0];
        [self.view addSubview:v];
        [self.view setBackgroundColor:[UIColor greenColor]];
    }
    else  {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        [textView setText:[blob data]];
        [self.view addSubview:textView];
        [textView release];
    }
}

- (NSString *)decodeBase64:(NSString *)input {
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-";
    NSString *decoded = @"";
    NSString *encoded = [input stringByPaddingToLength:(ceil([input length] / 4) * 4)
                                            withString:@"A"
                                       startingAtIndex:0];
    
    int i;
    char a, b, c, d;
    UInt32 z;
    
    for(i = 0; i < [encoded length]; i += 4) {
        a = [alphabet rangeOfString:[encoded substringWithRange:NSMakeRange(i + 0, 1)]].location;
        b = [alphabet rangeOfString:[encoded substringWithRange:NSMakeRange(i + 1, 1)]].location;
        c = [alphabet rangeOfString:[encoded substringWithRange:NSMakeRange(i + 2, 1)]].location;
        d = [alphabet rangeOfString:[encoded substringWithRange:NSMakeRange(i + 3, 1)]].location;
        
        z = ((UInt32)a << 26) + ((UInt32)b << 20) + ((UInt32)c << 14) + ((UInt32)d << 8);
        decoded = [decoded stringByAppendingString:[NSString stringWithCString:(char *)&z]];
    }
    
    return decoded;
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
