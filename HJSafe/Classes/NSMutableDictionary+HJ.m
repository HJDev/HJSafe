//
//  NSMutableDictionary+HJ.m
//  RuntimeDemo
//
//  Created by HeJun<mail@hejun.org> on 15/05/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSMutableDictionary (Safe)
#ifndef DEBUG

+ (void)load {
    Class dictCls = NSClassFromString(@"__NSDictionaryM");
    
    Method methodSetObjSuperScript = class_getInstanceMethod(dictCls, @selector(setObject:forKeyedSubscript:));
    Method methodSetObjScript = class_getInstanceMethod(dictCls, @selector(customSetObject:forKeyedSubscript:));
    method_exchangeImplementations(methodSetObjSuperScript, methodSetObjScript);

    
    Method methodSetObjSuper = class_getInstanceMethod(dictCls, NSSelectorFromString(@"setObject:forKey:"));
    Method methodSetObj = class_getInstanceMethod(dictCls, @selector(customSetObject:forKey:));
    method_exchangeImplementations(methodSetObj, methodSetObjSuper);

    Method methodSuperRemoveKey = class_getInstanceMethod(dictCls, @selector(removeObjectForKey:));
    Method methodRemoveKey = class_getInstanceMethod(dictCls, @selector(customRemoveObjectForKey:));
    method_exchangeImplementations(methodRemoveKey, methodSuperRemoveKey);

}
- (void)customRemoveObjectForKey:(id)aKey {
    if (aKey && aKey) {
        [self customRemoveObjectForKey:aKey];
    } else {
        NSLog(@"remove了一个空，key为%@",aKey);
    }
}
//dic["key"] = value
- (void)customSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (obj && key) {
        [self customSetObject:obj forKeyedSubscript:key];
    } else {
        NSLog(@"setObject了一个空，key为%@",key);
    }
}
//[dic setvalue forkey];
- (void)customSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey) {
        [self customSetObject:anObject forKey:aKey];
    } else {
        NSLog(@"setObject了一个空，key为%@",aKey);
    }
}
#endif
@end
