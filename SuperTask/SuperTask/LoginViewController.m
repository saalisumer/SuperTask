//
//  RootViewController.m
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@interface LoginViewController ()<FBSDKLoginButtonDelegate>

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [self configureView];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)configureView
{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    
    if ([FBSDKAccessToken currentAccessToken]) {
        self.lblName.hidden = NO;
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     self.lblName.text = [result valueForKey:@"name"];
                 }
             }];
    }
    else
    {
        self.lblName.hidden = YES;
    }
    
    loginButton.delegate = self;
    loginButton.center = self.view.center;
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    if (error == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Login Failed" message:@"Please Try Again Later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
}

@end
