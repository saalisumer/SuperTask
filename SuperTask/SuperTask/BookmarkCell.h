//
//  BookmarkCell.h
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bookmark.h"

@protocol BookmarkCellProtocol <NSObject>

-(void)shareImage:(UIImage*)image;

@end

@interface BookmarkCell : UITableViewCell
@property (nonatomic, weak) Bookmark * bookmark;
@property (nonatomic, weak) IBOutlet UIImageView * imvShirt;
@property (nonatomic, weak) IBOutlet UIImageView * imvPant;
@property (nonatomic, weak) IBOutlet UIView * bgView;

@property (nonatomic, weak) id<BookmarkCellProtocol> delegate;
-(IBAction)didTapShare:(id)sender;
@end
