//
//  ShirtPantManager.m
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import "ShirtPantManager.h"
#import <UIKit/UIKit.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "Constants.h"
#import "AppDelegate.h"

@implementation ShirtPantManager


static ShirtPantManager *singletonInstance = nil;

- (id)init {
    if(self = [super init]) {
 
    }
    
    return self;
}

+ (ShirtPantManager *) instance {
    @synchronized(self) {
        if(!singletonInstance) {
            singletonInstance = [[ShirtPantManager alloc] init];
        }
    }
    
    return singletonInstance;
}

-(NSManagedObjectContext *)context
{
    return ((AppDelegate*)[[UIApplication sharedApplication] delegate]).managedObjectContext;
}

- (void)loadShirtPantForFirstLoad
{
    //Load some shirt pants from bundle into photo album
    //Persist in NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL firstLaunch = [userDefaults boolForKey:kFirstLaunchShirtPantLoaded];
    
    if (firstLaunch == NO) {
        [self loadPantShirtsIntoPhotoAlbum];
    }
    [userDefaults setBool:YES forKey:kFirstLaunchShirtPantLoaded];
    [userDefaults synchronize];
    

}

- (void)loadPantShirtsIntoPhotoAlbum
{
    static int p = 1;
    
    UIImage * pant = [UIImage imageNamed:[NSString stringWithFormat:@"pant%d",p]];
    UIImage * shirt = [UIImage imageNamed:[NSString stringWithFormat:@"shirt%d",p]];
    ALAssetsLibrary * library = [ALAssetsLibrary new];
    [library saveImage:pant toAlbum:@"Pant" completion:^(NSURL *assetURL, NSError *error) {
        [library saveImage:shirt toAlbum:@"Shirt" completion:^(NSURL *assetURL, NSError *error) {
            if (p<14) {
                p++;
                [self loadPantShirtsIntoPhotoAlbum];
            }
            else
            {
                return;
            }
        } failure:^(NSError *error) {
        }];
        
    } failure:^(NSError *error) {
    }];
}

- (void)saveShirts:(NSArray*)shirts andPants:(NSArray*)pants
{
    for (UIImage * image in shirts) {
        [self saveShirt:image];
    }
    
    for (UIImage * image in pants) {
        [self savePant:image];
    }
}

- (void)saveShirt:(UIImage*)shirt
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Image"
                                                         inManagedObjectContext:self.context];
    
    Image *shirtImage = [[Image alloc]
                                       initWithEntity:entityDescription
                                       insertIntoManagedObjectContext:self.context];
    shirtImage.imageData = UIImagePNGRepresentation(shirt);
    shirtImage.imageType = kImageTypeShirt;
    [self.context save:nil];
}

- (void)savePant:(UIImage*)pant
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Image"
                                                         inManagedObjectContext:self.context];
    
    Image *pantImage = [[Image alloc]
                         initWithEntity:entityDescription
                         insertIntoManagedObjectContext:self.context];
    pantImage.imageData = UIImagePNGRepresentation(pant);
    pantImage.imageType = kImageTypePant;
    [self.context save:nil];
}

- (NSDictionary*)getRandomShirtPantPair
{
    Image * shirt = [self getAnyShirt];
    Image * pant = [self getAnyPant];
    
    NSDictionary * dictionary;
    
    if (shirt!=nil && pant!=nil)
    dictionary= [[NSDictionary alloc]initWithObjectsAndKeys:shirt,kImageTypeShirt,pant,kImageTypePant, nil];
    
    return dictionary;
}

- (Image*)getAnyShirt
{
    NSArray *fetchedObjects;
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Image"  inManagedObjectContext: self.context];
    [fetch setEntity:entityDescription];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"(ANY imageType contains %@)",kImageTypeShirt]];
    NSError * error = nil;
    fetchedObjects = [self.context executeFetchRequest:fetch error:&error];
    
    if([fetchedObjects count] == 1)
        return [fetchedObjects objectAtIndex:0];
    else
    {
        NSUInteger randomIndex = arc4random() % [fetchedObjects count];
        return fetchedObjects[randomIndex];
    }
}

- (Image*)getAnyPant
{
    NSArray *fetchedObjects;
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Image"  inManagedObjectContext: self.context];
    [fetch setEntity:entityDescription];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"(ANY imageType contains %@)",kImageTypePant]];
    NSError * error = nil;
    fetchedObjects = [self.context executeFetchRequest:fetch error:&error];
    
    if([fetchedObjects count] == 1)
        return [fetchedObjects objectAtIndex:0];
    else
    {
        NSUInteger randomIndex = arc4random() % [fetchedObjects count];
        return fetchedObjects[randomIndex];
    }
}

- (void)addBookmarkShirt:(Image*)shirt andPant:(Image*)pant
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Bookmark"
                                                         inManagedObjectContext:self.context];
    
    Bookmark *bookmark = [[Bookmark alloc]
                        initWithEntity:entityDescription
                        insertIntoManagedObjectContext:self.context];
    bookmark.shirtImage = shirt;
    bookmark.pantImage = pant;
    
    [self.context save:nil];
}

- (NSArray*)getAllBookmarks
{
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Bookmark" inManagedObjectContext:self.context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *allBookmarks = [self.context executeFetchRequest:request error:&error];
    return allBookmarks;
}

@end
