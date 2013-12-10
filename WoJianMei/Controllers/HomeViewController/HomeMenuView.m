//
//  HomeMenuView.m
//  Draw
//
//  Created by gamy on 12-12-8.
//
//

#import "HomeMenuView.h"
#import "ImageManager.h"
#import "ConfigManager.h"
#import "DeviceDetection.h"
#import "PPDebug.h"


#define NSLS(x)			NSLocalizedString(x, nil)


@implementation HomeMenuView
@synthesize button = _button;

- (void)updateIcon:(UIImage *)icon
             title:(NSString *)title
              type:(HomeMenuType)type
{
    [self.button setImage:icon forState:UIControlStateNormal];
    [self setType:type];
    
    if (!isMainMenuButton(type)) {
        title = nil;
    }
    if (self.title) {
        [self.title setText:title];
    }else{
        [self.button setTitle:title forState:UIControlStateNormal];
    }

}

- (void)updateBadge:(NSInteger)count
{
    if (count <= 0 ) {
        self.badge.hidden = YES;
    }else if(count > 99){
        self.badge.hidden = NO;
        [self.badge setTitle:@"N" forState:UIControlStateNormal];
    }else{
        self.badge.hidden = NO;
        [self.badge setTitle:[NSString stringWithFormat:@"%d",count]
                    forState:UIControlStateNormal];
    }
}

+ (NSString *)titleForType:(HomeMenuType)type
{
    
    switch (type) {
        //draw main menu
        case HomeMenuTypeDrawDraw :{
            return NSLS(@"增肌增重");
        }
        case HomeMenuTypeDrawGuess:{
            return NSLS(@"瘦身减肥");
        }
        case HomeMenuTypeDrawGame:{
            return NSLS(@"肩部");
        }
        case HomeMenuTypeDrawTimeline:{
            return NSLS(@"胸肌");
        }
        case HomeMenuTypeDrawRank:{
            return NSLS(@"背部");
        }
        case HomeMenuTypeDrawContest:{
            return NSLS(@"腹肌");
        }
        case HomeMenuTypeDrawBBS:{
            return NSLS(@"腰部");
        }
        case HomeMenuTypeDrawBigShop:
        {
            return NSLS(@"更多");
        }

            
        //For woman
        case HomeMenuTypeDrawShop:{
            return NSLS(@"增肌增重");
        }
        case HomeMenuTypeDrawApps:{
            return NSLS(@"瘦身减肥");
        }
        case HomeMenuTypeDrawPhoto:
        {
            return NSLS(@"腿部锻炼");
        }
        case HomeMenuTypeDrawMessage:
        {
            return NSLS(@"上肢锻炼");
        }
        case HomeMenuTypeDrawFriend:
        {
            return NSLS(@"腹部锻炼");
        }
        case HomeMenuTypeDrawFreeCoins:
        {
            return NSLS(@"臀部锻炼");
        }
        case HomeMenuTypeDrawPlayWithFriend:{
            return NSLS(@"生理期锻炼");
        }
        case HomeMenuTypeDrawMore:{
            return NSLS(@"更多");
        }
        default:
        return nil;
    }
}
+ (UIImage *)imageForType:(HomeMenuType)type
{
    switch (type) {
            //draw main menu
        case HomeMenuTypeDrawDraw :{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawGuess:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawGame:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawTimeline:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawRank:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawContest:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawBBS:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawShop:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawBigShop: {
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawApps:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawFreeCoins:
        {
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawPlayWithFriend:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawPhoto: {
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
            //draw bottom menu
        case HomeMenuTypeDrawHome :{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawOpus:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawMessage:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawSetting:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawMore:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawMe:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawFriend:{
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        case HomeMenuTypeDrawCharge: {
            return [UIImage imageNamed:@"draw_home_draw.png"];
        }
        default:
        return nil;
    }
}


#define CENTER_DISTANCE_Y 26

- (void)updateView
{
    if ([DeviceDetection isIPhone5] && [self isHomeMainMenu]) {
        CGFloat y = self.center.y - CENTER_DISTANCE_Y;
        self.badge.center = CGPointMake(self.badge.center.x, y);
    }
}

+ (id)createView:(id<HomeCommonViewDelegate>)delegate identifier:(NSString *)identifier
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create %@ but cannot find view object from Nib", identifier);
        return nil;
    }
    HomeCommonView<HomeCommonViewProtocol> *view = [topLevelObjects objectAtIndex:0];
    view.delegate = delegate;
//    [view updateView];
    
    return view;
}

- (BOOL)isHomeMainMenu
{
    return isMainMenuButton(self.type);
}

+ (NSString *)identifierForType:(HomeMenuType)type
{
    if (isMainMenuButton(type)) {
        return @"HomeMainMenu";
    }else{
        return @"HomeBottomMenu";
    }
    return nil;
}
+ (HomeMenuView *)menuViewWithType:(HomeMenuType)type
                             badge:(NSInteger)badge
                          delegate:(id<HomeCommonViewDelegate>)delegate
{
    NSString *identifier = [HomeMenuView identifierForType:type];
    if (identifier) {
        HomeMenuView *menu = [HomeMenuView createView:delegate identifier:identifier];
        NSString *title = [HomeMenuView titleForType:type];
        UIImage *image = [HomeMenuView imageForType:type];
        [menu updateIcon:image title:title type:type];
        [menu updateBadge:badge];
        [menu setType:type];
        [menu updateView];
        [menu.title setTextColor:[UIColor whiteColor]];
        [menu.onlineNum setTextColor:[UIColor whiteColor]];

        return menu;
    }
    return nil;
}

- (void)dealloc {
    PPRelease(_button);
    [_badge release];
    [_title release];
    [super dealloc];
}

- (IBAction)clickButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickMenu:type:)]) {
        [self.delegate didClickMenu:self type:self.type];
    }
}
@end



int *getDrawMainMenuTypeListWithoutFreeCoins()
{
    int static list[] = {
        //For man
        HomeMenuTypeDrawDraw,
        HomeMenuTypeDrawGuess,
        HomeMenuTypeDrawGame,
        HomeMenuTypeDrawTimeline,
        HomeMenuTypeDrawRank,
        HomeMenuTypeDrawContest,
        HomeMenuTypeDrawBBS,
        HomeMenuTypeDrawBigShop,
        
        
        //For Woman
        HomeMenuTypeDrawShop,
        HomeMenuTypeDrawApps,
        HomeMenuTypeDrawPhoto,
        HomeMenuTypeDrawMessage,
        HomeMenuTypeDrawFriend,
        HomeMenuTypeDrawFreeCoins,
        HomeMenuTypeDrawPlayWithFriend,
        HomeMenuTypeDrawMore,
        
        
        //For End
        HomeMenuTypeEnd
    };
    return list;
}

int *getDrawMainMenuTypeList()
{
    return getDrawMainMenuTypeListWithoutFreeCoins();
}
BOOL typeInList(HomeMenuType type, int *list)
{
    int *l = list;
    while (l != NULL && *l != HomeMenuTypeEnd) {
        if (*l == type) {
            return YES;
        }
        ++ l;
    }
    return NO;
}


BOOL isMainMenuButton(HomeMenuType type)
{
    if (typeInList(type, getDrawMainMenuTypeList())) {
        return YES;
    }
    return NO;
}

int *getMainMenuTypeList()
{
    return getDrawMainMenuTypeList();

}


