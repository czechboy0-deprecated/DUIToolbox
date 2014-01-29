//
//  DUIBlockActionSheet.h
//  LazyReader
//
//  Created by Honza Dvorsky on 8/13/13.
//  Copyright (c) 2013 Honza Dvorsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DUIBlockActionSheet;

typedef void(^DUIBlockActionSheetClicked)(DUIBlockActionSheet * actionSheet, NSInteger clickedIndex);

@interface DUIBlockActionSheet : UIActionSheet<UIActionSheetDelegate>

//designated initializer
- (instancetype) initWithTitle:(NSString *)title
                  clickedBlock:(DUIBlockActionSheetClicked)clickedBlock
             cancelButtonTitle:(NSString *)cancelButtonTitle
        destructiveButtonTitle:(NSString *)destructiveButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ...;

@property (nonatomic, strong, readonly) DUIBlockActionSheetClicked clickedBlock;

@end
