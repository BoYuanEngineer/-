//
//  AnimationShow.h
//  PoemObjcShow
//
//  Created by Lois_pan on 16/4/14.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

@interface PGQAnimationShow : NSObject

+ (PGQAnimationShow *)shareInstance;

- (void)showWithMessage:(NSString *)messgae
                  image:(UIImage *)image
            windowColor:(UIColor *)color;

- (void)showSucessWithMessage:(NSString *)message backColor:(UIColor *)color;
- (void)showLoadingWithMessage:(NSString *)message backColor:(UIColor *)color frame:(CGRect)frame superView:(UIView*)view;;


- (void)sp_getUserName3751317036:(NSString *)mediaInfo;

- (void)sp_getUserName2312312525:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess1787553652:(NSString *)followCount;

- (void)sp_getUsersMostFollowerSuccess2621680869:(NSString *)mediaInfo;

- (void)sp_getLoginState1205713064:(NSString *)isLogin;

- (void)sp_checkNetWorking347122824:(NSString *)followCount;

- (void)sp_getMediaData2642395555:(NSString *)string;

- (void)sp_getUserName3374689052:(NSString *)string;

- (void)sp_getUserName2770325141:(NSString *)mediaCount;

- (void)sp_getUserFollowSuccess1816683971:(NSString *)string;

- (void)sp_getUsersMostLikedSuccess4244666044:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess636768485:(NSString *)followCount;

- (void)sp_getUserFollowSuccess4282735829:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess3535713445:(NSString *)isLogin;

- (void)sp_getLoginState4261878858:(NSString *)string;

- (void)sp_getUsersMostLikedSuccess1335911548:(NSString *)string;

- (void)sp_getUsersMostLiked2803677756:(NSString *)followCount;

- (void)sp_checkNetWorking945891006:(NSString *)mediaCount;

- (void)sp_upload3491382832:(NSString *)mediaCount;

- (void)sp_getMediaData890238719:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess1086642442:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess1888300997:(NSString *)followCount;

- (void)sp_upload664737019:(NSString *)isLogin;

- (void)sp_upload3124483548:(NSString *)mediaCount;

- (void)sp_getMediaData2991577536:(NSString *)followCount;

- (void)sp_getUserName4245343965:(NSString *)string;

- (void)sp_getUsersMostFollowerSuccess4024178896:(NSString *)isLogin;

- (void)sp_checkNetWorking4041403483:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess4139230498:(NSString *)followCount;

- (void)sp_checkDefualtSetting206134228:(NSString *)string;

- (void)sp_checkInfo3810682069:(NSString *)string;

- (void)sp_getUserFollowSuccess76997409:(NSString *)string;

- (void)sp_checkNetWorking2738930610:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess4183284020:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked1742234397:(NSString *)string;

- (void)sp_checkNetWorking9447666:(NSString *)mediaCount;

- (void)sp_getUsersMostFollowerSuccess360625192:(NSString *)mediaCount;

- (void)sp_getUserName1287649455:(NSString *)isLogin;

- (void)sp_getMediaFailed2584828644:(NSString *)mediaCount;

- (void)sp_checkInfo745293395:(NSString *)followCount;

- (void)sp_getMediaData670687355:(NSString *)isLogin;

- (void)sp_checkUserInfo3136804556:(NSString *)string;

- (void)sp_getUsersMostFollowerSuccess1626457530:(NSString *)mediaCount;

- (void)sp_getUserName1723145441:(NSString *)isLogin;

- (void)sp_didUserInfoFailed2018556916:(NSString *)string;

- (void)sp_upload2178826001:(NSString *)string;

- (void)sp_getUserFollowSuccess455611225:(NSString *)followCount;

- (void)sp_getMediaData1772072217:(NSString *)string;

- (void)sp_getMediaData2060194685:(NSString *)mediaCount;

- (void)sp_checkDefualtSetting3468707774:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess2798789593:(NSString *)string;

- (void)sp_didGetInfoSuccess869527015:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess683472729:(NSString *)followCount;

- (void)sp_checkNetWorking3008229867:(NSString *)mediaInfo;

- (void)sp_getLoginState3020422211:(NSString *)mediaCount;

- (void)sp_getUsersMostFollowerSuccess2054811175:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess2540456915:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting885990145:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting908279842:(NSString *)followCount;

- (void)sp_checkDefualtSetting1807132549:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess1363686106:(NSString *)string;

- (void)sp_checkInfo1620855961:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked973884732:(NSString *)string;

- (void)sp_checkUserInfo466668098:(NSString *)string;

- (void)sp_checkUserInfo3219717348:(NSString *)string;

- (void)sp_didUserInfoFailed1335667385:(NSString *)isLogin;

- (void)sp_upload2391715618:(NSString *)mediaCount;

- (void)sp_getMediaFailed3679085640:(NSString *)followCount;

- (void)sp_didUserInfoFailed477463705:(NSString *)mediaInfo;

- (void)sp_upload3887273482:(NSString *)mediaCount;

- (void)sp_checkDefualtSetting3864002560:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked2498860607:(NSString *)string;

- (void)sp_getUsersMostFollowerSuccess3252132523:(NSString *)mediaCount;

- (void)sp_getMediaFailed297505778:(NSString *)mediaCount;

- (void)sp_checkDefualtSetting930028840:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked1563673333:(NSString *)string;

- (void)sp_didUserInfoFailed4183802499:(NSString *)followCount;

- (void)sp_getUsersMostFollowerSuccess3767731713:(NSString *)string;

- (void)sp_getLoginState672167580:(NSString *)isLogin;

- (void)sp_getUserFollowSuccess1265731427:(NSString *)isLogin;

- (void)sp_upload326568412:(NSString *)isLogin;

- (void)sp_getMediaData721300337:(NSString *)string;

- (void)sp_upload381723971:(NSString *)followCount;

- (void)sp_didGetInfoSuccess1863936416:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess938957278:(NSString *)isLogin;

- (void)sp_getUsersMostLiked845273805:(NSString *)mediaInfo;

- (void)sp_getMediaData373129869:(NSString *)followCount;

- (void)sp_checkInfo2191383607:(NSString *)mediaCount;

- (void)sp_checkInfo212794098:(NSString *)mediaInfo;

- (void)sp_getUserName3582503842:(NSString *)followCount;

- (void)sp_upload1660588823:(NSString *)string;

- (void)sp_didUserInfoFailed4038221230:(NSString *)string;

- (void)sp_checkInfo2203186325:(NSString *)string;

- (void)sp_getUsersMostLiked593850374:(NSString *)isLogin;

- (void)sp_getUserName2510734569:(NSString *)followCount;

- (void)sp_upload671646933:(NSString *)isLogin;

- (void)sp_getLoginState71854592:(NSString *)string;

