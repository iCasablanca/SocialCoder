//
//  UserViewController.h
//  SocialCoder
//
//  Created by Toni Suter on 21.09.10.
//  Copyright 2010 Toni Suter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserViewController : TTTableViewController {
	NSString* _username;
}

@property (nonatomic, copy) NSString* username;

@end
