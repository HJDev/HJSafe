//
//  HJForwardProxy.m
//  RuntimeDemo
//
//  Created by HeJun<mail@hejun.org> on 23/05/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import "HJForwardProxy.h"

@implementation HJForwardProxy

+ (instancetype)sharedInstance {
	static HJForwardProxy *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[HJForwardProxy alloc] init];
	});
	return instance;
}

- (void)missMethodWithClass:(Class)class target:(id)target selector:(SEL)selector {
	
	if (self.missMethodBlock) {
		self.missMethodBlock(class, target, selector);
	} else if (self.delegate && [self.delegate respondsToSelector:@selector(missMethodWithClass:target:selector:)]) {
		[self.delegate missMethodWithClass:class target:target selector:selector];
	}
}

@end
