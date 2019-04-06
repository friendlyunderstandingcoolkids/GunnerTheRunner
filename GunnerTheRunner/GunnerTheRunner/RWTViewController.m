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
#import "sfxPlayer.h"

@interface RWTViewController ()
{
    BOOL fastFall;
    BOOL isJump;
    CGFloat viewWidth;
    CGFloat viewHeight;
    __weak IBOutlet UILabel *onScreenScore;
    __weak IBOutlet UIImageView *heart1;
    __weak IBOutlet UIImageView *heart2;
    __weak IBOutlet UIImageView *heart3;
    __weak IBOutlet UIImageView *Ammo1;
    __weak IBOutlet UIImageView *Ammo2;
    NSUserDefaults *_prefs;
}
@end

@implementation RWTViewController {
    RWTBaseEffect *_shader;
    RWTGlock *_glock;
    RWTBackgroundQuad *_background;
    CollisionHandler *_collision;
    RWTKnife *_knife;
    NSMutableArray *knives;
    NSMutableArray *mushrooms;
    NSMutableArray *bullets;
    sfxPlayer *fx;
    int score;
    int health;
}

- (void)setupScene {
    viewWidth = self.view.bounds.size.width;
    viewHeight = self.view.bounds.size.height;
    
    _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
    _glock = [[RWTGlock alloc] initWithShader:_shader viewWidth:viewWidth];
    _background = [[RWTBackgroundQuad alloc] initWithShader:_shader];
    [_background getScreenParams:self.view.bounds.size.height and:self.view.bounds.size.width];
    _collision = [[CollisionHandler alloc] init];
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
    
    knives = [[NSMutableArray alloc] init];
    mushrooms = [[NSMutableArray alloc] init];
    bullets = [[NSMutableArray alloc] init];
    
    for(int k=0;k<2;k++){
        RWTMushroom *mush = [[RWTMushroom alloc] initWithShader:_shader];
        [mushrooms addObject:mush];
    }
    
    RWTBullet *bullet = [[RWTBullet alloc] initWithShader:_shader];
    [bullets addObject:bullet];
    
    health = 3;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    fx = [[sfxPlayer alloc] init];
    
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
    
    for (NSInteger i=0; i < [knives count]; i++) {
        [knives[i] renderWithParentModelViewMatrix:viewMatrix];
        float posX = [knives[i] getXPosition];
        float posY = [knives[i] getYPosition];
        if (fabs(posX) >= 6.5 || fabs(posY >= 5)){
            [knives removeObjectAtIndex:i];
        }
    }
    if([mushrooms count] < 2){
        RWTMushroom *mush = [[RWTMushroom alloc] initWithShader:_shader];
        [mushrooms addObject:mush];
    }
    for(int j=0;j<[mushrooms count];j++){
        [mushrooms[j] renderWithParentModelViewMatrix:viewMatrix];
    }
    
    if([bullets count] < 1){
        RWTBullet *bullet = [[RWTBullet alloc] initWithShader:_shader];
        [bullets addObject:bullet];
    }
    for(int m=0;m<[bullets count];m++){
        [bullets[m] renderWithParentModelViewMatrix:viewMatrix];
    }
    _prefs = [NSUserDefaults standardUserDefaults];
}

- (void)update {
    score += 1;
    onScreenScore.text = [NSString stringWithFormat:@"Score: %d", score];
    [_glock updateWithDelta:self.timeSinceLastUpdate];
    [_background updateWithDelta:self.timeSinceLastUpdate];
    
//    NSLog(@"%lu", (unsigned long)[knives count]);
    if ([knives count] == 2){
        Ammo2.hidden = true;
        Ammo1.hidden = true;
    }
    else if ([knives count] == 1){
        Ammo1.hidden = false;
        Ammo2.hidden = true;
    }
    else{
        Ammo2.hidden = false;
        Ammo1.hidden = false;
    }
    
    
    if(health < 3){
        heart1.hidden = true;
    }
    if(health < 2){
        heart2.hidden = true;
    }
    if(health < 1){
        heart3.hidden = true;
        
        //COMPARING AND ADDING HIGHSCORE
        NSMutableArray *scores = [_prefs objectForKey:@"highscores"];
        NSNumber *newScore = [NSNumber numberWithInteger:score];
        scores = [NSMutableArray arrayWithArray:[scores sortedArrayUsingSelector: @selector(compare:)]];
        if([scores objectAtIndex:0] < newScore){
            [scores replaceObjectAtIndex:0 withObject:newScore];
        }
        [_prefs setObject:scores forKey:@"highscores"];
        [_prefs synchronize];
        [self swapScene];
    }
    
    
    for (int i=0;i<[knives count];i++) {
        [knives[i] updateWithDelta:self.timeSinceLastUpdate];
        BOOL hit = false;
        BOOL hit2 = false;
        //for (int x = 0; x < [mushrooms count]; x++) {
        //    hit = [_collision knifeDetection:(RWTKnife *)knives[i] mushDetection:(RWTMushroom *)mushrooms[x]];
        //}
        for (int y = 0; y < [bullets count]; y++) {
            hit2 = [_collision knifeDetection:(RWTKnife *)knives[i] bulletDetection:(RWTBullet *)bullets[y]];
            if(hit2) {
                [fx oof2];
                [bullets removeObjectAtIndex:y];
                score += 100;
            }
        }
        if(hit || hit2) {
            [knives removeObjectAtIndex:i];
        }
    }
    
    for (int h=0;h<[mushrooms count];h++) {
        [mushrooms[h] updateWithDelta:self.timeSinceLastUpdate];
        if([_collision mushroomDetection:mushrooms[h] glockDetection:_glock]){
            [mushrooms removeObjectAtIndex:h];
            health -= 1;
            [fx oof];
        };
    }
    
    for (int s=0;s<[bullets count];s++) {
        [bullets[s] updateWithDelta:self.timeSinceLastUpdate];
        if([_collision bulletDetection:(RWTBullet *)bullets[s] glockDetection:(RWTGlock *)_glock]){
//            NSLog(@"hit");
            [bullets removeObjectAtIndex:s];
            health -= 1;
            [fx oof];
        };
    }
}


- (void)swapScene {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MainViewController"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:NO completion:NULL];
}

//responds to tap
-(IBAction)tapResponder:(UITapGestureRecognizer *) recognizer
{
    CGPoint pointToShoot = [recognizer locationInView:self.view];
    NSLog(@"%s %f", "y pos", pointToShoot.y);
    NSLog(@"%s %f", "x pos", pointToShoot.x);
    if(pointToShoot.x <= 270) {
        [fx jump];
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
//        float angleDeg = angle * 100;
        //float angleDeg = angle * 180 / M_PI;
        
        NSLog(@"%s", "");
        
        _knife = [[RWTKnife alloc] initWithShader:_shader velx:velocityX vely:velocityY viewWidth:viewWidth];
        [knives addObject: _knife];
        [fx knifeThrowFX];
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
