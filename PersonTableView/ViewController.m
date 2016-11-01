//
//  ViewController.m
//  PersonTableView
//
//  Created by GengRui on 2016-10-31.
//  Copyright © 2016 GengRui. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

//Load all Data 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mutableArray = [[NSMutableArray alloc] init];
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age = 21", ];
    //    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Unresolved Fetch Error%@",error);
    }else{
        [self.mutableArray addObjectsFromArray:fetchedObjects];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Only One Section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mutableArray.count;
}

//Format Table Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    Person *person = self.mutableArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"name:%@,age:%d",person.name,person.age];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"gender:%@",person.gender];
    return cell;
    
}

//Add Data
- (IBAction)addData:(id)sender {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:managedObjectContext];
    
    Person *person = [[Person alloc]initWithEntity: entityDescription insertIntoManagedObjectContext:managedObjectContext];
    
    person.name = @"GENG";
    person.gender = @"Male";
    
    int age = arc4random()%20 + 1;
    person.age  = age;
    
    //[self.mutableArray addObject:person];
    [self.mutableArray insertObject:person atIndex:0];
    
    [[DataManager sharedManager] saveContext];
    
    //[self.tableView reloadData];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
}


//Delete Button
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"Delete";
}

//Delete One Row
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
        
        Person *person = self.mutableArray[indexPath.row];
        [self.mutableArray removeObject:person];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [managedObjectContext deleteObject:person];
        
        [[DataManager sharedManager] saveContext];
    }
    
}

//Delete All Data
- (IBAction)DeleteAllData:(id)sender {
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    NSFetchRequest * allRecords = [[NSFetchRequest alloc] init];
    
    [allRecords setEntity:[NSEntityDescription entityForName:@"Person" inManagedObjectContext:managedObjectContext]];
    
    [allRecords setIncludesPropertyValues:NO];
    
    NSError * error = nil;
    NSArray * result = [managedObjectContext executeFetchRequest:allRecords error:&error];
    for (Person * person in result) {
        [managedObjectContext deleteObject:person];
        [self.mutableArray removeObject:person];
    }
    NSError *saveError = nil;
    [managedObjectContext save:&saveError];
    [self.tableView reloadData];
    
}

//Modify Data
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Person *person = self.mutableArray[indexPath.row];
    
    if ([person.gender isEqualToString:@"Male"]) {
        
        person.gender = @"Femal";
        person.name = @"Rui";
        [[DataManager sharedManager] saveContext];
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
    }
    
    [self.tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
