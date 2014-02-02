//
//  NSObject+PerformBlock.h
//  Testbed
//
//  Created by Honza Dvorsky on 02/02/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUIBlockDispatcher.h"

/**
 The delay specifies not the time interval after which the
 block will be executed, but the time when it's added to the
 target queue. These two times can differ depending on the
 queue.
 */
@interface NSObject (PerformBlock)

/**
 Performs the specified block on the caller's queue after specified delay.
 */
- (void) performBlock:(void (^)(void))block
           afterDelay:(NSTimeInterval)delay;

/**
 Performs the specified block on the specified queue.
 */
- (void) performBlock:(void (^)(void))block
              onQueue:(NSOperationQueue *)queue;

/**
 Performs the specified block after delay on the specified queue.
 */
- (void) performBlock:(void (^)(void))block
           afterDelay:(NSTimeInterval)delay
              onQueue:(NSOperationQueue *)queue;

@end
