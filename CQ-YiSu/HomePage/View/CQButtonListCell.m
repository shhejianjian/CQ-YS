//
//  CQButtonListCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/5.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQButtonListCell.h"

@implementation CQButtonListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickOnlineRegistrationBtn:(id)sender {
    [_delegate clickOnlineRegistrationBtn:sender];
}
- (IBAction)clickSSFJSBtn:(id)sender {
    [_delegate clickSSFJSBtn:sender];
}

- (IBAction)clickDZSDBtn:(id)sender {
    [_delegate clickDZSDBtn:sender];

}
- (IBAction)clickAJCXBtn:(id)sender {
    [_delegate clickAJCXBtn:sender];

}
- (IBAction)clickZJJHBtn:(id)sender {
    [_delegate clickZJJHBtn:sender];

}

@end
