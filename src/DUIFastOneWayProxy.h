//
//  DUIFastOneWayProxy.h
//  LazyReader
//
//  Created by Honza Dvorsky on 8/22/13.
//  Copyright (c) 2013 Honza Dvorsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUIFastOneWayProxy : NSObject

- (instancetype) initWithClass:(Class)c receivers:(NSArray *)receivers;

@property (nonatomic, strong, readonly) NSArray *receivers;

@property (nonatomic, readonly) Class actAsClass;

@end

