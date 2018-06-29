//
//  CQKTGGCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/28.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQKTGGCell.h"

@implementation CQKTGGCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //边框宽
    self.bgView.layer.borderWidth = 1;
    //边框颜色
    self.bgView.layer.borderColor = [[UIColor orangeColor] CGColor];
    self.bgView.layer.cornerRadius = 5;
}

-(void)setKtggModel:(CQKTGGModel *)ktggModel{
    _ktggModel = ktggModel;
    self.ahqcLabel.text = ktggModel.ahqc;
    self.fymcLabel.text = ktggModel.fymc;
    self.xsksrqLabel.text = ktggModel.xsksrq;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
