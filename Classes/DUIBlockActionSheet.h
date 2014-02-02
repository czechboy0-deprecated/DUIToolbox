//
//  DUIBlockActionSheet.h
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import <UIKit/UIKit.h>

@class DUIBlockActionSheet;

typedef void(^DUIBlockActionSheetClicked)(DUIBlockActionSheet * actionSheet, NSInteger clickedIndex);

@interface DUIBlockActionSheet : UIActionSheet<UIActionSheetDelegate>

/**
 Convinience class method.
 */
+ (instancetype) actionSheetWithTitle:(NSString *)title
                         clickedBlock:(DUIBlockActionSheetClicked)clickedBlock
                    cancelButtonTitle:(NSString *)cancelButtonTitle
               destructiveButtonTitle:(NSString *)destructiveButtonTitle
                    otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

//designated initializer
- (instancetype) initWithTitle:(NSString *)title
                  clickedBlock:(DUIBlockActionSheetClicked)clickedBlock
             cancelButtonTitle:(NSString *)cancelButtonTitle
        destructiveButtonTitle:(NSString *)destructiveButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property (nonatomic, copy, readonly) DUIBlockActionSheetClicked clickedBlock;

@end
