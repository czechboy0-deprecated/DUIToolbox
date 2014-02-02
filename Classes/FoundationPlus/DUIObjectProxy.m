//
//  DUIObjectProxy.m
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import "DUIObjectProxy.h"

@implementation DUIObjectProxy

static Class _actAsClass = nil;

/*
 Example use:
        UITableViewCellStyle style = UITableViewCellStyleDefault;

        SEL sel = @selector(initWithStyle:reuseIdentifier:);
        NSMethodSignature * sign = [[SMSHeaderCell class] instanceMethodSignatureForSelector:sel];
        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:sign];
        [invocation setSelector:sel];
        [invocation setArgument:&style atIndex:2];
        [invocation setArgument:&CellIdentifier atIndex:3];

        cell = (SMSHeaderCell *)[[DUIObjectProxy alloc] initWithClass:[SMSHeaderCell class] customInitInvocation:invocation];
 
        
 */

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (id) initWithClass:(Class)c customInitInvocation:(NSInvocation *)initInvoke receivers:(NSArray *)receivers
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    if (self = [super init])
    {
        _actAsClass = c;
        _proxee = [_actAsClass alloc];
        _receivers = receivers;
        
        if (initInvoke) {
            [initInvoke invokeWithTarget:_proxee];
        } else {
            _proxee = [_proxee init];
        }
    }
    return self;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (id) initWithClass:(Class)c receivers:(NSArray *)receivers
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [self initWithClass:c customInitInvocation:nil receivers:receivers];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) forwardInvocation:(NSInvocation *)invocation
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
//    NSString *message = NSStringFromSelector([invocation selector]);
    
//    NSLog(@"%@: --- %@", NSStringFromClass(_actAsClass), message);
    
    [invocation invokeWithTarget:self.proxee];
    
    for (id receiver in self.receivers) {
        [invocation invokeWithTarget:receiver];
    }
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
//    NSLog(@"--- method signature for: %@", NSStringFromSelector(sel));
    return [[self.proxee class] instanceMethodSignatureForSelector:sel];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (Class) class
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return _actAsClass;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (BOOL) respondsToSelector:(SEL)aSelector
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
//    NSLog(@"--- responds to selector: %@", NSStringFromSelector(aSelector));
    return [_actAsClass respondsToSelector:aSelector];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-(void)doesNotRecognizeSelector:(SEL)aSelector
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSLog(@"!!! - does not recognize selector: %@", NSStringFromSelector(aSelector));
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (IMP)methodForSelector:(SEL)aSelector
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    IMP m = [super methodForSelector:aSelector];
    return m;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (BOOL) instancesRespondToSelector:(SEL)aSelector
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    BOOL s = [super instancesRespondToSelector:aSelector];
    return s;
}


@end


