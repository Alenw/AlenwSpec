//
//  AwWebViewController.m
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import "AwWebViewController.h"
#import <AwAlertViewlib/AwAlertViewlib.h>
#import <SKYCategory/SKYCategory.h>
#import <WebKit/WebKit.h>

@interface AwWebViewController ()<UIWebViewDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIBarButtonItem *item1;
@property (nonatomic, strong) UIBarButtonItem *item2;
@property (nonatomic, weak) UIButton *closeBtn;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
@property (nonatomic, weak) WKWebView *webView;
#else
@property (nonatomic, weak) UIWebView *webView;
#endif
@end

@implementation AwWebViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.hasNav = YES;
        self.iOS7FullScreenLayout = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.titlestr) {
        self.title=self.titlestr;
    }
    if (self.navigationController.navigationBar.translucent) {
        self.edgesForExtendedLayout = UIRectEdgeTop;
    }
    self.view.backgroundColor=[UIColor whiteColor];
    
    if (!self.itemTinColor) {
        self.itemTinColor=[UIColor whiteColor];
    }

    if (self.navigationController && !self.notNeedBackItem) {
        UIView *itemView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 84, 44)];
        
        UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 48, 44)];
        [backBtn setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateNormal];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:self.itemTinColor forState:UIControlStateNormal];
        backBtn.imageEdgeInsets=UIEdgeInsetsMake(0, -15, 0, 0);
        backBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -15, 0, 0);
        backBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [itemView addSubview:backBtn];
        
        UIButton *closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(48, 0, 36, 44)];
        closeBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [closeBtn addTarget:self action:@selector(cleanAll) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setTitleColor:self.itemTinColor forState:UIControlStateNormal];
        [itemView addSubview:closeBtn];
        
        UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:itemView];
        self.navigationItem.leftBarButtonItem=item;
        self.closeBtn=closeBtn;
        
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    WKWebView *webView=[[WKWebView alloc]init];
    webView.navigationDelegate=self;
    [self.view addSubview:webView];
    self.webView=webView;
#else
    UIWebView *sywebview=[[UIWebView alloc]init];
    sywebview.delegate=self;
    sywebview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:sywebview];
    self.webView=sywebview;
    sywebview.scalesPageToFit=YES;
#endif
    
    NSString *HL=@"|-0-[sywebview]-0-|";
    NSString *VL=@"V:|-0-[sywebview]-0-|";
    self.webView.translatesAutoresizingMaskIntoConstraints=NO;
    NSArray *vhl=[NSLayoutConstraint constraintsWithVisualFormat:HL options:NSLayoutFormatAlignAllLeft metrics:nil views:@{@"sywebview":self.webView}];
    NSArray *vvl=[NSLayoutConstraint constraintsWithVisualFormat:VL options:NSLayoutFormatAlignAllLeft metrics:nil views:@{@"sywebview":self.webView}];
    [self.view addConstraints:vhl];
    [self.view addConstraints:vvl];

    NSURL *url=nil;
    if (isNetworkPath(self.urlstr)) {
        url=[NSURL URLWithString:self.urlstr];
    }else{
        url=[NSURL fileURLWithPath:self.urlstr];
        if ([url.pathExtension isEqualToString:@"txt"]) {
            NSData *txtData = [NSData dataWithContentsOfFile:self.urlstr];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
            [self.webView loadData:txtData MIMEType:@"text/txt" characterEncodingName:@"utf-8" baseURL:url];
#else
            [self.webView loadHTMLString:[NSString stringWithContentsOfFile:self.urlstr encoding:NSUTF8StringEncoding error:nil] baseURL:url];
#endif
#else
            [self.webView loadData:txtData MIMEType:@"text/txt" textEncodingName:@"utf-8" baseURL:url];
#endif
            return;
        }
    }
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
}
static BOOL isNetworkPath (NSString *path){
    if ([path containsString:@"http"]) {
        return YES;
    }else{
        return NO;
    }
}
-(void)back{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cleanAll{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [AwTipView showMessage:@"正在加载..." toView:self.webView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [AwTipView hideForView:self.webView Animated:YES];
    if (self.webView.canGoBack) {
        [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        self.closeBtn.enabled=YES;
    }else{
        [self.closeBtn setTitle:@"" forState:UIControlStateNormal];
        self.closeBtn.enabled=NO;
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [AwTipView hideForView:self.webView Animated:YES];
}

#pragma mark - WKWebView Action

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [AwTipView showMessage:@"正在加载..." toView:self.webView];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [AwTipView hideForView:self.webView Animated:YES];
    if (self.webView.canGoBack) {
        [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        self.closeBtn.enabled=YES;
    }else{
        [self.closeBtn setTitle:@"" forState:UIControlStateNormal];
        self.closeBtn.enabled=NO;
    }
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [AwTipView hideForView:self.webView Animated:YES];
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
