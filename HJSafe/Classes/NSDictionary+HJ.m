//
//  NSDictionary+HJ.m
//  HJSafe
//
//  Created by HeJun<mail@hejun.org> on 15/05/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSDictionary (Safe)

#ifndef DEBUG

+ (void)load {
	Class dictCls = NSClassFromString(@"__NSDictionaryI");
	
    Method originalMethod = class_getClassMethod(dictCls, @selector(dictionaryWithObjects:forKeys:count:));
    Method swizzledMethod = class_getClassMethod(dictCls, @selector(customDictionaryWithObjects:forKeys:count:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
+ (instancetype)customDictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt {
    id nObjects[cnt];
    id nKeys[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i] && keys[i]) {
            nObjects[j] = objects[i];
            nKeys[j] = keys[i];
            j++;
        }
    }

    return [self customDictionaryWithObjects:nObjects forKeys:nKeys count:j];
}
#endif

@end
