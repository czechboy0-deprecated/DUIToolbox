//
//  DUIBlockAlertView.h
//  LazyReader
//
//  Created by Honza Dvorsky on 8/13/13.
//  Copyright (c) 2013 Honza Dvorsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DUIBlockAlertView;

typedef void(^DUIBlockAlertViewClicked)(DUIBlockAlertView * AlertView, NSInteger clickedIndex);

@interface DUIBlockAlertView : UIAlertView<UIAlertViewDelegate>

//designated initializer
- (instancetype) initWithTitle:(NSString *)title
                       message:(NSString *)message
                  clickedBlock:(DUIBlockAlertViewClicked)clickedBlock
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ...;

@property (nonatomic, strong, readonly) DUIBlockAlertViewClicked clickedBlock;

//useful initializer
- (instancetype) initWithError:(NSError *)error
                  clickedBlock:(DUIBlockAlertViewClicked)clickedBlock
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
