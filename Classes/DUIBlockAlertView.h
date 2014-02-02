//
//  DUIBlockAlertView.h
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import <UIKit/UIKit.h>

@class DUIBlockAlertView;

typedef void(^DUIBlockAlertViewClicked)(DUIBlockAlertView * alertView, NSInteger clickedIndex);

@interface DUIBlockAlertView : UIAlertView<UIAlertViewDelegate>

/**
 Convinience class method.
 */
+ (instancetype) alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                       clickedBlock:(DUIBlockAlertViewClicked)clickedBlock
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

//designated initializer
- (instancetype) initWithTitle:(NSString *)title
                       message:(NSString *)message
                  clickedBlock:(DUIBlockAlertViewClicked)clickedBlock
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property (nonatomic, copy, readonly) DUIBlockAlertViewClicked clickedBlock;

//useful initializer
- (instancetype) initWithError:(NSError *)error
                  clickedBlock:(DUIBlockAlertViewClicked)clickedBlock
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
