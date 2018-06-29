//
//  CQGGSDCell.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/27.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQGGSDModel.h"
@interface CQGGSDCell : UITableViewCell

@property(nonatomic,strong)CQGGSDModel *ggsdModel;
@property (strong, nonatomic) IBOutlet UILabel *gglxmcLabel;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;
@property (strong, nonatomic) IBOutlet UILabel *ggrLabel;
@property (strong, nonatomic) IBOutlet UILabel *dsrmcLabel;
@property (strong, nonatomic) IBOutlet UILabel *ggrqLabel;


@end
