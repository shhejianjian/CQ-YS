//
//  CQAJCXCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/13.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQAJCXCell.h"


@implementation CQAJCXCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setAjcxModel:(CQAJCXModel *)ajcxModel{
    _ajcxModel = ajcxModel;
    self.ahqcLabel.text = ajcxModel.ahqc;
    self.yuangaoLabel.text = ajcxModel.dyyg;
    self.beigaoLabel.text = ajcxModel.dybg;
    self.fymcLabel.text = ajcxModel.fymc;
    self.sqsjLabel.text = ajcxModel.larq;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
