//
//  WebViewController.m
//  JesseMapView
//
//  Created by Jesse Sahli on 7/19/16.
//  Copyright © 2016 sahlitude. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
 
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:[[UIScreen mainScreen]bounds] configuration:theConfiguration];
    NSURL *url = [NSURL URLWithString:self.annUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    [self.view addSubview:webView];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(goBack)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"< Back" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 80.0, 40.0);
    [self.view addSubview:button];
    [self.navigationController.navigationBar setHidden:NO];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}



-(BOOL)prefersStatusBarHidden{
    return YES;
}



-(void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
