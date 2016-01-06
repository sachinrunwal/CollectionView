//
//  ViewController.m
//  JSONToCollectionView
//
//  Created by Parag Dulam on 05/01/16.
//  Copyright (c) 2016 Parag Dulam. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "JsonInfo.h"


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,NSFetchedResultsControllerDelegate>
{
    NSArray *array;
    AppDelegate *aDel;
}
@end

@implementation ViewController

@synthesize fetchedResultsController= _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fetchedResultsController = nil;
    aDel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)download:(id)sender
{
    
    NSURLRequest *myReq=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.dropbox.com/s/4pushjbzex09txf/countries.json?dl=1"]];
   
    [NSURLConnection sendAsynchronousRequest:myReq queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         NSDictionary *parsedObject=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         
         NSArray *con_name = [parsedObject valueForKey:@"name"];
         NSArray *sta_name= [parsedObject valueForKey:@"status"];
         aDel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
         NSFetchRequest *req=[[NSFetchRequest alloc]initWithEntityName:@"JsonInfo"];
         NSMutableArray *ar=[[aDel.managedObjectContext executeFetchRequest:req error:nil]mutableCopy];
         JsonInfo *jsonData;
         int  i=0;
         for(;i<parsedObject.count;i++)
         {
             
             if ([[ar valueForKey:@"name"]containsObject:con_name[i]])
             {
                
 
             }
             else
             {
                 
                 jsonData=(JsonInfo *)[NSEntityDescription insertNewObjectForEntityForName:@"JsonInfo" inManagedObjectContext:aDel.managedObjectContext];
                 jsonData.name=con_name[i];
                 jsonData.status=sta_name[i];
                 
                 
             }
             
             
         }
         [aDel.managedObjectContext save:nil];
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yo..!" message:@"Data Saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }];
    
}


- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"JsonInfo" inManagedObjectContext:aDel.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:aDel.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
    
}


- (IBAction)display:(id)sender
{
    [self.fetchedResultsController performFetch:nil];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id  sectionInfo =[[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    JsonInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    
     UILabel *label = (UILabel *)[cell viewWithTag:100];
    //UILabel *label = (UILabel*)[cell.contentView viewWithTag:100];
    //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,30, self.view.frame.size.width,30)];
    //label.text = info.name;
    [label setText:info.name];
    //label.font = [UIFont fontWithName:@"HelveticaNeueLTStd-LtCn" size:8];
    label.textColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    //[cell.contentView addSubview:label];
     return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{

}

@end
