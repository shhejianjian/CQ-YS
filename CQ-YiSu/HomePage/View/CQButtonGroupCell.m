//
//  CQButtonGroupCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/7.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQButtonGroupCell.h"

@implementation CQButtonGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clickGGSDBtn:(id)sender {
    [_delegate clickGGSDBtn:sender];
}
- (IBAction)clickKTGGBtn:(id)sender {
    [_delegate clickKTGGBtn:sender];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
