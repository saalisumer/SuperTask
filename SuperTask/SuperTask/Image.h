//
//  Image.h
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Image : NSManagedObject

@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * imageType;

@end
