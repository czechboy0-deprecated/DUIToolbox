//
//  NSObject+MultipleDelegatesSupport.h
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import <Foundation/Foundation.h>

@interface NSObject (MultipleDelegatesSupport)

/**
 In case you have multiple delegates on an object and you need to call a certain selector with parameters on all of them
 (while only calling the selector IFF the delegate responds to it), this is for you. Works for <= 4 parameter functions.
 @param delegates An array of objects to call the selector on.
 @param selector The selector to call on all the delegates.
 @param params The selector parameters (up to 4).
 @return NSUInteger The count of successfully called delegates.
 */
- (NSUInteger) notifyDelegates:(NSSet *)delegates ofAction:(SEL)selector withParameters:(NSArray *)params;

@end
