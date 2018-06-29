//
//  CQMainWSLACell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/6.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQMainWSLACell.h"

@implementation CQMainWSLACell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPageModel:(CQPageStatisticsModel *)pageModel{
    _pageModel = pageModel;
    NSInteger num1 = pageModel.sctg.integerValue;
    NSInteger num2 = pageModel.yla.integerValue;
    NSInteger num3 = pageModel.wtj.integerValue;
    NSInteger num4 = pageModel.scbtg.integerValue;
    NSInteger num5 = pageModel.yja.integerValue;
    NSInteger num6 = pageModel.dsc.integerValue;
    NSInteger num7 = pageModel.ysa.integerValue;
    NSInteger result = num1 + num2 + num3 + num4 + num5 + num6 + num7;
    self.zjLabel.text = [NSString stringWithFormat:@"%ld",result];
    self.sctgLabel.text = pageModel.sctg;
    self.ylaLabel.text = pageModel.yla;
    self.dtjLabel.text = pageModel.wtj;
    self.scbtgLaebl.text = pageModel.scbtg;
    self.yjaLabel.text = pageModel.yja;
    self.dsaLaebl.text = pageModel.dsc;
    self.ysaLaebl.text = pageModel.ysa;
}

- (IBAction)clickWSLABtn:(UIButton *)button {
    [_delegate clickWSLABtn:button];
}



@end
