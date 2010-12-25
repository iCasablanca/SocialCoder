//
//  MenuTableViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 17.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MenuTableViewController : UITableViewController {
	id menuDelegate;
}

@property(nonatomic, assign)id menuDelegate;

@end
