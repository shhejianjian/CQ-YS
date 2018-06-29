//
//  CQUploadFileVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/14.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQUploadFileVC.h"
#import "MXConstant.h"
#import "CQUploadImageCell.h"
#import "LDActionSheet.h"
#import "LDImagePicker.h"
#import "ZoomImageView.h"
#import "CQLoginModel.h"


@interface CQUploadFileVC ()<UICollectionViewDelegate,UICollectionViewDataSource,LDActionSheetDelegate,LDImagePickerDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *imageDataArr;
@property (nonatomic, strong) NSMutableArray *clxxModelArr;



@end

@implementation CQUploadFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mxNavigationItem.title = @"上传诉讼材料";

    [self.myCollectionView registerNib:[UINib nibWithNibName:@"CQUploadImageCell"bundle:nil]forCellWithReuseIdentifier:@"collectionCellID"];
    
    [self uploadFileImageList];
    // Do any additional setup after loading the view from its nib.
}

//加载图片列表
-(void)uploadFileImageList{
    [self.imageDataArr removeAllObjects];
    [self.clxxModelArr removeAllObjects];
//    [MBProgressHUD showMessage:@"加载中..." toView:self.view];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"mlid"] = @"8";
    params[@"page"] = @"1";
    params[@"pagesize"] = @"10";
    params[@"orderType"] = @"2";
    NSLog(@"par::%@",params);
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_clsc_list ticket:ticket params:params success:^(id json) {
        NSLog(@"%@===+++===%@",json,params);
        CQLoginModel *loginModel = [CQLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.flag isEqualToString:@"true"]) {

            if ([loginModel.msg isEqualToString:@"当前没有信息"]) {
                [MBProgressHUD hideHUDForView:self.view];
                [self.myCollectionView reloadData];
            }
//            NSArray *arr = [GYClxxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
//
//            for (GYClxxModel *clxxModel in arr) {
//                [self.clxxModelArr addObject:clxxModel];
//                NSMutableDictionary *imageParams = [NSMutableDictionary dictionary];
//                imageParams[@"jlid"] = clxxModel.jlid;
//                [GYHttpTool postImage:wsla_ajxx_detailClxxImageInfoUrl ticket:ticket params:imageParams success:^(id json) {
//                    [self.imageDataArr addObject:json];
//                    [self.myCollectionView reloadData];
//                    [MBProgressHUD hideHUDForView:self.view];
//                } failure:^(NSError *error) {
//                    NSLog(@"%@",error);
//                }];
//            }
            
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
    imagePicker.delegate = self;
    [imagePicker showImagePickerWithType:buttonIndex InViewController:self Scale:0.75];
}

- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}

- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    NSData *imageData = UIImageJPEGRepresentation(editedImage, 0.5);
    
    if (imageData) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"ajbs"] = self.ajbsStr;
        params[@"mlid"] = @"3";
        params[@"page"] = @"1";
        params[@"pagesize"] = @"10";
        params[@"orderType"] = @"1";
        NSLog(@"par::%@",params);
        NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
        [GYHttpTool uploadImage:wsla_clsc_list andImageData:imageData ticket:ticket params:params success:^(id json) {
            NSLog(@"uploadSuccess:%@",json);
//            GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
//            if ([loginModel.success isEqualToString:@"true"]) {
//                NSLog(@"success");
//                [self loadWslaAjxxDetailInfoWithMlid];
//            } else {
//                [MBProgressHUD showError:loginModel.msg];
//            }
        } failure:^(NSError *error) {

        }];
    }
    
}



//有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageDataArr.count+1;
}


-(CQUploadImageCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CQUploadImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCellID" forIndexPath:indexPath];
    
    if (indexPath.row == self.imageDataArr.count) {
        cell.myImageView.image = [UIImage imageNamed:@"plus.png"];
    } else {
        UIImage *image = [UIImage imageWithData:self.imageDataArr[indexPath.row]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.myImageView.image = image;
        });
    }
    
    return cell;
    
}

//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(90, 116);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 20);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"+++%ld",(long)indexPath.row);
    CQUploadImageCell *cell = (CQUploadImageCell *)[self.myCollectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.row == self.imageDataArr.count) {
        NSLog(@"chooseImage");
        LDActionSheet *actionSheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从相册中选择", nil];
        [actionSheet showInView:self.view];
    } else {
        [[ZoomImageView getZoomImageView]showZoomImageView:cell.myImageView addGRType:0];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"长按小图可删除";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
}

- (NSMutableArray *)clxxModelArr {
    if(_clxxModelArr == nil) {
        _clxxModelArr = [[NSMutableArray alloc] init];
    }
    return _clxxModelArr;
}

- (NSMutableArray *)imageDataArr {
    if(_imageDataArr == nil) {
        _imageDataArr = [[NSMutableArray alloc] init];
    }
    return _imageDataArr;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
