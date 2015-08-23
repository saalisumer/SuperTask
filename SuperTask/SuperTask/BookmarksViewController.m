//
//  BookmarksViewController.m
//  SuperTask
//
//  Created by Saalis Umer on 23/08/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import "BookmarksViewController.h"
#import "ShirtPantManager.h"
#import "BookmarkCell.h"
#import "ShareUtility.h"

@interface BookmarksViewController ()<BookmarkCellProtocol>
{
    NSArray * bookmarks;
    ShirtPantManager * manager;
}

@end

@implementation BookmarksViewController

- (void)viewDidLoad {
    manager = [ShirtPantManager instance ];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    bookmarks = [manager getAllBookmarks];

    [self.tblBookmarks reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bookmarks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookmarkCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BOOKMARK_CELL" forIndexPath:indexPath];
    cell.delegate = self;
    cell.bookmark = bookmarks[indexPath.row];
    return cell;
}

#pragma bookmark cell protocol
-(void)shareImage:(UIImage*)image
{
    [ShareUtility shareImage:image onVC:self];
}
@end
