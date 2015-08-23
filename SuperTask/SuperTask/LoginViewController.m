//
//  RootViewController.m
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface LoginViewController ()<FBSDKLoginButtonDelegate>

@end

@implementation LoginViewController


- (void)viewDidLoad {
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.delegate = self;
    loginButton.center = self.view.center;
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    [self.view addSubview:loginButton];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    
}

@end
