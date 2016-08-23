//
//  JLOperationDefines.h
//
//  Version 0.1.0
//
//  Created by Joey L. on 8/22/16.
//  Copyright © 2016 Joey L. All rights reserved.
//
//  https://github.com/buhikon/JLOperation
//

#ifndef JLOperationDefines_h
#define JLOperationDefines_h

@class JLOperation;
@class JLOperationQueue;

@protocol JLOperationDelegate
- (void)operationDidFinish:(nonnull NSOperation *)operation;
@end

typedef void(^JLOperationBlock)(void);
typedef void(^JLOperationQueueBlock)(NSOperation * _Nonnull operation);

#endif /* JLOperationDefines_h */
