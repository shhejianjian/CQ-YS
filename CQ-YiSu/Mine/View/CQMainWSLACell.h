//
//  CQMainWSLACell.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/6.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQPageStatisticsModel.h"

@protocol CQMainWSLACellDelegate <NSObject>


- (void)clickWSLABtn:(UIButton *)button;


@end



@interface CQMainWSLACell : UITableViewCell

@property (nonatomic, weak) id <CQMainWSLACellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *zjLabel;
@property (strong, nonatomic) IBOutlet UILabel *dtjLabel;
@property (strong, nonatomic) IBOutlet UILabel *dsaLaebl;
@property (strong, nonatomic) IBOutlet UILabel *scbtgLaebl;
@property (strong, nonatomic) IBOutlet UILabel *sctgLabel;
@property (strong, nonatomic) IBOutlet UILabel *ysaLaebl;
@property (strong, nonatomic) IBOutlet UILabel *ylaLabel;

@property (strong, nonatomic) IBOutlet UILabel *yjaLabel;
@property(nonatomic,strong)CQPageStatisticsModel *pageModel;


@end
