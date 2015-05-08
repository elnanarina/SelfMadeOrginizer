//
//  PushNoAnimationSegue.m
//  selfMade
//
//  Created by Air on 1/12/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "PushNoAnimationSegue.h"

@implementation PushNoAnimationSegue
-(void) perform{
    [[[self sourceViewController] navigationController] pushViewController:[self   destinationViewController] animated:NO];
}
@end
