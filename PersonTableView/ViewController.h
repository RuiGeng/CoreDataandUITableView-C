//
//  ViewController.h
//  PersonTableView
//
//  Created by GengRui on 2016-10-31.
//  Copyright © 2016 GengRui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person+CoreDataProperties.h"
#import "DataManager.h"


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *mutableArray;


@end