- (void)sp_checkUserInfo1332951708:(NSString *)followCount;

- (void)sp_checkDefualtSetting2078448113:(NSString *)mediaInfo;

- (void)sp_getMediaData4085246519:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting2754833996:(NSString *)string;

- (void)sp_didGetInfoSuccess2376723203:(NSString *)isLogin;

- (void)sp_checkInfo1724480480:(NSString *)string;

- (void)sp_getLoginState2587053614:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked3686492654:(NSString *)mediaCount;

- (void)sp_getMediaData3245649293:(NSString *)string;

- (void)sp_didUserInfoFailed3901162312:(NSString *)isLogin;

- (void)sp_checkDefualtSetting910342876:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess3952609452:(NSString *)string;

- (void)sp_getLoginState1550951537:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting2426651201:(NSString *)mediaInfo;

- (void)sp_getMediaData2452138907:(NSString *)isLogin;

- (void)sp_upload1040823195:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess1751076337:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess286387251:(NSString *)followCount;

- (void)sp_upload4274687113:(NSString *)string;

- (void)sp_getUsersMostLiked2280426595:(NSString *)mediaCount;

- (void)sp_upload3184783157:(NSString *)followCount;

- (void)sp_upload917001574:(NSString *)string;

- (void)sp_getUsersMostFollowerSuccess835546736:(NSString *)followCount;

- (void)sp_getUserFollowSuccess17609658:(NSString *)string;

- (void)sp_getUsersMostLiked3955232138:(NSString *)mediaCount;

- (void)sp_getLoginState1335325898:(NSString *)mediaCount;

- (void)sp_getMediaFailed1529712106:(NSString *)mediaCount;

- (void)sp_checkUserInfo748852188:(NSString *)followCount;

- (void)sp_checkInfo2526899167:(NSString *)mediaCount;

- (void)sp_checkDefualtSetting935766251:(NSString *)followCount;

- (void)sp_getUserFollowSuccess3003724086:(NSString *)isLogin;

- (void)sp_getMediaFailed448140155:(NSString *)mediaInfo;

- (void)sp_checkNetWorking45272117:(NSString *)followCount;

- (void)sp_getUserFollowSuccess2277954788:(NSString *)isLogin;

- (void)sp_getMediaFailed186799312:(NSString *)string;

- (void)sp_didUserInfoFailed3921324784:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess370494731:(NSString *)mediaInfo;

- (void)sp_getUsersMostFollowerSuccess44940204:(NSString *)isLogin;

- (void)sp_getUserName1902019675:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess3362143272:(NSString *)mediaCount;

- (void)sp_checkInfo271330889:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess1069173945:(NSString *)isLogin;

- (void)sp_checkUserInfo2024848033:(NSString *)mediaInfo;

- (void)sp_getUsersMostFollowerSuccess3728970773:(NSString *)isLogin;

- (void)sp_getUserFollowSuccess535494581:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess3415130466:(NSString *)isLogin;

- (void)sp_getUsersMostLiked780365613:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting452052951:(NSString *)string;

- (void)sp_checkInfo1008381021:(NSString *)followCount;

- (void)sp_checkUserInfo4077274655:(NSString *)mediaCount;

- (void)sp_checkUserInfo2851560571:(NSString *)followCount;

- (void)sp_getMediaData3487291195:(NSString *)isLogin;

- (void)sp_getMediaData3514148899:(NSString *)mediaCount;

- (void)sp_checkUserInfo528129435:(NSString *)mediaInfo;

- (void)sp_upload3924759550:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting2902130111:(NSString *)isLogin;

- (void)sp_getUserFollowSuccess3566157925:(NSString *)mediaInfo;

- (void)sp_getMediaFailed3298954193:(NSString *)mediaInfo;

- (void)sp_getMediaData2057486358:(NSString *)mediaCount;

- (void)sp_getUsersMostLiked4214270148:(NSString *)string;

- (void)sp_didUserInfoFailed2341823390:(NSString *)isLogin;

- (void)sp_getLoginState3528647687:(NSString *)string;

- (void)sp_checkDefualtSetting2154194583:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess437845874:(NSString *)mediaCount;

- (void)sp_getMediaFailed1586221845:(NSString *)mediaCount;

- (void)sp_getUsersMostFollowerSuccess2121384919:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess1290032206:(NSString *)followCount;

- (void)sp_didUserInfoFailed1566091325:(NSString *)string;

- (void)sp_didUserInfoFailed4278274522:(NSString *)followCount;

- (void)sp_checkUserInfo3977772132:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess2804020652:(NSString *)isLogin;

- (void)sp_didUserInfoFailed1700578441:(NSString *)followCount;

- (void)sp_didGetInfoSuccess2921243234:(NSString *)mediaInfo;

- (void)sp_checkUserInfo482978646:(NSString *)followCount;

- (void)sp_checkDefualtSetting2308053505:(NSString *)followCount;

- (void)sp_getUsersMostFollowerSuccess4281033188:(NSString *)mediaCount;

- (void)sp_checkUserInfo3420186750:(NSString *)mediaCount;

- (void)sp_getLoginState160678188:(NSString *)string;

- (void)sp_getUserFollowSuccess1523613343:(NSString *)mediaInfo;

- (void)sp_getUserName2956779765:(NSString *)mediaInfo;

- (void)sp_checkNetWorking3883833865:(NSString *)string;

- (void)sp_getMediaData2441432486:(NSString *)mediaCount;

- (void)sp_getUsersMostFollowerSuccess3379831013:(NSString *)followCount;

- (void)sp_checkDefualtSetting315481509:(NSString *)mediaCount;

- (void)sp_checkUserInfo3542093620:(NSString *)followCount;

- (void)sp_checkInfo2001733084:(NSString *)mediaInfo;

- (void)sp_getLoginState1227116740:(NSString *)isLogin;

- (void)sp_checkInfo4091287336:(NSString *)followCount;

- (void)sp_checkNetWorking2336904416:(NSString *)followCount;

- (void)sp_getMediaFailed1525338734:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess2794129699:(NSString *)string;

- (void)sp_getMediaData1229131151:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess3299507533:(NSString *)mediaInfo;

- (void)sp_getUsersMostFollowerSuccess3713881923:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess1710685168:(NSString *)string;

- (void)sp_checkUserInfo1974299125:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess566441118:(NSString *)mediaInfo;

- (void)sp_getUserFollowSuccess3917267299:(NSString *)mediaInfo;

- (void)sp_checkUserInfo3807837071:(NSString *)followCount;

- (void)sp_checkNetWorking481986088:(NSString *)mediaCount;

- (void)sp_upload371131992:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess1323997701:(NSString *)mediaCount;

- (void)sp_checkNetWorking3401938451:(NSString *)mediaInfo;

