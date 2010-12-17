//
//  RepositoriesViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 27.09.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

@class RepositoryListViewController;
@class FileBrowserViewController;

@interface RepositoriesViewController : UIViewController {
	FileBrowserViewController *fileBrowserViewController_;
	
@private
    RepositoryListViewController *repositoryListViewController_;
    NSArray *credentials_;
}

@property(nonatomic, retain)FileBrowserViewController *fileBrowserViewController_;

- (id)initWithCredentials:(NSArray *)credentials;

@end
