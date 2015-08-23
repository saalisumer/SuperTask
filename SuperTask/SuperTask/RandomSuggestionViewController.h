//
//  RandomSuggestionViewController.h
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomSuggestionViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIImageView * shirtImageView;
@property (nonatomic, weak) IBOutlet UIImageView * pantImageView;
-(IBAction)didTapBookmark:(id)sender;
-(IBAction)didTapDislike:(id)sender;
@end
