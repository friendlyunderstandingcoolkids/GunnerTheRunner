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
#import "RWTKnife.h"
#import "RWTBullet.h"

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
    RWTKnife *_knife;
    NSMutableArray *knives;
    RWTBullet *_bullet;
}

- (void)setupScene {
    _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
    _glock = [[RWTGlock alloc] initWithShader:_shader];
    _background = [[RWTBackgroundQuad alloc] initWithShader:_shader];
    [_background getScreenParams:self.view.bounds.size.height and:self.view.bounds.size.width];
    _mush = [[RWTMushroom alloc] initWithShader:_shader];
    _mush2 = [[RWTMushroom alloc] initWithShader:_shader];
    _bullet = [[RWTBullet alloc] initWithShader:_shader];
    _collision = [[CollisionHandler alloc] init];
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
    
    knives = [[NSMutableArray alloc] init];
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
    [_bullet renderWithParentModelViewMatrix:viewMatrix];
    
    for (NSInteger i=0; i < [knives count]; i++) {
        [knives[i] renderWithParentModelViewMatrix:viewMatrix];
        float posX = [knives[i] getXPosition];
        float posY = [knives[i] getYPosition];
        if (fabs(posX) >= 6.5 || fabs(posY >= 5)){
            [knives removeObjectAtIndex:i];
        }
    }
}

- (void)update {
    [_glock updateWithDelta:self.timeSinceLastUpdate];
    [_background updateWithDelta:self.timeSinceLastUpdate];
    [_mush updateWithDelta:self.timeSinceLastUpdate isMush2:false];
    [_mush2 updateWithDelta:self.timeSinceLastUpdate isMush2:true];
    [_bullet updateWithDelta:self.timeSinceLastUpdate];
    [_collision mushroomDetection:(RWTMushroom *)_mush glockDetection:(RWTGlock *)_glock];
    [_collision mushroomDetection:(RWTMushroom *)_mush2 glockDetection:(RWTGlock *)_glock];
    [_collision bulletDetection:(RWTBullet *)_bullet glockDetection:(RWTGlock *)_glock];
    
    for (RWTKnife *knifeToRender in knives) {
        [knifeToRender updateWithDelta:self.timeSinceLastUpdate];
    }
}


//responds to tap
-(IBAction)tapResponder:(UITapGestureRecognizer *) recognizer
{
    CGPoint pointToShoot = [recognizer locationInView:self.view];
    NSLog(@"%s %f", "y pos", pointToShoot.y);
    NSLog(@"%s %f", "x pos", pointToShoot.x);
    if(pointToShoot.x <= 270) {
        [_glock doJump:(BOOL)isJump];
    }
    else if([knives count] < 2 && pointToShoot.x >= 310 && ![_glock isJumping]) {
        
        CGPoint barrelPos = [_glock getBarrelPos];
        NSLog(@"%s %f %f", "Barrel X and Y ", barrelPos.x, barrelPos.y);
        
        float adj = pointToShoot.x - barrelPos.x;
        float opp = barrelPos.y - pointToShoot.y;
        
        NSLog(@"%s %f", "ADJ", adj);
        NSLog(@"%s %f", "OPP", opp);
        
        
        float hyp = 8.0f;
        
        NSLog(@"%s %f", "hyp ", hyp);
        
        float angle = atan(opp/adj);
        
        float velocityX = cosf(angle) * hyp;
        float velocityY = sinf(angle) * hyp;
        
        NSLog(@"%s %f", "angle ", angle);
        float angleDeg = angle * 100;
        //float angleDeg = angle * 180 / M_PI;
        
        NSLog(@"%s", "");
        
        _knife = [[RWTKnife alloc] initWithShader:_shader velx:velocityX vely:velocityY];
        [knives addObject: _knife];
    }
}

//responds to doubleTap
-(IBAction)doubleTapResponder:(UITapGestureRecognizer *) recognizer
{
    CGPoint pointToShoot = [recognizer locationInView:self.view];
    if(pointToShoot.x <= 270) {
        [_glock dofastFall:(BOOL)fastFall];
    }
}

@end
