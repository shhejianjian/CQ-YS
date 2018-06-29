//
//  CQAJCXCell.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/13.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQAJCXModel.h"

@interface CQAJCXCell : UITableViewCell

@property(nonatomic,strong)CQAJCXModel *ajcxModel;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;

@property (strong, nonatomic) IBOutlet UILabel *yuangaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *beigaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;
@property (strong, nonatomic) IBOutlet UILabel *ajlxLabel;
@property (strong, nonatomic) IBOutlet UILabel *sqsjLabel;

@end
