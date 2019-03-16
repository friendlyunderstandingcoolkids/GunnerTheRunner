//
//  RWTViewController.m
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-16.
//

#import "RWTViewController.h"
#import "RWTVertex.h"
#import "RWTBaseEffect.h"
#import "RWTGlock.h"
#import "RWTBackgroundQuad.h"

@interface RWTViewController ()
{
    RWTGlock *RWTGlockScript;
    
    BOOL isJump;

}
@end

@implementation RWTViewController {
    RWTBaseEffect *_shader;
    RWTGlock *_glock;
    RWTBackgroundQuad *_background;
}

- (void)setupScene {
    _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
    _glock = [[RWTGlock alloc] initWithShader:_shader];
    _background = [[RWTBackgroundQuad alloc] initWithShader:_shader];
    [_background getScreenParams:self.view.bounds.size.height and:self.view.bounds.size.width];
    //_cube = [[RWTCube alloc] initWithShader:_shader];
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    RWTGlockScript = [[RWTGlock alloc] init];
    isJump = true;
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    
    [EAGLContext setCurrentContext:view.context];
    
    [self setupScene];
    
    //Tap Recognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapResponder:)];
    //Number of taps required
    tapRecognizer.numberOfTapsRequired = 2;
    //Number of fingers on screen
    tapRecognizer.numberOfTouchesRequired = 1;
    //Add Gesture Recognizer to View
    [self.view addGestureRecognizer:tapRecognizer];
    
    //Pan Recognizer
    /*UIPanGestureRecognizer * panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panResponder:)];
    panRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panRecognizer];*/
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, -1, -5);
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(0), 1, 1, 1);
    
    [_glock renderWithParentModelViewMatrix:viewMatrix];
    [_background renderWithParentModelViewMatrix:viewMatrix];
    //[_cube renderWithParentModelViewMatrix:viewMatrix];
    
}

- (void)update {
    [_glock updateWithDelta:self.timeSinceLastUpdate];
    [_background updateWithDelta:self.timeSinceLastUpdate];
    //[_cube updateWithDelta:self.timeSinceLastUpdate];
}


//responds to double tap
-(IBAction)tapResponder:(UITapGestureRecognizer *) recognizer
{
    [RWTGlockScript doJump:(BOOL)isJump];
}

////responds to pan
//-(IBAction)panResponder:(UIPanGestureRecognizer *) recognizer
//{
//    CGPoint touchLocation = [recognizer locationInView:self.view];
//    NSLog(@"%f",touchLocation);
//    float xPosition = touchLocation.x;
//    float yPosition = touchLocation.y;
//    [RWTGlockScript fingerLocationX:(float)xPosition fingerLocationY:(float)yPosition];
//
//}
@end
