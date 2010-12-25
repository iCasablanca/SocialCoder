//
//  RepositoryCell.h
//  SocialCoder
//
//  Created by Toni Suter on 19.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RepositoryCell : UITableViewCell {
	UILabel *nameLabel;
	UILabel *descLabel;
	UILabel *homepageLabel;
	UILabel *forksLabel;
	UILabel *watchersLabel;
	UIImageView *forksIcon;
	UIImageView *watchersIcon;
	BOOL fork;
	BOOL private;
}

@property(nonatomic, retain)UILabel *nameLabel;
@property(nonatomic, retain)UILabel *descLabel;
@property(nonatomic, retain)UILabel *homepageLabel;
@property(nonatomic, retain)UILabel *forksLabel;
@property(nonatomic, retain)UILabel *watchersLabel;
@property(nonatomic, retain)UIImageView *forksIcon;
@property(nonatomic, retain)UIImageView *watchersIcon;
@property(nonatomic, assign)BOOL fork;
@property(nonatomic, assign)BOOL private;

@end
