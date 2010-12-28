//
//  CommitCell.h
//  SocialCoder
//
//  Created by Toni Suter on 28.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubCommit.h"

@interface CommitCell : UITableViewCell {
	id<GitHubCommit> commit;
	UILabel *messageLabel;
	UILabel *authorLabel;
	UILabel *commitLabel;
	UILabel *treeLabel;
	UILabel *parentLabel;
	UILabel *commitSha;
	UILabel *treeSha;
	UILabel *parentSha;
}

@property(nonatomic, retain)id<GitHubCommit> commit;
@property(nonatomic, retain)UILabel *messageLabel;
@property(nonatomic, retain)UILabel *authorLabel;
@property(nonatomic, retain)UILabel *commitLabel;
@property(nonatomic, retain)UILabel *treeLabel;
@property(nonatomic, retain)UILabel *parentLabel;
@property(nonatomic, retain)UILabel *commitSha;
@property(nonatomic, retain)UILabel *treeSha;
@property(nonatomic, retain)UILabel *parentSha;

@end
