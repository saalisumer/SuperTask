//
//  BookmarksViewController.h
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookmarksViewController : UIViewController<UITableViewDataSource>
@property (nonatomic, weak)IBOutlet UITableView * tblBookmarks;
@end
