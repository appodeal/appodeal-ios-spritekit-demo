//
//  MainScene.m
//  SpriteKitDemoApp
//
//  Created by Lozhkin Ilya on 6/3/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "MainScene.h"
#import <Appodeal/Appodeal.h>

@interface MainScene ()<AppodealInterstitialDelegate, AppodealVideoDelegate, AppodealBannerViewDelegate, AppodealRewardedVideoDelegate>

@property (nonatomic, strong) SKLabelNode * interstitialLabel;
@property (nonatomic, strong) SKLabelNode * videoLabel;
@property (nonatomic, strong) SKLabelNode * videoOrInterstitialLabel;
@property (nonatomic, strong) SKLabelNode * rewardedVideoLabel;
@property (nonatomic, strong) SKLabelNode * bannerLabel;
@property (nonatomic, strong) SKLabelNode * nativeLabel;
@property (nonatomic, strong) UIViewController * controller;

@end

@implementation MainScene

- (instancetype) initWithSize:(CGSize)size onController:(UIViewController *)controller{
    self = [super initWithSize:size];
    if (self) {
        self.controller = controller;
    }
    return self;
}

- (void) didMoveToView:(SKView *)view{
    [super didMoveToView:view];
    
    {
        [Appodeal setInterstitialDelegate:self];
        [Appodeal setVideoDelegate:self];
        [Appodeal setRewardedVideoDelegate:self];
    }
    
    [self setup];
}

- (void)setup{
    [self createBackground];
    [self createInterstitialButton];
    [self createVideoButton];
    [self createBannerButton];
    [self createVideoOrInterstitialLabel];
    [self createRewardedVideoButton];
    [self createNativeButton];
}


#pragma mark --- CREATE_METHODS

- (void)createBackground{
    SKTexture * texture = [SKTexture textureWithImageNamed:@"Background"];
    SKSpriteNode * backgroundNode = [SKSpriteNode spriteNodeWithTexture:texture];
    backgroundNode.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
    
    [self  addChild:backgroundNode];
    self.scaleMode = SKSceneScaleModeAspectFill;
}

- (void) createInterstitialButton{
    self.interstitialLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Thin"];
    self.interstitialLabel.text = @"interstitial";
    self.interstitialLabel.fontSize = 30.0f;
    
    SKSpriteNode * background = [SKSpriteNode spriteNodeWithColor:UIColor.clearColor size:(CGSize){CGRectGetWidth(self.interstitialLabel.frame) + 60, CGRectGetHeight(self.interstitialLabel.frame) + 10}];
    background.name = @"int";
    [background addChild:self.interstitialLabel];
    
    self.interstitialLabel.position = (CGPoint){0, -CGRectGetHeight(self.interstitialLabel.frame)/2};
    background.position = (CGPoint){CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) + 120};
    
    [self addChild:background];
}

- (void) createVideoButton{
    self.videoLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Thin"];
    self.videoLabel.text = @"video";
    self.videoLabel.fontSize = 30.0f;
    
    SKSpriteNode * background = [SKSpriteNode spriteNodeWithColor:UIColor.clearColor size:(CGSize){CGRectGetWidth(self.videoLabel.frame) + 60, CGRectGetHeight(self.videoLabel.frame) + 10}];
    background.name = @"vid";
    [background addChild:self.videoLabel];
    
    self.videoLabel.position = (CGPoint){0, -CGRectGetHeight(self.videoLabel.frame)/2};
    background.position = (CGPoint){CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) + 80};
    
    [self addChild:background];
}

- (void) createVideoOrInterstitialLabel{
    self.videoOrInterstitialLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Thin"];
    self.videoOrInterstitialLabel.text = @"video or interstitial";
    self.videoOrInterstitialLabel.fontSize = 30.0f;
    
    SKSpriteNode * background = [SKSpriteNode spriteNodeWithColor:UIColor.clearColor size:(CGSize){CGRectGetWidth(self.videoOrInterstitialLabel.frame) + 60, CGRectGetHeight(self.videoOrInterstitialLabel.frame) + 10}];
    background.name = @"voi";
    [background addChild:self.videoOrInterstitialLabel];
    
    self.videoOrInterstitialLabel.position = (CGPoint){0, -CGRectGetHeight(self.videoOrInterstitialLabel.frame)/2};
    background.position = (CGPoint){CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) + 40};
    
    [self addChild:background];
}

- (void) createRewardedVideoButton{
    self.rewardedVideoLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Thin"];
    self.rewardedVideoLabel.text = @"rewarded video";
    self.rewardedVideoLabel.fontSize = 30.0f;
    
    SKSpriteNode * background = [SKSpriteNode spriteNodeWithColor:UIColor.clearColor size:(CGSize){CGRectGetWidth(self.rewardedVideoLabel.frame) + 60, CGRectGetHeight(self.rewardedVideoLabel.frame) + 10}];
    background.name = @"rvid";
    [background addChild:self.rewardedVideoLabel];
    
    self.rewardedVideoLabel.position = (CGPoint){0, -CGRectGetHeight(self.rewardedVideoLabel.frame)/2};
    background.position = (CGPoint){CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) + 0};
    
    [self addChild:background];
}

- (void) createBannerButton{
    self.bannerLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Thin"];
    self.bannerLabel.text = @"banner";
    self.bannerLabel.fontSize = 30.0f;
    
    SKSpriteNode * background = [SKSpriteNode spriteNodeWithColor:UIColor.clearColor size:(CGSize){CGRectGetWidth(self.bannerLabel.frame) + 60, CGRectGetHeight(self.bannerLabel.frame) + 10}];
    background.name = @"ban";
    [background addChild:self.bannerLabel];
    
    self.bannerLabel.position = (CGPoint){0, -CGRectGetHeight(self.bannerLabel.frame)/2};
    background.position = (CGPoint){CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) - 40};
    
    [self addChild:background];
}

