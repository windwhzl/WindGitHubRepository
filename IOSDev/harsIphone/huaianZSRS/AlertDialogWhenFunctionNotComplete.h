//
//  AlertDialogWhenFunctionNotComplete.h
//  huaianZSRS
//
//  Created by xiaomage on 14/12/6.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertDialogWhenFunctionNotComplete : UIView{
    UIImageView *image;
    UIButton *button;
}


/**设置代理，用于处理button的点击事件*/
-(void) show;

@end//通用“建设中”提示框，两秒后或者点击后，自动消失！
