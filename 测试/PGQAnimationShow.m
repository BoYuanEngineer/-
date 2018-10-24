//
//  AnimationShow.m
//  PoemObjcShow
//
//  Created by Lois_pan on 16/4/14.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import "PGQAnimationShow.h"

#define  windowY   40

@interface PGQAnimationShow()

//window背景
@property (nonatomic, strong) UIView * window;
//渐变色layer
@property (nonatomic, strong) CAGradientLayer * gradientLayer;
//字迹图层
@property (nonatomic, strong) CAShapeLayer * pathLayer;
//字迹动画的时间
@property (nonatomic, assign) NSTimeInterval textAnimationTime;
//window弹出动画的时间
@property (nonatomic, assign) NSTimeInterval windowTime;
//定时器
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation PGQAnimationShow
{
    CGRect winframe;
    UIView *supview;
}

+ (PGQAnimationShow *)shareInstance {
    static  PGQAnimationShow * sharemanager = nil;
    if (sharemanager == nil){
        sharemanager = [[PGQAnimationShow alloc]init];
    }
    return sharemanager;
}

- (void)showWithMessage:(NSString *)messgae image:(UIImage *)image windowColor:(UIColor *)color {
    _gradientLayer = [[CAGradientLayer alloc] init];
    _pathLayer = [[CAShapeLayer alloc] init];
    _textAnimationTime = 3.0;
    _windowTime = 0.2;
    [self showWindowWithColor:color];
    [self addGradientLayer];
    [self addPathLayerWithMessage:messgae];
    _gradientLayer.mask = _pathLayer;
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(CGRectGetMinX(_pathLayer.frame) - 5 - imageView.image.size.width, 0, imageView.image.size.width, imageView.image.size.height );
    imageView.center = _window.center;
    [_window addSubview:imageView];
}

//Sucess
- (void)showSucessWithMessage:(NSString *)message backColor:(UIColor *)color {
    UIImage * image = [UIImage imageNamed:@""];
    [self showWithMessage:@"这里有你想要的" image:image windowColor:color];
}

//Loading
- (void)showLoadingWithMessage:(NSString *)message backColor:(UIColor *)color frame:(CGRect)frame superView:(UIView *)view{
    winframe = frame;
    supview = view;
    
    [self showWithMessage:@"这里有你想要的" image:nil windowColor:color];
    [_timer invalidate];
    
    UIActivityIndicatorView * activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicatorView startAnimating];
    
    activityIndicatorView.frame = CGRectMake(CGRectGetMinX(_pathLayer.frame) - 5 - activityIndicatorView.frame.size.width, 0, activityIndicatorView.frame.size.width, activityIndicatorView.frame.size.height);
    
    [_window addSubview:activityIndicatorView];
}

- (void)showWindowWithColor:(UIColor *)color {
    [_timer invalidate];
    _timer = nil;
    _window = [[UIView alloc] init];
    [_pathLayer removeAllAnimations];
    _window.backgroundColor = color;
    
//    _window.frame   = CGRectMake(0, -windowY, [UIScreen mainScreen].bounds.size.width, windowY);
    _window.frame = winframe;
    [supview addSubview:_window];
    
    [UIView animateWithDuration:_windowTime animations:^{
//        _window.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, windowY);
    }];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_textAnimationTime+1 target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

//window hide
- (void)hide {
    [_timer invalidate];
    _timer = nil;
    if (_window) {
        [UIView animateWithDuration:_windowTime animations:^{
            _window.frame = CGRectMake(0, -windowY, [UIScreen mainScreen].bounds.size.width, windowY);
        } completion:^(BOOL finished) {
            _window = nil;
            [_pathLayer removeAllAnimations];
            [_gradientLayer removeAllAnimations];
        }];
    }
}

//Add GradientLayer
- (void)addGradientLayer {
    int count = 10;
    NSMutableArray * colors = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++) {
        UIColor * color = [UIColor colorWithRed:((255-10*i)/255.0) green:((255-10*i)/255.0) blue:((255-10*i)/255.0) alpha:1.0];
        [colors addObject:(id _Nonnull)color.CGColor];
    }
    
    _gradientLayer.startPoint = CGPointMake(0, 0.5);
    _gradientLayer.endPoint = CGPointMake(1, 0.5);
    
    _gradientLayer.colors = colors;
    _gradientLayer.frame = _window.bounds;
    _gradientLayer.type = kCAGradientLayerAxial;
    [_window.layer addSublayer:_gradientLayer];
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.duration = 1.5;
    animation.repeatCount = MAXFLOAT;
    
    NSMutableArray * toColors = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++) {
        
        UIColor * color = [UIColor colorWithRed:((180-2*i)/255.0) green:((205-2*i)/255.0) blue:((205-2*i)/255.0) alpha:1.0];
        [toColors addObject:(id _Nonnull)color.CGColor];
    }
    
    animation.autoreverses = YES;
    animation.toValue = toColors;
    [_gradientLayer addAnimation:animation forKey:@"gradientLayer"];
}


