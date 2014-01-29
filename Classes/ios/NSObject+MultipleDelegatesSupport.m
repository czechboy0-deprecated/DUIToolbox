//
//  NSObject+MultipleDelegatesSupport.m
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import "NSObject+MultipleDelegatesSupport.h"

@implementation NSObject (MultipleDelegatesSupport)

//up to 4 parameters
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (NSUInteger) notifyDelegates:(NSSet *)delegates ofAction:(SEL)selector withParameters:(NSArray *)params
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSUInteger called = 0;
    
    for (id del in delegates) {
        if ([del respondsToSelector:selector]) {
            
            //ignore the performSelector - leak warning
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
            switch ([params count]) {
                case 0:
                    [del performSelector:selector];
                    break;
                case 1:
                    [del performSelector:selector withObject:params[0]];
                    break;
                case 2:
                    [del performSelector:selector withObject:params[0] withObject:params[1]];
                    break;
                case 3:
                {
                    typedef void (*MethodType)(id, SEL, id, id, id);
                    MethodType methodToCall;
                    
                    assert([del isKindOfClass:[NSObject class]]);
                    NSObject * obj = (NSObject *)del;
                    
                    methodToCall = (MethodType)[obj methodForSelector:selector];
                    methodToCall(obj, selector, params[0], params[1], params[2]);
                }
                    break;
                case 4:
                {
                    typedef void (*MethodType)(id, SEL, id, id, id, id);
                    MethodType methodToCall;
                    
                    assert([del isKindOfClass:[NSObject class]]);
                    NSObject * obj = (NSObject *)del;
                    
                    methodToCall = (MethodType)[obj methodForSelector:selector];
                    methodToCall(obj, selector, params[0], params[1], params[2], params[3]);
                }
                    break;
                default:
                    //does not support more than 4 parameters for now
                    assert(NO);
                    break;
            }
            
#pragma clang diagnostic pop
            
            called++;
            
        }
    }
    
    return called;
}

@end
