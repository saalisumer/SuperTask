//
//  RootViewController.m
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import "RootViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LoginViewController.h"
#import "ShirtPantSelectorViewController.h"
#import "RandomSuggestionViewController.h"
#import "Constants.h"

@interface RootViewController ()

@end
static RootViewController *singletonInstance = nil;
@implementation RootViewController
+ (RootViewController *) instance {
    @synchronized(self) {
        if(!singletonInstance) {
            singletonInstance =  [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ROOT_VC"];
        }
    }
    
    return singletonInstance;
    
}

- (void)viewDidLoad {
      [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([FBSDKAccessToken currentAccessToken]) {
        //Persist in NSUserDefaults
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL shirtPantCollectionInitialized = [userDefaults boolForKey:kShirtPantCollectionInitialized];
        
        if (shirtPantCollectionInitialized == NO) {
            ShirtPantSelectorViewController * shirtPantSelector =  [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SHIRT_PANT_SELECTOR_VC"];
            [self presentViewController:shirtPantSelector animated:YES completion:nil];
        }
        else
        {
            UITabBarController * tabBar =  [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TAB_BAR_VC"];
            [self presentViewController:tabBar animated:YES completion:nil];
        }
    }
    else
    {
        LoginViewController * loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self presentViewController:loginVC animated:YES completion:^{
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
