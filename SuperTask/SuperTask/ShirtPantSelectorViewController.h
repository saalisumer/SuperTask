//
//  ShirtPantSelectorViewController.h
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShirtPantSelectorViewController : UIViewController<UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView * shirtsCollection;
@property (nonatomic, weak) IBOutlet UICollectionView * pantsCollection;

-(IBAction)didTapAddShirtFromPhotos:(id)sender;
-(IBAction)didTapAddShirtFromCamera:(id)sender;
-(IBAction)didTapAddPantFromPhotos:(id)sender;
-(IBAction)didTapAddPantFromCamera:(id)sender;
-(IBAction)didTapSave:(id)sender;

@end
