//
//  ShareUtility.h
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ShareUtility : NSObject
+ (void)shareImage:(UIImage*)image onVC:(UIViewController*)vc;
@end
