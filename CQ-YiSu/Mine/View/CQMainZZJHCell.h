//
//  CQMainZZJHCell.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/7.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQPageStatisticsModel.h"

@protocol CQMainZZJHCellDelegate <NSObject>


- (void)clickZZJHBtn:(UIButton *)button;


@end

@interface CQMainZZJHCell : UITableViewCell
@property (nonatomic, weak) id <CQMainZZJHCellDelegate> delegate;
@property(nonatomic,strong)CQPageStatisticsModel *pageModel;
@property (strong, nonatomic) IBOutlet UILabel *zjLabel;
@property (strong, nonatomic) IBOutlet UILabel *wclLabel;
@property (strong, nonatomic) IBOutlet UILabel *yclLabel;


@end
