//
//  RWTGlock.m
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-23.
//

#import "RWTGlock.h"
#import "Glock19.h"

BOOL makeGunJump = false;
float gravity = -9.81;
float startVelocity = 7;
float Velocity;
float yPosition = 0.1;
@interface RWTGlock () {
    
}
@end

@implementation RWTGlock

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
    Velocity = startVelocity;
    if ((self = [super initWithName:"glock" shader:shader vertices:(RWTVertex *)Cube_Material_Vertices vertexCount:sizeof(Cube_Material_Vertices)/sizeof(Cube_Material_Vertices[0])])) {
        [self loadTexture:@"rainbow.png"];
        self.rotationY = M_PI;
        self.rotationX = M_PI_2;
        self.scale = 0.22;
        self.position = GLKVector3Make(-3, 0.1, 1.5);
        self.rotationX -= M_PI/180 * 10;
        self.rotationY -= M_PI/180 * 8;
        self.rotationZ = M_PI/180 * 90;
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    if(makeGunJump == true){
        if(yPosition > 0){
            yPosition += Velocity * dt + gravity * pow(dt, 2);
            Velocity = Velocity + gravity * dt;
            self.position = GLKVector3Make(-3, yPosition, 1.5);
        }
        else{
            makeGunJump = false;
            Velocity = startVelocity;
            yPosition = 0.1;
        }
    }
}

- (void)doJump:(BOOL)isJump{
    if(makeGunJump != true){
        makeGunJump = isJump;
    }
}

//-(void)fingerLocationX:(float)xPosition fingerLocationY:(float)yPosition{
//    NSLog(@"%f",xPosition);
//    NSLog(@"%f",yPosition);
//    printf("-----------");
//}
@end
