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
 */
@interface DUIBlockDispatcher : NSObject

+ (instancetype) blockDispatcher;

/**
 Performs the specified block after delay on the caller's queue.
 */
- (void) performBlock:(DUIBlockDispatcherBlockType)block
           afterDelay:(NSTimeInterval)delay;

/**
 Performs the specified block on the specified queue.
 */
- (void) performBlock:(DUIBlockDispatcherBlockType)block
              onQueue:(NSOperationQueue *)queue;

/**
 Performs the specified block after delay on the specified queue.
 */
- (void) performBlock:(DUIBlockDispatcherBlockType)block
           afterDelay:(NSTimeInterval)delay
              onQueue:(NSOperationQueue *)queue;
@end
