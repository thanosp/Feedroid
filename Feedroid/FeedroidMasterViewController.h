//
//  FeedroidMasterViewController.h
//  Feedroid
//
//  Created by Thanos Polymeneas on 31/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeedroidDetailViewController;

#import <CoreData/CoreData.h>

@interface FeedroidMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) FeedroidDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
