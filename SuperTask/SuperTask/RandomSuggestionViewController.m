//
//  RandomSuggestionViewController.m
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import "RandomSuggestionViewController.h"
#import "Image.h"
#import "Bookmark.h"
#import "ShirtPantManager.h"
#import "Constants.h"

@interface RandomSuggestionViewController ()
{
    ShirtPantManager * manager;
    Image * mShirtImage;
    Image * mPantImage;
    
    BOOL    mInitializationDone;
}
@end

@implementation RandomSuggestionViewController

- (void)viewDidLoad {
    manager = [ShirtPantManager instance];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (mInitializationDone == NO) {
        [self setRandomShirtPant];
        mInitializationDone = YES;
    }
}

- (void)setRandomShirtPant
{
    NSDictionary* shirtPant = [manager getRandomShirtPantPair];
    mShirtImage = shirtPant[kImageTypeShirt];
    mPantImage = shirtPant[kImageTypePant];
    [self setShirt:mShirtImage andPant:mPantImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didTapBookmark:(id)sender
{
    [manager addBookmarkShirt:mShirtImage andPant:mPantImage];
}

-(IBAction)didTapDislike:(id)sender
{
    [self setRandomShirtPant];
}

- (void)setShirt:(Image*)shirt andPant:(Image*)pant
{
    [UIView animateWithDuration:0.5 animations:^{
        self.shirtImageView.alpha = self.pantImageView.alpha = 0;
    }completion:^(BOOL finished) {
        self.shirtImageView.image = [UIImage imageWithData: shirt.imageData];
        self.pantImageView.image = [UIImage imageWithData: pant.imageData];
        self.shirtImageView.alpha = self.pantImageView.alpha = 1;
    }];
}
@end
