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
#import "RWTMushroom.h"
#import "CollisionHandler.h"
#import "RWTBackgroundQuad.h"

@interface RWTViewController ()
{
    BOOL fastFall;
    BOOL isJump;

}
@end

@implementation RWTViewController {
    RWTBaseEffect *_shader;
    RWTGlock *_glock;
    RWTBackgroundQuad *_background;
    RWTMushroom *_mush;
    RWTMushroom *_mush2;
    CollisionHandler *_collision;
}

- (void)setupScene {
    _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
    _glock = [[RWTGlock alloc] initWithShader:_shader];
    _background = [[RWTBackgroundQuad alloc] initWithShader:_shader];
    [_background getScreenParams:self.view.bounds.size.height and:self.view.bounds.size.width];
    _mush = [RWTMushroom alloc];
    _mush2 = [RWTMushroom alloc];
    _mush = [_mush initWithShader:_shader];
    _mush2 = [_mush2 initWithShader:_shader];
    _collision = [[CollisionHandler alloc] init];
    //_cube = [[RWTCube alloc] initWithShader:_shader];
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isJump = true;
    fastFall = true;
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    
    [EAGLContext setCurrentContext:view.context];
    
    [self setupScene];
    
    //Tap Recognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapResponder:)];
    //Number of taps required
    tapRecognizer.numberOfTapsRequired = 1;
    //Number of fingers on screen
    tapRecognizer.numberOfTouchesRequired = 1;
    //Add Gesture Recognizer to View
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    //Double Tap Recognizer
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapResponder:)];
    //Number of taps required
    doubleTapRecognizer.numberOfTapsRequired = 2;
    //Number of fingers on screen
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    //Add Gesture Recognizer to View
    [self.view addGestureRecognizer:doubleTapRecognizer];
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
    [_mush renderWithParentModelViewMatrix:viewMatrix];
    [_mush2 renderWithParentModelViewMatrix:viewMatrix];
    //[_cube renderWithParentModelViewMatrix:viewMatrix];
    
}

- (void)update {
    [_glock updateWithDelta:self.timeSinceLastUpdate];
    [_background updateWithDelta:self.timeSinceLastUpdate];
    [_mush updateWithDelta:self.timeSinceLastUpdate isMush2:false];
    [_mush2 updateWithDelta:self.timeSinceLastUpdate isMush2:true];
    [_collision mushroomDetection:(RWTMushroom *)_mush glockDetection:(RWTGlock *)_glock];
    [_collision mushroomDetection:(RWTMushroom *)_mush2 glockDetection:(RWTGlock *)_glock];
    //[_cube updateWithDelta:self.timeSinceLastUpdate];
}


//responds to tap
-(IBAction)tapResponder:(UITapGestureRecognizer *) recognizer
{
    [_glock doJump:(BOOL)isJump];
}

//responds to doubleTap
-(IBAction)doubleTapResponder:(UITapGestureRecognizer *) recognizer
{
    [_glock dofastFall:(BOOL)fastFall];
}

@end
