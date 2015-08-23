//
//  ShareUtility.m
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import "ShareUtility.h"
#import "RootViewController.h"

@implementation ShareUtility
+ (void)shareImage:(UIImage*)image onVC:(UIViewController*)vc
{
    NSString *textToShare = @"My Favorite Pair";
    NSArray *itemsToShare = @[textToShare, image];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll];
    [vc presentViewController:activityVC animated:YES completion:nil];
}
@end
