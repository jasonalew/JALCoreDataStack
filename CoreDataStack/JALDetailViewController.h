//
//  JALDetailViewController.h
//  CoreDataStack
//
//  Created by Jason Lew on 8/21/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface JALDetailViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectID *managedObjectID;

@end
