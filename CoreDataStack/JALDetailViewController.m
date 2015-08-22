//
//  JALDetailViewController.m
//  CoreDataStack
//
//  Created by Jason Lew on 8/21/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import "JALDetailViewController.h"
#import "Recipe.h"
#import "Type.h"
#import "RecipeIngredient.h"
#import "AppDelegate.h"
#import "JALCoreDataStack.h"
#import "JALLog.h"


@interface JALDetailViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *ingredient1;
@property (weak, nonatomic) IBOutlet UITextField *ingredient2;

@property (strong, nonatomic) Recipe *recipe;
@property (strong, nonatomic) NSSet *ingredients;
@property (strong, nonatomic) Type *type;

@end

@implementation JALDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.managedObjectID != nil) {
        [self updateValues];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.managedObjectID == nil) { // Segue via the add button.
        [self addRecipe];
    }
    
    [self saveRecipe];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateValues {
    self.recipe = (Recipe *)[self.managedObjectContext objectWithID:self.managedObjectID];
    self.nameTextField.text = self.recipe.name;
    self.descriptionTextField.text = self.recipe.desc;
    self.type = self.recipe.type;
    self.typeTextField.text = self.recipe.type.name;
    self.ingredients = self.recipe.ingredients;
    NSArray *ingredientArray = [self.ingredients allObjects];
    self.ingredient1.text = ((RecipeIngredient *)ingredientArray[0]).name;
    self.ingredient2.text = ((RecipeIngredient *)ingredientArray[1]).name;
}


- (void)addRecipe {
    self.recipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe"
                                                inManagedObjectContext:self.managedObjectContext];
    RecipeIngredient *newIngredient1 =
        [NSEntityDescription insertNewObjectForEntityForName:@"RecipeIngredient"
                                      inManagedObjectContext:self.managedObjectContext];
    RecipeIngredient *newIngredient2 =
        [NSEntityDescription insertNewObjectForEntityForName:@"RecipeIngredient"
                                      inManagedObjectContext:self.managedObjectContext];
    self.ingredients = [NSSet setWithObjects:newIngredient1, newIngredient2, nil];
    self.type = [NSEntityDescription insertNewObjectForEntityForName:@"Type"
                                              inManagedObjectContext:self.managedObjectContext];
    self.recipe.type = self.type;
}

- (void)saveRecipe {
    self.recipe.name = self.nameTextField.text;
    self.recipe.desc = self.descriptionTextField.text;
    
    NSArray *ingredientArray = [self.ingredients allObjects];
    ((RecipeIngredient *)ingredientArray[0]).name = self.ingredient1.text;
    ((RecipeIngredient *)ingredientArray[1]).name = self.ingredient2.text;
    self.ingredients = [NSSet setWithArray:ingredientArray];
    
    [self.recipe addIngredients:self.ingredients];
    
    
    //    newType.name = self.typeTextField.text;
    //    [newType addRecipesObject:newRecipe];
    
    self.recipe.type.name = self.typeTextField.text;
    DLog(@"Type: %@", self.type);
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    JALCoreDataStack *coreDataStack = appDelegate.coreDataStack;
    [coreDataStack saveContext:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
