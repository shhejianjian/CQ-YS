//
//  CQOnlineRegistrationCell.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/5.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQOnlineRegistrationModel.h"

@protocol CQOnlineRegistrationCellDelegate <NSObject>


- (void)clickDeleteBtn:(NSInteger )index;

@end

@interface CQOnlineRegistrationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;


@property(nonatomic,strong)CQOnlineRegistrationModel *wslaModel;
@property (nonatomic, weak) id <CQOnlineRegistrationCellDelegate> delegate;


@end





