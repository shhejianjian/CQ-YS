//
//  CQZJJHWclCell.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/19.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQZJJHModel.h"
#import "CQZJJHListVC.h"

@interface CQZJJHWclCell : UITableViewCell

@property(nonatomic,strong)CQZJJHModel *zjjhModel;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *fssjLabel;
@property (strong, nonatomic) IBOutlet UILabel *sxrqLabel;
@property (strong, nonatomic) IBOutlet UIButton *tjBtn;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *yclSxrqLabel;
@property (strong, nonatomic) IBOutlet UILabel *dsrLabel;
@property (copy, nonatomic) NSString *status;





@end
