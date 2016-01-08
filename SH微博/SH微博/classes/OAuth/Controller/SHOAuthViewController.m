//
//  SHOAuthViewController.m
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//


// URL:https://api.weibo.com/oauth2/authorize?client_id=300712997&redirect_uri=http://www.baidu.com
#import "SHOAuthViewController.h"
#import "SHUserAccount.h"
#import "SHAccountTool.h"
#import "SHChoseRootTool.h"

#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"

#define CZAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define CZClient_id        @"300712997"
#define CZRedirect_uri     @"http://www.baidu.com"
#define CZClient_secret    @"bcc592393d4e334d2a8491c063adc322"


@interface SHOAuthViewController ()<UIWebViewDelegate>

@end

@implementation SHOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //展示登陆的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    //拼接url字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",CZAuthorizeBaseUrl,CZClient_id,CZRedirect_uri];
//    SHLog(@"%@",urlStr);
    
    //创建url
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //加载网页
    [webView loadRequest:request];
    
    //设置代理
    webView.delegate = self;
    
}

#pragma mark -UIWebView代理
// 提示用户正在加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载。。。"];
}

// webview加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

//  webview加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    NSLog(@"%@",error);
}

// 拦截webView请求
// 当Webview需要加载一个请求的时候，就会调用这个方法，询问下是否请求
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = request.URL.absoluteString;
//    SHLog(@"%@",urlString);
    
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.length) {
        NSString *code = [urlString substringFromIndex:range.location+range.length];
        // 换取accessToken
        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    return YES;
}

/**
 *
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 *
 */

#pragma mark - 根据code获取accessToken
- (void) accessTokenWithCode:(NSString *) code
{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = CZClient_id;
    params[@"client_secret"] = CZClient_secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = CZRedirect_uri;
    params[@"code"] = code;
    
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 字典转模型
        SHUserAccount *account = [SHUserAccount accountWithDict:responseObject];
        
        [SHAccountTool saveUserAccount:account];
        
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        
        [SHChoseRootTool chooseRootViewController:[UIApplication sharedApplication].keyWindow];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

@end
