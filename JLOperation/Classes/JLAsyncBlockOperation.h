//
//  JLAsyncBlockOperation.h
//
//  Version 0.1.0
//
//  Created by Joey L. on 8/18/16.
//  Copyright © 2016 Joey L. All rights reserved.
//
//  https://github.com/buhikon/JLOperation
//
//  # how to use
//  1. use class method `blockOperationWithBlock:`
//  2. after execution completed, call `completionHandler()` which is sent in the parameter of the block.

#import "JLOperation.h"

typedef void (^JLAsyncBlock)(void(^completionHandler)(void));

@interface JLAsyncBlockOperation : JLOperation

+ (instancetype)blockOperationWithBlock:(JLAsyncBlock)block;
@property (readonly) JLAsyncBlock executionBlock;

@end
