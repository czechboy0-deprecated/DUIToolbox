//
//  NSObject+PerformBlock.m
//  Testbed
//
//  Created by Honza Dvorsky on 02/02/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import "NSObject+PerformBlock.h"
#import "DUIBlockDispatcher.h"
#import <objc/runtime.h>

const void *UniqueKey = &UniqueKey;

@implementation NSObject (PerformBlock)

#pragma mark - NSObject (PerformBlock)
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) performBlock:(void (^)(void))block
           afterDelay:(NSTimeInterval)delay
              onQueue:(NSOperationQueue *)queue
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    [[self _localDispatcher] dispatchBlock:block
                                afterDelay:delay
                                   onQueue:queue];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) performBlock:(void (^)(void))block
           afterDelay:(NSTimeInterval)delay
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    [self performBlock:block
            afterDelay:delay
               onQueue:nil];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) performBlock:(void (^)(void))block
              onQueue:(NSOperationQueue *)queue
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    [self performBlock:block
            afterDelay:0.0
               onQueue:queue];
}

#pragma mark - Private Methods
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (DUIBlockDispatcher *) _localDispatcher
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    @synchronized(self) {
        DUIBlockDispatcher *disp = objc_getAssociatedObject(self, UniqueKey);
        if (!disp) {
            disp = [DUIBlockDispatcher new];
            objc_setAssociatedObject(self, UniqueKey, disp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return disp;
    }
}


@end
