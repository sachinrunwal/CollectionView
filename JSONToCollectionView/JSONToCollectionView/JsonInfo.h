//
//  JsonInfo.h
//  JSONToCollectionView
//
//  Created by Parag Dulam on 05/01/16.
//  Copyright (c) 2016 Parag Dulam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface JsonInfo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * status;

@end
