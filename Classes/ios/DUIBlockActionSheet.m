//
//  DUIBlockActionSheet.m
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import "DUIBlockActionSheet.h"

@implementation DUIBlockActionSheet

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (instancetype) initWithTitle:(NSString *)title
                  clickedBlock:(DUIBlockActionSheetClicked)clickedBlock
             cancelButtonTitle:(NSString *)cancelButtonTitle
        destructiveButtonTitle:(NSString *)destructiveButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ...
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    if (self = [self initWithTitle:title
                           delegate:nil
                  cancelButtonTitle:cancelButtonTitle
             destructiveButtonTitle:destructiveButtonTitle
                  otherButtonTitles:otherButtonTitles, nil]) {
        _clickedBlock = clickedBlock;
    }
    return self;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (instancetype) initWithTitle:(NSString *)title
                      delegate:(id<UIActionSheetDelegate>)delegate
             cancelButtonTitle:(NSString *)cancelButtonTitle
        destructiveButtonTitle:(NSString *)destructiveButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ...
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert(!delegate);
    
    if (self = [super initWithTitle:title
                           delegate:self
                  cancelButtonTitle:cancelButtonTitle
             destructiveButtonTitle:destructiveButtonTitle
                  otherButtonTitles:otherButtonTitles, nil]) {
        
    }
    return self;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    if (self.clickedBlock) {
        self.clickedBlock(self, buttonIndex);
    }
}

@end
