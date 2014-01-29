//
//  UITableView+MultipleSelectionEnhacements.h
//  Dingo
//
//  Created by Honza Dvorsky on 8/24/13.
//  Copyright (c) 2013 AisaCorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (MultipleSelectionEnhacements)

- (NSArray *) allIndexPaths;
- (NSInteger) totalNumberOfRows;
- (BOOL) areAllRowsSelected;

- (void) selectRowsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated;
- (void) deselectRowsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated;

- (void) selectAllRowsAnimated:(BOOL)animated;
- (void) deselectAllRowsAnimated:(BOOL)animated;

@end
