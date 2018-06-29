//
//  CQButtonListCell.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/5.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CQButtonListCellDelegate <NSObject>

- (void)clickOnlineRegistrationBtn:(UIButton *)button;
- (void)clickSSFJSBtn:(UIButton *)button;
- (void)clickDZSDBtn:(UIButton *)button;
- (void)clickAJCXBtn:(UIButton *)button;
- (void)clickZJJHBtn:(UIButton *)button;

@end

@interface CQButtonListCell : UITableViewCell

@property (nonatomic, weak) id <CQButtonListCellDelegate> delegate;

@end
