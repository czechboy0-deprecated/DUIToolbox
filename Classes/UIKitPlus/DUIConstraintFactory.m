//
//  DUIConstraintFactory.m
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import "DUIConstraintFactory.h"

@implementation DUIConstraintFactory

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintEqualCenterXOfItem:(id)item1 andItem:(id)item2
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert(item1 && item2);
    NSLayoutConstraint * constraint =
    [NSLayoutConstraint constraintWithItem:item1
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:item2
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0];
    return [self _prepareConstraintForReturn:constraint];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintEqualCenterYOfItem:(id)item1 andItem:(id)item2
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert(item1 && item2);
    NSLayoutConstraint * constraint =
    [NSLayoutConstraint constraintWithItem:item1
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:item2
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0];
    return [self _prepareConstraintForReturn:constraint];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintHeightOfItem:(id)item toConstant:(CGFloat)contant
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert(item);
    UIView * view = [self _convertAndStripOfAutoresizingMask:item];
    assert(view);

    NSLayoutConstraint * constraint =
    [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:0
                                multiplier:0.0
                                  constant:contant];
    return [self _prepareConstraintForReturn:constraint];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintWidthOfItem:(id)item toConstant:(CGFloat)contant
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert(item);
    UIView * view = [self _convertAndStripOfAutoresizingMask:item];
    assert(view);
    
    NSLayoutConstraint * constraint =
    [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:0
                                multiplier:0.0
                                  constant:contant];
    return [self _prepareConstraintForReturn:constraint];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintsForCGSize:(CGSize)size ofItem:(id)item
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert(item);
    NSLayoutConstraint * width = [self constraintWidthOfItem:item toConstant:size.width];
    NSLayoutConstraint * height = [self constraintHeightOfItem:item toConstant:size.height];
    return [self _prepareConstraintsForReturn:@[width, height]];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintsForCenterOfItem:(id)item1 beingSameAsCenterOfItem:(id)item2
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert(item1 && item2);
    NSLayoutConstraint * centerX = [self constraintEqualCenterXOfItem:item1 andItem:item2];
    NSLayoutConstraint * centerY = [self constraintEqualCenterYOfItem:item1 andItem:item2];
    return [self _prepareConstraintsForReturn:@[centerX, centerY]];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintLeadingToSuperviewOfItem:(id)item withConstant:(CGFloat)constant
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIView * view = [self _convertAndStripOfAutoresizingMask:item];
    assert([view superview]);
    
    NSString * format = [NSString stringWithFormat:@"H:|-(%f)-[view]", constant];
    
    NSArray * cs = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                           options:0
                                                           metrics:nil
                                                             views:NSDictionaryOfVariableBindings(view)];
    assert([cs count] == 1);
    return [self _prepareConstraintForReturn:cs[0]];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintTrailingToSuperviewOfItem:(id)item withConstant:(CGFloat)constant
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIView * view = [self _convertAndStripOfAutoresizingMask:item];
    assert([view superview]);
    
    NSString * format = [NSString stringWithFormat:@"H:[view]-(%f)-|", constant];
    
    NSArray * cs = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                           options:0
                                                           metrics:nil
                                                             views:NSDictionaryOfVariableBindings(view)];
    assert([cs count] == 1);
    return [self _prepareConstraintForReturn:cs[0]];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintTopToSuperviewOfItem:(id)item withConstant:(CGFloat)constant
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIView * view = [self _convertAndStripOfAutoresizingMask:item];
    assert([view superview]);
    
    NSString * format = [NSString stringWithFormat:@"V:|-(%f)-[view]", constant];
    
    NSArray * cs = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                           options:0
                                                           metrics:nil
                                                             views:NSDictionaryOfVariableBindings(view)];
    assert([cs count] == 1);
    return [self _prepareConstraintForReturn:cs[0]];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintBottomToSuperviewOfItem:(id)item withConstant:(CGFloat)constant
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIView * view = [self _convertAndStripOfAutoresizingMask:item];
    assert([view superview]);
    
    NSString * format = [NSString stringWithFormat:@"V:[view]-(%f)-|", constant];
    
    NSArray * cs = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                           options:0
                                                           metrics:nil
                                                             views:NSDictionaryOfVariableBindings(view)];
    assert([cs count] == 1);
    return [self _prepareConstraintForReturn:cs[0]];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintsVerticalIntoSuperviewTop:(CGFloat)top bottom:(CGFloat)bottom ofItem:(id)item
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIView * view = [self _convertAndStripOfAutoresizingMask:item];
    assert([view superview]);
    
    NSString * format = [NSString stringWithFormat:@"V:|-(%f)-[view]-(%f)-|", top, bottom];
    
    NSArray * constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:format
                                            options:0
                                            metrics:nil
                                              views:NSDictionaryOfVariableBindings(view)];
    
    return [self _prepareConstraintsForReturn:constraints];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintsHorizontalIntoSuperviewLeft:(CGFloat)left right:(CGFloat)right ofItem:(id)item
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIView * view = [self _convertAndStripOfAutoresizingMask:item];
    assert([view superview]);
    
    NSString * format = [NSString stringWithFormat:@"H:|-(%f)-[view]-(%f)-|", left, right];
    
    NSArray * constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:format
                                            options:0
                                            metrics:nil
                                              views:NSDictionaryOfVariableBindings(view)];
    
    return [self _prepareConstraintsForReturn:constraints];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintsForVerticalNeighborsTop:(id)topItem bottom:(id)bottomItem withSpace:(CGFloat)space
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIView * viewTop = [self _convertAndStripOfAutoresizingMask:topItem];
    UIView * viewBottom = [self _convertAndStripOfAutoresizingMask:bottomItem];
    assert([viewTop superview] == [viewBottom superview] && [viewTop superview]);
    
    NSString * format = [NSString stringWithFormat:@"V:[viewTop]-(%f)-[viewBottom]", space];
    
    NSArray * constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:format
                                            options:0
                                            metrics:nil
                                              views:NSDictionaryOfVariableBindings(viewTop, viewBottom)];
    
    return [self _prepareConstraintsForReturn:constraints];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintsForHorizontalNeighborsLeft:(id)leftItem right:(id)rightItem withSpace:(CGFloat)space
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIView * viewLeft = [self _convertAndStripOfAutoresizingMask:leftItem];
    UIView * viewRight = [self _convertAndStripOfAutoresizingMask:rightItem];
    assert([viewLeft superview] == [viewRight superview] && [viewLeft superview]);
    
    NSString * format = [NSString stringWithFormat:@"H:[viewLeft]-(%f)-[viewRight]", space];
    
    NSArray * constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:format
                                            options:0
                                            metrics:nil
                                              views:NSDictionaryOfVariableBindings(viewLeft, viewRight)];
    
    return [self _prepareConstraintsForReturn:constraints];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintsItem:(id)item intoSuperviewWithEdges:(UIEdgeInsets)edges
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIView * view = [self _convertAndStripOfAutoresizingMask:item];
    assert(view.superview);
    
    NSMutableArray * allConstraints = [NSMutableArray new];
    
    [allConstraints addObjectsFromArray:[self constraintsHorizontalIntoSuperviewLeft:edges.left right:edges.right ofItem:view]];
    [allConstraints addObjectsFromArray:[self constraintsVerticalIntoSuperviewTop:edges.top bottom:edges.bottom ofItem:view]];
    
    return [self _prepareConstraintsForReturn:allConstraints];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) _constraintEqualAttribute:(NSLayoutAttribute)attribute ofItem:(id)item1 andItem:(id)item2
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [self _constraintEqualAttribute:attribute
                                    ofItem:item1
                                   andItem:item2
                              withConstant:0.0];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) _constraintEqualAttribute:(NSLayoutAttribute)attribute ofItem:(id)item1 andItem:(id)item2 withConstant:(CGFloat)constant
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIView * view1 = [self _convertAndStripOfAutoresizingMask:item1];
    UIView * view2 = [self _convertAndStripOfAutoresizingMask:item2];
    
    NSLayoutConstraint * constraint =
    [NSLayoutConstraint constraintWithItem:view1
                                 attribute:attribute
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:view2
                                 attribute:attribute
                                multiplier:1.0
                                  constant:constant];
    return [self _prepareConstraintForReturn:constraint];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintEqualHeightsOfItem:(id)item1 andItem:(id)item2
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [self _constraintEqualAttribute:NSLayoutAttributeHeight ofItem:item1 andItem:item2];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintEqualHeightsOfItem:(id)item1 andItem:(id)item2 withConstant:(CGFloat)constant
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [self _constraintEqualAttribute:NSLayoutAttributeHeight ofItem:item1 andItem:item2 withConstant:constant];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintsEqualSizesOfItem:(id)item1 andItem:(id)item2
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSArray * allConstraints = @[
                                 [self constraintEqualWidthsOfItem:item1 andItem:item2],
                                 [self constraintEqualHeightsOfItem:item1 andItem:item2],
                                 ];
    
    return allConstraints;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) constraintEqualWidthsOfItem:(id)item1 andItem:(id)item2
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [self _constraintEqualAttribute:NSLayoutAttributeWidth ofItem:item1 andItem:item2];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintEvenlyItemsHorizontally:(NSArray *)items
                                       leftEdge:(CGFloat)leftEdge
                                      rightEdge:(CGFloat)rightEdge
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    /*
     -[1]-[2]-[n]- etc.
     - item 1 leading
     - item n trailing
     - items 2,...,n link to previous item
     */
    
    if (!items || [items count] < 1) {
        return nil;
    }
    
    NSArray *namesViews = [self _viewNames:@"view" forCount:items.count];
    NSMutableDictionary *viewDict = [NSMutableDictionary dictionaryWithObjects:items forKeys:namesViews];
    NSMutableString *visualLanguage = [NSMutableString new];
    
    NSMutableArray *spacers = [NSMutableArray new];
    NSArray *namesSpacers = [self _viewNames:@"spacer" forCount:items.count-1];
    
    UIView *itemsSuperview = [items[0] superview];
    assert(itemsSuperview);
    
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        //make sure the views are valid and usable
        UIView * view = [self _convertAndStripOfAutoresizingMask:obj];
        assert(view.superview);
        
        if (idx == 0) {
            //item 1
            [visualLanguage appendFormat:@"H:|-%f-[%@]", leftEdge, namesViews[idx]];
        } else {
            //middle item
            //create a spacer
            
            UIView *spacer = [[UIView alloc] initWithFrame:CGRectZero];
            spacer = [self _convertAndStripOfAutoresizingMask:spacer];
            
            spacer.alpha = 0.0;
//            spacer.backgroundColor = [UIColor redColor];
            
            [itemsSuperview addSubview:spacer];
            
            [spacer addConstraint: [ConstraintFactory constraintHeightOfItem:spacer toConstant:30]];
            [spacer.superview addConstraint: [ConstraintFactory constraintEqualCenterYOfItem:spacer andItem:spacer.superview]];
            
            [spacers addObject:spacer];
            
            NSUInteger spacerIdx = idx-1;
            
            if (spacerIdx == 0) {
                [visualLanguage appendFormat:@"[%@][%@]", namesSpacers[spacerIdx], namesViews[idx]];
            } else {
                [visualLanguage appendFormat:@"[%@(==%@)][%@]", namesSpacers[spacerIdx], namesSpacers[0], namesViews[idx]];
            }
        }
        
        if (idx == items.count-1) {
            //item n
            [visualLanguage appendFormat:@"-%f-|", rightEdge];
        }
        
    }];
    
    [viewDict addEntriesFromDictionary:[NSDictionary dictionaryWithObjects:spacers forKeys:namesSpacers]];
    
    NSArray *allConstraints = [NSLayoutConstraint constraintsWithVisualFormat: visualLanguage
                                                                      options: 0
                                                                      metrics: nil
                                                                        views: viewDict];
    return [self _prepareConstraintsForReturn:allConstraints];
}


