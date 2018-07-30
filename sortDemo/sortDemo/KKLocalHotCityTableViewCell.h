//
//  KKLocalHotCityTableViewCell.h
//  KKTribe
//
//  Created by 路飞  on 2018/7/18.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import <UIKit/UIKit.h>
//热门城市
@interface KKLocalHotCityTableViewCell : UITableViewCell<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
//datas
@property (nonatomic, strong) NSArray* hotCityArr;
@property (nonatomic, copy) void(^HotCityClickBlock)(NSString* name);
//views
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UICollectionView* collectionView;
//methods
+(instancetype)createKKLocalHotCityTableViewCellWithTableView:(UITableView*)tableView;

@end
