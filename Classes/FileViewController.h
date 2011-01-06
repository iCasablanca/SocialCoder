//
//  FileViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 31.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubServiceGotBlobDelegate.h"
#import "GitHubTreeItem.h"

@interface FileViewController : UIViewController<GitHubServiceGotBlobDelegate> {

}

- (id)initWithTreeSha:(NSString *)sha_ repository:(NSString *)repository_ treeItem:(id<GitHubTreeItem>)treeItem_;

@end
