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
 PerformBlock is a category - a shortcut for adding blocks
 to queues after specified delay. The delay specifies not
 the time interval after which the block will be executed,
 but the time when it will be added to the target queue.
 These two times can differ depending on the queue, but should
 be quite similar on the main queue.
 
 The dispatcher is thread safe and supports adding multiple
 blocks from multiple threads.
 
 @see DUIBlockDispatcher
 */
@interface NSObject (PerformBlock)

/**
 Dispatches the specified block to the caller's queue after delay.
 @param block A block of work passed in. Must not be nil.
 @param delay Delay between now and when the block is placed on the specified queue.
 */
- (void) performBlock:(void (^)(void))block
           afterDelay:(NSTimeInterval)delay;

/**
 Dispatches the specified block on the specified queue.
 @param block A block of work passed in. Must not be nil.
 @param queue Operation queue on which the block should be placed after delay. If nil,
 the current queue (the caller's queue) is used.
 */
- (void) performBlock:(void (^)(void))block
              onQueue:(NSOperationQueue *)queue;

/**
 Dispatches the specified block after delay on the specified queue.
 @param block A block of work passed in. Must not be nil.
 @param delay Delay between now and when the block is placed on the specified queue.
 @param queue Operation queue on which the block should be placed after delay. If nil,
 the current queue (the caller's queue) is used.
 */
- (void) performBlock:(void (^)(void))block
           afterDelay:(NSTimeInterval)delay
              onQueue:(NSOperationQueue *)queue;

@end



