//
//  LoginView.m
//  SocialCoder
//
//  Created by Toni Suter on 12.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoginView.h"


@implementation LoginView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat locations[] = { 0.0, 1.0 };

	NSArray *colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.004 green:0.016 blue:0.035 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:0.071 green:0.161 blue:0.282 alpha:1.0] CGColor], nil];
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef) colors, locations);
	
	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}


- (void)dealloc {
    [super dealloc];
}


@end
