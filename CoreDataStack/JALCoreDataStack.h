//
//  JALCoreDataStack.h
//  CoreDataStack
//
//  Created by Jason Lew on 8/17/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

extern NSString *const kContextInitializedKey;

@interface JALCoreDataStack : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *privateContext;

- (instancetype)initWithStoreType:(NSString *)storeType
                            model:(NSString *)model
                          options:(NSDictionary *)options;
- (void)saveContext:(BOOL)wait;

@end
