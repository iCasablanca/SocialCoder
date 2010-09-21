//
//  UserModel.h
//  SocialCoder
//
//  Created by Toni Suter on 21.09.10.
//  Copyright 2010 Toni Suter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : TTURLRequestModel<NSXMLParserDelegate> {
	NSString*             _username;
	NSMutableDictionary*  _properties;
	NSString*             _activePropertyKey;
	NSString*             _activePropertyType;	
}

@property (nonatomic, copy)     NSString*             username;
@property (nonatomic, readonly) NSMutableDictionary*  properties;

- (id)initWithUsername:(NSString*)username;
- (void)setActivePropertyKey:(NSString *)activePropertyKey type:(NSString *)type;

@end
