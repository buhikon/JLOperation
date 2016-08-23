//
//  JLOperationQueue.h
//
//  Version 0.1.0
//
//  Created by Joey L. on 8/22/16.
//  Copyright © 2016 Joey L. All rights reserved.
//
//  https://github.com/buhikon/JLOperation
//

#import <Foundation/Foundation.h>
#import "JLOperationDefines.h"

@interface JLOperationQueue : NSOperationQueue

+ (nonnull JLOperationQueue *)sharedQueue;

// protected
- (void)notifyOperationCompleted:(nonnull NSOperation *)operation;

// public
- (void)addDelegate:(nonnull id<JLOperationDelegate>)delegate;
- (void)addDelegate:(nonnull id<JLOperationDelegate>)delegate queue:(nullable dispatch_queue_t)queue;
- (void)removeDelegate:(nonnull id<JLOperationDelegate>)delegate;
- (void)removeAllDelegates;
- (BOOL)hasDelegate:(nonnull id<JLOperationDelegate>)delegate;

- (void)addCompletionHandler:(nonnull JLOperationQueueBlock)completionHandler;
- (void)addCompletionHandler:(nonnull JLOperationQueueBlock)completionHandler name:(nullable NSString *)name; // name은 remove시 식별자로 사용된다.
- (void)addCompletionHandler:(nonnull JLOperationQueueBlock)completionHandler name:(nullable NSString *)name queue:(nullable dispatch_queue_t)queue; // name은 remove시 식별자로 사용된다.
- (void)removeCompletionHandlerForName:(nonnull NSString *)name;
- (void)removeAllCompletionHandlers;

@end