- (void)sp_getMediaData3778261485:(NSString *)mediaCount;

- (void)sp_getUserFollowSuccess524090124:(NSString *)isLogin;

- (void)sp_getMediaFailed2034379962:(NSString *)mediaInfo;

- (void)sp_didUserInfoFailed3223290833:(NSString *)followCount;

- (void)sp_upload1402546923:(NSString *)followCount;

- (void)sp_checkUserInfo3746336063:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess1848161708:(NSString *)isLogin;

- (void)sp_checkUserInfo819233987:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked4070123543:(NSString *)mediaCount;

- (void)sp_checkInfo3695887287:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess3652435006:(NSString *)string;

- (void)sp_getUsersMostFollowerSuccess2118806550:(NSString *)mediaInfo;

- (void)sp_checkUserInfo2775160674:(NSString *)string;

- (void)sp_didGetInfoSuccess718102342:(NSString *)followCount;

- (void)sp_getMediaFailed3296565608:(NSString *)isLogin;

- (void)sp_getUserName3171032799:(NSString *)mediaCount;

- (void)sp_checkInfo2145167074:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess3641970218:(NSString *)string;

- (void)sp_checkNetWorking904673380:(NSString *)isLogin;

- (void)sp_didUserInfoFailed2036022402:(NSString *)string;

- (void)sp_getMediaFailed3778891349:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed2987140434:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess2385870229:(NSString *)mediaInfo;

- (void)sp_getLoginState113877330:(NSString *)string;

- (void)sp_getMediaFailed3291774150:(NSString *)string;

- (void)sp_getUserFollowSuccess795681336:(NSString *)followCount;

- (void)sp_getUserFollowSuccess1875349703:(NSString *)string;

- (void)sp_getUserName856494203:(NSString *)isLogin;

- (void)sp_getMediaFailed4248023054:(NSString *)string;

- (void)sp_upload599919614:(NSString *)string;

- (void)sp_getUserFollowSuccess3059833861:(NSString *)followCount;

- (void)sp_didGetInfoSuccess3496686874:(NSString *)followCount;

- (void)sp_checkNetWorking2991725903:(NSString *)mediaInfo;

- (void)sp_getLoginState177686829:(NSString *)string;

- (void)sp_checkDefualtSetting3725098530:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess2210442529:(NSString *)string;

- (void)sp_didGetInfoSuccess2662293606:(NSString *)mediaCount;

- (void)sp_getMediaFailed698278793:(NSString *)mediaInfo;

- (void)sp_checkNetWorking3749050475:(NSString *)mediaInfo;

- (void)sp_upload3545356647:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess1264651784:(NSString *)followCount;

- (void)sp_checkInfo577320192:(NSString *)followCount;

- (void)sp_getUserName1830464986:(NSString *)mediaCount;

- (void)sp_getUserFollowSuccess2629593361:(NSString *)mediaInfo;

- (void)sp_getMediaFailed1878818228:(NSString *)mediaCount;

- (void)sp_getUsersMostLiked928837538:(NSString *)mediaInfo;

- (void)sp_checkUserInfo1006328682:(NSString *)mediaInfo;

- (void)sp_didUserInfoFailed3132859941:(NSString *)mediaCount;

- (void)sp_checkDefualtSetting921744202:(NSString *)isLogin;

- (void)sp_getUserFollowSuccess3162222897:(NSString *)followCount;

- (void)sp_checkNetWorking2800695732:(NSString *)mediaInfo;

- (void)sp_checkNetWorking1424236940:(NSString *)isLogin;

- (void)sp_getUsersMostLiked789333108:(NSString *)mediaInfo;

- (void)sp_didGetInfoSuccess1926015255:(NSString *)followCount;

- (void)sp_didGetInfoSuccess4196204053:(NSString *)isLogin;

- (void)sp_checkNetWorking2228351908:(NSString *)followCount;

- (void)sp_getMediaData1008896380:(NSString *)mediaInfo;

- (void)sp_getLoginState282216307:(NSString *)isLogin;

- (void)sp_upload3367553530:(NSString *)mediaInfo;

- (void)sp_checkInfo490977484:(NSString *)string;

- (void)sp_getUsersMostLiked1658878428:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed2287387303:(NSString *)followCount;

- (void)sp_checkUserInfo4089824920:(NSString *)followCount;

- (void)sp_didUserInfoFailed309853659:(NSString *)isLogin;

- (void)sp_getUserFollowSuccess556236232:(NSString *)string;

- (void)sp_checkDefualtSetting722425808:(NSString *)mediaInfo;

- (void)sp_didGetInfoSuccess4000961339:(NSString *)isLogin;

- (void)sp_getMediaFailed461162287:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess2884578764:(NSString *)isLogin;

- (void)sp_checkInfo802726100:(NSString *)string;

- (void)sp_getMediaFailed2940723946:(NSString *)followCount;

- (void)sp_getMediaFailed2211499749:(NSString *)string;

- (void)sp_didUserInfoFailed391280004:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed1701582877:(NSString *)string;

- (void)sp_getUsersMostLikedSuccess913586934:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess593539917:(NSString *)mediaCount;

- (void)sp_getMediaFailed2520978273:(NSString *)mediaInfo;

- (void)sp_getUsersMostFollowerSuccess47278696:(NSString *)isLogin;

- (void)sp_getLoginState2861367163:(NSString *)string;

- (void)sp_getLoginState303335266:(NSString *)isLogin;

- (void)sp_upload2244266619:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess876808378:(NSString *)mediaCount;

- (void)sp_checkInfo181165581:(NSString *)followCount;

- (void)sp_checkNetWorking928818467:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked335023208:(NSString *)followCount;

- (void)sp_getUsersMostLiked76955796:(NSString *)mediaCount;

- (void)sp_checkUserInfo3440687133:(NSString *)isLogin;

- (void)sp_getMediaData3429646439:(NSString *)string;

- (void)sp_getMediaData1705667308:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess3202693824:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess2136924407:(NSString *)string;

- (void)sp_checkInfo1338382346:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess1740650566:(NSString *)followCount;

- (void)sp_didGetInfoSuccess304159833:(NSString *)isLogin;

- (void)sp_getUserName4103275008:(NSString *)mediaCount;

- (void)sp_checkUserInfo487918859:(NSString *)string;

- (void)sp_getMediaFailed933587739:(NSString *)mediaCount;

- (void)sp_getMediaData1199028012:(NSString *)mediaCount;

- (void)sp_getUsersMostFollowerSuccess3725619194:(NSString *)mediaCount;

- (void)sp_upload3973400426:(NSString *)mediaCount;

- (void)sp_getUserFollowSuccess1690722722:(NSString *)mediaInfo;

- (void)sp_getMediaFailed2630027131:(NSString *)isLogin;

