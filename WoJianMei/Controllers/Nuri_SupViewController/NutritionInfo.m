//
//  NutritionInfo.m
//  WoJianMei
//
//  Created by Tom Callon  on 9/9/12.
//
//

#import "NutritionInfo.h"


#define NutritionId          @"nutritionId"
#define NutritionTitle       @"nutritionTitle"
#define ImageName            @"imageName"
#define CreatdDate           @"creatdDate"
#define ClickedNumber        @"clickedNumber"
#define CommentsNumber       @"commentsNumber"



@implementation NutritionInfo
@synthesize nutritionId      =_nutritionId;
@synthesize nutritionTitle   =_nutritionTitle;
@synthesize imageName        =_imageName;
@synthesize creatdDate       =_creatdDate;
@synthesize clickedNumber    = _clickedNumber;
@synthesize commentsNumber   =_commentsNumber;



-(void)dealloc{
    
    
    [_nutritionId release];
    [_nutritionTitle release];
    [_imageName release];
    [_creatdDate release];
    [_clickedNumber release];
    [_commentsNumber release];
    [super dealloc];
    
    
}

-(id)initWithNutritionId:(NSString *)aNutritionId
          nutritionTitle:(NSString *)aNutritionTitle
               imageName:(NSString *)aImageName
              creatdDate:(NSString *)aCreatdDate
           clickedNumber:(NSString *)aClickedNumber
          commentsNumber:(NSString *)aCommentsNumber

{
    if (self = [super init]) {
        self.nutritionId      =aNutritionId;
        self.nutritionTitle   =aNutritionTitle;
        self.imageName        =aImageName;
        self.creatdDate       =aCreatdDate;
        self.clickedNumber    =aClickedNumber;
        self.commentsNumber   =aCommentsNumber;
        
    }
    return  self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.nutritionId       forKey:NutritionId];
    [aCoder encodeObject:self.nutritionTitle    forKey:NutritionTitle];
    [aCoder encodeObject:self.imageName         forKey:ImageName];
    [aCoder encodeObject:self.creatdDate        forKey:CreatdDate];
    [aCoder encodeObject:self.clickedNumber     forKey:ClickedNumber];
    [aCoder encodeObject:self.commentsNumber    forKey:CommentsNumber];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.nutritionId      =[aDecoder decodeObjectForKey:NutritionId];
        self.nutritionTitle   =[aDecoder decodeObjectForKey:NutritionTitle];
        self.imageName        =[aDecoder decodeObjectForKey:ImageName];
        self.creatdDate       =[aDecoder decodeObjectForKey:CreatdDate];
        self.clickedNumber    =[aDecoder decodeObjectForKey:ClickedNumber];
        self.commentsNumber   =[aDecoder decodeObjectForKey:CommentsNumber];
    }
    return self;
}





@end
