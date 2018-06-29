//
//  CQGGSDCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/27.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQGGSDCell.h"

@implementation CQGGSDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setGgsdModel:(CQGGSDModel *)ggsdModel{
    _ggsdModel = ggsdModel;
    self.ggrLabel.text = ggsdModel.ggr;
    self.fymcLabel.text = ggsdModel.fymc;
    self.ggrqLabel.text = ggsdModel.ggrq;
    self.gglxmcLabel.text = ggsdModel.gglxmc;
    self.dsrmcLabel.text = ggsdModel.dsrmc;
    self.ahqcLabel.text = ggsdModel.ahqc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
