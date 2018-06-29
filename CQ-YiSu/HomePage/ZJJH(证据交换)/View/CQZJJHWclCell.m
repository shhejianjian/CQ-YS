//
//  CQZJJHWclCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/19.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQZJJHWclCell.h"

@implementation CQZJJHWclCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setZjjhModel:(CQZJJHModel *)zjjhModel{
    _zjjhModel = zjjhModel;
    if ([self.status isEqualToString:@"1"]) {
        self.titleLabel.text = zjjhModel.title;
        self.sxrqLabel.text = [zjjhModel.sxrq substringToIndex:10];
        self.fssjLabel.text = [zjjhModel.fssj substringToIndex:10];
        self.ahqcLabel.text = zjjhModel.ahqc;
        self.dsrLabel.text = @"失效日期 :";
        self.image.hidden = YES;
        self.yclSxrqLabel.hidden = YES;
        self.label.hidden = YES;
    }else if ([self.status isEqualToString:@"2"]){
        self.ahqcLabel.text = zjjhModel.ahqc;
        self.titleLabel.text = zjjhModel.title;
        self.fssjLabel.text = [zjjhModel.fssj substringToIndex:10];
        self.sxrqLabel.text = zjjhModel.dsrmc;
        self.yclSxrqLabel.text = [zjjhModel.sxrq substringToIndex:10];
        self.dsrLabel.text = @"当事人 :";
        self.image.hidden = NO;
        self.dsrLabel.hidden = NO;
        self.yclSxrqLabel.hidden = NO;
        self.label.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
