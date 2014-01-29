//
//  DUIObjectProxy.m
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//
//The MIT License (MIT)
//
//Copyright (c) 2013 Honza Dvorsky
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of
//this software and associated documentation files (the "Software"), to deal in
//the Software without restriction, including without limitation the rights to
//use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//the Software, and to permit persons to whom the Software is furnished to do so,
//subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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


