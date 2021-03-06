//
//  CCViewController.m
//  CCViewController
//
//  Created by Jerrod Putman on 2/7/12.
//  Copyright (c) 2012 Tiny Tim Games. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CCViewController.h"


@interface CCViewController ()
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) CCScene *scene;
@property (strong, nonatomic) CCLayer *layer;
@end

@implementation CCViewController


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setUp];
    }
    
    return self;
}

-(void)setUp{
    
// self.scene = [CCScene node];
////    HelloWorldLayer *layer = [HelloWorldLayer node];
////    [scene addChild:layer];
//    
//    self.layer = [CCLayer node];
//    
//    [self.scene addChild:self.layer];
//    
//    // create and initialize a Label
//    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
//    
//    // ask director for the window size
//    
//	
//    // position the label on the center of the screen
//    label.position =  ccp( 20 /2 , 20/2 );
//    
//    // add the label as a child to this Layer
//    [self.layer addChild: label];
    
 
}

//+(id)scene{
//    CCScene *scene = [CCScene node];
//    HelloWorldLayer *layer = [HelloWorldLayer node];
//    [scene addChild:layer];
//    
//    return scene;
//}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    CCDirector *director = [CCDirector sharedDirector];

    // If the director's OpenGL view hasn't been set up yet, then we should create it now. If you would like to prevent this "lazy loading", you should initialize the director and set its view elsewhere in your code.
    if([director isViewLoaded] == NO)
    {
        director.view = [self createDirectorGLView];
        [self didInitializeDirector];
    }

    director.delegate = self;
    
    CCScene *tempScene = [HelloWorldLayer scene];
    [director runWithScene:tempScene];
    self.layer = [tempScene.children objectAtIndex:0];
    
    // Add the director as a child view controller.
    [self addChildViewController:director];
    
    // Add the director's OpenGL view, and send it to the back of the view hierarchy so we can place UIKit elements on top of it.
    [self.view addSubview:director.view];
    [self.view sendSubviewToBack:director.view];
    
//    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.button.frame = CGRectMake(20, 20, 200, 44);
//    [self.button setTitle:@"I exist" forState:UIControlStateNormal];
//    [self.view addSubview:self.button];
    
    

    
    
    
    // Ensure we fulfill all of our view controller containment requirements.
    [director didMoveToParentViewController:self];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Observe some notifications so we can properly instruct the director.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification 
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationSignificantTimeChange:)
                                                 name:UIApplicationSignificantTimeChangeNotification
                                               object:nil];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationSignificantTimeChangeNotification object:nil];
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    [[CCDirector sharedDirector] setDelegate:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [[CCDirector sharedDirector] purgeCachedData];
}


#pragma mark - Setting up the director

- (CCGLView *)createDirectorGLView
{
    // Create a default OpenGL view.
    CCGLView *glView = [CCGLView viewWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds]
                                   pixelFormat:kEAGLColorFormatRGB565
                                   depthFormat:0
                            preserveBackbuffer:NO
                                    sharegroup:nil
                                 multiSampling:NO
                               numberOfSamples:0];
    
    return glView;
}


- (void)didInitializeDirector
{
    CCDirector *director = [CCDirector sharedDirector];

    // Set up some common director properties.
    [director setAnimationInterval:1.0f/60.0f];
    [director enableRetinaDisplay:YES];
}


#pragma mark - Notification handlers

- (void)applicationWillResignActive:(NSNotification *)notification
{
    [[CCDirector sharedDirector] pause];
}


- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [[CCDirector sharedDirector] resume];
}


- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    [[CCDirector sharedDirector] stopAnimation];
}


- (void)applicationWillEnterForeground:(NSNotification *)notification
{
    [[CCDirector sharedDirector] startAnimation];
}


- (void)applicationWillTerminate:(NSNotification *)notification
{
    [[CCDirector sharedDirector] end];
}


- (void)applicationSignificantTimeChange:(NSNotification *)notification
{
    [[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}


#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
//	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
//	[[app navController] dismissModalViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
//	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
//	[[app navController] dismissModalViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
