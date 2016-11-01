//
//  DataManager.h
//  PersonTableView
//
//  Created by GengRui on 2016-10-31.
//  Copyright © 2016 GengRui. All rights reserved.
//

#ifndef DataManager_h
#define DataManager_h


#endif /* DataManager_h */

@interface DataManager : NSObject

+ (DataManager *)sharedManager;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *) applicationDocumentsDirectory;

@end
