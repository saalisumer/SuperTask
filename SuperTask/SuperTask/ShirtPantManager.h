//
//  ShirtPantManager.h
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Image.h"
#import "Bookmark.h"

@interface ShirtPantManager : NSObject
@property (nonatomic, weak) NSManagedObjectContext * context;

+ (ShirtPantManager *) instance;
- (void)loadShirtPantForFirstLoad;
- (void)saveShirts:(NSArray*)shirts andPants:(NSArray*)pants;
- (NSDictionary*)getRandomShirtPantPair;
- (void)addBookmarkShirt:(Image*)shirt andPant:(Image*)pant;
- (NSArray*)getAllBookmarks;
@end
