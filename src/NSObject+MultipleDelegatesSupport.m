//
//  NSObject+MultipleDelegatesSupport.m
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
