//
//  Donkey.h
//  bullet hell-o
//
//  Created by Kevin Frans on 7/3/13.
//
//

#import "CCSprite.h"

@interface Donkey : CCSprite
{
    float angle;
    float speed;
    
}

-(id) initWithValues: (float) speedIn: (float) angleIn;
-(float) getAngle;
-(float) getSpeed;
-(void) changeAngle: (float) angleIn;
-(void) changeSpeed: (float) speedIn;
+(id) donkey: (float) speedIn:(float) angleIn;
@end

