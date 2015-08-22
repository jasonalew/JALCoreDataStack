//
//  Recipe.h
//  CoreDataStack
//
//  Created by Jason Lew on 8/22/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RecipeImage, RecipeIngredient, Type;

@interface Recipe : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSData * imageThumb;
@property (nonatomic, retain) NSString * instructions;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) RecipeImage *image;
@property (nonatomic, retain) NSSet *ingredients;
@property (nonatomic, retain) Type *type;
@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)addIngredientsObject:(RecipeIngredient *)value;
- (void)removeIngredientsObject:(RecipeIngredient *)value;
- (void)addIngredients:(NSSet *)values;
- (void)removeIngredients:(NSSet *)values;

@end
