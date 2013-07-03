//
//  Bullet.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/1/13.
//
//

#import "Bullet.h"

@implementation Bullet

+(id) bullet: (float) speedIn:(float) angleIn
{
    id bullet = [[self alloc] initWithValues:speedIn :angleIn];
    
    return bullet;
}

-(id) initWithValues: (float) speedIn:(float) angleIn
{
    if (self = [super initWithFile:@"Glowing_Blue_Orb.png"])
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
