//
//  NSObject+PerformBlock.h
//  Testbed
//
//  Created by Honza Dvorsky on 02/02/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformBlock)

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
