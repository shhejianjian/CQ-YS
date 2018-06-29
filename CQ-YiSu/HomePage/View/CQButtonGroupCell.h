//
//  CQButtonGroupCell.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/7.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CQButtonGroupCellDelegate <NSObject>

- (void)clickGGSDBtn:(UIButton *)button;
- (void)clickKTGGBtn:(UIButton *)button;

@end


@interface CQButtonGroupCell : UITableViewCell

@property (nonatomic, weak) id <CQButtonGroupCellDelegate> delegate;


@end
