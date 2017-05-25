//
//  NSArray+HJ.m
//  RuntimeDemo
//
//  Created by HeJun<mail@hejun.org> on 15/05/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSArray (Safe)

#ifndef DEBUG

+ (void)load {
    Method originalMethod = class_getClassMethod(self, @selector(arrayWithObjects:count:));
    Method swizzledMethod = class_getClassMethod(self, @selector(customArrayWithObjects:count:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    Class arrayM = NSClassFromString(@"__NSArrayI");
	
    Method objectAtIndex = class_getInstanceMethod(arrayM, @selector(objectAtIndex:));
    Method customObjectAtIndex = class_getInstanceMethod(arrayM, @selector(customObjectAtIndex:));
    method_exchangeImplementations(objectAtIndex, customObjectAtIndex);
}

+ (instancetype)customArrayWithObjects:(const id [])objects count:(NSUInteger)cnt {
    id nObjects[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i]) {
            nObjects[j] = objects[i];
            j++;
        }
    }
    
    return [self customArrayWithObjects:nObjects count:j];
}

- (id)customObjectAtIndex:(NSInteger)index{
    if (index >= self.count) {
        return nil;
    }
    return [self customObjectAtIndex:index];
}

#endif

@end
