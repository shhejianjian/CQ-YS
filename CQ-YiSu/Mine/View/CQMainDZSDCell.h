//
//  CQMainDZSDCell.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/7.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQPageStatisticsModel.h"

@protocol CQMainDZSDCellDelegate <NSObject>

- (void)clickDZSDBtn:(UIButton *)button;

@end

@interface CQMainDZSDCell : UITableViewCell
@property (nonatomic, weak) id <CQMainDZSDCellDelegate> delegate;
@property(nonatomic,strong)CQPageStatisticsModel *pageModel;
@property (strong, nonatomic) IBOutlet UILabel *dqsLabel;
@property (strong, nonatomic) IBOutlet UILabel *yqsLabel;
@property (strong, nonatomic) IBOutlet UILabel *adajLabel;
@property (strong, nonatomic) IBOutlet UILabel *dktLabel;


@end
