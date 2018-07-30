//
//  KKLocalHotCollectionViewCell.m
//  KKTribe
//
//  Created by 路飞  on 2018/7/18.
//  Copyright © 2018年 杭州鼎代. All rights reserved.
//

#import "KKLocalHotCollectionViewCell.h"

@implementation KKLocalHotCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    self.backgroundColor = [UIColor whiteColor];
    self.nameLb = [[UILabel alloc]initWithFrame:self.bounds];
    _nameLb.textColor = [UIColor darkGrayColor];
    _nameLb.font = [UIFont systemFontOfSize:15.0f];
    _nameLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLb];
    self.layer.cornerRadius = 3.0f;
    self.layer.borderColor = RGB(243, 243, 243).CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.masksToBounds = YES;
}
-(void)setName:(NSString *)name{
    _name = name;
    _nameLb.text = name;
}
@end
