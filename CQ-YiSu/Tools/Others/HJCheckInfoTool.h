//
//  HJCheckInfoTool.h
//  SxLsPtProhect
//
//  Created by 何键键 on 17/10/12.
//  Copyright © 2017年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCheckInfoTool : NSObject
+ (BOOL)checkTelephone:(NSString *)telStr;
+ (BOOL)cardIDIsCorrect:(NSString *)IDNumber;
@end
