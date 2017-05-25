//
//  NSMutableArray+HJ.m
//  RuntimeDemo
//
//  Created by HeJun<mail@hejun.org> on 15/05/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>


@implementation NSMutableArray (HJ)
#ifndef DEBUG

+ (void)load {

    Class arrayM = NSClassFromString(@"__NSArrayM");
	
    Method methodSuper = class_getInstanceMethod(arrayM, @selector(addObject:));
    Method method = class_getInstanceMethod(arrayM, @selector(customAddObject:));
    method_exchangeImplementations(methodSuper, method);

    Method methodSuperInsert = class_getInstanceMethod(arrayM, @selector(insertObject:atIndex:));
    Method methodInsert = class_getInstanceMethod(arrayM, @selector(customInsertObject:atIndex:));
    method_exchangeImplementations(methodSuperInsert, methodInsert);

    Method methodSuperSetObj = class_getInstanceMethod(arrayM, @selector(setObject:atIndexedSubscript:));
    Method methodSetObj = class_getInstanceMethod(arrayM, @selector(customSetObject:atIndexedSubscript:));
    method_exchangeImplementations(methodSetObj, methodSuperSetObj);

    Method methodSuperRemove = class_getInstanceMethod(arrayM, @selector(removeObjectAtIndex:));
    Method methodRemove = class_getInstanceMethod(arrayM, @selector(customRemoveObjectAtIndex:));
    method_exchangeImplementations(methodSuperRemove, methodRemove);

    Method methodSuperRemoveObj = class_getInstanceMethod(arrayM, @selector(removeObject:));
    Method methodRemoveObj = class_getInstanceMethod(arrayM, @selector(customRemoveObject:));
    method_exchangeImplementations(methodSuperRemoveObj, methodRemoveObj);
    
    Method objectAtIndex = class_getInstanceMethod(arrayM, @selector(objectAtIndex:));
    Method customObjectAtIndex = class_getInstanceMethod(arrayM, @selector(customObjectAtIndex:));
    method_exchangeImplementations(objectAtIndex, customObjectAtIndex);


}
- (void)customRemoveObject:(id)anObject{
    if (anObject) {
        [self customRemoveObject:anObject];
    }else{
        NSLog(@"数组移除了一个空的元素");
    }
}
- (void)customRemoveObjectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        [self customRemoveObjectAtIndex:index];
    }else{
        NSLog(@"数组移除了一个大于数组长度的元素，下标为%lu",(unsigned long)index);
    }

}
//arr[0] = value
- (void)customSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx{
    if (obj) {
        [self customSetObject:obj atIndexedSubscript:idx];
    }else{
        NSLog(@"兄弟啊,数组赋了个空值：%s传了个空值\n",__func__);
    }
}

- (void)customInsertObject:(id)anObject atIndex:(NSUInteger)index{
    if (anObject && index <= self.count) {
        [self customInsertObject:anObject atIndex:index];
    }else{
        NSLog(@"兄弟啊,数组赋了个空值：%s传了个空值\n",__func__);
    }
}
- (void)customAddObject:(id)obj{
    if (obj) {
        [self customAddObject:obj];
    }else{
        NSLog(@"兄弟啊,数组赋了个空值：%s传了个空值\n",__func__);
    }
}
- (id)customObjectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        return nil;
    }
    return [self customObjectAtIndex:index];
}
#endif
@end
