//
//  Recipe.h
//  CoreDataStack
//
//  Created by Jason Lew on 8/21/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject, RecipeIngredient;

@interface Recipe : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSData * imageThumb;
@property (nonatomic, retain) NSString * instructions;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *image;
@property (nonatomic, retain) NSSet *ingredient;
@property (nonatomic, retain) NSManagedObject *type;
@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)addIngredientObject:(RecipeIngredient *)value;
- (void)removeIngredientObject:(RecipeIngredient *)value;
- (void)addIngredient:(NSSet *)values;
- (void)removeIngredient:(NSSet *)values;

@end
