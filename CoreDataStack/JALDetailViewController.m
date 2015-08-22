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

@end

@implementation JALDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [self addRecipe];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRecipe {
    Recipe *newRecipe = (Recipe *)[NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:self.managedObjectContext];
    newRecipe.name = self.nameTextField.text;
    newRecipe.desc = self.descriptionTextField.text;
    RecipeIngredient *newIngredient1 = [NSEntityDescription insertNewObjectForEntityForName:@"RecipeIngredient" inManagedObjectContext:self.managedObjectContext];
    newIngredient1.name = self.ingredient1.text;
    RecipeIngredient *newIngredient2 = [NSEntityDescription insertNewObjectForEntityForName:@"RecipeIngredient" inManagedObjectContext:self.managedObjectContext];
    newIngredient2.name = self.ingredient2.text;
    NSSet *ingredientSet = [NSSet setWithObjects:newIngredient1, newIngredient2, nil];
    DLog(@"newRecipe is: %@", [newRecipe class]);
    [newRecipe addIngredients:ingredientSet];
    Type *newType = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:self.managedObjectContext];
    DLog(@"Type: %@", newType);
    newType.name = self.typeTextField.text;
    [newType addRecipesObject:newRecipe];
//     newRecipe.type = newType;
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