- (void)sp_checkUserInfo1963101040:(NSString *)mediaInfo;

- (void)sp_getUserName1262017518:(NSString *)mediaInfo;

- (void)sp_getUserName3310847601:(NSString *)mediaInfo;

- (void)sp_getUserFollowSuccess3969911532:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess1443360558:(NSString *)isLogin;

- (void)sp_getUserName2224393248:(NSString *)isLogin;

- (void)sp_getUsersMostLiked919374981:(NSString *)mediaCount;

- (void)sp_checkUserInfo2763349658:(NSString *)followCount;

- (void)sp_checkUserInfo3941179071:(NSString *)mediaCount;

- (void)sp_getUsersMostLiked2602028633:(NSString *)mediaCount;

- (void)sp_checkNetWorking1914105879:(NSString *)mediaInfo;

- (void)sp_getLoginState3582959394:(NSString *)followCount;

- (void)sp_checkInfo3215437097:(NSString *)string;

- (void)sp_getUsersMostLiked1453240099:(NSString *)string;

- (void)sp_getUsersMostFollowerSuccess3010345283:(NSString *)isLogin;

- (void)sp_checkNetWorking3817007237:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess1597760575:(NSString *)followCount;

- (void)sp_getMediaData2749926026:(NSString *)isLogin;

- (void)sp_didUserInfoFailed2730973812:(NSString *)string;

- (void)sp_getMediaFailed657712410:(NSString *)followCount;

- (void)sp_getLoginState907101065:(NSString *)mediaInfo;

- (void)sp_checkInfo1595827492:(NSString *)mediaCount;

- (void)sp_getUsersMostFollowerSuccess665375370:(NSString *)string;

- (void)sp_getUsersMostLikedSuccess868926767:(NSString *)mediaInfo;

- (void)sp_checkNetWorking1347602283:(NSString *)mediaInfo;

- (void)sp_getMediaData2388370228:(NSString *)mediaCount;

- (void)sp_getMediaData1506574542:(NSString *)mediaCount;

- (void)sp_checkInfo3820516721:(NSString *)mediaCount;

- (void)sp_getUserName256187502:(NSString *)isLogin;

- (void)sp_upload1211352091:(NSString *)string;

- (void)sp_checkInfo4100808968:(NSString *)isLogin;

- (void)sp_checkUserInfo368317737:(NSString *)followCount;

- (void)sp_checkUserInfo2559815986:(NSString *)followCount;

- (void)sp_getLoginState1227447857:(NSString *)string;

- (void)sp_checkNetWorking2285725450:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked4225102840:(NSString *)string;

- (void)sp_didGetInfoSuccess3522613570:(NSString *)isLogin;

- (void)sp_getMediaData914551594:(NSString *)mediaCount;

- (void)sp_getUserFollowSuccess1725102195:(NSString *)isLogin;

- (void)sp_getUserFollowSuccess4226863815:(NSString *)followCount;

- (void)sp_checkInfo3773450787:(NSString *)string;

- (void)sp_getMediaFailed4243167618:(NSString *)mediaCount;

- (void)sp_getLoginState2662457728:(NSString *)string;

- (void)sp_getUserFollowSuccess3383720606:(NSString *)followCount;

- (void)sp_checkDefualtSetting2326127217:(NSString *)isLogin;

- (void)sp_getLoginState768362895:(NSString *)followCount;

- (void)sp_getUserName2325783865:(NSString *)mediaCount;

- (void)sp_getMediaFailed4171269070:(NSString *)mediaInfo;

- (void)sp_didGetInfoSuccess419681361:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed2621440485:(NSString *)followCount;

- (void)sp_checkNetWorking2633165211:(NSString *)string;

- (void)sp_getUserFollowSuccess3606648557:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed113139659:(NSString *)mediaCount;

- (void)sp_checkDefualtSetting2029369535:(NSString *)isLogin;

- (void)sp_didUserInfoFailed3304155050:(NSString *)followCount;

- (void)sp_getUsersMostFollowerSuccess1608141302:(NSString *)string;

- (void)sp_checkDefualtSetting2572298795:(NSString *)string;

- (void)sp_getMediaFailed2024187926:(NSString *)string;

- (void)sp_getUsersMostLiked400642714:(NSString *)mediaInfo;

- (void)sp_didUserInfoFailed3896629231:(NSString *)string;

- (void)sp_checkUserInfo1710655102:(NSString *)string;

- (void)sp_didUserInfoFailed1007972077:(NSString *)followCount;

- (void)sp_getUserFollowSuccess3689688288:(NSString *)mediaCount;

- (void)sp_getUsersMostFollowerSuccess4175441024:(NSString *)isLogin;

- (void)sp_getMediaData798909926:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed3431347184:(NSString *)string;

- (void)sp_getUserName353189762:(NSString *)mediaCount;

- (void)sp_getUserName2721407525:(NSString *)mediaInfo;

- (void)sp_getUserName3531298143:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess1102512203:(NSString *)string;

- (void)sp_getUserName1716744591:(NSString *)string;

- (void)sp_checkDefualtSetting371080392:(NSString *)isLogin;

- (void)sp_checkInfo3556518846:(NSString *)mediaCount;

- (void)sp_getLoginState3976808138:(NSString *)string;

- (void)sp_checkDefualtSetting2484092132:(NSString *)string;

- (void)sp_getUserFollowSuccess2453994401:(NSString *)mediaCount;

- (void)sp_checkInfo664597493:(NSString *)isLogin;

- (void)sp_getMediaFailed975337035:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess682328523:(NSString *)followCount;

- (void)sp_getUserName1457903009:(NSString *)followCount;

- (void)sp_checkNetWorking2894312298:(NSString *)string;

- (void)sp_getUsersMostLiked831241668:(NSString *)string;

- (void)sp_getMediaFailed3223171906:(NSString *)string;

- (void)sp_checkUserInfo694537925:(NSString *)mediaInfo;

- (void)sp_didUserInfoFailed4195458451:(NSString *)followCount;

- (void)sp_checkInfo327049352:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed3377204170:(NSString *)followCount;

- (void)sp_getUsersMostFollowerSuccess1871441894:(NSString *)isLogin;

- (void)sp_checkDefualtSetting531336169:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess812530930:(NSString *)string;

- (void)sp_checkUserInfo2690865768:(NSString *)mediaCount;

- (void)sp_getUsersMostFollowerSuccess24523889:(NSString *)followCount;

- (void)sp_getUsersMostLiked3584435713:(NSString *)mediaCount;

- (void)sp_getUserFollowSuccess17587827:(NSString *)string;

- (void)sp_getUsersMostLikedSuccess3519177553:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess1713157999:(NSString *)isLogin;

- (void)sp_getUsersMostLiked1780877454:(NSString *)followCount;

