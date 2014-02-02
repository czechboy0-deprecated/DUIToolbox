//
//  DUIBlockButton.m
//  Testbed
//
//  Created by Honza Dvorsky on 02/02/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import "DUIBlockButton.h"

@implementation DUIBlockButton

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (instancetype) buttonWithFrame:(CGRect)frame
                    clickedBlock:(DUIBlockButtonClicked)clickedBlock
                forControlEvents:(UIControlEvents)events
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [[self alloc] initWithFrame:frame
                          clickedBlock:clickedBlock
                      forControlEvents:events];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (instancetype) initWithFrame:(CGRect)frame
                  clickedBlock:(DUIBlockButtonClicked)clickedBlock
              forControlEvents:(UIControlEvents)events
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    if (self = [super initWithFrame:frame]) {
        _clickedBlock = [clickedBlock copy];
        [self _attachTargetAction:events];
    }
    return self;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) _attachTargetAction:(UIControlEvents)events
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    [self addTarget:self action:@selector(_buttonTriggered:) forControlEvents:events];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) _buttonTriggered:(DUIBlockButton *)sender
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert(sender == self);
    if (self.clickedBlock) {
        self.clickedBlock(self);
    }
}

@end
