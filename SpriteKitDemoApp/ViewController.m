//
//  ViewController.m
//  SpriteKitDemoApp
//
//  Created by Lozhkin Ilya on 6/3/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "ViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "MainScene.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
//    UIViewController * controller = [UIViewController new];
//    [self addChildViewController:controller];
//    [controller.view setFrame:CGRectMake(0, 0, 320, 50)];
//    [controller.view setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:controller.view];
    [super viewDidLoad];
   
    SKView * spriteKitView = [[SKView alloc] initWithFrame:self.view.frame];
    [spriteKitView showsFPS];
    [spriteKitView showsNodeCount];
    self.view = spriteKitView;
    
    SKScene * spriteKitScene = [[MainScene alloc] initWithSize:self.view.bounds.size onController:self];
    [spriteKitView presentScene:spriteKitScene];
    
}

@end
