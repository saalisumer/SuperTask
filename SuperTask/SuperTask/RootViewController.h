//
//  RootViewController.h
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface RootViewController : UIViewController
{
    MBProgressHUD * mHUD;
}
@property (nonatomic, strong)MBProgressHUD * mHUD;
+ (RootViewController*)instance;
@end
