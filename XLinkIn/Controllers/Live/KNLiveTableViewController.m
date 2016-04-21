//
//  KNLiveTableViewController.m
//  XLinkIn
//
//  Created by emper on 16/4/21.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNLiveTableViewController.h"
#import "KNLiveTableViewCell.h"
@interface KNLiveTableViewController ()

@end

@implementation KNLiveTableViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[KNLiveTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _channelDataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KNLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.topLineStyle = CellLineStyleNone;
    cell.bottomLineStyle = CellLineStyleSpace;
    
    NSDictionary *channel = [_channelDataList objectAtIndex:indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:[channel objectForKey:@"image"]];
    [cell.iconImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"movie_default"]];
    cell.nameLabel.text = [channel objectForKey:@"name"];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = DEFAULT_TABBAR_COLOR;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
@end
