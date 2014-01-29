//
//  DUIFastOneWayProxy.h
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import <Foundation/Foundation.h>

@interface DUIFastOneWayProxy : NSObject

- (instancetype) initWithClass:(Class)c receivers:(NSArray *)receivers;

@property (nonatomic, strong, readonly) NSArray *receivers;

@property (nonatomic, readonly) Class actAsClass;

@end

