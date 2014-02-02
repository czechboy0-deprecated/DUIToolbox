//
//  DUIBlockDispatcher.h
//  Testbed
//
//  Created by Honza Dvorsky on 02/02/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^DUIBlockDispatcherBlockType)(void);

/**
 The delay specifies not the time interval after which the
 block will be executed, but the time when it's added to the
 target queue. These two times can differ depending on the
 queue.
 The dispatcher is thread safe and supports adding multiple
 blocks from multiple threads.
 */
@interface DUIBlockDispatcher : NSObject

+ (instancetype) blockDispatcher;

/**
 Dispatches the specified block after delay on the caller's queue.
 */
- (void) dispatchBlock:(DUIBlockDispatcherBlockType)block
            afterDelay:(NSTimeInterval)delay;

/**
 Dispatches the specified block on the specified queue.
 */
- (void) dispatchBlock:(DUIBlockDispatcherBlockType)block
               onQueue:(NSOperationQueue *)queue;

/**
 Dispatches the specified block after delay on the specified queue.
 @param block A block of work passed in. Must not be nil.
 @param delay Delay between now and when the block is placed on the specified queue.
 @param queue Operation queue on which the block should be placed after delay. If nil,
 the current queue (the caller's queue) is used.
 */
- (void) dispatchBlock:(DUIBlockDispatcherBlockType)block
            afterDelay:(NSTimeInterval)delay
               onQueue:(NSOperationQueue *)queue;
@end
