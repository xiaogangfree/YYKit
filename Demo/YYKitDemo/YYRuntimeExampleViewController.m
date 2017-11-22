//
//  YYRuntimeExampleViewController.m
//  YYKitDemo
//
//  Created by kiven on 2017/11/22.
//  Copyright © 2017年 ibireme. All rights reserved.
//

#import "YYRuntimeExampleViewController.h"
#import <objc/runtime.h>

void TestMetaClass(id self, SEL _cmd) {
    NSLog(@"This objcet is %p", self);
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
}

@interface YYRuntimeExampleViewController ()

@end

@implementation YYRuntimeExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self run_ex_registerClassPair_eaxmple];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 Objective-C Runtime 运行时之一：类与对象 示例
 南峰子的技术博客
 http://southpeak.github.io/2014/10/25/objective-c-runtime-1/
 类与对象示例
 */
- (void)run_ex_registerClassPair_eaxmple {
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
    objc_registerClassPair(newClass);
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    [instance performSelector:@selector(testMetaClass)];
}

@end







