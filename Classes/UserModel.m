//
//  UserModel.m
//  SocialCoder
//
//  Created by Toni Suter on 21.09.10.
//  Copyright 2010 Toni Suter. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

@synthesize username = _username;
@synthesize properties = _properties;

- (id)initWithUsername:(NSString*)username {
	if (self = [super init]) {
		self.username = username;
	}
	
	return self;
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLDataResponse* response = request.response;
	
	// Useful debugging logic.
	 NSString* string = [[NSString alloc] initWithData: response.data
	                                          encoding: NSUTF8StringEncoding];
	 NSLog(@"string: %@", string);
	 TT_RELEASE_SAFELY(string);
	
	// Ensure that we don't cause a leak.
	TT_RELEASE_SAFELY(_properties);
	_properties = [[NSMutableDictionary alloc] init];
	
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData:response.data];
	parser.delegate = self;
	[parser parse];
	TT_RELEASE_SAFELY(parser);
	
	[super requestDidFinishLoad:request];
}

- (void)setActivePropertyKey:(NSString*)activePropertyKey type:(NSString*)type {
	NSString* keyCopy = [activePropertyKey copy];
	[_activePropertyKey release];
	_activePropertyKey = keyCopy;
	
	NSString* typeCopy = [type copy];
	[_activePropertyType release];
	_activePropertyType = typeCopy;
}

- (void)parser:          (NSXMLParser*)parser
didStartElement: (NSString*)elementName
  namespaceURI: (NSString*)namespaceURI
 qualifiedName: (NSString*)qName
	attributes: (NSDictionary*)attributeDict {
	if( ![elementName isEqualToString:@"user"] ) {
		[self setActivePropertyKey: elementName
							  type: [attributeDict objectForKey:@"type"]];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if( nil != _activePropertyKey ) {
		NSString* property = [_properties objectForKey:_activePropertyKey];
		if( nil == property ) {
			property = [[NSString alloc] init];
			[_properties setObject:property forKey:_activePropertyKey];
			[property release];
		}
		
		[_properties setObject: [property stringByAppendingString:string]
						forKey: _activePropertyKey];
	}
}

- (void)parser:        (NSXMLParser *)parser
 didEndElement: (NSString *)elementName
  namespaceURI: (NSString *)namespaceURI
 qualifiedName: (NSString *)qName {
	if( nil != _activePropertyKey && nil != _activePropertyType ) {
		if( [_activePropertyType isEqualToString:@"integer"] ) {
			NSString* property = [_properties objectForKey:_activePropertyKey];
			[_properties setObject: [NSNumber numberWithInt:[property intValue]]
							forKey: _activePropertyKey];
			
		} else if( [_activePropertyType isEqualToString:@"datetime"] ) {
			NSString* property = [_properties objectForKey:_activePropertyKey];
			
			// Remove the last colon for iOS4 NSDateFormatter pickiness
			property = [[property substringToIndex:[property length] - 3]
						stringByAppendingString:@"00"];
			
			NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
			[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
			
			NSDate* date = [dateFormatter dateFromString:property];
			TT_RELEASE_SAFELY(dateFormatter);
			
			[_properties setObject:date forKey:_activePropertyKey];
		}
	}
	
	[self setActivePropertyKey:nil type:nil];
}



- (void)dealloc {
	TT_RELEASE_SAFELY(_username);
	TT_RELEASE_SAFELY(_properties);
	TT_RELEASE_SAFELY(_activePropertyKey);
	TT_RELEASE_SAFELY(_activePropertyType);	
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading && TTIsStringWithAnyText(_username)) {
		NSString* url = [@"http://github.com/api/v2/xml/user/show/"
						 stringByAppendingString:_username];
		
		TTURLRequest* request = [TTURLRequest
								 requestWithURL: url
								 delegate: self];
		
		id<TTURLResponse> response = [[TTURLDataResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[request send];
	}
}

@end
