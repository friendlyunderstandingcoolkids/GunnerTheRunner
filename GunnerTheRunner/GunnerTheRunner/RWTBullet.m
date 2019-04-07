//
//  RWTBullet.m
//  GunnerTheRunner
//
//  Created by Kabilan Thangarajah on 2019-03-16.
//

#import "RWTBullet.h"
#import "bullet.h"

float bulletxPosition = 8;
float bulletSpeed = 3;
float bulletOTP = 3;
float bulletTypeOTP = 1;
float bulletInitialYPosition = 4;
float bulletYPosition = 4;
int spawnedPosX;
int spawnedPosY;
float xpos;
float ypos;
int type;

@implementation RWTBullet
- (instancetype)initWithShader:(RWTBaseEffect *)shader {
    if ((self = [super initWithName:"Bullet" shader:shader vertices:(RWTVertex *)Linie01_Gold_1_faked_ref_Vertices vertexCount:sizeof(Linie01_Gold_1_faked_ref_Vertices)/sizeof(Linie01_Gold_1_faked_ref_Vertices[0])])) {
        [self loadTexture:@"BULLETou3.png"];
        self.rotationY = M_PI;
        self.rotationX = M_PI_2;
        //self.scale = GLKVector3Make(0.3, 0.3, 0.3);
        self.scale = GLKVector3Make(0.2, 0.2, 0.2);
        self.position = GLKVector3Make(12, 1, 1.5);
        self.rotationX = M_PI/6;
        self.rotationY += M_PI/2;
        //        self.rotationZ = M_PI/180 * 40;
        spawnedPosX = [self getRandomNumberBetween:8 to:12];
        xpos = spawnedPosX;
        spawnedPosY = [self getRandomNumberBetween:0 to:3];
        ypos = spawnedPosX;
        type = [self getRandomNumberBetween:1 to:2];
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
    xpos -= dt*8;
    ypos -= dt*2;
    
    if(type == 1){
        if(self.position.x < -10){
            spawnedPosX = [self getRandomNumberBetween:8 to:12];
            spawnedPosY = [self getRandomNumberBetween:0 to:2];
            self.position = GLKVector3Make(spawnedPosX, spawnedPosY, 1.5);
            xpos = spawnedPosX;
            type = [self getRandomNumberBetween:1 to:2];
        }
        else{
            self.position = GLKVector3Make(xpos, spawnedPosY, 1.5);
        }
    }
    else {
        if(self.position.x < -10){
            spawnedPosX = [self getRandomNumberBetween:8 to:12];
            spawnedPosY = [self getRandomNumberBetween:1 to:2];
            self.position = GLKVector3Make(spawnedPosX, spawnedPosY, 1.5);
            xpos = spawnedPosX;
            ypos = spawnedPosY;
            type = [self getRandomNumberBetween:1 to:2];
        }
        else{
            self.position = GLKVector3Make(xpos, ypos, 1.5);
        }
    }
    
//    if(bulletxPosition < -10){
//        bulletTypeOTP = [self getRandomNumberBetween:0 to:3];
//        bulletOTP = [self getRandomNumberBetween:3 to:5];
//        bulletxPosition = 9;
//        bulletInitialYPosition = [self getRandomNumberBetween:2 to:4];
//        if(bulletInitialYPosition > 3){
//            if(bulletOTP == 5){
//                self.rotationY = M_PI;
//                self.rotationX = M_PI_2;
//                self.rotationY += M_PI/2 + 0.3;
//            }
//            else if(bulletOTP == 4){
//                self.rotationY = M_PI;
//                self.rotationX = M_PI_2;
//                self.rotationY += M_PI/2 + 0.4;
//            }
//            else{
//                self.rotationY = M_PI;
//                self.rotationX = M_PI_2;
//                self.rotationY += M_PI/2 + 0.5;
//            }
//        }
//        else{
//            if(bulletOTP == 5){
//                self.rotationY = M_PI;
//                self.rotationX = M_PI_2;
//                self.rotationY += M_PI/2 + 0.3;
//            }
//            else if(bulletOTP == 4){
//                self.rotationY = M_PI;
//                self.rotationX = M_PI_2;
//                self.rotationY += M_PI/2 + 0.2;
//
//            }
//            else{
//                self.rotationY = M_PI;
//                self.rotationX = M_PI_2;
//                self.rotationY += M_PI/2 + 0.1;
//            }
//        }
//        bulletYPosition = bulletInitialYPosition;
//
//    }
//    if(bulletTypeOTP <= 1){
//        self.rotationY = M_PI;
//        self.rotationX = M_PI_2;
//        self.rotationY += M_PI/2;
//        bulletxPosition -= dt * bulletSpeed * bulletOTP;
//        self.position = GLKVector3Make(bulletxPosition,0.3, 1.5);
//    }
//    else{
//        if(bulletInitialYPosition < 3){
//            bulletxPosition -= dt * bulletSpeed * bulletOTP;
//            bulletYPosition -= dt;
//            self.position = GLKVector3Make(bulletxPosition,bulletYPosition, 1.5);
//        }
//        else{
//            bulletxPosition -= dt * bulletSpeed * bulletOTP;
//            bulletYPosition -= dt * 2.5;
//            self.position = GLKVector3Make(bulletxPosition,bulletYPosition, 1.5);
//        }
//
//    }
    
}

-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

-(void) onBulletStab{
    bulletxPosition = -11;
}
@end
