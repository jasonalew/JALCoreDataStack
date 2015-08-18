//
//  JALCoreDataStack.m
//  CoreDataStack
//
//  Created by Jason Lew on 8/17/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import "JALCoreDataStack.h"
#import "JALLog.h"
@import CoreData;

NSString *const kContextInitializedKey = @"contextInitializedKey";

@interface JALCoreDataStack()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *privateContext;

@end

@implementation JALCoreDataStack

- (void)initializeCoreDataStack {
    NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"JALCoreDataStack" withExtension:@"momd"];
    NSAssert(modelURL, @"Failed to find model URL");
    
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    NSAssert(mom, @"Failed to initialize model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:mom];
    NSAssert(psc, @"Failed to initialize persistent store coordinator");
    
    // Make sure the NSManagedObjectContext is initialized before the
    // NSPersistentStore is added to the coordinator.
    self.privateContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.privateContext.persistentStoreCoordinator = psc;
    
    self.managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    // Instead of attaching and writing to the NSPersistentStoreCoordinator,
    // saves on the main context will be pushed to the private context.
    self.managedObjectContext.parentContext = self.privateContext;
    
    // Adding the NSPersistentStore to the NSPersistentStoreCoordinator
    // could take an unknown amount of time. Do this on a background queue
    // to avoid delaying launch.
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *directoryArray = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL *storeURL = [directoryArray lastObject];
        storeURL = [storeURL URLByAppendingPathComponent:@"JALCoreDataStack.sqlite"];
        
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES,
                                         NSInferMappingModelAutomaticallyOption: @YES};
        NSError *error = nil;
        NSPersistentStore *store = nil;
        store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
        
        if (!store) {
            DLog(@"Error adding persistent store to coordinator %@", error
                                                                    .localizedDescription);
//TODO: present user facing error
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Let the UI know that the psc is ready
            [self contextInitialized];
        });
    });
}

- (void)contextInitialized {
    // Send out notification that the context is initialized
    [[NSNotificationCenter defaultCenter]postNotificationName:kContextInitializedKey object:nil];
}

- (void)saveContext:(BOOL)wait {
    NSManagedObjectContext *moc = self.managedObjectContext;
    NSManagedObjectContext *private = self.privateContext;
    
    if (!moc) {
        return;
    }
    
    if (moc.hasChanges) {
        [moc performBlockAndWait:^{
            NSError *error = nil;
            [moc save:&error];
            if (error) {
                DLog(@"Error saving MOC: %@\n%@", error.localizedDescription, error.userInfo);
            }
        }];
    }
    
    void (^savePrivate)(void) = ^{
        NSError *error = nil;
        [private save:&error];
        if (error) {
            DLog(@"Error saving MOC: %@\n%@", error.localizedDescription, error.userInfo);
        }
    };
    
    if (private.hasChanges) {
        // When going into the background or terminating the app, we might
        // want to block until the save completes.
        if (wait) {
            [private performBlockAndWait:savePrivate];
        } else {
            [private performBlock:savePrivate];
        }
    }
}

@end
