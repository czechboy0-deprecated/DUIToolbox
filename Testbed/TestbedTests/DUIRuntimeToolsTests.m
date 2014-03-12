//
//  DUIRuntimeToolsTests.m
//  Testbed
//
//  Created by Honza Dvorsky on 12/03/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DUIRuntimeTools.h"
#import <objc/message.h>

@interface DUIRuntimeToolsTests : XCTestCase

@end

typedef struct {
    Class isa;
} dui_object;

typedef dui_object* dui_id;

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

- (void)testFakeId
{
    Class objectClass = [ClassInfo class];

    dui_object object = { objectClass };
    dui_id myid = &object;
    id myidbridged = (__bridge id)(myid);
    
    id ret = objc_msgSend(myidbridged, @selector(class));
    XCTAssert(ret == objectClass, @"We faked an object");
}

- (void)testClassHierarchy
{
    NSDictionary *allClasses;
    __unused NSDictionary *classHierarchy = [DUIRuntimeTools snapshotClassHierarchyReturnBaseClassesFillAllClassInfos:&allClasses];

    [DUIRuntimeTools logHierarchyForClassInfo:allClasses[@"UIView"]];
    
    NSLog(@"Runtime detected %i registered classes.", allClasses.count);
}

@end