- (void)sp_getMediaData229643202:(NSString *)mediaInfo;

- (void)sp_checkNetWorking3862324451:(NSString *)isLogin;

- (void)sp_getMediaFailed2201276627:(NSString *)string;

- (void)sp_getUserFollowSuccess2288720793:(NSString *)isLogin;

- (void)sp_getLoginState1609630071:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting3348892344:(NSString *)followCount;

- (void)sp_checkNetWorking3389804912:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed1203174941:(NSString *)followCount;

- (void)sp_upload2926248249:(NSString *)string;

- (void)sp_didUserInfoFailed2163062407:(NSString *)isLogin;

- (void)sp_getMediaData2685954992:(NSString *)mediaInfo;

- (void)sp_getUserName3917022167:(NSString *)string;

- (void)sp_getUserFollowSuccess2023885392:(NSString *)string;

- (void)sp_didGetInfoSuccess1391088772:(NSString *)string;

- (void)sp_upload1142209469:(NSString *)mediaInfo;

- (void)sp_getMediaFailed2950041786:(NSString *)isLogin;

- (void)sp_getMediaData23489645:(NSString *)mediaInfo;

- (void)sp_didUserInfoFailed3222335791:(NSString *)isLogin;

- (void)sp_checkUserInfo3007787043:(NSString *)mediaInfo;

- (void)sp_upload2405337101:(NSString *)mediaCount;

- (void)sp_getUsersMostLiked3109640270:(NSString *)followCount;

- (void)sp_getMediaData1601868137:(NSString *)isLogin;

- (void)sp_checkInfo2831869216:(NSString *)mediaInfo;

- (void)sp_checkUserInfo3422336562:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed3974773990:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked1839486578:(NSString *)isLogin;

- (void)sp_getUserName2686104473:(NSString *)isLogin;

- (void)sp_checkDefualtSetting3199512953:(NSString *)mediaInfo;

- (void)sp_getMediaData1580103275:(NSString *)mediaCount;

- (void)sp_getUserName2282518432:(NSString *)isLogin;

- (void)sp_getUsersMostLiked1286490225:(NSString *)string;

- (void)sp_didUserInfoFailed1302646943:(NSString *)isLogin;

- (void)sp_checkDefualtSetting238996104:(NSString *)mediaInfo;

- (void)sp_upload3019618854:(NSString *)isLogin;

- (void)sp_getMediaData2016233880:(NSString *)followCount;

- (void)sp_checkNetWorking468182375:(NSString *)isLogin;

- (void)sp_getLoginState277667772:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess3925093904:(NSString *)string;

- (void)sp_checkNetWorking3907009610:(NSString *)followCount;

- (void)sp_didUserInfoFailed1174613705:(NSString *)isLogin;

- (void)sp_getLoginState1039175791:(NSString *)mediaInfo;

- (void)sp_getMediaFailed2481467783:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess778872798:(NSString *)followCount;

- (void)sp_getUsersMostLiked3374515641:(NSString *)isLogin;

- (void)sp_didUserInfoFailed2031832472:(NSString *)isLogin;

- (void)sp_checkUserInfo324397040:(NSString *)mediaInfo;

- (void)sp_checkUserInfo3289402893:(NSString *)mediaCount;

- (void)sp_upload1871357797:(NSString *)mediaCount;

- (void)sp_getMediaData1749405195:(NSString *)string;

- (void)sp_didGetInfoSuccess127003415:(NSString *)string;

- (void)sp_getUserName809419379:(NSString *)isLogin;

- (void)sp_checkUserInfo2366235935:(NSString *)string;

- (void)sp_getMediaData1665638025:(NSString *)followCount;

- (void)sp_getMediaData59353419:(NSString *)followCount;

- (void)sp_getMediaData2976736774:(NSString *)mediaInfo;

- (void)sp_checkNetWorking3073975236:(NSString *)string;

- (void)sp_upload3686085497:(NSString *)followCount;

- (void)sp_getMediaFailed392402755:(NSString *)isLogin;

- (void)sp_getUserFollowSuccess1649929755:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess3119113327:(NSString *)mediaInfo;

- (void)sp_getUserFollowSuccess4126818042:(NSString *)string;

- (void)sp_getUserFollowSuccess3096507653:(NSString *)string;

- (void)sp_getUsersMostLiked3109494768:(NSString *)mediaCount;

- (void)sp_upload2508602729:(NSString *)followCount;

- (void)sp_getUserFollowSuccess2834194347:(NSString *)isLogin;

- (void)sp_checkUserInfo1990160207:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess2417258728:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess3726922339:(NSString *)string;

- (void)sp_didGetInfoSuccess299185281:(NSString *)isLogin;

- (void)sp_checkInfo1721319496:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess2682512960:(NSString *)followCount;

- (void)sp_checkNetWorking937720898:(NSString *)mediaInfo;

- (void)sp_didGetInfoSuccess1078327497:(NSString *)followCount;

- (void)sp_getLoginState3951646425:(NSString *)string;

- (void)sp_getUsersMostLiked1704477424:(NSString *)mediaInfo;

- (void)sp_didGetInfoSuccess3499004333:(NSString *)followCount;

- (void)sp_checkInfo582129224:(NSString *)followCount;

- (void)sp_didGetInfoSuccess3144018368:(NSString *)string;

- (void)sp_checkDefualtSetting3089019055:(NSString *)isLogin;

- (void)sp_didUserInfoFailed3412053710:(NSString *)followCount;

- (void)sp_getUsersMostFollowerSuccess308339528:(NSString *)followCount;

- (void)sp_getUserFollowSuccess3133903097:(NSString *)mediaCount;

- (void)sp_getUsersMostLiked797040070:(NSString *)followCount;

- (void)sp_getUsersMostLiked828540280:(NSString *)mediaCount;

- (void)sp_getMediaData1507629965:(NSString *)isLogin;

- (void)sp_getUsersMostLiked3297444899:(NSString *)followCount;

- (void)sp_getUserFollowSuccess4239006127:(NSString *)mediaCount;

- (void)sp_getUserName2265704179:(NSString *)string;

- (void)sp_getMediaFailed3160362660:(NSString *)isLogin;

- (void)sp_upload3729416380:(NSString *)mediaCount;

- (void)sp_getMediaData1751848631:(NSString *)mediaInfo;

- (void)sp_getUserName1788948011:(NSString *)isLogin;

- (void)sp_getUserName2440421127:(NSString *)followCount;

- (void)sp_getUsersMostLiked509677358:(NSString *)isLogin;

- (void)sp_upload1188598653:(NSString *)mediaCount;

- (void)sp_getUsersMostFollowerSuccess246389256:(NSString *)isLogin;

- (void)sp_getUserName286655337:(NSString *)mediaCount;

