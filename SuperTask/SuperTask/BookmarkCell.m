//
//  BookmarkCell.m
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import "BookmarkCell.h"
#import "Image.h"
#import "ShareUtility.h"

@implementation BookmarkCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBookmark:(Bookmark *)bookmark
{
    _bookmark  = bookmark;
    [self validateProperties];
}

-(void)validateProperties
{
    self.imvShirt.image = [UIImage imageWithData: self.bookmark.shirtImage.imageData];
    self.imvPant.image = [UIImage imageWithData: self.bookmark.pantImage.imageData];
}

-(IBAction)didTapShare:(id)sender
{
    UIImage * image = [self imageWithView:self.bgView];
    [self.delegate shareImage:image];
}

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
@end
