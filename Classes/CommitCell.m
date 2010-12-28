//
//  CommitCell.m
//  SocialCoder
//
//  Created by Toni Suter on 28.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommitCell.h"


@implementation CommitCell

@synthesize commit;
@synthesize messageLabel;
@synthesize authorLabel;
@synthesize commitLabel;
@synthesize treeLabel;
@synthesize parentLabel;
@synthesize commitSha;
@synthesize treeSha;
@synthesize parentSha;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[messageLabel setFont:[UIFont systemFontOfSize:14]];
		[messageLabel setBackgroundColor:[UIColor clearColor]];
		[self addSubview:messageLabel];
		
		authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[authorLabel setFont:[UIFont systemFontOfSize:14]];
		[authorLabel setBackgroundColor:[UIColor clearColor]];
		[authorLabel setTextColor:[UIColor grayColor]];
		[self addSubview:authorLabel];
		
		commitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[commitLabel setFont:[UIFont systemFontOfSize:12]];
		[commitLabel setText:@"commit"];
		[commitLabel setBackgroundColor:[UIColor clearColor]];
		[commitLabel setTextColor:[UIColor grayColor]];
		[self addSubview:commitLabel];
		
		treeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[treeLabel setFont:[UIFont systemFontOfSize:12]];
		[treeLabel setText:@"tree"];
		[treeLabel setBackgroundColor:[UIColor clearColor]];
		[treeLabel setTextColor:[UIColor grayColor]];
		[self addSubview:treeLabel];
		
		parentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[parentLabel setFont:[UIFont systemFontOfSize:12]];
		[parentLabel setText:@"parent"];
		[parentLabel setBackgroundColor:[UIColor clearColor]];
		[parentLabel setTextColor:[UIColor grayColor]];
		[self addSubview:parentLabel];
		
		commitSha = [[UILabel alloc] initWithFrame:CGRectZero];
		[commitSha setFont:[UIFont systemFontOfSize:12]];
		[commitSha setBackgroundColor:[UIColor clearColor]];
		[commitSha setTextColor:[UIColor colorWithRed:0.26 green:0.51 blue:0.77 alpha:1.0]];
		[self addSubview:commitSha];
		
		treeSha = [[UILabel alloc] initWithFrame:CGRectZero];
		[treeSha setFont:[UIFont systemFontOfSize:12]];
		[treeSha setBackgroundColor:[UIColor clearColor]];
		[treeSha setTextColor:[UIColor colorWithRed:0.26 green:0.51 blue:0.77 alpha:1.0]];
		[self addSubview:treeSha];
		
		parentSha = [[UILabel alloc] initWithFrame:CGRectZero];
		[parentSha setFont:[UIFont systemFontOfSize:12]];
		[parentSha setBackgroundColor:[UIColor clearColor]];
		[parentSha setTextColor:[UIColor colorWithRed:0.26 green:0.51 blue:0.77 alpha:1.0]];
		[self addSubview:parentSha];
	}
    return self;
}


- (void)setCommit:(id <GitHubCommit>)commit_  {
	if(commit != commit_)  {
		[commit release];
		commit = [commit_ retain];
		[messageLabel setText:[commit message]];
		[authorLabel setText:[commit authorLogin]];
		[commitSha setText:[[commit sha] substringToIndex:20]];
		[treeSha setText:[[commit tree] substringToIndex:20]];
		[parentSha setText:[[[commit parents] objectAtIndex:0] substringToIndex:20]];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	if(selected)  {
		
	}
	else  {
		
	}
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated  {
	[super setHighlighted:highlighted animated:animated];
	if(highlighted)  {
		
	}
	else  {
		
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[messageLabel setFrame:CGRectMake(5,5,self.frame.size.width-205, 25)];
	[authorLabel setFrame:CGRectMake(70,50,self.frame.size.width-270,25)];
	[commitLabel setFrame:CGRectMake(self.frame.size.width-200,10,100,25)];
	[treeLabel setFrame:CGRectMake(self.frame.size.width-200,35,100,25)];
	[parentLabel setFrame:CGRectMake(self.frame.size.width-200,60,100,25)];
	[commitSha setFrame:CGRectMake(self.frame.size.width-150,10,150,25)];
	[treeSha setFrame:CGRectMake(self.frame.size.width-150,35,150,25)];
	[parentSha setFrame:CGRectMake(self.frame.size.width-150,60,150,25)];
}

- (void)dealloc {
	[commit release];
	[messageLabel release];
	[authorLabel release];
	[commitLabel release];
	[treeLabel release];
	[parentLabel release];
	[commitSha release];
	[treeSha release];
	[parentSha release];
    [super dealloc];
}


@end
