//
//  KKLocalHotCityTableViewCell.m
//  KKTribe
//
//  Created by 路飞  on 2018/7/18.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "KKLocalHotCityTableViewCell.h"
#import "KKLocalHotCollectionViewCell.h"

@implementation KKLocalHotCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+(instancetype)createKKLocalHotCityTableViewCellWithTableView:(UITableView *)tableView{
    KKLocalHotCityTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"KKLocalHotCityTableViewCell"];
    if (!cell) {
        cell = [[KKLocalHotCityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KKLocalHotCityTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell initViews];
    }
    return cell;
}
-(void)initViews{
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10, 40)];
    _titleLb.text = @"热门城市";
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = [UIColor lightGrayColor];
    [self addSubview:_titleLb];
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((self.contentView.frame.size.width-24)/3.0, 30);
    layout.minimumLineSpacing = 6;
    layout.minimumInteritemSpacing = 6;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH-40, 90) collectionViewLayout:layout];
    [_collectionView registerClass:[KKLocalHotCollectionViewCell class] forCellWithReuseIdentifier:@"KKLocalHotCollectionViewCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_collectionView];
}
#pragma mark - delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _hotCityArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKLocalHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKLocalHotCollectionViewCell" forIndexPath:indexPath];
    cell.name = _hotCityArr[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_HotCityClickBlock) {
        _HotCityClickBlock(_hotCityArr[indexPath.row]);
    }
}
@end
