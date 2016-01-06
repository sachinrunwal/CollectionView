//
//  ViewController.h
//  JSONToCollectionView
//
//  Created by Parag Dulam on 05/01/16.
//  Copyright (c) 2016 Parag Dulam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,retain) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
-(IBAction) download:(id)sender;
-(IBAction)display:(id)sender;
@end

