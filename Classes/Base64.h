//
//  Base64.h
//  SocialCoder
//
//  Created by Toni Suter on 27.09.10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Base64 : NSObject {

}

+(char *)encode:(NSData *)plainText;

@end
