//
//  NewsFeedViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 23.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsFeedViewController : UITableViewController {
@private
    NSArray *credentials_;
}

- (id)initWithCredentials:(NSArray *)credentials;

@end
