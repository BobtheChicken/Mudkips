//
//  Bullet.h
//  bullet hell-o
//
//  Created by Kevin Frans on 7/1/13.
//
//

#import "CCSprite.h"

@interface Bullet : CCSprite
{
    float angle;
    float speed;

}

-(id) initWithValues: (float) speedIn: (float) angleIn;
-(float) getAngle;
-(float) getSpeed;
-(void) changeAngle: (float) angleIn;
-(void) changeSpeed: (float) speedIn;
+(id) bullet: (float) speedIn:(float) angleIn;



@end
