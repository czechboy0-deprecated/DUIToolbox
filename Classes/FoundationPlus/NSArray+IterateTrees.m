//
//  NSArray+IterateTrees.m
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import "NSArray+IterateTrees.h"

@implementation NSArray (IterateTrees)

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (void) depthFirstIterateRoot1:(id)root1
                       andRoot2:(id)root2
                 expandingBlock:(IterateTwoTreesExpandBlock)expandBlock
                  functionBlock:(IterateTwoTreesFunctionBlock)functionBlock
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert([root1 isMemberOfClass:[root2 class]]);
    assert(functionBlock && expandBlock);
    
    //call the function block
    functionBlock(root1, root2);
    
    //get the subtrees and iterate those too
    NSArray * subtree1 = expandBlock(root1);
    NSArray * subtree2 = expandBlock(root2);
    
    assert([subtree1 count] == [subtree2 count]);
    
    NSInteger size = [subtree1 count];
    
    for (NSInteger i = 0; i < size; i++) {
        [self depthFirstIterateRoot1:subtree1[i]
                            andRoot2:subtree2[i]
                      expandingBlock:expandBlock
                       functionBlock:functionBlock];
    }
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (void) depthFirstIterateRoot1:(id)root1
                       andRoot2:(id)root2
                       andRoot3:(id)root3
                 expandingBlock:(IterateThreeTreesExpandBlock)expandBlock
                  functionBlock:(IterateThreeTreesFunctionBlock)functionBlock
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    assert([root1 isMemberOfClass:[root2 class]]
           &&[root1 isMemberOfClass:[root3 class]]);
    assert(functionBlock && expandBlock);
    
    //call the function block
    functionBlock(root1, root2, root3);
    
    //get the subtrees and iterate those too
    NSArray * subtree1 = expandBlock(root1);
    NSArray * subtree2 = expandBlock(root2);
    NSArray * subtree3 = expandBlock(root3);
    
    assert([subtree1 count] == [subtree2 count] && [subtree1 count] == [subtree3 count]);
    
    NSInteger size = [subtree1 count];
    
    for (NSInteger i = 0; i < size; i++) {
        [self depthFirstIterateRoot1:subtree1[i]
                            andRoot2:subtree2[i]
                            andRoot3:subtree3[i]
                      expandingBlock:expandBlock
                       functionBlock:functionBlock];
    }
}

@end
