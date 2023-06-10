//
//  ViewController.m
//  ImageInpainting
//
//  Created by guoliting on 23/06/09.
//  Copyright © 2016年 NingXia. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *imageInpaintingWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect frame = self.view.bounds;
    
    // 可以做一些初始化配置定制
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.selectionGranularity = WKSelectionGranularityDynamic;
    configuration.allowsInlineMediaPlayback = YES;

    WKPreferences *preferences = [WKPreferences new];
    //是否支持JavaScript
    preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;

    _imageInpaintingWebView = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
    [_imageInpaintingWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://4837538ea28105308f.gradio.live"]]];
    [self.view addSubview:_imageInpaintingWebView];

    // 有两种代理，UIDelegate负责界面弹窗，navigationDelegate负责加载、跳转等
    _imageInpaintingWebView.UIDelegate = self;
    _imageInpaintingWebView.navigationDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKNavigationDelegate
/* 页面开始加载 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didStartProvisionalNavigation");
}
/* 开始返回内容 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"didCommitNavigation");
}
/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"didFinishNavigation");
}
/* 页面加载失败 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation:%@", error.localizedDescription);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailNavigation:%@", error.localizedDescription);
}

/* 在发送请求之前，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

/* 在收到响应后，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
     
    NSLog(@"decidePolicyForNavigationResponse:%@", navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

@end
