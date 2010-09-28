//
//  RepositoryListViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 27.09.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


@interface RepositoryListViewController : UITableViewController {
@private
    NSMutableData *receivedData_;
    NSMutableArray *tableData_;
    NSArray *credentials_;
}

- (id)initWithCredentials:(NSArray *)credentials;

@end