//添加pathlayer
- (void)addPathLayerWithMessage:(NSString *)message {
    UIBezierPath *textPath = [self bezierPathFrom:message];
    _pathLayer.bounds = CGPathGetBoundingBox(textPath.CGPath);
    _pathLayer.position = _gradientLayer.position;
    _pathLayer.geometryFlipped = YES;
    _pathLayer.path = textPath.CGPath;
    _pathLayer.fillColor = nil;
    _pathLayer.lineWidth = 1;
    _pathLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    CABasicAnimation * textAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    textAnimation.duration = _textAnimationTime;
    textAnimation.fromValue = [NSNumber numberWithFloat:0];
    textAnimation.toValue = [NSNumber numberWithFloat:1];
//    textAnimation.delegate = _window;
    
    [_pathLayer addAnimation:textAnimation forKey:@"strokeEnd"];
}

//绘制bezierPath
- (UIBezierPath *)bezierPathFrom:(NSString *)string {
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CTFontRef font = CTFontCreateWithName(CFSTR("SnellRoundhand"), 16.0f, NULL);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    // for each run
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {
        // Get Font for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLyph in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) {
            // get Glyph & Glyph-data
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            // Get path of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    return path;
}




- (void)sp_getUserName3880453816:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName789063866:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2820883664:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2963526185:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState3654439930:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2550159757:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2045543116:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName604687976:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2214380131:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess2821874028:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess3602399180:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess1379190503:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess956015723:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1819967249:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState540175130:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess388433144:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked920241746:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3746066218:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload89425612:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData3183941523:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3686567717:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3771708345:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_upload1492098706:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload2295045586:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData3733098977:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserName368812608:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess3734589093:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2413763544:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1888923117:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting2818389699:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1382605658:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess639664664:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking4231273901:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess544985149:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked1860514986:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1245825180:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess2923216288:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName816420416:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3178960429:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo4018685747:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1242461288:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo3089323796:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess4090692621:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName3300330637:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed475653333:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_upload664026107:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess646514597:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2772805093:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData4285487623:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting1067496454:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess3640567601:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess2837660117:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess3922911522:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3159703555:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState3238669928:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess1794228582:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2160876094:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2302444245:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting416249440:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1913637700:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1203483379:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo2110098153:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked450355833:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2612127505:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2041319362:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed1458909077:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload2425024711:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed1121934516:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed3784676049:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2607528719:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting3098877095:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked349406561:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess675215106:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed3819617171:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting1547910640:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3816287601:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed3374513143:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2964109491:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3495840165:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3801225905:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1709685694:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData3216550391:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2596024932:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2816879900:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess4046587441:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked3746997738:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData2208628083:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo4153122870:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo2394631335:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3348020678:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_upload607291759:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed2969515121:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3752734971:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1428236999:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName4003711059:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_upload698357312:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2949484374:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo1175187948:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting3462899006:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1886919656:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting1094491507:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1345207005:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo754489547:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState147117793:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked41142955:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData3944687250:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed358827512:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting741998973:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess4121590047:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState4010030281:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting183639857:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData3704712464:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload2419232882:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess559981446:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess510207683:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_upload1890140073:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1594515841:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload850137005:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_upload426629479:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess4241049695:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess1270727302:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1639598527:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState760868393:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed1392058099:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2242135037:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2772734182:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2006975938:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess1012075627:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3281905456:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking1141274050:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2506680915:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2187987712:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed623789109:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess487776353:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess2646807496:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2725086269:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess263504745:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo1619710955:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess3594434024:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo3260827403:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess309557780:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess4251441333:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2570884922:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked2587902777:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting631021873:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1091298918:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2993191118:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1063970015:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2274784931:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData2171117947:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo976486962:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2122013657:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting1278202944:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2975424273:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3362844472:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData447558036:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked2181831857:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed2044398576:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2670791569:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting1010000996:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess817652124:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed3432652065:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess501018299:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess248102891:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1638204668:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed2697126838:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo1997688292:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess1948490804:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3183956165:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2310981256:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo3541744696:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting3242905277:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess461813640:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2106651826:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState1972627326:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess887776702:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName4045460978:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking3418954772:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1841970087:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess2733775082:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting703198651:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo178339460:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo1196331962:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState3198003656:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo1348844555:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3406277099:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3024027856:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1337467385:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1157051069:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1467438735:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess2059583656:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess1930526812:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo1420614466:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1423141319:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess2119389816:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1450755382:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking2881256427:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload2499240330:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2564545217:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3915280597:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData3117602132:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess1306572311:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3976603225:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2250935453:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_upload1897246035:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3109450261:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1162489391:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo281728451:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked1312487629:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo1879827124:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess4116017064:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess3198041630:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo3452657540:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1704766653:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed619102995:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName981500394:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3443172802:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1935161400:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking3442164146:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed1776605780:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1166040746:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1152433571:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess3992654997:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState335938508:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1081603677:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess408857578:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess3719044179:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName321158917:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2839238533:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1178096091:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess541553045:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess818658268:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking204811673:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState1389060579:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting3420764177:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess497645353:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess2075017362:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed241989962:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2485065137:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2486108195:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess1388264542:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2373001458:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserName691521786:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess2954586405:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed4270289237:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3601353119:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1392327710:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1016011139:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting1177097664:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3765182494:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking1195682733:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking3276717956:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked1794057680:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess310942835:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2373297520:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking106104587:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2795254782:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState689030207:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload746137886:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo3334551058:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3870447286:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1643966104:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3297274234:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1429640141:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1598431926:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting1631143842:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3179776174:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed14346802:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2590458293:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3873187218:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed135071366:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed2149910765:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed662478263:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed752854290:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess2872541814:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2288982724:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2639349814:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3209533604:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState4282234611:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2956555679:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload3006366718:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2418281092:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo1875164119:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking1038584129:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked1576079848:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked3012798142:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo3899804962:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData3258466118:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData299523221:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3113488409:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess3457695829:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo989691699:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess621945189:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess6261159:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName1842355315:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1739182151:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1518229867:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData614325330:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess846103856:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload1856921194:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3517675717:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed246521288:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2384884663:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3692996431:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2111018646:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess77904325:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess3649153318:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName259054549:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked874282514:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1936613569:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo932765238:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3311918077:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3696457574:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState3540147649:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2137580895:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3862468637:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess4160256242:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking195552274:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3685165282:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1653996013:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed2561489535:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed608847099:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getLoginState4258891644:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo2359363050:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess1163243271:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess1605257436:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking872344064:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1633411973:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData3831683727:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3860529145:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName472164623:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1598212786:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1232049909:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo1133250978:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo4183512714:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getLoginState376054374:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking3838431098:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3626772777:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1189724538:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData4258940716:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess1330940772:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1234017719:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2406104607:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed3272879304:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState2360886786:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess2051733549:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting3587918767:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState580862659:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserName1852503034:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed3125262312:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess2804424841:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed517199798:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking2540187094:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess534859021:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1294876575:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting3033239261:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3329942082:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess1672511314:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2624341194:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1005404438:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3883668141:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed4029815261:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo1008105923:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed805761579:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess4255787417:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess1597443843:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData2818530931:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2624743538:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2328931526:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2726244124:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName4005476744:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess2957993989:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName676670219:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting198785489:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo1905221709:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState745600560:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting1670537835:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess1867780617:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo2540132569:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3287492527:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1977099711:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserName1419698122:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking4061651011:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3002777742:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed75709852:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo4014828083:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1098573751:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo1627294007:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1894324826:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2618906717:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3021646200:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess2119194691:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo1807298753:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess2504842328:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1131428391:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess2538125265:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess3000421263:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess669747617:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked4213945465:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2813726587:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking3213809195:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1290585288:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess3360557031:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2132450184:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2656856668:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3746206424:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3551832019:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_upload2547510272:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed943867792:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData3602321284:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2463413346:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess2871314688:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess590635176:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_upload620782719:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3263992500:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData3731806017:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2149613461:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo408308901:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2796249808:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked370171008:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3875094472:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3773653331:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo2597567563:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1392345804:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3116889701:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2871532430:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting108251128:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData2485148755:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2746344101:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked150851474:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed1191441769:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting800154603:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload4172859505:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData1986700198:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking1411159225:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState704245610:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2984519033:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking3526144678:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed3090246649:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3208211364:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed4165596106:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess3746516374:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1927184746:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed4071384409:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo3501015798:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1666404376:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload3406602827:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData45852994:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess217227104:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName3863615390:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2539868640:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData3609769516:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1656704159:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3734099131:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2798419559:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1956909082:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3564446443:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3978751355:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3060422930:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess4069621091:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess2783358175:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3026965613:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload834696350:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess4054188975:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2007339071:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1040282020:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess4030546265:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1980888991:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo2665100984:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2293368186:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking244832329:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3734005553:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getLoginState2550441863:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3856057194:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3070254171:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2692438026:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess462758581:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting4210987230:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3962472401:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2837967504:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess3125774694:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked1072939269:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1093041197:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData555750354:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked2943545516:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2408942731:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName270356000:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1086253857:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1203045530:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData851239859:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName1486336246:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName228580319:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1384823609:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload3701600687:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess3991849175:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName1275364321:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState1363521202:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2196345396:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2288346944:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1225839940:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3868400730:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload2532968302:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess3775392412:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3754252509:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2541575966:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1413592867:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2616032580:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2084743015:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2005962222:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking1129139783:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState1250893933:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2351155938:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting2632464325:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo663293529:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData774652953:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3711338653:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting423072743:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1319968182:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_upload2517837784:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1603901183:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2855691908:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3230392571:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting2468841005:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2298086903:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2775055579:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1057513570:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3282052891:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1077138576:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess247305193:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2010315668:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1507924157:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3101061739:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess2379119144:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3926769244:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData419246465:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2304828960:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2674412689:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2168012251:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserName1462445846:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess3618886919:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3264513668:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName3687803406:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed1309450494:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2917112764:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserName2192177232:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData4224770288:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName1605756461:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName395373304:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess628417890:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking947206020:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getLoginState2558460165:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData3074031667:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName449656250:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2031052105:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting353694405:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData64443971:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1185970513:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2826236133:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState2160152619:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed2646285672:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3665958891:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName4249103888:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed970465080:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess4059746145:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2342831057:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName30559933:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3211513085:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting1257189760:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3520009131:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1214625811:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess479364693:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo394866003:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed3185983210:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1219102321:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo623727066:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload1497433924:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking3228454302:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked931001554:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload815660299:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked1252865745:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess1572532429:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2768531743:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed3726452932:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1660423848:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting3236777643:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting4205002719:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2404258355:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess3274816375:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2136606443:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState3495537327:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2103750156:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess4229988392:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed1293272126:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess282468029:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1526758263:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo4085455301:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1291750983:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1340581398:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2327596061:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo2074601890:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload952648982:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3008993770:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo1602266472:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess867293022:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getLoginState3000230084:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData4242320955:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked4254655661:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1374552802:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess337641644:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3752761502:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess3049598121:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked2623647718:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo2177146992:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed798624517:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked2670902248:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking629824915:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1086295162:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1294751630:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking2808604576:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed2580167199:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed842907867:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess278642356:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData261409136:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3445453333:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo4090583038:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName1033003995:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo3571902432:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess399352911:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1198436096:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking999391664:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3573774749:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo1712843311:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3073267791:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking3705312465:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3195478045:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed740066522:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo585265379:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked698423321:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2849063922:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload925911383:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked270404484:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1518408579:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2253782111:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess55537285:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3997284598:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3091019916:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo1178137658:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo590118670:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3073921815:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed4067935017:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed266820061:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked860335607:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload52413979:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1102418874:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1826873531:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2266047290:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2418419236:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking2065339919:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName1417168576:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess3920030522:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed3363715231:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked961197352:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2676469813:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3460803877:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking3519872496:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3110024050:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1454246330:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_upload3221418733:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2653463394:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess320377947:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1794565885:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed23962938:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload2021873449:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked1243020685:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess238666800:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1089956391:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo1162913074:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2401728693:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState4125626180:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2966117593:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed741952999:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1451103952:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2881541165:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess673164390:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState4013423881:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed3198167233:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1159699673:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2824023967:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2814712115:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed502281358:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3980214050:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo176488075:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3311527396:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo245790211:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2192337315:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1871990659:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1392848319:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData4228386844:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3342102677:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2867445270:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2874685534:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState323701787:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo96766125:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3957903560:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName1000719460:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1369563972:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess3084418801:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserName4190716068:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserName2678324028:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess973534825:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked870092216:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed1588794543:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2308430918:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2429308981:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess2527489015:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting1748426425:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking291972282:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed4039519575:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess1856246947:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getLoginState3015100406:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess478389440:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3417784215:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1588324047:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked1071198641:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload3789039592:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1248714136:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload537216197:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess3097253342:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2579924485:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload876714975:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3350984525:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload234335828:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData849358769:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData3786818273:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1369592986:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking2880148162:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2977115332:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload3795788237:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess154680830:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked4274692541:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1601679409:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking855109842:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUserName2785880653:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo2156167322:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess101458711:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2934398928:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess683762455:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed759289036:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload2553714675:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess3751892969:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess230590131:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess3978536643:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1547408885:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_upload3741947071:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo4284808710:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData1504421838:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess4030387273:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2008264896:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1500526317:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2375042007:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess3534319866:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed2424148352:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess1391699785:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName1732955500:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2701763191:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked995239927:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1009152700:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked2559521071:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2546349457:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName3720571470:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName1076671263:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1669059642:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2798658127:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData3117927348:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo3195728017:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess855276278:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1135131681:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess230697363:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkInfo3056703549:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2721290487:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getLoginState1019696599:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked122047293:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3837897282:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting2013335921:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking1749510106:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo619755761:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking1636934987:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess360287971:(NSString *)string {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed3302198264:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload2844230670:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1545804058:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess34306630:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking952711067:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2848745867:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess247541361:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo663732176:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}
@end
