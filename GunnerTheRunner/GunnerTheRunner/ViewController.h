//
//  ViewController.h
//  GunnerTheRunner
//
//  Created by Dylan Chew on 2019-02-16.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController {
    CMMotionManager *motionManager;
    NSOperationQueue *opQ;
}
@end

