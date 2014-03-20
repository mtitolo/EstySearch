//
//  MRTShakeView.m
//  EtsySearch
//
//  Created by Michele Titolo on 3/20/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import "MRTShakeView.h"

@implementation MRTShakeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self becomeFirstResponder];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DeviceShake" object:nil];
    }
}

@end
