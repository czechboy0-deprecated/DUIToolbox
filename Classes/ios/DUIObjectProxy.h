//
//  DUIObjectProxy.h
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import <Foundation/Foundation.h>

@interface DUIObjectProxy : NSObject

- (instancetype) initWithClass:(Class)c receivers:(NSArray *)receivers; //calls alloc/init on the object of the watched class
- (instancetype) initWithClass:(Class)c customInitInvocation:(NSInvocation *)initInvoke receivers:(NSArray *)receivers;

@property (nonatomic, strong, readonly) NSArray *receivers;

@property (nonatomic, readonly) Class actAsClass;
@property (nonatomic, readonly) NSObject *proxee;

@end

