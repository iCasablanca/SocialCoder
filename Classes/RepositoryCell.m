//
//  RepositoryCell.m
//  SocialCoder
//
//  Created by Toni Suter on 19.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RepositoryCell.h"

@implementation RepositoryCell

@synthesize nameLabel;
@synthesize descLabel;
@synthesize homepageLabel;
@synthesize forksLabel;
@synthesize watchersLabel;
@synthesize forksIcon;
@synthesize watchersIcon;
@synthesize fork;
@synthesize private;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        UIImageView *bg = [[UIImageView alloc] initWithFrame:[self bounds]];
        [bg setImage:[UIImage imageNamed:@"rowBg1.png"]];
        [self setBackgroundView:bg];
        [bg release];
        
        UIImageView *bg2 = [[UIImageView alloc] initWithFrame:[self bounds]];
        [bg2 setImage:[UIImage imageNamed:@"rowBg2.png"]];
        [self setSelectedBackgroundView:bg2];
        [bg2 release];
		
		nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10,self.contentView.frame.size.width-10,30)];
		[nameLabel setText:@"<name>"];
		[nameLabel setFont:[UIFont boldSystemFontOfSize:25]];
		[nameLabel setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:nameLabel];
		
		descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,40,self.contentView.frame.size.width-10,25)];
		[descLabel setText:@"<desc>"];
		[descLabel setFont:[UIFont systemFontOfSize:14]];
		[descLabel setTextColor:[UIColor colorWithRed:0.51 green:0.50 blue:0.45 alpha:1.0]];
		[descLabel setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:descLabel];
		
		homepageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,65,self.contentView.frame.size.width-10,25)];
		[homepageLabel setText:@"<homepage>"];
		[homepageLabel setFont:[UIFont systemFontOfSize:14]];
		[homepageLabel setTextColor:[UIColor colorWithRed:0.51 green:0.50 blue:0.8 alpha:1.0]];
		[homepageLabel setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:homepageLabel];
		
		forksLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,50,25)];
		[forksLabel setText:@"<forks>"];
		[forksLabel setFont:[UIFont systemFontOfSize:14]];
		[forksLabel setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:forksLabel];
		
		watchersLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,50,25)];
		[watchersLabel setText:@"<watchers>"];
		[watchersLabel setFont:[UIFont systemFontOfSize:14]];
		[watchersLabel setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:watchersLabel];
		
		forksIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forks.png"]];
		[self.contentView addSubview:forksIcon];
		
		watchersIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"watchers.png"]];
		[self.contentView addSubview:watchersIcon];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
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
	[forksLabel setCenter:CGPointMake(self.contentView.frame.size.width-25, [nameLabel center].y)];
	[watchersLabel setCenter:CGPointMake(self.contentView.frame.size.width-75, [nameLabel center].y)];
	[forksIcon setCenter:CGPointMake(self.contentView.frame.size.width-60, [nameLabel center].y)];
	[watchersIcon setCenter:CGPointMake(self.contentView.frame.size.width-110, [nameLabel center].y)];
}

- (void)dealloc {
	[nameLabel release];
	[descLabel release];
	[homepageLabel release];
	[forksLabel release];
	[watchersLabel release];
	[forksIcon release];
	[watchersIcon release];
    [super dealloc];
}


@end






