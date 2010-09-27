//
//  RepositoryListViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 27.09.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RepositoryListViewController : UITableViewController {
@private
    NSMutableData *receivedData_;
    NSMutableArray *tableData_;
    NSArray *credentials_;
}

- (id)initWithCredentials:(NSArray *)credentials;

@end
