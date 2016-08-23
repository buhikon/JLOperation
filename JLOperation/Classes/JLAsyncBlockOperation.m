//
//  JLAsyncBlockOperation.m
//
//  Version 0.1.0
//
//  Created by Joey L. on 8/18/16.
//  Copyright © 2016 Joey L. All rights reserved.
//
//  https://github.com/buhikon/JLOperation
//
//  referenced from http://stackoverflow.com/questions/1596160
//

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag
#endif

#import "JLAsyncBlockOperation.h"

@interface JLAsyncBlockOperation ()
// 'executing' and 'finished' exist in NSOperation, but are readonly
@property (atomic, assign) BOOL _executing;
@property (atomic, assign) BOOL _finished;
@property (atomic, copy) JLAsyncBlock _executionBlock;
@end

@implementation JLAsyncBlockOperation

+ (instancetype)blockOperationWithBlock:(JLAsyncBlock)block {
    JLAsyncBlockOperation *instance = [[JLAsyncBlockOperation alloc] init];
    instance._executionBlock = block;
    return instance;
}

- (JLAsyncBlock)executionBlock {
    return self._executionBlock;
}

#pragma mark -

- (void)start;
{
    if([self isCancelled]) {
        // Move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        self._finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    if(self._executionBlock) {
        void(^completionHandler)(void) = ^(void) {
            [self completeOperation];
        };
        self._executionBlock(completionHandler);
    }
    self._executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
}

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return self._executing;
}

- (BOOL)isFinished {
    return self._finished;
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    self._executing = NO;
    self._finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}


@end
