//
//  RootViewController.m
//  Demo_TextKitPaging
//
//  Created by SACRELEE on 15/5/30.
//  Copyright (c) 2015年 Sumtice. All rights reserved.
//

#import "RootViewController.h"

#define sHeight [UIScreen mainScreen].bounds.size.height
#define sWidth [UIScreen mainScreen].bounds.size.width

#define sSpacing 20.f
#define sTextViewHeight sHeight - sSpacing * 2
#define sTextViewWidth sWidth - sSpacing * 2


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self pagingWithTextKit];
}

-(void)pagingWithTextKit
{
    
    // 1.读取文件中的文本
    NSString *textString = [[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Text" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    // 2.将字符串封装到TextStorage中
    NSTextStorage *storage = [[NSTextStorage alloc]initWithString:textString];
    
    // 3.为TextStorag添加一个LayoutManager
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
    [storage addLayoutManager:layoutManager];
    
    // 初始化滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake( 10 * sWidth, sHeight);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    int i = 0;
    while ( YES )
    {
        // 4.将有准确矩形大小的TextContainer添加到LayoutManager上
       NSTextContainer *textContainer = [[NSTextContainer alloc]initWithSize:CGSizeMake(sTextViewWidth, sTextViewHeight)];
       [layoutManager addTextContainer:textContainer];
       
       // 5.绑定TextContainer到TextView上
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(i * sWidth + sSpacing, sSpacing, sTextViewWidth, sTextViewHeight) textContainer:textContainer];
        textView.editable = NO;
        [scrollView addSubview:textView];
        
        i ++;
        
        // 排版结束的判断
        NSRange range = [layoutManager glyphRangeForTextContainer:textContainer];  // 此方法用来获取当前TextContainer内的文本Range
       if ( range.length + range.location == textString.length )
            break;
    }
    
    // 规整下滚动视图的contentSize
    scrollView.contentSize = CGSizeMake( i * sWidth, sHeight);
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

@end
