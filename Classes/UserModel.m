#import "UserModel.h"

@implementation UserModel

@synthesize username = _username;

- (id)initWithUsername:(NSString*)username {
	if (self = [super init]) {
		self.username = username;
	}
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_username);
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