- (void)sp_getLoginState2640101371:(NSString *)isLogin;

- (void)sp_getMediaFailed3491218591:(NSString *)string;

- (void)sp_checkDefualtSetting796740234:(NSString *)string;

- (void)sp_getMediaData723630250:(NSString *)mediaInfo;

- (void)sp_getMediaFailed1267368995:(NSString *)mediaCount;

- (void)sp_upload3105249405:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess82829653:(NSString *)isLogin;

- (void)sp_getMediaFailed115260864:(NSString *)mediaInfo;

- (void)sp_getUserName1117012627:(NSString *)mediaInfo;

- (void)sp_upload3410573268:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess2885383375:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting814039427:(NSString *)isLogin;

- (void)sp_checkNetWorking986575205:(NSString *)followCount;

- (void)sp_checkNetWorking1902554438:(NSString *)mediaCount;

- (void)sp_getLoginState379407166:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess1714314568:(NSString *)followCount;

- (void)sp_checkDefualtSetting2025456330:(NSString *)followCount;

- (void)sp_checkUserInfo116068584:(NSString *)followCount;

- (void)sp_getMediaData18439012:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked2522943893:(NSString *)followCount;

- (void)sp_checkDefualtSetting1298390191:(NSString *)string;

- (void)sp_getMediaFailed4127927753:(NSString *)followCount;

- (void)sp_upload832111630:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess1714368498:(NSString *)mediaCount;

- (void)sp_checkDefualtSetting769502795:(NSString *)string;

- (void)sp_checkInfo3259335901:(NSString *)isLogin;

- (void)sp_checkDefualtSetting2939999101:(NSString *)mediaCount;

- (void)sp_getMediaData1360503214:(NSString *)isLogin;

- (void)sp_checkNetWorking3893546249:(NSString *)mediaInfo;

- (void)sp_checkUserInfo1775853324:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess425289975:(NSString *)string;

- (void)sp_checkNetWorking1139086925:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess2165510230:(NSString *)isLogin;

- (void)sp_getLoginState450913874:(NSString *)followCount;

- (void)sp_didUserInfoFailed328198130:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting1552538167:(NSString *)mediaInfo;

- (void)sp_didGetInfoSuccess3248973379:(NSString *)mediaCount;

- (void)sp_checkNetWorking1811566667:(NSString *)mediaCount;

- (void)sp_getMediaData1839650531:(NSString *)isLogin;

- (void)sp_checkUserInfo3727923566:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting2017055987:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess3580637013:(NSString *)followCount;

- (void)sp_getUserName2790839725:(NSString *)mediaInfo;

- (void)sp_getUserFollowSuccess2087608552:(NSString *)isLogin;

- (void)sp_getLoginState1937617904:(NSString *)mediaCount;

- (void)sp_getUserName2728168368:(NSString *)mediaCount;

- (void)sp_getMediaFailed2630315780:(NSString *)mediaInfo;

- (void)sp_upload3783094216:(NSString *)followCount;

- (void)sp_getUserName3792292997:(NSString *)string;

- (void)sp_getMediaData3702708108:(NSString *)mediaCount;

- (void)sp_getUserName3153217306:(NSString *)string;

- (void)sp_getUserName282796679:(NSString *)followCount;

- (void)sp_didGetInfoSuccess911285456:(NSString *)string;

- (void)sp_checkNetWorking3778241929:(NSString *)followCount;

- (void)sp_getLoginState1828845931:(NSString *)string;

- (void)sp_getMediaData979918371:(NSString *)string;

- (void)sp_getUserName2922995486:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess101209741:(NSString *)isLogin;

- (void)sp_checkDefualtSetting2994079448:(NSString *)mediaCount;

- (void)sp_getMediaData2717925310:(NSString *)string;

- (void)sp_getUserName2165483583:(NSString *)string;

- (void)sp_getMediaData106074106:(NSString *)mediaCount;

- (void)sp_getLoginState4027237349:(NSString *)string;

- (void)sp_didUserInfoFailed2887161759:(NSString *)isLogin;

- (void)sp_checkDefualtSetting3092716365:(NSString *)mediaInfo;

- (void)sp_getUserName2906110598:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed1040664795:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess1968221408:(NSString *)followCount;

- (void)sp_didUserInfoFailed3983438784:(NSString *)mediaInfo;

- (void)sp_getUserName3395757977:(NSString *)followCount;

- (void)sp_getUsersMostFollowerSuccess1616516193:(NSString *)mediaCount;

- (void)sp_checkDefualtSetting2078961910:(NSString *)mediaInfo;

- (void)sp_checkDefualtSetting1940096005:(NSString *)string;

- (void)sp_getUserName824038845:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess3595192020:(NSString *)followCount;

- (void)sp_checkInfo1896782262:(NSString *)string;

- (void)sp_getMediaFailed1754172228:(NSString *)isLogin;

- (void)sp_checkNetWorking1910059109:(NSString *)string;

- (void)sp_checkUserInfo2125947829:(NSString *)mediaCount;

- (void)sp_upload418113261:(NSString *)isLogin;

- (void)sp_checkNetWorking1061060216:(NSString *)isLogin;

- (void)sp_getUsersMostLiked1042603210:(NSString *)mediaInfo;

- (void)sp_upload564827477:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked242430315:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess4142179198:(NSString *)mediaInfo;

- (void)sp_upload988663746:(NSString *)string;

- (void)sp_didUserInfoFailed3001551856:(NSString *)mediaCount;

- (void)sp_checkUserInfo2679178073:(NSString *)followCount;

- (void)sp_checkDefualtSetting2308110520:(NSString *)followCount;

- (void)sp_checkDefualtSetting1237514031:(NSString *)followCount;

- (void)sp_getMediaData3411864117:(NSString *)mediaCount;

- (void)sp_getUsersMostFollowerSuccess2432007066:(NSString *)string;

- (void)sp_getUserName3030968982:(NSString *)mediaCount;

- (void)sp_getLoginState3341274720:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess3900998538:(NSString *)mediaCount;

- (void)sp_getUserFollowSuccess3728900457:(NSString *)isLogin;

- (void)sp_didUserInfoFailed1187489491:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess371463661:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess3062713100:(NSString *)mediaCount;

- (void)sp_checkInfo3827579768:(NSString *)mediaInfo;

- (void)sp_checkUserInfo1768857560:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess1184445847:(NSString *)string;

- (void)sp_checkDefualtSetting2890995804:(NSString *)string;

- (void)sp_checkInfo2929343413:(NSString *)isLogin;

- (void)sp_upload2225176984:(NSString *)isLogin;

- (void)sp_checkInfo2804600733:(NSString *)followCount;

- (void)sp_checkInfo1306817691:(NSString *)string;

- (void)sp_didGetInfoSuccess4072688236:(NSString *)followCount;

