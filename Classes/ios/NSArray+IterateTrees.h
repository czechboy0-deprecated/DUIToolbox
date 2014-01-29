//
//  NSArray+IterateTrees.h
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import <Foundation/Foundation.h>

typedef NSArray*(^IterateTwoTreesExpandBlock)(id node);
typedef void(^IterateTwoTreesFunctionBlock)(id node1, id node2);

typedef NSArray*(^IterateThreeTreesExpandBlock)(id node);
typedef void(^IterateThreeTreesFunctionBlock)(id node1, id node2, id node3);

@interface NSArray (IterateTrees)

/**
 Crawls two equivalent trees (it is your responsibility to assure it is a tree).
 Types of the equivalent nodes MUST match, otherwise assertion fails.
 Needs and expand block to expand subnodes and a function block which enables
 you to perform some action on two equivalent nodes in those two trees (the point of this function).
 @param root1 The root object of the first tree.
 @param root2 The root object of the second tree.
 @param expandBlock The block which is called onto each node - if nil or empty array is returned, we have a terminal.
 @param functionBlock The function block giving you the chance to do anything with the equivalent nodes in both trees.
 */
+ (void) depthFirstIterateRoot1:(id)root1
                       andRoot2:(id)root2
                 expandingBlock:(IterateTwoTreesExpandBlock)expandBlock
                  functionBlock:(IterateTwoTreesFunctionBlock)functionBlock;

/**
 Crawls three equivalent trees (it is your responsibility to assure it is a tree).
 Types of the equivalent nodes MUST match, otherwise assertion fails.
 Needs and expand block to expand subnodes and a function block which enables
 you to perform some action on two equivalent nodes in those three trees (the point of this function).
 @param root1 The root object of the first tree.
 @param root2 The root object of the second tree.
 @param root3 The root object of the third tree.
 @param expandBlock The block which is called onto each node - if nil or empty array is returned, we have a terminal.
 @param functionBlock The function block giving you the chance to do anything with the equivalent nodes in all three trees.
 */
+ (void) depthFirstIterateRoot1:(id)root1
                       andRoot2:(id)root2
                       andRoot3:(id)root3
                 expandingBlock:(IterateThreeTreesExpandBlock)expandBlock
                  functionBlock:(IterateThreeTreesFunctionBlock)functionBlock;

@end
