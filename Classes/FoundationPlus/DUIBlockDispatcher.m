//
//  DUIBlockDispatcher.m
//  Testbed
//
//  Created by Honza Dvorsky on 02/02/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import "DUIBlockDispatcher.h"

@interface DUIBlockDispatcher ()

@property (nonatomic, strong) NSMutableDictionary *blocksToPerform;

@end

@implementation DUIBlockDispatcher

#pragma mark - Class Methods
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (instancetype) blockDispatcher
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [[[self class] alloc] init];
}

#pragma mark - Instance Methods

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) dispatchBlock:(DUIBlockDispatcherBlockType)block
           afterDelay:(NSTimeInterval)delay
              onQueue:(NSOperationQueue *)queue
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSAssert(block, @"Block must not be nil.");
    
    @synchronized (self.blocksToPerform) {
        NSString * uuid = [[NSUUID UUID] UUIDString];
        self.blocksToPerform[uuid] = @{@"queue": (queue ?: [NSOperationQueue currentQueue]),
                                       @"block": [block copy]};
        [self performSelector:@selector(_delayedTrigger:) withObject:uuid afterDelay:delay];
    }
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) dispatchBlock:(DUIBlockDispatcherBlockType)block
           afterDelay:(NSTimeInterval)delay
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    [self dispatchBlock:block
            afterDelay:delay
               onQueue:nil];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) dispatchBlock:(DUIBlockDispatcherBlockType)block
              onQueue:(NSOperationQueue *)queue
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    [self dispatchBlock:block
            afterDelay:0.0
               onQueue:queue];
}

#pragma mark - Private Methods

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) _delayedTrigger:(NSString *)uuid
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSDictionary * dict = self.blocksToPerform[uuid];
    
    if (!dict) {
        NSAssert(NO, @"Where is the dictionary for %@?", uuid);
        return;
    }
    
    DUIBlockDispatcherBlockType block = dict[@"block"];
    NSOperationQueue * queue = dict[@"queue"];
    [queue addOperationWithBlock:block];
}

#pragma mark - Private Properties

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (NSMutableDictionary *) blocksToPerform
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    @synchronized(self) {
        if (!_blocksToPerform) {
            _blocksToPerform = [NSMutableDictionary new];
        }
        return _blocksToPerform;
    }
}

@end
