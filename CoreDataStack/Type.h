//
//  Type.h
//  CoreDataStack
//
//  Created by Jason Lew on 8/22/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface Type : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *recipes;
@end

@interface Type (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(Recipe *)value;
- (void)removeRecipesObject:(Recipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;

@end
