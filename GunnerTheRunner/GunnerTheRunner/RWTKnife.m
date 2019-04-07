//
//  RWTKnife.m
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-03-16.
//

#import "RWTKnife.h"
#import "betterknife.h"

float yPosition;

@interface RWTKnife () {
    float velX;
    float velY;
    float initXPos;
    float initYPos;
    float initZPos;
}
@end

@implementation RWTKnife
- (instancetype)initWithShader:(RWTBaseEffect *)shader velx:(float)velx vely:(float)vely viewWidth:(CGFloat)viewWidth{
    velX = velx;
    velY = vely;
    initZPos = 1.5;
    initYPos = -0.3;
    if ((self = [super initWithName:"knife" shader:shader vertices:(RWTVertex *)betterknife_Vertices vertexCount:sizeof(betterknife_Vertices)/sizeof(betterknife_Vertices[0])])) {
        [self loadTexture:@"grey.png"];
//        self.scale = GLKVector3Make(0.35f, 0.35f, 0.35f);
        self.scale = GLKVector3Make(0.25f, 0.25f, 0.25f);
        if(viewWidth == 1024){
            initXPos = -2.1;
        }else if(viewWidth == 896){
            initXPos = -4.0;
        }
        self.position = GLKVector3Make(initXPos, initYPos, initZPos);
        self.rotationY = 180 * M_PI/180;
        yPosition = self.position.y;
    }
    return self;
}
//isMoving:(BOOL)isMoving finalPos:(CGPoint)finalPos viewWidth:(float)viewWidth viewHeight:(float)viewHeight angle:(float)angle hyp:(float)hyp opp:(float)opp adj:(float)adj glockPosX:(float)glockPosX glockPosY:(float)glockPosY

- (void)updateWithDelta:(NSTimeInterval)dt {
    
    self.position = GLKVector3Make(self.position.x + velX * dt, self.position.y + velY * dt, self.position.z);
    self.rotationZ += M_PI * 5 *dt;
    
//    NSLog(@"%f", self.position.x);
    /*float finalX = ((finalPos.x / (viewWidth/2) - 1) * self.scale);
    float finalY = ((finalPos.y / (viewHeight/2) - 0.5) * -2) * self.scale;
    
    float barrelPosX = glockPosX + 0.017;
    float barrelPosY = glockPosY + 0.0613;
    
    printf("%s %f", " Barrel X: ", barrelPosX);
    printf("%s %f", " Barrel Y: ", barrelPosY);
    
    printf("%s %f", " Final X: ", finalX);
    printf("%s %f", " Final Y: ", finalY);
    
    float x = finalX - barrelPosX;
    float y = finalY - barrelPosY;
    float angleForReal = atanf(y/x);*/
    
    /*printf("%s %f", " X: ", x);
    printf("%s %f", " Y: ", y);
    angleForReal = angleForReal * 180 / M_PI;
    printf("%s %f", " ANGLE: ", angleForReal);*/
    //float opp = sin(angle) * hyp;
    //float adj = cos(angle) * hyp;
    
    //opp = ((opp / (viewWidth/2) - 1) * self.scale);
    //adj = ((adj / (viewHeight/2) - 0.5) * -2) * self.scale;
    
    //printf("%s %f", " X:", finalX);
    //printf(" \n");
    //printf("%s %f", " Y:", finalY);
    
    //self.rotationY += M_PI/4 *dt;
    //self.rotationY += M_PI/4 *dt;
    /*if(yPosition < finalPos.y){
        printf("%f", finalPos.y);
        printf(" ");
        printf("%f", yPosition);
        yPosition += 0.2;
        self.position = GLKVector3Make(-3, yPosition, 1.5);
    }
    else{
        //yPosition = self.position.y;
    }*/

}

- (float) getXPosition {
    return self.position.x;
}
- (float) getYPosition {
    return self.position.y;
}
@end
