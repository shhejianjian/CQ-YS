//
//  CQUploadImageCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/14.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQUploadImageCell.h"

@implementation CQUploadImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.myImageView.layer.cornerRadius = 5;
    self.myImageView.layer.masksToBounds = YES;

    // Initialization code
}

@end
