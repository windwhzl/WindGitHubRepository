//
//  banshizhuanquViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-29.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "banshizhuanquViewController.h"
#import "WuxianfuwuViewController.h"
#import "laodongweiquanViewController.h"
#import "woyaoqiuzhiViewController.h"
#import "woyaochuangyeViewController.h"
#import "woyaopeixunViewController.h"
#import "niwenwodaViewController.h"
#import "fuwujigouViewController.h"
#import "renshikaoshiViewController.h"
#import "danganchaxunViewController.h"
#import "rensheyunViewController.h"
#import "ShouyeViewController.h"
#import "rensheLoginViewController.h"
#import "AlertDialogWhenFunctionNotComplete.h"
#import "SystemSetViewController.h"
@interface banshizhuanquViewController ()

@end

@implementation banshizhuanquViewController

@synthesize scrollView;
@synthesize slideImages,pageControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setQianjinFlag:0];
    [self doScrollImg];
}
-(void) viewDidAppear:(BOOL)animated
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dismissSelf:(id)sender {
    UIAlertController *alert;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)qianjinClick:(id)sender
{
    switch ([self getQianjinFlag]) {
        case 0:
            break;
        case 1:
            [self wuxianClick:sender];
            break;
        case 2:
            [self laodongClick:sender];
            break;
        case 3:
            [self qiuzhiClick:sender];
            break;
        case 4:
            [self chuangyeClick:sender];
            break;
        case 5:
            [self peixunClick:sender];
            break;
        case 6:
            [self wendaClick:sender];
            break;
        case 7:
            [self jigouClick:sender];
            break;
        case 8:
            [self kaoshiClick:sender];
            break;
        case 9:
            [self danganClick:sender];
            break;
        case 10:
            [self rensheyunClick:sender];
            break;
        default:
            break;
    }
    
}

- (IBAction)wuxianClick:(id)sender {
    [self setQianjinFlag:1];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    WuxianfuwuViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"WuxianfuwuView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];

}

- (IBAction)laodongClick:(id)sender {
    [self setQianjinFlag:2];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    laodongweiquanViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"laodongweiquanView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)chuangyeClick:(id)sender {
    [self setQianjinFlag:3];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    woyaochuangyeViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"woyaochuangyeView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)zhuyeClick:(id)sender {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    ShouyeViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"ShouyeView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)qiuzhiClick:(id)sender {
    [self setQianjinFlag:4];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    woyaoqiuzhiViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"woyaoqiuzhiView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)peixunClick:(id)sender {
    [self setQianjinFlag:5];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    woyaopeixunViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"woyaopeixunView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)wendaClick:(id)sender {
    [self setQianjinFlag:6];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    niwenwodaViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"niwenwodaView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)jigouClick:(id)sender {
    [self setQianjinFlag:7];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    fuwujigouViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"fuwujigouView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)kaoshiClick:(id)sender {
    [self setQianjinFlag:8];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    renshikaoshiViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"renshikaoshiView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)danganClick:(id)sender {
    [self setQianjinFlag:9];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    danganchaxunViewController  *listView = [mainStory instantiateViewControllerWithIdentifier:@"danganchaxunView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)rensheyunClick:(id)sender {
    [self setQianjinFlag:10];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    rensheyunViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"rensheyunView"];
    [listView setDepcode:@""];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)moreFunction:(id)sender {
    SystemSetViewController *systemSet = [[SystemSetViewController alloc] initWithNibName:nil bundle:nil];
    systemSet.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:systemSet animated:YES completion:nil];

}
-(void) setQianjinFlag:(int)qianjinFlag
{
    _qianjinFlag = qianjinFlag;
}
-(int) getQianjinFlag
{
    return  _qianjinFlag;
}
#pragma mark- 图片滚动处理
-(void) doScrollImg{
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:@"scrollImg01.jpg"];
    [slideImages addObject:@"scrollImg02.png"];
    [slideImages addObject:@"scrollImg03.jpg"];
//    [slideImages addObject:@"scrollImg04.jpg"];
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    for (int i = 0;i<[slideImages count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((scrollView.frame.size.width * i) + scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
    }
    // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:([slideImages count]-1)]]];
    imageView.frame = CGRectMake(0,0, scrollView.frame.size.width, scrollView.frame.size.height); // 添加最后1页在首页 循环
    [scrollView addSubview:imageView];
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
    imageView.frame = CGRectMake((scrollView.frame.size.width * ([slideImages count] + 1)) , 0, scrollView.frame.size.width, scrollView.frame.size.height); // 添加第1页在最后 循环
    [scrollView addSubview:imageView];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * ([slideImages count] + 2), scrollView.frame.origin.y)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width,0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/([slideImages count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ ([slideImages count]+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * [slideImages count],0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([slideImages count]+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO]; // 最后+1,循环第1页
    }
}
- (void)runTimePage
{
    int page = pageControl.currentPage; // 获取当前的page
    page++;
    page = page > 2 ? 0 : page ;
    pageControl.currentPage = page;
    [self turnPage];
}
- (void)turnPage
{
    int page = pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width*(page+1),0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
@end
