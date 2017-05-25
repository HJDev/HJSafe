//
//  HJForwardProxy.h
//  RuntimeDemo
//
//  Created by HeJun<mail@hejun.org> on 23/05/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HJForwardProxyDelegate <NSObject>

@optional
- (void)missMethodWithClass:(Class)cls target:(id)target selector:(SEL)selector;

@end

typedef void(^OnMissMethodPerformed)(Class cls, id target, SEL selector);

@interface HJForwardProxy : NSObject

@property (nonatomic, weak) id<HJForwardProxyDelegate> delegate;
@property (nonatomic, copy) OnMissMethodPerformed missMethodBlock;

+ (instancetype)sharedInstance;
- (void)missMethodWithClass:(Class)class target:(id)target selector:(SEL)selector;

- (void)setMissMethodBlock:(OnMissMethodPerformed)missMethodBlock;

@end
