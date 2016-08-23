//
//  JLBlockOperation.m
//
//  Version 0.1.0
//
//  Created by Joey L. on 8/22/16.
//  Copyright © 2016 Joey L. All rights reserved.
//
//  https://github.com/buhikon/JLOperation
//

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag
#endif

#import "JLBlockOperation.h"
#import "JLOperationQueue.h"

@interface JLBlockOperation ()
@property (strong, nonatomic) NSMutableArray *delegates;
@property (strong, nonatomic) NSMutableArray *completionHandlers;
@end

@implementation JLBlockOperation

static NSInteger JLBlockOperationObservanceContext;

#pragma mark - accessor

- (JLOperationQueue *)queue {
    if(!_queue) {
        _queue = [JLOperationQueue sharedQueue];
    }
    return _queue;
}
- (NSMutableArray *)delegates
{
    if(!_delegates) {
        _delegates = [[NSMutableArray alloc] init];
    }
    return _delegates;
}
- (NSMutableArray *)completionHandlers
{
    if(!_completionHandlers) {
        _completionHandlers = [[NSMutableArray alloc] init];
    }
    return _completionHandlers;
}

#pragma mark - public methods

- (void)startOperation {
    [self addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:&JLBlockOperationObservanceContext];
    [self.queue addOperation:self];
}

- (void)addDelegate:(id<JLOperationDelegate>)delegate {
    [self addDelegate:delegate queue:nil];
}
- (void)addDelegate:(id<JLOperationDelegate>)delegate queue:(dispatch_queue_t)queue {
    if(!delegate) return;
    @synchronized (self.delegates) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
        [dict setObject:(id)delegate forKey:@"delegate"];
        if(queue) {
            [dict setObject:(id)queue forKey:@"queue"];
        }
        [self.delegates addObject:dict];
    }
}
- (void)removeDelegate:(id<JLOperationDelegate>)delegate {
    if(!delegate) return;
    @synchronized (self.delegates) {
        for(NSInteger i=self.delegates.count-1; i>=0; i--) {
            NSDictionary *dict = self.delegates[i];
            id<JLOperationDelegate> delegateInArray = dict[@"delegate"];
            if(delegateInArray == delegate) {
                [self.delegates removeObjectAtIndex:i];
            }
        }
    }
}
- (void)removeAllDelegates {
    @synchronized (self.delegates) {
        [self.delegates removeAllObjects];
    }
}
- (BOOL)hasDelegate:(id<JLOperationDelegate>)delegate {
    @synchronized (self.delegates) {
        for(NSInteger i=self.delegates.count-1; i>=0; i--) {
            NSDictionary *dict = self.delegates[i];
            id<JLOperationDelegate> delegateInArray = dict[@"delegate"];
            if(delegateInArray == delegate) {
                return YES;
            }
        }
        return NO;
    }
}

- (void)addCompletionHandler:(JLOperationBlock)completionHandler {
    [self addCompletionHandler:completionHandler name:nil queue:nil];
}
- (void)addCompletionHandler:(JLOperationBlock)completionHandler name:(NSString *)name {
    [self addCompletionHandler:completionHandler name:name queue:nil];
}
- (void)addCompletionHandler:(JLOperationBlock)completionHandler name:(NSString *)name queue:(dispatch_queue_t)queue {
    if(!completionHandler) return;
    @synchronized (self.completionHandlers) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
        [dict setObject:(id)completionHandler forKey:@"completionHandler"];
        if(name) {
            [dict setObject:(id)name forKey:@"name"];
        }
        if(queue) {
            [dict setObject:(id)queue forKey:@"queue"];
        }
        [self.completionHandlers addObject:dict];
    }
}
- (void)removeCompletionHandlerForName:(NSString *)name {
    if(!name) return;
    @synchronized (self.completionHandlers) {
        for(NSInteger i=self.completionHandlers.count-1; i>=0; i--) {
            NSDictionary *dict = self.completionHandlers[i];
            NSString *nameInArray = dict[@"name"];
            if(nameInArray && [nameInArray isEqualToString:name]) {
                [self.completionHandlers removeObjectAtIndex:i];
            }
        }
    }
}
- (void)removeAllCompletionHandlers {
    @synchronized (self.completionHandlers) {
        [self.completionHandlers removeAllObjects];
    }
}

#pragma mark - private methods

- (void)addFinishObserver {
    [self addFinishObserver];
}
- (void)removeFinishObserver {
    [self removeObserver:self forKeyPath:@"isFinished" context:&JLBlockOperationObservanceContext];
}

- (void)notifyFinish {
    [self notifyToQueue];
    [self notifyDelegates];
    [self notifyCompletionHandlers];
}

- (void)notifyToQueue {
    if([self.queue respondsToSelector:@selector(notifyOperationCompleted:)]) {
        [self.queue notifyOperationCompleted:self];
    }
}

- (void)notifyDelegates {
    for (NSDictionary *dict in self.delegates) {
        id<JLOperationDelegate> delegate = dict[@"delegate"];
        dispatch_queue_t queue = dict[@"queue"];
        if(queue) {
            dispatch_async(queue, ^{
                [delegate operationDidFinish:self];
            });
        }
        else {
            [delegate operationDidFinish:self];
        }
    }
}
- (void)notifyCompletionHandlers {
    for (NSDictionary *dict in self.completionHandlers) {
        JLOperationBlock completionHandler = dict[@"completionHandler"];
        dispatch_queue_t queue = dict[@"queue"];
        if(queue) {
            dispatch_async(queue, ^{
                completionHandler();
            });
        }
        else {
            completionHandler();
        }
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context {
    if(context == &JLBlockOperationObservanceContext) {
        if([keyPath isEqualToString:@"isFinished"]) {
            NSOperation *op = object;
            if(op.finished) {
                [self removeFinishObserver];
                [self notifyFinish];
            }
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
