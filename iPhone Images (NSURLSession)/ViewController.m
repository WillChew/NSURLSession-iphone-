//
//  ViewController.m
//  iPhone Images (NSURLSession)
//
//  Created by Will Chew on 2018-06-21.
//  Copyright © 2018 Will Chew. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"https://imgur.com/bktnImE.png"]; //1
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; //2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; //3
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { //1
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; //2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //this runs on main queue
            self.iPhoneImageView.image = image; //4
        }];
    }]; //4
    [downloadTask resume];//5
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
