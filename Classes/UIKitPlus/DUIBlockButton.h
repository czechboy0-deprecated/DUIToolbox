//
//  DUIBlockButton.h
//  Testbed
//
//  Created by Honza Dvorsky on 02/02/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DUIBlockButton;

typedef void(^DUIBlockButtonClicked)(DUIBlockButton * button);

@interface DUIBlockButton : UIButton

+ (instancetype) buttonWithFrame:(CGRect)frame
                    clickedBlock:(DUIBlockButtonClicked)clickedBlock
                forControlEvents:(UIControlEvents)events;

- (instancetype) initWithFrame:(CGRect)frame
                  clickedBlock:(DUIBlockButtonClicked)clickedBlock
              forControlEvents:(UIControlEvents)events;

@property (nonatomic, copy, readonly) DUIBlockButtonClicked clickedBlock;

@end
