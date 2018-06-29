//
//  CQMainZZJHCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/7.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQMainZZJHCell.h"

@implementation CQMainZZJHCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setPageModel:(CQPageStatisticsModel *)pageModel{
    _pageModel = pageModel;
    self.zjLabel.text = pageModel.zjjhCount;
    self.wclLabel.text = pageModel.zjjhCountWcl;
    self.yclLabel.text = pageModel.zjjhCountYcl;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickZZJHBtn:(UIButton *)button {
    [_delegate clickZZJHBtn:button];
}


@end
