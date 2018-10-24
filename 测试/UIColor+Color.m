//
//  UIColor+Color.m
//  中孝社区
//
//  Created by 吴思达 on 2016/10/18.
//  Copyright © 2016年 吴思达. All rights reserved.
//

#import "UIColor+Color.h"

@implementation UIColor (Color)

+ (UIColor *)colorWithColorString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithColorString:(NSString *)color
{
    return [self colorWithColorString:color alpha:1.0f];
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}



- (void)sp_getUsersMostLikedSuccess3812196272 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess4076982903 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess425290602 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3208579876 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1293247280 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2570609001 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess143026441 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3484100963 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess3785573082 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState3375505201 {
    NSLog(@"Continue");
}

- (void)sp_getUserName4074146034 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload4277275517 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed3704109698 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3305431598 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess825849778 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1839176384 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed559323558 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo544386077 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2099446683 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting3640096824 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess631612269 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2501288646 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1441990967 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2605306682 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName4218406795 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting500380084 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1288062662 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo2723760971 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2043741013 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking3534970331 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData1167172992 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2351023280 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed766012511 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo3331812686 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1629043286 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3701426363 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess60355783 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload4283499555 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState553317724 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess942191851 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo4165095221 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking645117758 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1164873512 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo326628509 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking917779371 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2745468157 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName272562391 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1484235534 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState4282387140 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2694910088 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo2950697507 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess1570182818 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2948068905 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1347330254 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2135893516 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2579655988 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess3387212459 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3951815945 {
    NSLog(@"Check your Network");
}

- (void)sp_upload4253381608 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess639735677 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed72738457 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo484597814 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1257389124 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3083935828 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData258521125 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess809961749 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2769379746 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2442230046 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking486385701 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3135128350 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess82865752 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2005350039 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1318708551 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed4086595173 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3075534020 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess916244819 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2291618625 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked550133630 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess4124263404 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed166281161 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3677448678 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2945926933 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1387872576 {
    NSLog(@"Continue");
}

- (void)sp_upload2642286985 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2227822861 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload890766092 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess1866049516 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking4079940393 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1073710323 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo1426925554 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2674846642 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting4019798689 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData908501174 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed4097208251 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2652902108 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1748245491 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo4245377579 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName3608250865 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed504781882 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName3368682792 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess1944034224 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2352721398 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName4207036716 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData1766836619 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed197526212 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess419952448 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1697106035 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed2132015709 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess86837384 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess772681421 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo433367971 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting3699402459 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking1360176544 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3189906544 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess513469795 {
    NSLog(@"Continue");
}

- (void)sp_getUserName2733419331 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName3507499171 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1374568469 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3961138800 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed3217442409 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3465921164 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1486570249 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked130124626 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload3124822690 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2066113116 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1274169435 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess1916445894 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1115590872 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3944760005 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed618095747 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2428430716 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting1733766521 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess4086370035 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess2623773131 {
    NSLog(@"Continue");
}

- (void)sp_upload1636177414 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking4261906227 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess533354702 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3588222332 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2278994905 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess680682722 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2594248634 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload2431056474 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1696148745 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2796700877 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2483633738 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2137696693 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3312618356 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3081490608 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1735011925 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3431710374 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess3610233765 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData2445363018 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3304906321 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData2693938508 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess933460024 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1379526240 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData2069761096 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData3199664081 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo3422236476 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting3815548810 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1222001532 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState2219440924 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed112769590 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData25832259 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName255858260 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1086196635 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo3400673637 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2850929488 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState2924379662 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked2838023261 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1412509156 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload216227697 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState1229458067 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState274630419 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData496723560 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed4042716514 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState1005686570 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2238865671 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2165434447 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo2469652659 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState2069781096 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo1949502475 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess2531335660 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3330543236 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3325429890 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3890880696 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking4040888026 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess588998709 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1154684683 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting2361932601 {
    NSLog(@"Continue");
}

- (void)sp_getUserName2562228859 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1743538008 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName1416641562 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess2027354684 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking418374345 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking1706130858 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3040660995 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2881080362 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed4186236683 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked511620284 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed154120206 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName1801266829 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName3100026000 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2829503235 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName562290220 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData1120160964 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess1514406380 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3253795890 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1452297753 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess161664501 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload4228292592 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3113651062 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess840312650 {
    NSLog(@"Continue");
}

- (void)sp_upload2913863159 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo1087951978 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess4024413104 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess2483484572 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3857242221 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3853984823 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess697249957 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2777024185 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed4014411960 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo679047767 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked1564202520 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState934559744 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName1657200782 {
    NSLog(@"Check your Network");
}

- (void)sp_upload3685969280 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed227334772 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo1027006929 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3178109251 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess3330053337 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo2460861197 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess2357143989 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess1049542642 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2070474145 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData77724604 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData2863633172 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3044604463 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2120166030 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3984557729 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking1338609918 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1666160869 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1992089279 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2500477947 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess2213965570 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked3792410274 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo1879638134 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo2501104453 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo3670281384 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3982916127 {
    NSLog(@"Continue");
}