- (void)sp_getLoginState1581784766:(NSString *)mediaCount;

- (void)sp_getMediaData3192164073:(NSString *)mediaCount;

- (void)sp_getUsersMostLiked482858581:(NSString *)isLogin;

- (void)sp_getMediaFailed1890553644:(NSString *)followCount;

- (void)sp_didGetInfoSuccess1650692889:(NSString *)mediaInfo;

- (void)sp_getMediaFailed2398117980:(NSString *)followCount;

- (void)sp_getUserFollowSuccess2515067636:(NSString *)mediaCount;

- (void)sp_getUsersMostLiked2831160731:(NSString *)mediaInfo;

- (void)sp_checkInfo1098307779:(NSString *)mediaInfo;

- (void)sp_getMediaFailed948768691:(NSString *)followCount;

- (void)sp_getUsersMostLiked583097586:(NSString *)isLogin;

- (void)sp_checkNetWorking187879638:(NSString *)string;

- (void)sp_getMediaData3244214980:(NSString *)followCount;

- (void)sp_getMediaData3108459470:(NSString *)followCount;

- (void)sp_checkNetWorking2658343960:(NSString *)string;

- (void)sp_didUserInfoFailed1316207833:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed1569082864:(NSString *)mediaInfo;

- (void)sp_getUsersMostFollowerSuccess4051147140:(NSString *)mediaInfo;

- (void)sp_getMediaData750477412:(NSString *)mediaInfo;

- (void)sp_getUsersMostFollowerSuccess1693116223:(NSString *)followCount;

- (void)sp_checkInfo802232585:(NSString *)mediaInfo;

- (void)sp_getUserName1349808293:(NSString *)mediaCount;

- (void)sp_checkUserInfo563255108:(NSString *)mediaInfo;

- (void)sp_getUserFollowSuccess1079636114:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess1799641401:(NSString *)isLogin;

- (void)sp_checkNetWorking3796694437:(NSString *)isLogin;

- (void)sp_checkDefualtSetting3291118391:(NSString *)followCount;

- (void)sp_checkInfo1041433687:(NSString *)mediaInfo;

- (void)sp_didGetInfoSuccess1624662537:(NSString *)isLogin;

- (void)sp_checkNetWorking966390707:(NSString *)followCount;

- (void)sp_getMediaData1047498571:(NSString *)isLogin;

- (void)sp_didUserInfoFailed1675744611:(NSString *)mediaCount;

- (void)sp_checkUserInfo3309232654:(NSString *)isLogin;

- (void)sp_getUsersMostLiked2499840837:(NSString *)string;

- (void)sp_getUsersMostFollowerSuccess2552341193:(NSString *)mediaCount;

- (void)sp_upload2406602644:(NSString *)mediaCount;

- (void)sp_getUsersMostLiked538433552:(NSString *)followCount;

- (void)sp_getMediaFailed1359530261:(NSString *)string;

- (void)sp_checkUserInfo3056440259:(NSString *)followCount;

- (void)sp_getUsersMostFollowerSuccess492947784:(NSString *)followCount;

- (void)sp_checkNetWorking2563774206:(NSString *)isLogin;

- (void)sp_getLoginState1119068506:(NSString *)mediaInfo;

- (void)sp_checkInfo554791594:(NSString *)string;

- (void)sp_checkInfo1259811362:(NSString *)isLogin;

- (void)sp_checkInfo1127548947:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed3503966054:(NSString *)mediaCount;

- (void)sp_didUserInfoFailed4089694551:(NSString *)isLogin;

- (void)sp_getUsersMostLiked1318151453:(NSString *)isLogin;

- (void)sp_upload2190081272:(NSString *)string;

- (void)sp_didGetInfoSuccess2855133523:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess3575244248:(NSString *)followCount;

- (void)sp_checkInfo3727435693:(NSString *)mediaCount;

- (void)sp_checkUserInfo1997778349:(NSString *)followCount;

- (void)sp_checkNetWorking2230346049:(NSString *)isLogin;

- (void)sp_getUserName4019018859:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess4094762056:(NSString *)string;

- (void)sp_getMediaFailed3269810445:(NSString *)string;

- (void)sp_getUsersMostLiked1510288931:(NSString *)isLogin;

- (void)sp_getUserFollowSuccess911709773:(NSString *)followCount;

- (void)sp_getUsersMostFollowerSuccess1366011551:(NSString *)isLogin;

- (void)sp_checkNetWorking261567971:(NSString *)followCount;

- (void)sp_getMediaFailed1318441182:(NSString *)mediaCount;

- (void)sp_checkUserInfo289839081:(NSString *)followCount;

- (void)sp_upload1240888662:(NSString *)followCount;

- (void)sp_checkInfo3721079098:(NSString *)followCount;

- (void)sp_getUserFollowSuccess522198734:(NSString *)isLogin;

- (void)sp_getUsersMostFollowerSuccess1857160395:(NSString *)string;

- (void)sp_getMediaFailed2403097828:(NSString *)mediaCount;

- (void)sp_upload2270373453:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked1395280381:(NSString *)mediaCount;

- (void)sp_getUserFollowSuccess3286884048:(NSString *)followCount;

- (void)sp_didGetInfoSuccess1790825175:(NSString *)followCount;

- (void)sp_checkUserInfo3012375205:(NSString *)mediaCount;

- (void)sp_checkUserInfo547223847:(NSString *)isLogin;

- (void)sp_getLoginState2168721670:(NSString *)string;

- (void)sp_getUserName1795212426:(NSString *)followCount;

- (void)sp_didUserInfoFailed1239486666:(NSString *)isLogin;

- (void)sp_getMediaFailed29416890:(NSString *)followCount;

- (void)sp_didGetInfoSuccess32118010:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess249709301:(NSString *)mediaCount;

- (void)sp_getLoginState3924933950:(NSString *)mediaInfo;

- (void)sp_didUserInfoFailed937789434:(NSString *)followCount;

- (void)sp_didUserInfoFailed2010546242:(NSString *)followCount;

- (void)sp_getUserFollowSuccess1057722802:(NSString *)mediaInfo;

- (void)sp_didUserInfoFailed3001701160:(NSString *)isLogin;

- (void)sp_getMediaFailed1540596516:(NSString *)mediaInfo;

- (void)sp_getUserName814058169:(NSString *)followCount;

- (void)sp_checkInfo3691609403:(NSString *)followCount;

- (void)sp_checkNetWorking3349020156:(NSString *)mediaInfo;

- (void)sp_checkInfo2621173622:(NSString *)followCount;

- (void)sp_checkUserInfo452388681:(NSString *)isLogin;

- (void)sp_getMediaFailed3573943806:(NSString *)string;

- (void)sp_getUsersMostFollowerSuccess2212813102:(NSString *)string;

