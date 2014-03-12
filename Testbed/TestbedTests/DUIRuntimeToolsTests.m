//
//  DUIRuntimeToolsTests.m
//  Testbed
//
//  Created by Honza Dvorsky on 12/03/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DUIRuntimeTools.h"

@interface DUIRuntimeToolsTests : XCTestCase

@end

@implementation DUIRuntimeToolsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSDictionary *allClasses;
    __unused NSDictionary *classHierarchy = [DUIRuntimeTools scanClassHierarchy:&allClasses];

    [DUIRuntimeTools logHierarchyForClassInfo:allClasses[@"UIView"]];
    
    NSLog(@"Runtime detected %i registered classes.", allClasses.count);
}

@end
