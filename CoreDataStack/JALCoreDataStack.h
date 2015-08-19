//
//  JALCoreDataStack.h
//  CoreDataStack
//
//  Created by Jason Lew on 8/17/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kContextInitializedKey;

@interface JALCoreDataStack : NSObject

- (void)saveContext:(BOOL)wait;

@end
