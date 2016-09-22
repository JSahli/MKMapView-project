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
    
    //Trying to make a clean looking button to dismiss view controller without navigation controller
    
//    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//   [self.view addSubview:navBar];

//    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];;
//    [self.view addSubview:toolBar];
//    [toolBar addSubview:button];
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
