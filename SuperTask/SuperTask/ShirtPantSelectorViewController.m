//
//  ShirtPantSelectorViewController.m
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import "ShirtPantSelectorViewController.h"
#import "ShirtPantSelectionCell.h"
#import "ELCImagePickerController.h"
#import "ShirtPantManager.h"
#import "Constants.h"
#import "RootViewController.h"
#import "MBProgressHUD.h"

@interface ShirtPantSelectorViewController ()<ELCImagePickerControllerDelegate,UIImagePickerControllerDelegate>
{
    NSMutableArray * shirtsArray;
    NSMutableArray * pantsArray;
    MBProgressHUD  * mHUD;
    
    BOOL isPickingPant;
}
@end

@implementation ShirtPantSelectorViewController

- (void)viewDidLoad {
    shirtsArray = [[NSMutableArray alloc]init];
    pantsArray = [[NSMutableArray alloc]init];
    
    mHUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:mHUD];
    [mHUD hide:YES];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)didTapAddShirtFromPhotos:(id)sender
{
    isPickingPant = NO;
    [self presentPicker];
}

-(IBAction)didTapAddShirtFromCamera:(id)sender
{
    isPickingPant = NO;
    [self presentCameraPicker];
}

-(IBAction)didTapAddPantFromPhotos:(id)sender
{
    isPickingPant = YES;
    [self presentPicker];
   
}

-(IBAction)didTapAddPantFromCamera:(id)sender
{
    isPickingPant = YES;
    [self presentCameraPicker];
}

-(IBAction)didTapSave:(id)sender
{
    if (pantsArray.count == 0 || shirtsArray.count == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please add a few shirts and pants." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil ];
        [alert show];
    }
    else
    {
        [mHUD show:YES];
        
        [self performSelector:@selector(saveAllShirtsAndPantsToDB) withObject:nil afterDelay:0.0];
    }
}

-(void)saveAllShirtsAndPantsToDB
{
    ShirtPantManager * shirtPantManager = [ShirtPantManager instance ];
    [shirtPantManager saveShirts:shirtsArray andPants:pantsArray];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:kShirtPantCollectionInitialized];
    [userDefaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [mHUD hide:YES];
    }];
}

- (void)presentCameraPicker
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Camera Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil ];
        [alert show];
    }
}

- (void)presentPicker
{
    // Create the image picker
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 20; //Set the maximum number of images to select, defaults to 4
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return selected order of images
    elcPicker.imagePickerDelegate = self;
    
    //Present modally
    [self presentViewController:elcPicker animated:YES completion:nil];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.shirtsCollection]) {
        return shirtsArray.count;
    }
    else if([collectionView isEqual:self.pantsCollection])
    {
        return pantsArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShirtPantSelectionCell * cell;
    if ([collectionView isEqual:self.shirtsCollection]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SHIRT_CELL" forIndexPath:indexPath];
        cell.imageViewCell.image = shirtsArray[indexPath.row];
    }
    else if ([collectionView isEqual:self.pantsCollection])
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PANT_CELL" forIndexPath:indexPath];
        cell.imageViewCell.image = pantsArray[indexPath.row];
    }
    return cell;
}

#pragma mark ImagePicker Delegate
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    for (id value in info) {
        UIImage *chosenImage = value[UIImagePickerControllerOriginalImage];
        if (isPickingPant) {
            [pantsArray addObject:chosenImage];
        }
        else
        {
            [shirtsArray addObject:chosenImage];
        }
    }
    [self.pantsCollection reloadData];
    [self.shirtsCollection reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIImagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    if (isPickingPant) {
        [pantsArray addObject:chosenImage];
        [self.pantsCollection reloadData];
    }
    else
    {
        [shirtsArray addObject:chosenImage];
        [self.shirtsCollection reloadData];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
