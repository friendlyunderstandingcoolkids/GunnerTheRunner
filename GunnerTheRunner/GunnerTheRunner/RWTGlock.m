//
//  RWTGlock.m
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-23.
//

#import "RWTGlock.h"
#import "Glock19.h"

BOOL makeGunJump = false;
BOOL makeGunFastFall = false;
BOOL rotateLeft = false;
float gravity = -15;
float startVelocity = 10;
float Velocity;
float yPosition = 0.1;
float initXPos = 0;
float initYPos = -0.6;
float initZPos = 1.5;
float screenWidth = 0;

@interface RWTGlock () {
    
}
@end

@implementation RWTGlock

- (instancetype)initWithShader:(RWTBaseEffect *)shader viewWidth:(CGFloat)viewWidth {
    Velocity = startVelocity;
    if ((self = [super initWithName:"glock" shader:shader vertices:(RWTVertex *)Cube_Material_Vertices vertexCount:sizeof(Cube_Material_Vertices)/sizeof(Cube_Material_Vertices[0])])) {
        [self loadTexture:@"gunout.png"];
        screenWidth = viewWidth;
        self.rotationY = M_PI;
        self.rotationX = M_PI_2;
        self.scale = GLKVector3Make(0.11, 0.11, 0.11);
        if(screenWidth == 1024){
            initXPos = -2.8;
        }else if(screenWidth == 896){
            initXPos = -4.8;
        }else{
            initXPos = -3.5;
        }
        self.position = GLKVector3Make(initXPos, initYPos, initZPos);
        self.rotationX -= M_PI/180 * 10;
        self.rotationY -= M_PI/180 * 8;
        self.rotationZ = M_PI/180 * 100;
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    if(makeGunJump == true){
        if(yPosition > -0.61){
            yPosition += Velocity * dt + gravity * pow(dt, 2);
            Velocity = Velocity + gravity * dt;
            if(yPosition <= -0.59){
                yPosition = -0.61;
            }
            self.position = GLKVector3Make(initXPos, yPosition, initZPos);
        }
        else{
            makeGunJump = false;
            makeGunFastFall = false;
            Velocity = startVelocity;
            yPosition = -0.6;
            self.position = GLKVector3Make(initXPos, yPosition, initZPos);
        }
    }
    if(makeGunFastFall == true){
        gravity = -100;
    }
    else{
        gravity = -15;
    }
    
    if(self.rotationX < M_PI/180 * 90+0.2 && rotateLeft == false){
        self.rotationX += dt+dt;
    }
    else{
        rotateLeft = true;
    }
    if(self.rotationX > M_PI/180 * 90-0.2 && rotateLeft == true){
        self.rotationX -= (dt+dt);
    }
    else{
        rotateLeft = false;
    }
}

- (void)doJump:(BOOL)isJump{
    if(makeGunJump != true){
        makeGunJump = isJump;
    }
}

- (void)dofastFall:(BOOL)fastFall{
    if(makeGunJump == true){
        makeGunFastFall = true;
    }
}

- (BOOL)isJumping {
    return makeGunJump;
}

- (CGPoint)getBarrelPos{
    CGPoint barrelPos;
    if(screenWidth == 1024){
        barrelPos = CGPointMake(247, 541);
    }else if (screenWidth == 896){
        barrelPos = CGPointMake(189, 292);
    }else{
        barrelPos = CGPointMake(135, 218);
    }
    return barrelPos;
}

- (float)getPositionX {
    return self.position.x;
}

- (float)getPositionY {
    return self.position.y;
}

@end
