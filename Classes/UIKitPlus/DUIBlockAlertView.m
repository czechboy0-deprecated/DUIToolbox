//
//  DUIBlockAlertView.m
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import "DUIBlockAlertView.h"

@implementation DUIBlockAlertView

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (instancetype) alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                       clickedBlock:(DUIBlockAlertViewClicked)clickedBlock
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSString *)otherButtonTitles, ...
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [[self alloc] initWithTitle:title
                               message:message
                          clickedBlock:clickedBlock
                     cancelButtonTitle:cancelButtonTitle
                     otherButtonTitles:otherButtonTitles, nil];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (instancetype) initWithTitle:(NSString *)title
                       message:(NSString *)message
                  clickedBlock:(DUIBlockAlertViewClicked)clickedBlock
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ...
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    if (self = [self initWithTitle:title
                           message:message
                          delegate:nil
                 cancelButtonTitle:cancelButtonTitle
                 otherButtonTitles:otherButtonTitles, nil]) {
        
        _clickedBlock = [clickedBlock copy];
    
    }
    return self;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (instancetype) initWithTitle:(NSString *)title
                       message:(NSString *)message
                      delegate:(id)delegate
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ...
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert(!delegate);
    
    if (self = [super initWithTitle:title
                            message:message
                           delegate:self
                  cancelButtonTitle:cancelButtonTitle
                  otherButtonTitles:otherButtonTitles, nil]) {
        
    }
    return self;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (instancetype) initWithError:(NSError *)error
                  clickedBlock:(DUIBlockAlertViewClicked)clickedBlock
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ...
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSString * localizedDescription = nil;
    NSString * format = NSLocalizedString(@"Whoops (error %i)", @"Error alert view title");
    NSString * title = [NSString stringWithFormat:format, error.code];
    
    if (error.userInfo[@"HTTPError"]) {
        
        NSError * httpError = error.userInfo[@"HTTPError"];
        
        /*
         Pocket specific: 
         200 - Request was successful
         400 - Invalid request, please make sure you follow the documentation for proper syntax
         401 - Problem authenticating the user
         403 - User was authenticated, but access denied due to lack of permission or rate limiting
         503 - Pocket's sync server is down for scheduled maintenance.
         */
        
        localizedDescription = [httpError localizedDescription];
        
    } else {
        localizedDescription = [error localizedDescription];
    }
    
    if (self = [self initWithTitle:title
                           message:localizedDescription
                      clickedBlock:clickedBlock
                 cancelButtonTitle:cancelButtonTitle
                 otherButtonTitles:otherButtonTitles, nil]) {
        //
    }
    return self;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    if (self.clickedBlock) {
        self.clickedBlock(self, buttonIndex);
    }
}

@end
