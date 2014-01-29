//
//  DUIBlockAlertView.m
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

#import "DUIBlockAlertView.h"

@implementation DUIBlockAlertView

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
        
        _clickedBlock = clickedBlock;
    
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
