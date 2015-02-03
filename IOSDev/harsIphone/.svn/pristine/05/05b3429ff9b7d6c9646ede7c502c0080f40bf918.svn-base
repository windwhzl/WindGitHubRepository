//
//  LaunchScreenViewController.m
//  huaianZSRS
//
//  Created by xiaomage on 14/12/10.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import "ShouyeViewController.h"
#import "AppDelegate.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
    self.scrollView.delegate=self;
    //设置scrolliew的可滚动区域
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width*3, self.scrollView.frame.size.height);
    self.scrollView.contentOffset=CGPointMake(0, 0);
    
    [self.pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//分页指示器上的点击事件
-(void)changePage{
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * self.pageControl.currentPage,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO]; // 序号0 最后1页
}

//当scrollView开始滚动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if((self.scrollView.contentOffset.x-self.scrollView.frame.size.width*2)>(self.scrollView.frame.size.width/4)){
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeRootViewController];
    }
}

//手指离开scrollview后，还要滚动一段距离，在减速阶段将会调用该方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int pageIndex=abs(self.scrollView.contentOffset.x)/self.scrollView.frame.size.width;
    self.pageControl.currentPage=pageIndex;
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * pageIndex,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO]; // 序号0 最后1页
}

- (IBAction)nextPageForButton1Click:(id)sender {
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width,
                                                    0,
                                                    self.scrollView.frame.size.width,
                                                    self.scrollView.frame.size.height) animated:YES];
    self.pageControl.currentPage=1;
}

- (IBAction)nextPageForButton2Click:(id)sender {
     [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width*2,
                                                     0,
                                                     self.scrollView.frame.size.width,
                                                     self.scrollView.frame.size.height) animated:YES];
    self.pageControl.currentPage=2;
}

- (IBAction)skipForButton1Click:(id)sender {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeRootViewController];
}

@end
