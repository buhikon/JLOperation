//
//  JLBlockOperation.h
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

@class JLOperationQueue;

@interface JLBlockOperation : NSBlockOperation

@property (assign, nonatomic, nullable) JLOperationQueue *queue; // default : currentQueue

- (void)startOperation;

- (void)addDelegate:(nonnull id<JLOperationDelegate>)delegate;
- (void)addDelegate:(nonnull id<JLOperationDelegate>)delegate queue:(nullable dispatch_queue_t)queue;
- (void)removeDelegate:(nonnull id<JLOperationDelegate>)delegate;
- (void)removeAllDelegates;
- (BOOL)hasDelegate:(nonnull id<JLOperationDelegate>)delegate;

- (void)addCompletionHandler:(nonnull JLOperationBlock)completionHandler;
- (void)addCompletionHandler:(nonnull JLOperationBlock)completionHandler name:(nullable NSString *)name; // name은 remove시 식별자로 사용된다.
- (void)addCompletionHandler:(nonnull JLOperationBlock)completionHandler name:(nullable NSString *)name queue:(nullable dispatch_queue_t)queue; // name은 remove시 식별자로 사용된다.
- (void)removeCompletionHandlerForName:(nonnull NSString *)name;
- (void)removeAllCompletionHandlers;

@end
