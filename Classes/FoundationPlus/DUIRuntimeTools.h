//
//  DUIRuntimeTools.h
//  DUIToolbox
//
//  Created by Honza Dvorsky on 11/03/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClassInfo;

@interface DUIRuntimeTools : NSObject

/**
 Scans class hierarchy of the runtime.
 @param allClasses pointer to a pointer to NSDictionary - fils in dict with all ClassInfos
 @return NSDictionary of all base classes.
 */
+ (NSDictionary *)snapshotClassHierarchyReturnBaseClassesFillAllClassInfos:(NSDictionary **)allClasses;

/**
 Logs class hiearchy for a class info.
 */
+ (void)logHierarchyForClassInfo:(ClassInfo *)info;

@end

@interface ClassInfo : NSObject

- (instancetype) initWithName:(NSString *)name;
+ (instancetype) infoWithName:(NSString *)name;

@property (nonatomic, strong, readonly) Class superclass;
@property (nonatomic, strong, readonly) NSString *superclassName;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSMutableSet *subclasses;

@end
