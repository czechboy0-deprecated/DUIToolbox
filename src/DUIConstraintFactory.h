//
//  DUIConstraintFactory.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DUIConstraintFactory : NSObject

//note: Turn translatesAutoresizingMaskIntoConstraints off if you want to use autolayout - it might cause not only inconsistencies but also crashes. It also adds constraints you probably did not want.

/**
 Creates constraint for the fixed width of an item.
 @param item A UIView.
 @param constant A CGFloat of the width.
 @return NSLayoutConstraint - add it to the item directly: [item addConstraint:[... constraintWidthOfItem:toConstant:]];
 */
+ (NSLayoutConstraint *) constraintWidthOfItem:(id)item toConstant:(CGFloat)contant;

/**
 Creates constraint for the fixed height of an item.
 @param item A UIView.
 @param constant A CGFloat of the height.
 @return NSLayoutConstraint - add it to the item directly: [item addConstraint:[... constraintHeightOfItem:toConstant:]];
 */
+ (NSLayoutConstraint *) constraintHeightOfItem:(id)item toConstant:(CGFloat)contant;

/**
 Creates constraint for setting the item1 in the center of item2 (horizontally).
 @param item1 The 'small' UIView.
 @param item2 The 'superview' UIView.
 @return NSLayoutConstraint - add it to the item's superview (item2) : [item2 addConstraint:[... constraintEqual...]];
 */
+ (NSLayoutConstraint *) constraintEqualCenterXOfItem:(id)item1 andItem:(id)item2;

/**
 Creates constraint for setting the item1 in the center of item2 (vertically).
 @param item1 The 'small' UIView.
 @param item2 The 'superview' UIView.
 @return NSLayoutConstraint - add it to the item's superview (item2) : [item2 addConstraint:[... constraintEqual...]];
 */
+ (NSLayoutConstraint *) constraintEqualCenterYOfItem:(id)item1 andItem:(id)item2;

/**
 Creates constraints for the fixed size of an item.
 @param item A UIView.
 @param size The desired CGSize.
 @return NSArray of NSLayoutConstraints - add them to the item directly: [item addConstraints:[... constraintsForCGSize...]];
 */
+ (NSArray *) constraintsForCGSize:(CGSize)size ofItem:(id)item;

/**
 Creates constraints for setting the item1 in the center of item2 (both horizontally and vertically).
 @param item1 The 'small' UIView.
 @param item2 The 'superview' UIView.
 @return NSLayoutConstraint - add it to the item's superview (item2) : [item2 addConstraints:[... constraintForCenter...]];
 */
+ (NSArray *) constraintsForCenterOfItem:(id)item1 beingSameAsCenterOfItem:(id)item2;

/**
 Creates constraint for setting the item leading to its superview by a constant.
 @param item A UIView.
 @param constant A CGFloat of the edge.
 @return NSLayoutConstraint - add it to the item's superview : [item.superview addConstraint:[... constraint...]];
 */
+ (NSLayoutConstraint *) constraintLeadingToSuperviewOfItem:(id)item withConstant:(CGFloat)constant;

/**
 Creates constraint for setting the item trailing to its superview by a constant.
 @param item A UIView.
 @param constant A CGFloat of the edge.
 @return NSLayoutConstraint - add it to the item's superview : [item.superview addConstraint:[... constraint...]];
 */
+ (NSLayoutConstraint *) constraintTrailingToSuperviewOfItem:(id)item withConstant:(CGFloat)constant;

/**
 Creates constraint for setting the item align top to its superview by a constant.
 @param item A UIView.
 @param constant A CGFloat of the edge.
 @return NSLayoutConstraint - add it to the item's superview : [item.superview addConstraint:[... constraint...]];
 */
+ (NSLayoutConstraint *) constraintTopToSuperviewOfItem:(id)item withConstant:(CGFloat)constant;

/**
 Creates constraint for setting the item align bottom to its superview by a constant.
 @param item A UIView.
 @param constant A CGFloat of the edge.
 @return NSLayoutConstraint - add it to the item's superview : [item.superview addConstraint:[... constraint...]];
 */
+ (NSLayoutConstraint *) constraintBottomToSuperviewOfItem:(id)item withConstant:(CGFloat)constant;

/**
 Creates constraints for setting the item align top and bottom to its superview by constants.
 @param item A UIView.
 @param top A CGFloat of the top edge.
 @param bottom A CGFloat of the bottom edge.
 @return NSLayoutConstraint - add it to the item's superview : [item.superview addConstraints:[... constraint...]];
 */
+ (NSArray *) constraintsVerticalIntoSuperviewTop:(CGFloat)top bottom:(CGFloat)bottom ofItem:(id)item;

/**
 Creates constraints for setting the item align left and right edges to its superview by constants.
 @param item A UIView.
 @param left A CGFloat of the left edge.
 @param right A CGFloat of the right edge.
 @return NSLayoutConstraint - add it to the item's superview : [item.superview addConstraints:[... constraint...]];
 */
+ (NSArray *) constraintsHorizontalIntoSuperviewLeft:(CGFloat)left right:(CGFloat)right ofItem:(id)item;

/**
 Creates constraints for setting two items neighbor vertically with a space between.
 @param topItem A UIView.
 @param bottomItem A UIView.
 @param space A CGFloat of the space between.
 @return NSLayoutConstraint - add it to the item's superview : [item.superview addConstraints:[... constraint...]];
 */
+ (NSArray *) constraintsForVerticalNeighborsTop:(id)topItem bottom:(id)bottomItem withSpace:(CGFloat)space;

/**
 Creates constraints for setting two items neighbor horizontally with a space between.
 @param topItem A UIView.
 @param bottomItem A UIView.
 @param space A CGFloat of the space between.
 @return NSLayoutConstraint - add it to the item's superview : [item.superview addConstraints:[... constraint...]];
 */
+ (NSArray *) constraintsForHorizontalNeighborsLeft:(id)leftItem right:(id)rightItem withSpace:(CGFloat)space;

/**
 Creates constraints for setting the item align to its superview by constants.
 @param item A UIView.
 @param edges A CGFloats of the edges.
 @return NSLayoutConstraint - add it to the item's superview : [item.superview addConstraints:[... constraint...]];
 */
+ (NSArray *) constraintsItem:(id)item intoSuperviewWithEdges:(UIEdgeInsets)edges;

@end
