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
@property (nonatomic, assign) BOOL authenticated;
@property (nonatomic, strong) NSURLConnection *urlConnection;

@property (nonatomic, weak) UIView *webView;
@end

@implementation AwWebViewController
- (id)init{
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

    NSURL *url=nil;
    if (![self.urlstr hasPrefix:@"https:"]) {
        _authenticated=YES;
    }
    
    if (isNetworkPath(self.urlstr)) {
        self.urlstr = [self.urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        url=[NSURL URLWithString:self.urlstr];
        if (IOS8_OR_LATER && !self.forceFit) {
            WKWebView *webView=[[WKWebView alloc]init];
            webView.navigationDelegate=self;
            [self.view addSubview:webView];
            self.webView=webView;
        }else{
            goto webViewAction;
            
        }
    }else{
        
        if (IOS8_OR_LATER && !self.forceFit) {
            WKWebView *webView=[[WKWebView alloc]init];
            webView.navigationDelegate=self;
            [self.view addSubview:webView];
            self.webView=webView;
        }else{
        webViewAction:{}
            UIWebView *sywebview=[[UIWebView alloc]init];
            sywebview.delegate=self;
            sywebview.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:sywebview];
            self.webView=sywebview;
            sywebview.scalesPageToFit=YES;
            if (isNetworkPath(self.urlstr)) {
                goto outofMethod;
            }
        }
        
        url=[NSURL fileURLWithPath:self.urlstr];
        if ([url.pathExtension isEqualToString:@"txt"]) {
            NSData *txtData = [NSData dataWithContentsOfFile:self.urlstr];
            
            if (IOS8_OR_LATER && !self.forceFit) {
                if (IOS9_OR_LATER) {
                    [(WKWebView *)self.webView loadData:txtData MIMEType:@"text/txt" characterEncodingName:@"utf-8" baseURL:url];
                }else{
                    [(WKWebView *)self.webView loadHTMLString:[NSString stringWithContentsOfFile:self.urlstr encoding:NSUTF8StringEncoding error:nil] baseURL:url];
                }
            }else{
                [(UIWebView *)self.webView loadData:txtData MIMEType:@"text/txt" textEncodingName:@"utf-8" baseURL:url];
            }
            return;
        }
    }
outofMethod:{}
    NSString *HL=@"|-0-[sywebview]-0-|";
    NSString *VL=@"V:|-0-[sywebview]-0-|";
    self.webView.translatesAutoresizingMaskIntoConstraints=NO;
    NSArray *vhl=[NSLayoutConstraint constraintsWithVisualFormat:HL options:NSLayoutFormatAlignAllLeft metrics:nil views:@{@"sywebview":self.webView}];
    NSArray *vvl=[NSLayoutConstraint constraintsWithVisualFormat:VL options:NSLayoutFormatAlignAllLeft metrics:nil views:@{@"sywebview":self.webView}];
    [self.view addConstraints:vhl];
    [self.view addConstraints:vvl];
    
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
//    NSDictionary *headers = @{
//                              @"Cookie":@"JSESSIONID=00F0BC8B896EB1129EE7E18FFA3469A2"
//                              };
//    [request setHTTPShouldHandleCookies:YES];
//    [request setAllHTTPHeaderFields:headers];
    
    if (IOS8_OR_LATER && !self.forceFit) {
        [(WKWebView *)self.webView loadRequest:request];
    }else {
        [(UIWebView *)self.webView loadRequest:request];
    }
    
}
static BOOL isNetworkPath (NSString *path){
    if ([path containsString:@"http"]) {
        return YES;
    }else{
        return NO;
    }
}
-(void)back{
    if ([self.webView isKindOfClass:[WKWebView class]]) {
        WKWebView *view=(WKWebView *)self.webView;
        if (view.canGoBack) {
            [view goBack];
            return;
        }
    }else{
        UIWebView *view=(UIWebView *)self.webView;
        if (view.canGoBack) {
            [view goBack];
            return;
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cleanAll{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [AwTipView showMessage:@"正在加载..." toView:webView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [AwTipView hideForView:webView Animated:YES];
    if (webView.canGoBack) {
        [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        self.closeBtn.enabled=YES;
    }else{
        [self.closeBtn setTitle:@"" forState:UIControlStateNormal];
        self.closeBtn.enabled=NO;
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [AwTipView hideForView:webView Animated:YES];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"Did start loading: %@ auth:%d", [[request URL] absoluteString], _authenticated);
    //    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //    　　NSArray *cookies = [sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:self.urlstr]];
    //    　　NSEnumerator *enumerator = [cookies objectEnumerator];
    //    　　NSHTTPCookie *cookie;
    //    　　while (cookie = [enumerator nextObject]) {
    //        　　NSLog(@"COOKIE{name: %@, value: %@}", [cookie name], [cookie value]);
    //        　　}
    /*
     {
     Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8";
     "User-Agent" = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_3_5 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Mobile/13G36";
     }
     {
     Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8";
     Referer = "http://gz.gdltax.gov.cn/";
     "User-Agent" = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_3_5 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Mobile/13G36";
     }
     
     {
     Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8";
     Referer = "http://gz.gdltax.gov.cn/ekp/new/admin/document/document_list_of_channel_ds_search.jsp?SiteId=8&OrderField=crtime&OrderType=desc&trandom=0.28936713584698737";
     "User-Agent" = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_3_5 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Mobile/13G36";
     }
     */
    if (!_authenticated) {
        
        _authenticated = NO;
        
        _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [_urlConnection start];
        
        return NO;
    }
    return YES;
}
#pragma mark === connectDelegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    NSLog(@"验证签名证书");
    
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"WebController received response via NSURLConnection");
    
    // remake a webview call now that authentication has passed ok.
    
    _authenticated = YES;
    [(UIWebView *)self.webView loadRequest:connection.currentRequest];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

#pragma mark - WKWebView Action

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    [AwTipView showMessage:@"正在加载..." toView:webView];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    [AwTipView hideForView:webView Animated:YES];
    if (webView.canGoBack) {
        [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        self.closeBtn.enabled=YES;
    }else{
        [self.closeBtn setTitle:@"" forState:UIControlStateNormal];
        self.closeBtn.enabled=NO;
    }
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
//    [AwTipView hideForView:webView Animated:YES];
}
// 取消https 验证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
    NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:@"bob"
                                                               password:@"pass"
                                                            persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
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
