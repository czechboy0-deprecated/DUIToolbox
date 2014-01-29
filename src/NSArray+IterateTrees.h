//
//  NSArray+IterateTrees.h
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