- (void) createNativeButton{
    self.nativeLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Thin"];
    self.nativeLabel.text = @"native ads";
    self.nativeLabel.fontSize = 30.0f;
    
    SKSpriteNode * background = [SKSpriteNode spriteNodeWithColor:UIColor.clearColor size:(CGSize){CGRectGetWidth(self.nativeLabel.frame) + 60, CGRectGetHeight(self.nativeLabel.frame) + 10}];
    background.name = @"nat";
    [background addChild:self.nativeLabel];
    
    self.nativeLabel.position = (CGPoint){0, -CGRectGetHeight(self.nativeLabel.frame)/2};
    background.position = (CGPoint){CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) - 120};
    
    [self addChild:background];
}

#pragma mark --- EVENT

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint positionInScene = [touch locationInNode:[self childNodeWithName:@"int"]];
    CGPoint positionVidScene = [touch locationInNode:[self childNodeWithName:@"vid"]];
    CGPoint positionBanScene = [touch locationInNode:[self childNodeWithName:@"ban"]];
    CGPoint positionVoIScene = [touch locationInNode:[self childNodeWithName:@"voi"]];
    CGPoint positionRvidScene = [touch locationInNode:[self childNodeWithName:@"rvid"]];
    CGPoint positionNatScene = [touch locationInNode:[self childNodeWithName:@"nat"]];
    
    if(CGRectContainsPoint(self.interstitialLabel.frame, positionInScene))
    {
        NSLog(@"interstitial click");
        [Appodeal showAd:AppodealShowStyleInterstitial rootViewController:self.controller];
    }
    
    if(CGRectContainsPoint(self.videoLabel.frame, positionVidScene))
    {
        NSLog(@"video click");
        [Appodeal showAd:AppodealShowStyleSkippableVideo rootViewController:self.controller];
    }
    
    if(CGRectContainsPoint(self.videoOrInterstitialLabel.frame, positionVoIScene))
    {
        NSLog(@"video or interstitial click");
        [Appodeal showAd:AppodealShowStyleVideoOrInterstitial rootViewController:self.controller];
    }
    
    if(CGRectContainsPoint(self.rewardedVideoLabel.frame, positionRvidScene))
    {
        NSLog(@"rewarded video click");
        [Appodeal showAd:AppodealShowStyleRewardedVideo rootViewController:self.controller];
    }
    
    if(CGRectContainsPoint(self.bannerLabel.frame, positionBanScene))
    {
        NSLog(@"banner click");
        AppodealBannerView * bannerView = [[AppodealBannerView alloc] initWithSize:kAppodealUnitSize_320x50 rootViewController:self.controller];
        
        bannerView.layer.position = (CGPoint){CGRectGetMidX(self.view.frame), CGRectGetHeight(self.view.frame) - 25};
        if (![self.view viewWithTag:1]) {
            [self.view addSubview:bannerView];
            bannerView.tag = 1;
            bannerView.delegate = self;
            [bannerView loadAd];
        }
    }
    
    if(CGRectContainsPoint(self.nativeLabel.frame, positionNatScene))
    {
        NSLog(@"native ads click");
    }
}

#pragma mark --- INTERSTITIAL_DELEGATE

- (void)interstitialDidLoadAd{
    NSLog(@"interstitialDidLoadAd");
}
- (void)interstitialDidFailToLoadAd{
    NSLog(@"interstitialDidFailToLoadAd");
}
- (void)interstitialWillPresent{
    NSLog(@"interstitialWillPresent");
}
- (void)interstitialDidDismiss{
    NSLog(@"interstitialDidDismiss");
}
- (void)interstitialDidClick{
    NSLog(@"interstitialDidClick");
}

#pragma mark --- VIDEO_DELEGATE

- (void)videoDidLoadAd{
    NSLog(@"videoDidLoadAd");
}

- (void)videoDidFailToLoadAd{
    NSLog(@"videoDidFailToLoadAd");
}

- (void)videoDidPresent{
    NSLog(@"videoDidPresent");
}

- (void)videoWillDismiss{
    NSLog(@"videoWillDismiss");
}

- (void)videoDidFinish{
     NSLog(@"videoDidFinish");
}

- (void)videoDidClick{
    NSLog(@"videoDidClick");
}

#pragma mark --- REWARDED_VIDEO_DELEGATE

- (void)rewardedVideoDidLoadAd{
    NSLog(@"rewardedVideoDidLoadAd");
}

- (void)rewardedVideoDidFailToLoadAd{
    NSLog(@"rewardedVideoDidFailToLoadAd");
}

- (void)rewardedVideoDidPresent{
    NSLog(@"rewardedVideoDidPresent");
}

- (void)rewardedVideoWillDismiss{
    NSLog(@"rewardedVideoWillDismiss");
}

- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName{
    NSLog(@"rewardedVideoDidFinish");
}

- (void) rewardedVideoDidClick{
    NSLog(@"rewardedVideoDidClick");
}

#pragma mark --- BANNER_VIEW

- (void)bannerViewDidLoadAd:(AppodealBannerView *)bannerView{
    NSLog(@"bannerViewDidLoadAd");
}

- (void)bannerView:(AppodealBannerView *)bannerView didFailToLoadAdWithError:(NSError *)error{
    NSLog(@"bannerView didFailToLoadAdWithError");
}

- (void)bannerViewDidInteract:(AppodealBannerView *)bannerView{
    NSLog(@"bannerViewDidInteract");
}

@end
