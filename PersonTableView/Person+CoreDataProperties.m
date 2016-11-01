//
//  Person+CoreDataProperties.m
//  PersonTableView
//
//  Created by GengRui on 2016-11-01.
//  Copyright © 2016 GengRui. All rights reserved.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic age;
@dynamic gender;
@dynamic name;

@end
