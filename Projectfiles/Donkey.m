//
//  Donkey.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/3/13.
//
//

#import "Donkey.h"

@implementation Donkey


+(id) donkey: (float) speedIn:(float) angleIn
{
    id donkey = [[self alloc] initWithValues:speedIn :angleIn];
    
    return donkey;
}

-(id) initWithValues: (float) speedIn:(float) angleIn
{
    if (self = [super initWithFile:@"Democrat_Donkey.png"])
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