//
//  UserDataSource.m
//  SocialCoder
//
//  Created by Toni Suter on 21.09.10.
//  Copyright 2010 Toni Suter. All rights reserved.
//

#import "UserDataSource.h"
#import "UserModel.h"

@implementation UserDataSource

- (id)initWithUsername:(NSString*)username {
	if (self = [self init]) {
		_usermodel = [[UserModel alloc] initWithUsername:username];
	}
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_usermodel);
	
	[super dealloc];
}

- (id<TTModel>)model {
	return _usermodel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* sections = [[NSMutableArray alloc] init];
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	{
		// This section has no title.
		[sections addObject:@""];
		
		NSMutableArray* itemRows = [[NSMutableArray alloc] init];
		
		NSString* name = [_usermodel.properties objectForKey:@"name"];
		NSString* email = [_usermodel.properties objectForKey:@"email"];
		NSString* company = [_usermodel.properties objectForKey:@"company"];
		NSString* blog = [_usermodel.properties objectForKey:@"blog"];
		NSString* location = [_usermodel.properties objectForKey:@"location"];
		NSDate* memberSince = [_usermodel.properties objectForKey:@"created-at"];
		NSString *gravatarID = [_usermodel.properties objectForKey:@"gravatar-id"];
			
		NSString* imageUrl = [@"http://www.gravatar.com/avatar/" stringByAppendingString:gravatarID];
			
		TTStyle* style = [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
						 [TTSolidBorderStyle styleWithColor:[UIColor colorWithWhite:0.86 alpha:1] width:1 next:
						 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(2, 2, 2, 2) next:
						 [TTContentStyle styleWithNext:
						 [TTImageStyle styleWithImageURL:nil defaultImage:nil contentMode:UIViewContentModeScaleAspectFill size:CGSizeMake(50, 50) next:nil]]]]];
			
		[itemRows addObject:[TTTableImageItem
							 itemWithText: name
							 imageURL: imageUrl
							 defaultImage: TTIMAGE(@"bundle://default-avatar.png")
							 imageStyle: style
							 URL: nil]];
		
		
		if( TTIsStringWithAnyText(email) ) {
			[itemRows addObject:[TTTableCaptionItem itemWithText:email
														 caption:@"Email"]];
		}
		
		if( TTIsStringWithAnyText(blog) ) {
			[itemRows addObject:[TTTableCaptionItem
								 itemWithText: [[blog
												 stringByReplacingOccurrencesOfString:@"http://"
												 withString:@""]
												stringByTrimmingCharactersInSet:[NSCharacterSet
																				 characterSetWithCharactersInString:@"/"]]
								 caption: @"Website/Blog"
								 URL: blog]];
		}
		
		if( TTIsStringWithAnyText(company) ) {
			[itemRows addObject:[TTTableCaptionItem itemWithText:company
														 caption:@"Company"]];
		}
		
		if( TTIsStringWithAnyText(location) ) {
			[itemRows addObject:[TTTableCaptionItem itemWithText:location
														 caption:@"Location"]];
		}
		
		if( nil != memberSince ) {
			NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
			formatter.dateFormat = @"LLLL d, YYYY";
			[itemRows addObject:[TTTableCaptionItem
								 itemWithText: [formatter stringFromDate:memberSince]
								 caption: @"Member Since"]];
			TT_RELEASE_SAFELY(formatter);
		}
		
		[items addObject:itemRows];
		TT_RELEASE_SAFELY(itemRows);
	}
	
	
	{
		[sections addObject:@"Stats"];
		
		NSMutableArray* itemRows = [[NSMutableArray alloc] init];
		
		NSNumber* publicRepoCount = [_usermodel.properties
									 objectForKey:@"public-repo-count"];
		if( nil != publicRepoCount ) {
			[itemRows addObject:[TTTableTextItem
								 itemWithText: [NSString stringWithFormat:@"%d public repos",
												[publicRepoCount intValue]]]];
		}
		
		NSNumber* followersCount = [_usermodel.properties objectForKey:@"followers-count"];
		if( nil != followersCount ) {
			[itemRows addObject:[TTTableTextItem
								 itemWithText: [NSString stringWithFormat:@"%d followers",
												[followersCount intValue]]]];
		}
		
		NSNumber* followingCount = [_usermodel.properties objectForKey:@"following-count"];
		if( nil != followingCount ) {
			[itemRows addObject:[TTTableTextItem
								 itemWithText: [NSString stringWithFormat:@"Following %d githubbers",
												[followingCount intValue]]]];
		}
		
		[items addObject:itemRows];
		
		TT_RELEASE_SAFELY(itemRows);
	}
	
	
	self.sections = sections;
	self.items = items;
	
	TT_RELEASE_SAFELY(sections);
	TT_RELEASE_SAFELY(items);
	
}


@end