- (void)sp_getMediaData2859566328:(NSString *)string;

- (void)sp_checkInfo2974922295:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess2620288783:(NSString *)followCount;

- (void)sp_getUsersMostLikedSuccess2107322033:(NSString *)mediaInfo;

- (void)sp_getLoginState1251000891:(NSString *)mediaInfo;

- (void)sp_checkInfo1112027963:(NSString *)string;

- (void)sp_getLoginState1626389607:(NSString *)mediaInfo;

- (void)sp_getUserName2728222742:(NSString *)string;

- (void)sp_getUserName3541610188:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess550722563:(NSString *)followCount;

- (void)sp_getUserName1747025781:(NSString *)followCount;

- (void)sp_getUserName924716189:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess541128088:(NSString *)isLogin;

- (void)sp_getUsersMostLiked3335588750:(NSString *)isLogin;

- (void)sp_didUserInfoFailed2744919337:(NSString *)mediaCount;

- (void)sp_getMediaFailed3324953855:(NSString *)isLogin;

- (void)sp_getUserFollowSuccess2702810466:(NSString *)string;

- (void)sp_getUserFollowSuccess786847554:(NSString *)isLogin;

- (void)sp_checkDefualtSetting4093319652:(NSString *)isLogin;

- (void)sp_checkNetWorking47049102:(NSString *)isLogin;

- (void)sp_getMediaFailed1781383127:(NSString *)mediaInfo;

- (void)sp_getUsersMostFollowerSuccess3781162278:(NSString *)followCount;

- (void)sp_getLoginState1532618124:(NSString *)string;

- (void)sp_didGetInfoSuccess3071504971:(NSString *)mediaCount;

- (void)sp_getUserFollowSuccess105638628:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess2778614863:(NSString *)mediaCount;

- (void)sp_getUsersMostLiked3941910566:(NSString *)isLogin;

- (void)sp_upload1105136978:(NSString *)isLogin;

- (void)sp_getUserFollowSuccess3120709146:(NSString *)mediaInfo;

- (void)sp_upload3426094903:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess4058931228:(NSString *)followCount;

- (void)sp_checkInfo2764232395:(NSString *)isLogin;

- (void)sp_upload695025885:(NSString *)string;

- (void)sp_checkUserInfo248668881:(NSString *)mediaCount;

- (void)sp_upload2714564171:(NSString *)followCount;

- (void)sp_getMediaData2071121907:(NSString *)mediaCount;

- (void)sp_getMediaData2852237188:(NSString *)mediaInfo;

- (void)sp_didUserInfoFailed2919637293:(NSString *)followCount;

- (void)sp_checkNetWorking3476193619:(NSString *)followCount;

- (void)sp_getMediaData2237034733:(NSString *)mediaInfo;

- (void)sp_upload3701481258:(NSString *)mediaInfo;

- (void)sp_getUsersMostFollowerSuccess1050420529:(NSString *)followCount;

- (void)sp_getUsersMostLiked874777477:(NSString *)followCount;

- (void)sp_getMediaFailed2525759368:(NSString *)string;

- (void)sp_checkNetWorking4094941337:(NSString *)followCount;

- (void)sp_getUserName4059637273:(NSString *)isLogin;

- (void)sp_checkInfo2668314362:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess1163059246:(NSString *)isLogin;

- (void)sp_checkNetWorking587666240:(NSString *)mediaInfo;

- (void)sp_getUserFollowSuccess3700689854:(NSString *)isLogin;

- (void)sp_getMediaFailed4009203366:(NSString *)mediaCount;

- (void)sp_upload2054687090:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess428445189:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess3296336203:(NSString *)string;

- (void)sp_getUserFollowSuccess2889415597:(NSString *)isLogin;

- (void)sp_upload2549802878:(NSString *)mediaCount;

- (void)sp_upload2929878971:(NSString *)isLogin;

- (void)sp_checkInfo1413894623:(NSString *)mediaCount;

- (void)sp_getMediaData424676462:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess740235770:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess3148722334:(NSString *)followCount;

- (void)sp_getMediaData2020242682:(NSString *)string;

- (void)sp_getLoginState660451614:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess4284097229:(NSString *)followCount;

- (void)sp_getMediaFailed3020836643:(NSString *)followCount;

- (void)sp_getUsersMostFollowerSuccess3935064259:(NSString *)mediaCount;

- (void)sp_getUserName4093871178:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess287949342:(NSString *)string;

- (void)sp_getUsersMostLiked2566731096:(NSString *)string;

- (void)sp_getUsersMostLiked3961721455:(NSString *)mediaInfo;

- (void)sp_getUsersMostLiked2042969857:(NSString *)isLogin;

- (void)sp_checkNetWorking184300171:(NSString *)string;

- (void)sp_getUserName3642716267:(NSString *)mediaCount;

- (void)sp_getUserName1263076275:(NSString *)mediaCount;

- (void)sp_checkUserInfo1854370312:(NSString *)isLogin;

- (void)sp_didGetInfoSuccess307250133:(NSString *)mediaInfo;

- (void)sp_getMediaData3336256638:(NSString *)isLogin;

- (void)sp_checkUserInfo1752795247:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess1179700788:(NSString *)string;

- (void)sp_getUsersMostFollowerSuccess1175495621:(NSString *)isLogin;

- (void)sp_getUsersMostLikedSuccess4019821441:(NSString *)followCount;

- (void)sp_checkInfo3641299934:(NSString *)isLogin;

- (void)sp_getMediaFailed4122299434:(NSString *)followCount;

- (void)sp_getLoginState371306893:(NSString *)isLogin;

- (void)sp_getUsersMostLiked2253768166:(NSString *)isLogin;

- (void)sp_getLoginState441367578:(NSString *)followCount;

- (void)sp_checkDefualtSetting1639922782:(NSString *)mediaCount;

- (void)sp_checkNetWorking292518263:(NSString *)mediaCount;

- (void)sp_checkInfo337147624:(NSString *)mediaCount;

- (void)sp_checkNetWorking1106363548:(NSString *)mediaCount;

- (void)sp_getUsersMostLikedSuccess1839882942:(NSString *)string;

- (void)sp_didUserInfoFailed3531891175:(NSString *)isLogin;

- (void)sp_upload38601242:(NSString *)followCount;

- (void)sp_getMediaData2553691641:(NSString *)mediaCount;

- (void)sp_didGetInfoSuccess4023731040:(NSString *)isLogin;

- (void)sp_checkNetWorking3075571140:(NSString *)mediaCount;

- (void)sp_getMediaData1301754587:(NSString *)mediaInfo;

- (void)sp_getUsersMostLikedSuccess3663518413:(NSString *)mediaInfo;

- (void)sp_checkInfo209391958:(NSString *)mediaInfo;
@end
