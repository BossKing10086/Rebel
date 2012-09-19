//
//  CAAnimation+RBLBlockAdditions.m
//  Rebel
//
//  Created by Danny Greg on 13/09/2012.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "CAAnimation+RBLBlockAdditions.h"

#import <objc/runtime.h>

static void *RBLCAAnimationCompletionBlockAssociatedObjectKey = &RBLCAAnimationCompletionBlockAssociatedObjectKey;

@implementation CAAnimation (RBLBlockAdditions)

- (void)setRbl_completionBlock:(void (^)(BOOL))block {
	self.delegate = self;
	objc_setAssociatedObject(self, RBLCAAnimationCompletionBlockAssociatedObjectKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(BOOL))rbl_completionBlock {
	return objc_getAssociatedObject(self, RBLCAAnimationCompletionBlockAssociatedObjectKey);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	if (self.rbl_completionBlock != nil) self.rbl_completionBlock(flag);
}

@end