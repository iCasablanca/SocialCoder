#import <Foundation/Foundation.h>

@interface UserModel : TTURLRequestModel {
	NSString* _username;
}

@property (nonatomic, copy) NSString* username;

- (id)initWithUsername:(NSString*)username;

@end
