//
//  CQDZSDCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/13.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQDZSDCell.h"

@interface CQDZSDCell ()
@property (strong, nonatomic) IBOutlet UILabel *btLabel;
@property (strong, nonatomic) IBOutlet UILabel *jsdzsdrLabel;
@property (strong, nonatomic) IBOutlet UILabel *sdsjLabel;
@property (strong, nonatomic) IBOutlet UILabel *qssjLabel;




@end

@implementation CQDZSDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDzsdModel:(CQDZSDModel *)dzsdModel{
    _dzsdModel = dzsdModel;
    self.btLabel.text = dzsdModel.bt;
    self.jsdzsdrLabel.text = dzsdModel.jsdzsdr;
    self.sdsjLabel.text = dzsdModel.sdsj;
    self.qssjLabel.text = dzsdModel.qssj;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