- (void)sp_upload4116716251 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess4065566660 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo755841170 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2057684575 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting163976233 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess3936569459 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3272458518 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking1918101685 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess878967689 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess3671573207 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData3285901407 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload636106913 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2652936230 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess2999896271 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess398537571 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed1136939731 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2687129229 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState1156898013 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1275898571 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1733137197 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3307944350 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3091622529 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2325627924 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking3106414500 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess1484409681 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting976348623 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo2667809924 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState1186642077 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2883350047 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting1416284 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1420220728 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking4018690136 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1185181590 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2105979932 {
    NSLog(@"Check your Network");
}

- (void)sp_upload3537492371 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked2606490246 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData205075258 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName356067496 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1775829719 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1814088826 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess4136868905 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3432296869 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess3377206076 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2200445766 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName1833708846 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo834014975 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2301986549 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3271871059 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1210270705 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2757215624 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2975507740 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2946808061 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked728310183 {
    NSLog(@"Continue");
}

- (void)sp_upload4132361482 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo646147226 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3109300371 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3872088755 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess2711404173 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2740565286 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3620174734 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo986863780 {
    NSLog(@"Continue");
}

- (void)sp_getUserName2503633279 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3706535195 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState740608700 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed3935958244 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState1371716898 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked1801159479 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1583428668 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1766741631 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking2772719918 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed1842892535 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData745985939 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1971893221 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed1900163310 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting4238403720 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData937710575 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking1863749055 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo3342108698 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess1568632673 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3700436589 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed890061147 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName384788354 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess3176061314 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState3469781957 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2244729947 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload376211180 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking3570405742 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo4266090782 {
    NSLog(@"Continue");
}

- (void)sp_getUserName1373854159 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess3040947365 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3190308028 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking467213054 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3783682212 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2003327880 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking738964742 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1147495206 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1308427952 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo864081249 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3913862843 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting4187790342 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1850201255 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess3567591962 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2366380012 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess858982010 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess2347268907 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1153060830 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2322843884 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2421641257 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3867350049 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState2554401957 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed1206748653 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName3188189313 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess1097084559 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData3518639000 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2407371288 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3987010413 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2776309503 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo262093474 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2005922194 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess1811174798 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1903806316 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2125173232 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked2166336717 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2822729371 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo2766654910 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3491237245 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting626402221 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState2140893335 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2266048686 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess2082794782 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2528067473 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess3802555547 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed2923705557 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1376627928 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3692321290 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3626989383 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess419100691 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2463152368 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2482934906 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed505170006 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState2859857171 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed227789123 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess523154568 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess9875507 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3766333792 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed2463525207 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo4229569405 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking4092054038 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess1103539145 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2455645123 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1238354875 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess4130214093 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked2350505150 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2916597195 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess1189485483 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData1006870679 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3113183230 {
    NSLog(@"Check your Network");
}

- (void)sp_upload368762260 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2457922795 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData51988225 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload4227781289 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1567620649 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking2317641309 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1295777584 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo2581264971 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2671667706 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload3382991539 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1707688662 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3840057832 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting2751666292 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2542811121 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess864012171 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess601122311 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload44348640 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking183915200 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo2834557515 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo1147664917 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState1474782349 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3558070670 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState648319419 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData456798527 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess1695308265 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess431346924 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1671897644 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess1109401885 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo668047161 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1999236136 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1529223614 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed2156429932 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3536780247 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked366002715 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3253659469 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting2600430909 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData258931181 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked1608383294 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess3816336543 {
    NSLog(@"Check your Network");
}

- (void)sp_upload1961733892 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2814642741 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3060130390 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed477476820 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed277426983 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1713352002 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting1661482092 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData3784273110 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo2214711165 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState3971153994 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3650849493 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1408369997 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1854727385 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3823415675 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess859607700 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed3435394738 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2424857569 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess33732523 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess909985465 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed3225819124 {
    NSLog(@"Continue");
}

- (void)sp_getUserName2435380529 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName689234532 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1170753784 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked404513295 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking794978103 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload52769325 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName3583482351 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo2966125085 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked1122082465 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking310017516 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3020525379 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3034605258 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting1847939836 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName1460360596 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1270624844 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName1098982402 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3872993491 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3650039494 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3755481840 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess4285876278 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1399098795 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed2778055845 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData3232674547 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked451521146 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking1100704761 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3553816089 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting1270454597 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload49607815 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3190959226 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState1869965796 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3963191865 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2970398260 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked287172336 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo4095779898 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState3623732335 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo2128772106 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1826050344 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2373425645 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2698047160 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess2230991609 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo2472422061 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting2155084316 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess2875762277 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3189307752 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3978883169 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked2694853924 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed344957225 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess2197365695 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2086984377 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2743434742 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed1293429444 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState3717822485 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload3925976609 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2280875230 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked2166598036 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload3276527424 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1112027810 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2653187396 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo684306840 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3061849972 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess397214013 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState107034570 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo2554096703 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess3355949551 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess60956366 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess328374428 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3547615006 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess77523304 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1015412570 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1133028358 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3775498552 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked3519227467 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo15604821 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess345868238 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking659590704 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess3575088040 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess965562175 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2401074492 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1088561265 {
    NSLog(@"Continue");
}

