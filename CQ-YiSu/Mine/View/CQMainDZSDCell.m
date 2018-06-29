//
//  CQMainDZSDCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/7.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQMainDZSDCell.h"

@implementation CQMainDZSDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//-(void)setPageModel:(CQPageStatisticsModel *)pageModel{
//    _pageModel = pageModel;
//    self.wdajBtn = pageModel.count;
//    self
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPageModel:(CQPageStatisticsModel *)pageModel{
    _pageModel = pageModel;
    
}

- (IBAction)clickDZSDBtn:(UIButton *)button {
    [_delegate clickDZSDBtn:button];
}

@end
