//
//  Powerup.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/8/13.
//
//

#import "Powerup.h"

@implementation Powerup

+(id) powerup: (float) speedIn:(float) angleIn
{
    id powerup = [[self alloc] initWithValues:speedIn :angleIn];
    
    return powerup;
}

-(id) initWithValues: (float) speedIn:(float) angleIn
{
    if (self = [super initWithFile:@"greenfield.png"])
    {
        speed = speedIn;
        angle = angleIn;
        
        
    }
    
    return self;
}

-(void) changeSpeed: (float) speedIn
{
    speed = speedIn;
}

-(void) changeAngle: (float) angleIn
{
    angle = angleIn;
}

-(float) getSpeed
{
    return speed;
}

-(float) getAngle
{
    return angle;
}

@end
