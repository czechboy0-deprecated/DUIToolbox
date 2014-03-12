//
//  DUIRuntimeTools.m
//  DUIToolbox
//
//  Created by Honza Dvorsky on 11/03/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import "DUIRuntimeTools.h"
#import <objc/runtime.h>

@implementation ClassInfo

- (Class)superclass
{
    return class_getSuperclass(NSClassFromString(self.name));
}

- (NSString *)superclassName
{
    Class c = [self superclass];
    if (c) {
        return NSStringFromClass(c);
    }
    return nil;
}

- (instancetype) initWithName:(NSString *)name
{
    if (self = [super init]) {
        _name = name;
        _subclasses = [NSMutableSet new];
    }
    return self;
}

+ (instancetype) infoWithName:(NSString *)name
{
    return [[self alloc] initWithName:name];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    ClassInfo *other = (ClassInfo *)object;
    return [self.name isEqualToString:other.name];
}

- (NSUInteger)hash
{
    return [self.name hash];
}

- (NSString *)description
{
//    NSMutableString *subclasses = [[NSString stringWithFormat:@"Subs %i:[", self.subclasses.count] mutableCopy];
//    [self.subclasses enumerateObjectsUsingBlock:^(ClassInfo *obj, BOOL *stop) {
//        [subclasses appendFormat:@"%@, ", obj.name];
//    }];
//    [subclasses appendString:@"]"];
    NSString *subclasses = [NSString stringWithFormat:@"Subs %i", self.subclasses.count];
    
    return [[super description] stringByAppendingFormat:@"<Name:%@, %@, superclass: %@>", self.name, subclasses, self.superclassName];
}

@end


@implementation DUIRuntimeTools

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSSet *)_getClassList
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    int numClasses;
    Class * classes = NULL;
    
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    
    NSMutableSet *classList = [NSMutableSet new];
    if (numClasses > 0 )
    {
        classes = (Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        
        for (int i = 0; i < numClasses; i++) {
            Class c = *(classes + i);
            NSString *name = NSStringFromClass(c);
            [classList addObject:name];
        }
        
        free(classes);
    }
    return classList;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (ClassInfo *)_constructClassHierarchy:(NSString *)className
                                   flat:(NSMutableDictionary *)flat
                            baseClasses:(NSMutableDictionary *)baseClasses
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    ClassInfo *classInfo = flat[className];
    if (classInfo) {
        return classInfo;
    }
    //find class info, if exists
    classInfo = [ClassInfo infoWithName:className];
    flat[className] = classInfo;
    
    NSString *superclass = [classInfo superclassName];
    if (superclass) {
        //we need to keep climbing up
        ClassInfo *superInfo = [self _constructClassHierarchy:superclass
                                                         flat:flat
                                                  baseClasses:baseClasses];
        [superInfo.subclasses addObject:classInfo];
    } else {
        //found a base class
        baseClasses[className] = classInfo;
    }
    return classInfo;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (NSDictionary *)snapshotClassHierarchyReturnBaseClassesFillAllClassInfos:(NSDictionary *__autoreleasing *)allClasses
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSMutableDictionary *flat;
    NSMutableDictionary *baseClasses;

    //prep the containers
    {
        flat = [NSMutableDictionary new];
        baseClasses = [NSMutableDictionary new];
    }
    
    //go through the hierarchy and construct
    NSSet *all = [self _getClassList];

    [all enumerateObjectsUsingBlock:^(NSString *obj, BOOL *stop) {
        [self _constructClassHierarchy:obj
                                  flat:flat
                           baseClasses:baseClasses];
    }];
    
    *allClasses = [flat copy];
    return [baseClasses copy];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (void)_logHierarchyForClassInfo:(ClassInfo *)info level:(NSUInteger)level
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSString *name = info.name;
    
    NSUInteger count = info.subclasses.count;
    if (count > 0) {
        name = [name stringByAppendingFormat:@" (%i subclasses)", count];
    }
    
    NSString *prefix = @"|---";
    for (NSUInteger i = 0; i < level; i++) {
        prefix = [@"   " stringByAppendingString:prefix];
    }
    
    NSLog(@"%@ %@", prefix, name);
    level++;
    [info.subclasses enumerateObjectsUsingBlock:^(ClassInfo *obj, BOOL *stop) {
        [self _logHierarchyForClassInfo:obj level:level];
    }];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (void)logHierarchyForClassInfo:(ClassInfo *)info
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    NSAssert(info, @"Must pass in info");
    [self _logHierarchyForClassInfo:info level:0];
}


@end
