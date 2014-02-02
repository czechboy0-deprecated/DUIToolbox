//
//  UITableView+MultipleSelectionEnhacements.h
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
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
