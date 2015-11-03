//
//  ViewController.m
//  qsa
//
//  Created by C. Brody on 11/2/15.
//  Copyright (c) 2015 C. Brody. All rights reserved.
//

#import "ViewController.h"

// thanks: http://hayageek.com/execute-javascript-in-ios/
#import <JavascriptCore/JSContext.h>

extern UIWebView *gWebView;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) JSContext * myContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"view did load ok");

    gWebView = self.myWebView;

    // THANKS: http://stackoverflow.com/a/20156311/1283667
    JSContext *c = [self.myWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.myContext = c;

    // THANKS: https://infinum.co/the-capsized-eight/articles/running-javascript-in-an-ios-application-with-javascriptcore
    //         http://nshipster.com/javascriptcore/
    c[@"$TestObject$query"] = ^(NSString * arg1, NSString * arg2) {
        NSString * s1 = [NSString stringWithFormat: @"received %@", arg2];
        NSString * e = [NSString stringWithFormat:@"%@('%@', '%@');", @"TestObjectCB", arg1, s1];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                // FUTURE TBD: [self.myContext evaluateScript: e];
                [self.myWebView stringByEvaluatingJavaScriptFromString: e];
            });
        });
        return @"OK";
    };
    [c evaluateScript: @"var TestObject = {query: $TestObject$query};"];

    NSString * up = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"];
    NSURLRequest * myreq = [NSURLRequest requestWithURL:[NSURL fileURLWithPath: up]];
    [self.myWebView loadRequest: myreq];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