- (void)sp_upload2929060422 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2591070399 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2387687718 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess3369923345 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3765129961 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState1934577847 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2900423757 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess1726342475 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1134026234 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2520665212 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3731832024 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2128902013 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState2872767341 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3212205910 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting537465234 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2910139821 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking1453009450 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting4039233200 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1300139151 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed845722506 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload4042622524 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1418362827 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess1917424373 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked1740101932 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1237125418 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess4187296679 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData463143043 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3973078936 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2300001717 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3327208914 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData1229978022 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo1396478046 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess3201591765 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData625207618 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3785607785 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1637024555 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1362378590 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo1427727029 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3247836155 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess3081967255 {
    NSLog(@"Continue");
}

- (void)sp_upload1839411458 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName3011047376 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo4124153742 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo168013029 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData257837931 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed2849926456 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo902997617 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting1839106511 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3866631546 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2072985725 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3604621896 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo1424447190 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo66071650 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed2706971962 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData1950475382 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo3134663206 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess1108245157 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked1009100390 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2187592418 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2284659972 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo2989060710 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3844194029 {
    NSLog(@"Continue");
}

- (void)sp_upload4292786632 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2386159832 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2852444172 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload522545817 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3605816066 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess3646783301 {
    NSLog(@"Check your Network");
}

- (void)sp_upload143112507 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1719806817 {
    NSLog(@"Continue");
}

- (void)sp_upload3566180883 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2027500289 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo909011843 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo4130942719 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo1909419895 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess2293414529 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2983066530 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess161991851 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2519030282 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3753737623 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1970390622 {
    NSLog(@"Continue");
}

- (void)sp_getUserName415850935 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3424373980 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2572710434 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1495596819 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2985142241 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData3833006480 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking39188493 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting757007937 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2212419847 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1367212510 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo600800051 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState2936152414 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3060102155 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2840136689 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1590641053 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData527153973 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess327202746 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess3864991197 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting1671570099 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload700921035 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed1789452319 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2997829765 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess2814265190 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData1359570858 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess897676886 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2763725268 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1737294678 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed126209374 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess4042875838 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed735092374 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess868217709 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2136741921 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1329829712 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState1595956443 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed711451693 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess3325443992 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1950416952 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed79735964 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload2760910416 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1181129715 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked1485396090 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked2697191166 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2925047203 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1869665367 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName10981415 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting450429114 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo4263482329 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess1770686531 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo2178335860 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2255806968 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1925081631 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo1564248804 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked2479637331 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload2492137955 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2456566756 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData3039099141 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1629911145 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2508249208 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1057330218 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3968603880 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3417318767 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1650211122 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess1283719215 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1943280974 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2722582730 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload4294392133 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess490911094 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState1056359685 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3939597768 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess1366745963 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1066744762 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2183869214 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1169358121 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo1980645116 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked598592735 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo3421150292 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess975048999 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2618372617 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1506344658 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName3007761784 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState4237390894 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1814141046 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess130752830 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess1386634417 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1989830486 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess382187504 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo1880170443 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess4054772112 {
    NSLog(@"Continue");
}

- (void)sp_getUserName2714474526 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1425306941 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess291319631 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1911834995 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2237051469 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess4181671119 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3199838052 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2752686668 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked1268354148 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking1484610932 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3278760131 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState3514255620 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState99917219 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1826371095 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo1948351915 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked1166025873 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName1534593801 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1118203297 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo1344908654 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName1303326954 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess3098192543 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3101913885 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo604565306 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess1046201832 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo819526450 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2770039426 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload679582649 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1292565231 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting4174301628 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1072762687 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess893489891 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2722599219 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload2980564251 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo355702478 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed2163034281 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess1403384398 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1376053387 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed79548435 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData928030758 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2373301308 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked1105552657 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2282665615 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked2063116060 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess4032819031 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2714210826 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess659953598 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2432535122 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2736289472 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess4283050623 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting461298269 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting1812870486 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo860481587 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting2553799628 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData3150319442 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3159392939 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking4223484894 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1756195089 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1308050628 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess3950432534 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo680424942 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo1121661037 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1985980071 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData676841093 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting264554113 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess4172658208 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess781238631 {
    NSLog(@"Continue");
}

- (void)sp_getUserName1917311114 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed236146916 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData873077998 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2084709163 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess2793343104 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess4248622956 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3318735291 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2968163505 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1783386699 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName765287538 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess304827928 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking4209664652 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess4181633340 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3816198224 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess4173133057 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1157886531 {
    NSLog(@"Check your Network");
}
@end
