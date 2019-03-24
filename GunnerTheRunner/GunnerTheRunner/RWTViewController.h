//
//  RWTViewController.h
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-16.
//

#import <UIKit/UIKit.h>
#import "RWTGlock.h"
#import <CoreMotion/CoreMotion.h>
@import GLKit;

@interface RWTViewController : GLKViewController
{
    CMMotionManager *motionManager;
    NSOperationQueue *opQ;
}
@end


