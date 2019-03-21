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

@interface RWTGlock () {
    
}
@end

@implementation RWTGlock

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
    Velocity = startVelocity;
    if ((self = [super initWithName:"glock" shader:shader vertices:(RWTVertex *)Cube_Material_Vertices vertexCount:sizeof(Cube_Material_Vertices)/sizeof(Cube_Material_Vertices[0])])) {
        [self loadTexture:@"brass.png"];
        self.rotationY = M_PI;
        self.rotationX = M_PI_2;
        self.scale = GLKVector3Make(0.22, 0.22, 0.22);
        self.position = GLKVector3Make(-4, -0.3, 1.5);
        self.rotationX -= M_PI/180 * 10;
        self.rotationY -= M_PI/180 * 8;
        self.rotationZ = M_PI/180 * 100;
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    if(makeGunJump == true){
        if(yPosition > -0.31){
            yPosition += Velocity * dt + gravity * pow(dt, 2);
            Velocity = Velocity + gravity * dt;
            if(yPosition < -0.3){
                yPosition = -0.35;
            }
            self.position = GLKVector3Make(-4, yPosition, 1.5);
        }
        else{
            makeGunJump = false;
            makeGunFastFall = false;
            Velocity = startVelocity;
            yPosition = -0.3;
            self.position = GLKVector3Make(-4, yPosition, 1.5);
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
    CGPoint barrelPos = CGPointMake(269, 261);
    return barrelPos;
}

- (float)getPositionX {
    return self.position.x;
}

- (float)getPositionY {
    return self.position.y;
}

@end
