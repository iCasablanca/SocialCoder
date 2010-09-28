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
@private
    RepositoryListViewController *repositoryListViewController_;
    FileBrowserViewController *fileBrowserViewController_;
    NSArray *credentials_;
}

- (id)initWithCredentials:(NSArray *)credentials;

@end
