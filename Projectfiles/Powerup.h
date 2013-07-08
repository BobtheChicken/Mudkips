//
//  Powerup.h
//  bullet hell-o
//
//  Created by Kevin Frans on 7/8/13.
//
//

#import "CCSprite.h"

@interface Powerup : CCSprite
{
    float angle;
    float speed;
    
}



-(id) initWithValues: (float) speedIn: (float) angleIn;
-(float) getAngle;
-(float) getSpeed;
-(void) changeAngle: (float) angleIn;
-(void) changeSpeed: (float) speedIn;
+(id) powerup: (float) speedIn:(float) angleIn;

@end
