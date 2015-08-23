//
//  Bookmark.h
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface Bookmark : NSManagedObject

@property (nonatomic, retain) Image *shirtImage;
@property (nonatomic, retain) Image *pantImage;

@end