#pragma mark - Private methods

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) _viewNames:(NSString *)name forCount:(NSUInteger)count
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSMutableArray *names = [NSMutableArray new];
    for (NSUInteger i = 0; i < count; i++) {
        [names addObject:[NSString stringWithFormat:@"%@%i", name, i]];
    }
    
    return [names copy];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) _constraintAllEqualAttribute:(NSLayoutAttribute)attribute ofItems:(NSArray *)items
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSMutableArray * allConstraints = [NSMutableArray new];
    id __block superview = nil;
    
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        UIView * view = [self _convertAndStripOfAutoresizingMask:obj];
        assert(view.superview);
        
        if (idx == 0) {
            superview = view.superview;
        }
        assert(view.superview == superview);
        //make sure all the items have the same superview
        
        if (idx > 0) {
            
            UIView * prevView = [self _convertAndStripOfAutoresizingMask:items[idx-1]];
            [allConstraints addObject:[self _constraintEqualAttribute:attribute ofItem:prevView andItem:view]];
        }
    }];
    
    return [self _prepareConstraintsForReturn:allConstraints];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintAllEqualWidthsOfItems:(NSArray *)items
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [self _constraintAllEqualAttribute:NSLayoutAttributeWidth ofItems:items];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintAllEqualHeightsOfItems:(NSArray *)items
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [self _constraintAllEqualAttribute:NSLayoutAttributeHeight ofItems:items];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) constraintAllEqualSizesOfItems:(NSArray *)items
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSMutableArray * allConstraints = [NSMutableArray new];
    
    [allConstraints addObjectsFromArray:[self constraintAllEqualWidthsOfItems:items]];
    [allConstraints addObjectsFromArray:[self constraintAllEqualHeightsOfItems:items]];

    return allConstraints;
}


#pragma mark - Private
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (UIView *) _convertAndStripOfAutoresizingMask:(id)item
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert(item);
    UIView * view = (UIView *)item;
    assert([view isKindOfClass:[UIView class]]);
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSLayoutConstraint *) _prepareConstraintForReturn:(NSLayoutConstraint *)constraint
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    //do anything we need before the constraint is returned
    
    //YES, archive (so that we can copy the UIViews)
    constraint.shouldBeArchived = YES;
    
    return constraint;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSArray *) _prepareConstraintsForReturn:(NSArray *)constraints
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    for (NSLayoutConstraint * constraint in constraints) {
        [self _prepareConstraintForReturn:constraint];
    }
    
    return constraints;
}
@end















