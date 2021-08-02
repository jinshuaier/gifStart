//
//  WSMovieController.m
//  StartMovie
//
//  Created by iMac on 16/8/29.
//  Copyright © 2016年 sinfotek. All rights reserved.
//

#import "WSMovieController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "RootTabBarController.h"
@interface WSMovieController ()
@property (strong, nonatomic) MPMoviePlayerController *player;
@property (strong, nonatomic) FLAnimatedImageView *imageView1;
@property (nonatomic,strong)FLAnimatedImageView *imgView2;

@end

@implementation WSMovieController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self SetupVideoPlayer];
}


- (void)SetupVideoPlayer
{
    if (!self.imageView1) {
          self.imageView1 = [[FLAnimatedImageView alloc] init];
          self.imageView1.contentMode = UIViewContentModeScaleAspectFit;
          self.imageView1.clipsToBounds = YES;
      }
      [self.view addSubview:self.imageView1];
      self.imageView1.frame = CGRectMake(0.0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
      NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"001" withExtension:@"gif"];
      NSData *data1 = [NSData dataWithContentsOfURL:url1];
      FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
      animatedImage1.loopCount = 0;
      self.imageView1.animatedImage = animatedImage1;

    
//    if (!self.imgView2) {
//        self.imgView2 = [[FLAnimatedImageView alloc] init];
//        self.imgView2.contentMode = UIViewContentModeScaleAspectFill;
//        self.imgView2.clipsToBounds = YES;
//    }
//
//    [self.view addSubview:self.imgView2];
//
//    self.imgView2.frame = CGRectMake(0, 240, self.view.frame.size.width, 400);
//
//    FLAnimatedImage *__block animatedImage2 = nil;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *url2 = [NSURL URLWithString:@"http://raphaelschaad.com/static/nyan.gif"];
//        NSData *data2 = [NSData dataWithContentsOfURL:url2];
//        animatedImage2 = [FLAnimatedImage animatedImageWithGIFData:data2];
//
//        self.imgView2.animatedImage = animatedImage2;
//
//    });
    
    [self performSelector:@selector(animationDidFinish) withObject:self afterDelay:200];

//
//    self.player = [[MPMoviePlayerController alloc] initWithContentURL:_movieURL];
//    [self.view addSubview:self.player.view];
//    self.player.shouldAutoplay = YES;
//    [self.player setControlStyle:MPMovieControlStyleNone];
//    self.player.repeatMode = MPMovieRepeatModeOne;
//    [self.player.view setFrame:[UIScreen mainScreen].bounds];
//    self.player.view.alpha = 0;
//    [UIView animateWithDuration:3 animations:^{
//        self.player.view.alpha = 1;
//        [self.player prepareToPlay];
//    }];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];

    [self setupLoginView];
}

- (void)animationDidFinish {
    NSLog(@"我在这里瑟瑟发抖");
    RootTabBarController *rootTabCtrl = [[RootTabBarController alloc]init];
    self.view.window.rootViewController = rootTabCtrl;
}


- (void)setupLoginView
{
    //进入按钮
    UIButton *enterMainButton = [[UIButton alloc] init];
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"进入应用" forState:UIControlStateNormal];
    enterMainButton.alpha = 0;
    [self.player.view addSubview:enterMainButton];
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [UIView animateWithDuration:3.0 animations:^{
        enterMainButton.alpha = 1.0;
    }];
}

#pragma mark - NSNotificationCenter
- (void)playbackStateChanged
{
    MPMoviePlaybackState playbackState = [self.player playbackState];
    if (playbackState == MPMoviePlaybackStateStopped || playbackState == MPMoviePlaybackStatePaused) {
        [self.player play];
    }
}


- (void)enterMainAction:(UIButton *)btn {
    NSLog(@"进入应用");
    RootTabBarController *rootTabCtrl = [[RootTabBarController alloc]init];
    self.view.window.rootViewController = rootTabCtrl;
}


@end
