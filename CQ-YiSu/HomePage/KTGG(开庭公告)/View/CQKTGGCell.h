//
//  CQKTGGCell.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/28.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQKTGGModel.h"

@interface CQKTGGCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property(nonatomic,strong)CQKTGGModel *ktggModel;
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *xsksrqLabel;


@end
