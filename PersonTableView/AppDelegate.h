//
//  AppDelegate.h
//  PersonTableView
//
//  Created by GengRui on 2016-10-31.
//  Copyright © 2016 GengRui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

