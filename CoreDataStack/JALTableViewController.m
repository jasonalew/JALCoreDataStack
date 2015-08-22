//
//  JALTableViewController.m
//  CoreDataStack
//
//  Created by Jason Lew on 8/21/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import "JALTableViewController.h"
#import "JALTableViewCell.h"
#import "JALDetailViewController.h"

@interface JALTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation JALTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    DLog(@"Managed object context: %@", self.managedObjectContext);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addRecipe:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    JALDetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVCID"];
//    [self presentViewController:detailVC animated:YES completion:nil];
    [self performSegueWithIdentifier:@"recipeDetailSegue" sender:sender];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo>sectionInfo = sections[section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JALTableViewCell *cell = (JALTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JALTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecipeCell"];
//        cell.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 88);
    }
    // Configure the cell...
    NSManagedObject *obj = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.recipeName.text = [obj valueForKey:@"name"];
    cell.recipeDescription.text = [obj valueForKey:@"description"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Fetched Results Controller

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    // Get the recipes and order by name
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
    
    
    fetchRequest.fetchBatchSize = 20;
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"type.name" ascending:YES];
    NSSortDescriptor *nameSort = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptorArray = @[sort, nameSort];
    fetchRequest.sortDescriptors = sortDescriptorArray;
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"type.name" cacheName:@"Master"];
    _fetchedResultsController = frc;
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        DLog(@"Unresolved error %@\n%@", error.localizedDescription, error.userInfo);
    }
    return _fetchedResultsController;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"recipeDetailSegue"]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            DLog(@"From cell");
        }
    }
}


@end
