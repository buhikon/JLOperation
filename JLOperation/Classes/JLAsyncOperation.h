//
//  JLAsyncOperation.h
//
//  Version 0.1.0
//
//  Created by Joey L. on 8/18/16.
//  Copyright © 2016 Joey L. All rights reserved.
//
//  https://github.com/buhikon/JLOperation
//
//  # how to use
//  1. override this class and implement `main` method.
//  2. after execution completed, call `completeOperation`.
//
//  # note
//  1. `main` method will be invoked in a different thread to avoid a deadlock when using `performSelector:afterDelay:` or something like that.

#import "JLOperation.h"

@interface JLAsyncOperation : JLOperation

- (void)completeOperation;

@end
