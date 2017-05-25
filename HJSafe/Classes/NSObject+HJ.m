//
//  NSObject+HJ.m
//  HJSafe
//
//  Created by HeJun<mail@hejun.org> on 23/05/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import "NSObject+HJ.h"
#import <objc/runtime.h>
#import "HJForwardProxy.h"

@implementation NSObject (HJ)

#ifndef DEBUG
+ (void)load {
	Method methodSignatureForSelector = class_getInstanceMethod(self, @selector(methodSignatureForSelector:));
	Method customMethodSignatureForSelector = class_getClassMethod(self, @selector(customMethodSignatureForSelector:));
	method_exchangeImplementations(methodSignatureForSelector, customMethodSignatureForSelector);
	
	Method forwardInvocation = class_getInstanceMethod(self, @selector(forwardInvocation:));
	Method customForwardInvocation = class_getClassMethod(self, @selector(customForwardInvocation:));
	method_exchangeImplementations(forwardInvocation, customForwardInvocation);
}

- (NSMethodSignature *)customMethodSignatureForSelector:(SEL)aSelector {
	
	NSMethodSignature *ms = [self customMethodSignatureForSelector:aSelector];
	
	if (ms == nil) {
		ms = [HJForwardProxy instanceMethodSignatureForSelector:@selector(missMethodWithClass:target:selector:)];
	}
	
	return ms;
}

- (void)customForwardInvocation:(NSInvocation *)anInvocation {
	
	if (anInvocation) {
		[[HJForwardProxy sharedInstance] missMethodWithClass:[self class] target:[anInvocation target] selector:[anInvocation selector]];
	}
}
#endif

@end
