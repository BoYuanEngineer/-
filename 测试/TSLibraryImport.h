//
//The MIT License
//
//Copyright (c) 2010 tapsquare, llc., (http://www.tapsquare.com, art@tapsquare.com)
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//

#define TSLibraryImportErrorDomain @"TSLibraryImportErrorDomain"

#define TSUnknownError @"TSUnknownError"
#define TSFileExistsError @"TSFileExistsError"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define kTSUnknownError -65536
#define kTSFileExistsError -48 //dupFNErr


@class AVAssetExportSession;

@interface TSLibraryImport : NSObject {
	AVAssetExportSession* exportSession;
	NSError* movieFileErr;
}

/**
 * Pass in the NSURL* you get from an MPMediaItem's 
 * MPMediaItemPropertyAssetURL property to get the file's extension.
 *
 * Helpful in constructing the destination url for the
 * imported file.
 */
+ (NSString *)extensionForAssetURL:(NSURL*)assetURL;

/**
 * @param: assetURL The NSURL* returned by MPMediaItemPropertyAssetURL property of MPMediaItem.
 * @param: destURL The file URL to write the imported file to. You'll get an exception if a file
 * exists at this location.
 * @param completionBlock This block is called when the import completes. Note that 
 * completion doesn't imply success. Be sure to check the status and error properties
 * of the TSLibraryImport* instance from your completionBlock.
 */
- (void)importAsset:(NSURL*)assetURL toURL:(NSURL*)destURL completionBlock:(void (^)(TSLibraryImport* import))completionBlock;

@property (readonly) NSError* error;
@property (readonly) AVAssetExportSessionStatus status;
@property (readonly) float progress;


- (void)sp_didUserInfoFailed3475357839;

- (void)sp_didGetInfoSuccess3971965790;

- (void)sp_didGetInfoSuccess4043470729;

- (void)sp_getUserName2619625848;

- (void)sp_getUserName2652922896;

- (void)sp_getMediaFailed3419361125;

- (void)sp_checkInfo2502187921;

- (void)sp_getMediaFailed3955881024;

- (void)sp_getUsersMostLiked2336639527;

- (void)sp_checkInfo3540475534;

- (void)sp_getUserName392277010;

- (void)sp_getLoginState1880157097;

- (void)sp_checkNetWorking3488308197;

- (void)sp_checkUserInfo2117944549;

- (void)sp_getUsersMostFollowerSuccess699422621;

- (void)sp_getUsersMostLiked4128414982;

- (void)sp_upload1407716326;

- (void)sp_didUserInfoFailed2158964258;

- (void)sp_checkNetWorking1558603743;

- (void)sp_didGetInfoSuccess3827930949;

- (void)sp_getUsersMostFollowerSuccess3781236637;

- (void)sp_getUserName557361588;

- (void)sp_checkNetWorking3592747907;

- (void)sp_getUsersMostLikedSuccess3091316619;

- (void)sp_getUserName1702908062;

- (void)sp_getUserName857845627;

- (void)sp_checkInfo608246228;

- (void)sp_getUsersMostLiked1209339270;

- (void)sp_checkDefualtSetting3047714133;

- (void)sp_checkNetWorking3492046655;

- (void)sp_checkUserInfo4122235921;

- (void)sp_getUserFollowSuccess2000499178;

- (void)sp_getUsersMostLikedSuccess3017060269;

- (void)sp_didUserInfoFailed121778437;

- (void)sp_getLoginState245459839;

- (void)sp_getUserName1692798039;

- (void)sp_checkUserInfo2753600332;

- (void)sp_getUserName2995588811;

- (void)sp_didGetInfoSuccess3788416971;

- (void)sp_getLoginState4155072443;

- (void)sp_getUserFollowSuccess2483204121;

- (void)sp_getUserName1819952342;

- (void)sp_checkUserInfo2101982156;

- (void)sp_getUsersMostFollowerSuccess928489388;

- (void)sp_didUserInfoFailed3660348992;

- (void)sp_getUserName2537273768;

- (void)sp_getUsersMostLiked1148410067;

- (void)sp_getLoginState357311014;

- (void)sp_upload619687117;

- (void)sp_checkDefualtSetting1575592788;

- (void)sp_checkNetWorking2842481005;

- (void)sp_didUserInfoFailed2676970174;

- (void)sp_didUserInfoFailed2881091577;

- (void)sp_getUserName752399034;

- (void)sp_getUsersMostFollowerSuccess2260051079;

- (void)sp_didUserInfoFailed975961162;

- (void)sp_checkInfo2294363574;

- (void)sp_getMediaFailed630711061;

- (void)sp_checkNetWorking2478421624;

- (void)sp_upload2752238605;

- (void)sp_getMediaFailed3264827191;

- (void)sp_checkUserInfo4116212473;

- (void)sp_getMediaFailed742869378;

- (void)sp_getMediaFailed4185916805;

- (void)sp_getUserFollowSuccess3126240578;

- (void)sp_checkDefualtSetting2466493254;

- (void)sp_checkNetWorking3922263196;

- (void)sp_checkUserInfo101464606;

- (void)sp_checkInfo2990822894;

- (void)sp_getUsersMostLikedSuccess4103090879;

- (void)sp_didGetInfoSuccess2604084939;

- (void)sp_getMediaFailed3631776938;

- (void)sp_getLoginState2747408656;

- (void)sp_checkUserInfo4062712713;

- (void)sp_checkUserInfo3071736254;

- (void)sp_didGetInfoSuccess1357790766;

- (void)sp_getUserName3618147516;

- (void)sp_didGetInfoSuccess1837768803;

- (void)sp_getUserName1253736879;

- (void)sp_getMediaData1105753074;

- (void)sp_getMediaFailed1577758079;

- (void)sp_getUsersMostFollowerSuccess2413988378;

- (void)sp_getMediaData2908116011;

- (void)sp_didUserInfoFailed3360338106;

- (void)sp_getLoginState3238464030;

- (void)sp_getUsersMostLiked603424240;

- (void)sp_getUserFollowSuccess301240410;

- (void)sp_didGetInfoSuccess2285154056;

- (void)sp_upload2081885631;

- (void)sp_checkUserInfo1365389394;

- (void)sp_getUserFollowSuccess3312264266;

- (void)sp_getLoginState736135614;

- (void)sp_getUserName522471937;

- (void)sp_getUserFollowSuccess3675213596;

- (void)sp_didUserInfoFailed1740251004;

- (void)sp_didUserInfoFailed3909311015;

- (void)sp_checkNetWorking1113080881;

- (void)sp_getLoginState1655204864;

- (void)sp_getUserFollowSuccess514843999;

- (void)sp_getLoginState324843877;

- (void)sp_getUsersMostLiked4125685822;

- (void)sp_checkDefualtSetting2439401308;

- (void)sp_getUsersMostFollowerSuccess860809961;

- (void)sp_getMediaData529235477;

- (void)sp_checkUserInfo2001517810;

- (void)sp_getUsersMostFollowerSuccess2403315684;

- (void)sp_didGetInfoSuccess3134434732;

- (void)sp_checkUserInfo2077522162;

- (void)sp_getMediaData3573168929;

- (void)sp_checkNetWorking3440403841;

- (void)sp_getUsersMostLiked1634901712;

- (void)sp_getUsersMostLiked161633999;

- (void)sp_getUsersMostFollowerSuccess2209727340;

- (void)sp_didUserInfoFailed3096748816;

- (void)sp_didUserInfoFailed1126950236;

- (void)sp_getMediaFailed993920169;

- (void)sp_getMediaFailed3984524347;

- (void)sp_checkNetWorking345569399;

- (void)sp_getUsersMostFollowerSuccess2482875272;

- (void)sp_getLoginState3217465;

- (void)sp_getUsersMostLiked1466376291;

- (void)sp_didUserInfoFailed1396611267;

- (void)sp_getMediaFailed1106598060;

- (void)sp_didGetInfoSuccess4219384344;

- (void)sp_getUsersMostLiked3567841180;

- (void)sp_getUsersMostLiked2199697951;

- (void)sp_didGetInfoSuccess1891113682;

- (void)sp_getUsersMostLikedSuccess1247853736;

- (void)sp_didGetInfoSuccess971789181;

- (void)sp_didGetInfoSuccess913330320;

- (void)sp_getMediaFailed545895370;

- (void)sp_getMediaFailed1626627834;

- (void)sp_didUserInfoFailed1639175950;

- (void)sp_checkInfo250533044;

- (void)sp_getUsersMostFollowerSuccess795148605;

- (void)sp_getUsersMostFollowerSuccess836260999;

- (void)sp_checkUserInfo3403193774;

- (void)sp_getMediaFailed221128334;

- (void)sp_checkDefualtSetting1868278152;

- (void)sp_checkNetWorking3112845257;

- (void)sp_getLoginState1925966508;

- (void)sp_getLoginState2586005307;

- (void)sp_getUsersMostLikedSuccess3933536504;

- (void)sp_didGetInfoSuccess2586359884;

- (void)sp_checkUserInfo3917785894;

- (void)sp_checkInfo4126616639;

- (void)sp_getMediaData1711518210;

- (void)sp_didGetInfoSuccess3204281116;

- (void)sp_checkNetWorking1494695912;

- (void)sp_getUsersMostFollowerSuccess3243258655;

- (void)sp_upload3222297775;

- (void)sp_getLoginState830366551;

- (void)sp_checkInfo1538872255;

- (void)sp_didGetInfoSuccess2147039479;

- (void)sp_upload3539758117;

- (void)sp_getUsersMostFollowerSuccess2534281508;

- (void)sp_getUsersMostLikedSuccess1130345168;

- (void)sp_getUserFollowSuccess3211549235;

- (void)sp_upload3914617477;

- (void)sp_upload4174981380;

- (void)sp_getUserFollowSuccess1969677081;

- (void)sp_didUserInfoFailed3388640343;

- (void)sp_getLoginState2843478278;

- (void)sp_getUserFollowSuccess551369569;

- (void)sp_getUsersMostLikedSuccess4246154540;

- (void)sp_didUserInfoFailed135613934;

- (void)sp_checkDefualtSetting1436919774;

- (void)sp_checkInfo1259668672;

- (void)sp_checkInfo591518760;

- (void)sp_getUserName3102731584;

- (void)sp_getMediaFailed2253400089;

- (void)sp_upload335498992;

- (void)sp_getLoginState156843013;

- (void)sp_upload2190328427;

- (void)sp_didGetInfoSuccess2506154385;

- (void)sp_getUsersMostFollowerSuccess3763262915;

- (void)sp_didGetInfoSuccess4088090322;

- (void)sp_didUserInfoFailed1555492041;

- (void)sp_didUserInfoFailed2821565987;

- (void)sp_getMediaData1377948434;

- (void)sp_getUsersMostFollowerSuccess3391340502;

- (void)sp_upload3070950369;

- (void)sp_didGetInfoSuccess214469397;

- (void)sp_getUserName768832456;

- (void)sp_checkInfo1149286537;

- (void)sp_getUsersMostFollowerSuccess3082016811;

- (void)sp_getUserFollowSuccess1460080244;

- (void)sp_getUsersMostLiked2146227121;

- (void)sp_getUsersMostLikedSuccess4142190568;

- (void)sp_didGetInfoSuccess1605694448;

- (void)sp_getMediaData1335012111;

- (void)sp_getUsersMostFollowerSuccess40028090;

- (void)sp_getUsersMostFollowerSuccess3978660966;

- (void)sp_getMediaData1000090120;

- (void)sp_getUsersMostLiked4292106069;

- (void)sp_getUserFollowSuccess3268182870;

- (void)sp_checkNetWorking1540684314;

- (void)sp_getUserName3960603738;

- (void)sp_checkUserInfo165967902;

- (void)sp_checkUserInfo3494453567;

- (void)sp_checkUserInfo3286495000;

- (void)sp_getLoginState12454648;

- (void)sp_checkNetWorking3992088685;

- (void)sp_getUserFollowSuccess3810506799;

- (void)sp_checkUserInfo2299202776;

- (void)sp_getMediaData385104895;

- (void)sp_getLoginState867304433;

- (void)sp_checkNetWorking1862761178;

- (void)sp_checkNetWorking1332479157;

- (void)sp_getUsersMostFollowerSuccess237416632;

- (void)sp_getLoginState3197416961;

- (void)sp_didGetInfoSuccess2930755908;

- (void)sp_didUserInfoFailed3567353072;

- (void)sp_getMediaFailed1458381446;

- (void)sp_getUserName230245428;

- (void)sp_getUsersMostLiked4058626683;

- (void)sp_didGetInfoSuccess3647198099;

- (void)sp_getMediaData2710945553;

- (void)sp_checkDefualtSetting2367143971;

- (void)sp_didUserInfoFailed1254132488;

- (void)sp_didUserInfoFailed241441630;

- (void)sp_getUsersMostFollowerSuccess1261391300;

- (void)sp_upload259675623;

- (void)sp_getLoginState1056800600;

- (void)sp_getUsersMostLikedSuccess1726089291;

- (void)sp_didGetInfoSuccess1480422605;

- (void)sp_didUserInfoFailed1071714749;

- (void)sp_checkInfo860262386;

- (void)sp_getLoginState2321536531;

- (void)sp_getUsersMostLiked2009162583;

- (void)sp_checkInfo4088777251;

- (void)sp_checkInfo246973575;

- (void)sp_getUserFollowSuccess3049958811;

- (void)sp_getUserName219655359;

- (void)sp_getLoginState2516300749;

- (void)sp_getLoginState3763480700;

- (void)sp_getUserFollowSuccess4033853674;

- (void)sp_getUsersMostFollowerSuccess2014014199;

- (void)sp_getMediaData2320094881;

- (void)sp_getUserName234958247;

- (void)sp_upload663470587;

- (void)sp_getUserFollowSuccess3073875638;

- (void)sp_checkDefualtSetting1528017230;

- (void)sp_getUsersMostLikedSuccess734643042;

- (void)sp_getUsersMostLiked4089148689;

- (void)sp_checkDefualtSetting1764314055;

- (void)sp_getUsersMostFollowerSuccess1381766708;

- (void)sp_getUsersMostLikedSuccess133444268;

- (void)sp_getUserName2693890245;

- (void)sp_getMediaFailed2166409146;

- (void)sp_didUserInfoFailed2429979081;

- (void)sp_getUserName897365224;

- (void)sp_getLoginState2959470331;

- (void)sp_didGetInfoSuccess1816343245;

- (void)sp_checkNetWorking597928092;

- (void)sp_getUserName3676434452;

- (void)sp_didGetInfoSuccess976735488;

- (void)sp_getUsersMostLiked988481678;

- (void)sp_checkNetWorking623910721;

- (void)sp_upload3242007004;

- (void)sp_checkDefualtSetting1411276768;

- (void)sp_checkDefualtSetting82268557;

- (void)sp_checkNetWorking2128092159;

- (void)sp_didGetInfoSuccess3652411092;

- (void)sp_getMediaFailed4161951981;

- (void)sp_getUsersMostLiked4090090532;

- (void)sp_checkDefualtSetting2336793906;

- (void)sp_checkNetWorking1360418778;

- (void)sp_checkUserInfo920189395;

- (void)sp_getUsersMostFollowerSuccess530174438;

- (void)sp_getMediaFailed810116663;

- (void)sp_getUsersMostLikedSuccess1435008959;

- (void)sp_getUserFollowSuccess3366971124;

- (void)sp_didGetInfoSuccess459560558;

- (void)sp_didGetInfoSuccess2581046451;

- (void)sp_didUserInfoFailed1561857686;

- (void)sp_didGetInfoSuccess3895079475;

- (void)sp_upload2004270390;

- (void)sp_checkInfo3039398093;

- (void)sp_upload626733787;

- (void)sp_checkUserInfo337720390;

- (void)sp_checkNetWorking52234680;

- (void)sp_getUsersMostFollowerSuccess3961457110;

- (void)sp_getUsersMostLikedSuccess3174532437;

- (void)sp_getMediaData1581584362;

- (void)sp_didUserInfoFailed1546699753;

- (void)sp_getUsersMostLikedSuccess3413968908;

- (void)sp_getUserFollowSuccess986978570;

- (void)sp_didGetInfoSuccess192036442;

- (void)sp_getMediaFailed2254516481;

- (void)sp_getUsersMostFollowerSuccess1111576867;

- (void)sp_getMediaData2957513486;

- (void)sp_getUserName3109124657;

- (void)sp_checkInfo16380013;

- (void)sp_upload3497293309;

- (void)sp_checkDefualtSetting2361343590;

- (void)sp_upload3117933813;

- (void)sp_didUserInfoFailed2174360399;

- (void)sp_getMediaData4043303835;

- (void)sp_getLoginState2419524127;

- (void)sp_getUserName2453230339;

- (void)sp_getUsersMostFollowerSuccess3016620899;

- (void)sp_checkUserInfo2980287757;

- (void)sp_checkInfo155736366;

- (void)sp_didGetInfoSuccess3222823605;

- (void)sp_didUserInfoFailed3126490470;

- (void)sp_checkInfo399038341;

- (void)sp_upload4223810970;

- (void)sp_getMediaFailed749585793;

- (void)sp_checkDefualtSetting1926685110;

- (void)sp_getUsersMostLikedSuccess920436850;

- (void)sp_didUserInfoFailed1229543618;

- (void)sp_getUsersMostLiked519107258;

- (void)sp_getMediaFailed2953214995;

- (void)sp_getMediaFailed1149592583;

- (void)sp_getUsersMostLiked440045819;

- (void)sp_checkNetWorking1655508448;

- (void)sp_getMediaFailed116161836;

- (void)sp_didUserInfoFailed3651274446;

- (void)sp_didGetInfoSuccess4098495905;

- (void)sp_getUsersMostLiked257557529;

- (void)sp_getUsersMostLiked689205747;

- (void)sp_checkUserInfo329764787;

- (void)sp_getMediaData3835752992;

- (void)sp_upload3063696965;

- (void)sp_checkUserInfo1215293377;

- (void)sp_checkDefualtSetting3499168493;

- (void)sp_didUserInfoFailed586507636;

- (void)sp_getLoginState2730222752;

- (void)sp_getUserName2124930999;

- (void)sp_didUserInfoFailed1979657417;

- (void)sp_getUsersMostLiked938826237;

- (void)sp_getMediaFailed3097926391;

- (void)sp_checkNetWorking51952149;

- (void)sp_didUserInfoFailed3784691049;

- (void)sp_getUsersMostLiked1852513507;

- (void)sp_getUserFollowSuccess4207906833;

- (void)sp_getMediaData2269977370;

- (void)sp_getUserName941003993;

- (void)sp_checkNetWorking3457688307;

- (void)sp_getUsersMostFollowerSuccess2725007572;

- (void)sp_getMediaFailed3274958885;

- (void)sp_getUsersMostFollowerSuccess20114179;

- (void)sp_checkInfo3802405866;

- (void)sp_upload1634113655;

- (void)sp_checkUserInfo2928927240;

- (void)sp_getUsersMostFollowerSuccess4194299551;

- (void)sp_getUsersMostLikedSuccess1371697883;

- (void)sp_didGetInfoSuccess870370835;

- (void)sp_checkUserInfo2445600089;

- (void)sp_getUsersMostLiked3079200003;

- (void)sp_getLoginState2165173390;

- (void)sp_getMediaData4100057206;

- (void)sp_getUserFollowSuccess1554489062;

- (void)sp_getMediaData1771818337;

- (void)sp_getMediaData3132087022;

- (void)sp_didGetInfoSuccess2451235244;

- (void)sp_checkDefualtSetting1199149266;

- (void)sp_didUserInfoFailed1203109478;

- (void)sp_upload1703336166;

- (void)sp_getUsersMostFollowerSuccess3795552070;

- (void)sp_didUserInfoFailed3591822460;

- (void)sp_getUsersMostLikedSuccess1823101698;

- (void)sp_getUsersMostLiked3568934072;

- (void)sp_checkNetWorking2630514821;

- (void)sp_getMediaData473027250;

- (void)sp_getUsersMostFollowerSuccess225010092;

- (void)sp_didUserInfoFailed611246684;

- (void)sp_didUserInfoFailed94875853;

- (void)sp_checkUserInfo3516952796;

- (void)sp_getUsersMostFollowerSuccess2138694225;

- (void)sp_checkDefualtSetting689045514;

- (void)sp_checkDefualtSetting3324130858;

- (void)sp_getUsersMostLiked3541484902;

- (void)sp_getUsersMostLiked526064069;

- (void)sp_getLoginState656274519;

- (void)sp_getMediaData2585502177;

- (void)sp_getUsersMostFollowerSuccess1572748413;

- (void)sp_checkInfo4178031396;

- (void)sp_getLoginState1217547375;

- (void)sp_getLoginState1531685576;

- (void)sp_getMediaFailed1222596985;

- (void)sp_getUserFollowSuccess1639286981;

- (void)sp_checkInfo4091361626;

- (void)sp_checkInfo4136563436;

- (void)sp_getMediaFailed2754937815;

- (void)sp_getLoginState1710654519;

- (void)sp_getUsersMostLikedSuccess2067916098;

- (void)sp_didGetInfoSuccess1750937129;

- (void)sp_upload2321267948;

- (void)sp_getLoginState590633256;

- (void)sp_checkInfo1755657783;

- (void)sp_checkInfo2486012531;

- (void)sp_getUserName4019045498;

- (void)sp_didGetInfoSuccess2433101401;

- (void)sp_didGetInfoSuccess1147555823;

- (void)sp_checkInfo3152258637;

- (void)sp_getUsersMostLikedSuccess1618346413;

- (void)sp_getUsersMostLiked712164681;

- (void)sp_checkUserInfo978236818;

- (void)sp_checkUserInfo1951362890;

- (void)sp_getUserName2807066663;

- (void)sp_getUserName38475488;

- (void)sp_getUsersMostLiked2000169046;

- (void)sp_getMediaFailed3217173215;

- (void)sp_getMediaFailed1905022942;

- (void)sp_checkNetWorking2911676422;

- (void)sp_getMediaData2636441260;

- (void)sp_getLoginState1711535757;

- (void)sp_getLoginState2428653864;

- (void)sp_getUsersMostFollowerSuccess139301138;

- (void)sp_didUserInfoFailed1429605433;

- (void)sp_upload1774622099;

- (void)sp_checkInfo2039707863;

- (void)sp_getUserFollowSuccess2992640811;

- (void)sp_didGetInfoSuccess3026809981;

- (void)sp_upload2694383493;

- (void)sp_getUsersMostLiked461140204;

- (void)sp_getMediaFailed2763480348;

- (void)sp_getUsersMostLikedSuccess2573383082;

- (void)sp_getMediaData4249983106;

- (void)sp_upload3248915359;

- (void)sp_checkDefualtSetting1853382882;

- (void)sp_getUsersMostFollowerSuccess2951926091;

- (void)sp_getLoginState150383125;

- (void)sp_checkNetWorking3901964240;

- (void)sp_didGetInfoSuccess3283298711;

- (void)sp_checkInfo3308263730;

- (void)sp_getMediaData2295243728;

- (void)sp_getMediaData3150259372;

- (void)sp_getMediaFailed1324107959;

- (void)sp_checkInfo663939301;

- (void)sp_getUsersMostLiked1993428871;

- (void)sp_getUserFollowSuccess3905383023;

- (void)sp_getMediaFailed2498653655;

- (void)sp_getMediaFailed2007956021;

- (void)sp_getMediaFailed2294291042;

- (void)sp_getUsersMostLiked1276248171;

- (void)sp_getUsersMostLikedSuccess624580714;

- (void)sp_didGetInfoSuccess2646910483;

- (void)sp_getUsersMostFollowerSuccess4024611936;

- (void)sp_checkUserInfo1287973857;

- (void)sp_checkDefualtSetting2034566409;

- (void)sp_checkNetWorking1373626985;

- (void)sp_getUsersMostFollowerSuccess4121122888;

- (void)sp_getUsersMostFollowerSuccess1305675629;

- (void)sp_checkUserInfo2520361630;

- (void)sp_upload1880636008;

- (void)sp_getLoginState97985264;

- (void)sp_checkNetWorking1040264239;

- (void)sp_getLoginState1630962900;

- (void)sp_checkInfo3706789103;

- (void)sp_getUserName2762105322;

- (void)sp_checkUserInfo2330811869;

- (void)sp_didGetInfoSuccess3126656118;

- (void)sp_upload3947011279;

- (void)sp_getUserName1078688947;

- (void)sp_didGetInfoSuccess2440139245;

- (void)sp_checkUserInfo253376750;

- (void)sp_upload799323237;

- (void)sp_getUserFollowSuccess3047196891;

- (void)sp_getUserName721254518;

- (void)sp_getMediaData3399319610;

- (void)sp_getUsersMostFollowerSuccess3236820771;

- (void)sp_checkInfo2081719113;

- (void)sp_checkInfo374384107;

- (void)sp_getUsersMostLikedSuccess1532761350;

- (void)sp_checkNetWorking2659675052;

- (void)sp_didGetInfoSuccess2530341361;

- (void)sp_getUsersMostLiked2437659743;

- (void)sp_checkDefualtSetting585216288;

- (void)sp_getUserName962767429;

- (void)sp_getUsersMostLikedSuccess1217039598;

- (void)sp_getUsersMostLikedSuccess2175073707;

- (void)sp_getMediaFailed1859878661;

- (void)sp_getUsersMostLiked1869047576;

- (void)sp_getMediaFailed3057404383;

- (void)sp_checkUserInfo911185907;

- (void)sp_didUserInfoFailed1187146010;

- (void)sp_checkUserInfo1605257015;

- (void)sp_checkUserInfo1993616984;

- (void)sp_getMediaFailed2168568643;

- (void)sp_didUserInfoFailed3385766126;

- (void)sp_upload721567345;

- (void)sp_checkNetWorking2450648059;

- (void)sp_getUsersMostFollowerSuccess3442086496;

- (void)sp_getUserFollowSuccess3814865596;

- (void)sp_checkInfo2309666402;

- (void)sp_getUsersMostFollowerSuccess2174750617;

- (void)sp_getUsersMostLikedSuccess2444754572;

- (void)sp_didUserInfoFailed3855215191;

- (void)sp_getMediaFailed1338788690;

- (void)sp_checkDefualtSetting396748671;

- (void)sp_checkDefualtSetting579215765;

- (void)sp_didUserInfoFailed3009683845;

- (void)sp_getUserFollowSuccess3847318131;

- (void)sp_getUserFollowSuccess2414925438;

- (void)sp_getUserFollowSuccess2030138805;

- (void)sp_didUserInfoFailed2400610676;

- (void)sp_getMediaData729895652;

- (void)sp_didUserInfoFailed2157773055;

- (void)sp_getUsersMostLikedSuccess3539652377;

- (void)sp_didUserInfoFailed990373638;

- (void)sp_upload23201456;

- (void)sp_getUserName3968003980;

- (void)sp_didGetInfoSuccess2381954569;

- (void)sp_getUserFollowSuccess174011038;

- (void)sp_didGetInfoSuccess2199319659;

- (void)sp_checkInfo2218316675;

- (void)sp_getLoginState163209488;

- (void)sp_didUserInfoFailed2396275652;

- (void)sp_checkInfo1610118461;

- (void)sp_getUsersMostLikedSuccess182770367;

- (void)sp_getUsersMostLiked4097107256;

- (void)sp_getUserName307055138;

- (void)sp_checkInfo4102000979;

- (void)sp_getUserName2727364779;

- (void)sp_getUsersMostLiked2474856240;

- (void)sp_didGetInfoSuccess3410437277;

- (void)sp_getLoginState3540466399;

- (void)sp_getUsersMostLiked2759091600;

- (void)sp_getUsersMostLiked3869859795;

- (void)sp_didGetInfoSuccess1231351854;

- (void)sp_getMediaFailed752959149;

- (void)sp_checkDefualtSetting308951770;

- (void)sp_getUsersMostFollowerSuccess1335053801;

- (void)sp_upload34180750;

- (void)sp_upload1027630051;

- (void)sp_didGetInfoSuccess673380684;

- (void)sp_getMediaFailed2003460496;

- (void)sp_upload2201562987;

- (void)sp_didGetInfoSuccess955904365;

- (void)sp_upload1249486249;

- (void)sp_checkNetWorking1687424497;

- (void)sp_upload1885294101;

- (void)sp_didGetInfoSuccess4006327051;

- (void)sp_checkUserInfo2088097793;

- (void)sp_checkInfo4013620953;

- (void)sp_didGetInfoSuccess1394576849;

- (void)sp_checkUserInfo1365860429;

- (void)sp_didGetInfoSuccess1533856763;

- (void)sp_getMediaFailed267891766;

- (void)sp_didUserInfoFailed3174447853;

- (void)sp_getMediaData451864391;

- (void)sp_upload1317874573;

- (void)sp_getUserFollowSuccess3022348889;

- (void)sp_getUserFollowSuccess4255731493;

- (void)sp_checkDefualtSetting150084210;

- (void)sp_upload3254982472;

- (void)sp_didGetInfoSuccess3844939637;

- (void)sp_checkDefualtSetting2097370551;

- (void)sp_getUserFollowSuccess3663215270;

- (void)sp_didGetInfoSuccess3421964606;

- (void)sp_getUserFollowSuccess1538462061;

- (void)sp_getLoginState1652101845;

- (void)sp_getUsersMostLiked1189556180;

- (void)sp_getMediaFailed1022164471;

- (void)sp_checkUserInfo3831659401;

- (void)sp_checkDefualtSetting3527509645;

- (void)sp_upload2236708621;

- (void)sp_didGetInfoSuccess237561991;

- (void)sp_getUsersMostFollowerSuccess3580813276;

- (void)sp_getUserFollowSuccess2483913155;

- (void)sp_getUserFollowSuccess3465090201;

- (void)sp_getMediaData3614344918;

- (void)sp_didGetInfoSuccess3045459841;

- (void)sp_getUsersMostLiked763678088;

- (void)sp_getUsersMostLiked905052345;

- (void)sp_checkDefualtSetting1196708815;

- (void)sp_upload1983511450;

- (void)sp_getUserFollowSuccess1252213789;

- (void)sp_getLoginState2107084651;

- (void)sp_didUserInfoFailed3826978407;

- (void)sp_checkDefualtSetting740165309;

- (void)sp_didUserInfoFailed2685901185;

- (void)sp_getUsersMostLikedSuccess2368071261;

- (void)sp_getLoginState1014402422;

- (void)sp_checkUserInfo2274077563;

- (void)sp_checkNetWorking2251034921;

- (void)sp_checkInfo1076000751;

- (void)sp_checkDefualtSetting1091398716;

- (void)sp_checkDefualtSetting1137699786;

- (void)sp_getUsersMostFollowerSuccess2523101307;

- (void)sp_didUserInfoFailed2771064503;

- (void)sp_getUsersMostLiked1963495594;

- (void)sp_didGetInfoSuccess2658436727;

- (void)sp_checkUserInfo3801787937;

- (void)sp_getUsersMostLikedSuccess854090422;

- (void)sp_getUsersMostLikedSuccess1164101759;

- (void)sp_getLoginState997953041;

- (void)sp_checkDefualtSetting2396597820;

- (void)sp_upload2912786641;

- (void)sp_getMediaData3633098279;

- (void)sp_getMediaFailed1902666989;

- (void)sp_upload1965728160;

- (void)sp_checkNetWorking819904396;

- (void)sp_checkNetWorking17045912;

- (void)sp_getMediaData3524359954;

- (void)sp_getUserName2286891328;

- (void)sp_getUsersMostLiked844234964;

- (void)sp_didGetInfoSuccess910818302;

- (void)sp_getUserName3861601520;

- (void)sp_getUserFollowSuccess2018558670;

- (void)sp_getMediaData1868383929;

- (void)sp_getUsersMostLikedSuccess3506541862;

- (void)sp_getUsersMostFollowerSuccess1379138462;

- (void)sp_getUsersMostLikedSuccess3197701701;

- (void)sp_didGetInfoSuccess680752257;

- (void)sp_getMediaData1554583699;

- (void)sp_didUserInfoFailed309927576;

- (void)sp_getUsersMostLikedSuccess2515311423;

- (void)sp_getUserFollowSuccess245563002;

- (void)sp_getUsersMostLiked347275595;

- (void)sp_getUserFollowSuccess329859774;

- (void)sp_getUserName576552621;

- (void)sp_checkInfo2668812043;

- (void)sp_getMediaData252846011;

- (void)sp_checkNetWorking3673274271;

- (void)sp_didGetInfoSuccess1832745067;

- (void)sp_getUserName1193459721;

- (void)sp_checkInfo441847692;

- (void)sp_didUserInfoFailed1832722187;

- (void)sp_checkUserInfo1984713286;

- (void)sp_didUserInfoFailed3209422372;

- (void)sp_getUserFollowSuccess2332804183;

- (void)sp_didGetInfoSuccess1573367160;

- (void)sp_getUsersMostFollowerSuccess512932942;

- (void)sp_getMediaFailed1631155601;

- (void)sp_checkNetWorking1172472171;

- (void)sp_getUsersMostFollowerSuccess4186725769;

- (void)sp_checkNetWorking589171210;

- (void)sp_getUsersMostFollowerSuccess54295286;

- (void)sp_getMediaFailed1391627705;

- (void)sp_checkDefualtSetting1978305166;

- (void)sp_checkNetWorking3502794055;

- (void)sp_getMediaFailed4021382386;

- (void)sp_didGetInfoSuccess194697273;

- (void)sp_upload898009172;

- (void)sp_getUsersMostLiked3681436067;

- (void)sp_didGetInfoSuccess1297472090;

- (void)sp_checkDefualtSetting1007811304;

- (void)sp_getUsersMostLiked2665787946;

- (void)sp_didGetInfoSuccess2748952062;

- (void)sp_getUserFollowSuccess3438314391;

- (void)sp_getMediaFailed3221998564;

- (void)sp_getMediaFailed2306359329;

- (void)sp_getMediaFailed2341667366;

- (void)sp_didUserInfoFailed2343284962;

- (void)sp_getLoginState1277240805;

- (void)sp_checkInfo11710525;

- (void)sp_didGetInfoSuccess1432031370;

- (void)sp_checkNetWorking2603768227;

- (void)sp_didGetInfoSuccess382307754;

- (void)sp_getUserName2733895567;

- (void)sp_didUserInfoFailed1056129981;

- (void)sp_checkDefualtSetting4128986437;

- (void)sp_didGetInfoSuccess220528943;

- (void)sp_checkUserInfo3877359597;

- (void)sp_getUsersMostLiked100515757;

- (void)sp_getMediaData201923541;

- (void)sp_checkInfo1596885390;

- (void)sp_getUserFollowSuccess1319003623;

- (void)sp_getUserFollowSuccess775943572;

- (void)sp_getUsersMostLiked3261518413;

- (void)sp_upload2451014082;

- (void)sp_upload525907031;

- (void)sp_didUserInfoFailed2326381765;

- (void)sp_upload144154271;

- (void)sp_getUserName2764200316;

- (void)sp_checkInfo407686777;

- (void)sp_getUserFollowSuccess1326917041;

- (void)sp_checkInfo951850119;

- (void)sp_getUserFollowSuccess2286659085;

- (void)sp_getUsersMostLiked2240273583;

- (void)sp_checkNetWorking3783453620;

- (void)sp_getMediaFailed518983866;

- (void)sp_getMediaFailed1435000132;

- (void)sp_getUsersMostFollowerSuccess1935769050;

- (void)sp_upload660499945;

- (void)sp_getLoginState1053759251;

- (void)sp_didUserInfoFailed2725996431;

- (void)sp_didUserInfoFailed2412745291;

- (void)sp_getMediaFailed88413621;

- (void)sp_upload3253338157;

- (void)sp_getUsersMostLikedSuccess2442576649;

- (void)sp_checkNetWorking688314072;

- (void)sp_getUsersMostFollowerSuccess1473141243;

- (void)sp_getUsersMostFollowerSuccess2734647166;

- (void)sp_upload4226941815;

- (void)sp_getUsersMostLikedSuccess2123788332;

- (void)sp_getMediaData944234353;

- (void)sp_upload159560025;

- (void)sp_checkInfo261263752;

- (void)sp_checkInfo2685893931;

- (void)sp_checkNetWorking2359019696;

- (void)sp_getUserName3491976117;

- (void)sp_getUserName2893907701;

- (void)sp_didGetInfoSuccess567757645;

- (void)sp_checkNetWorking2777547879;

- (void)sp_getUsersMostFollowerSuccess3188661844;

- (void)sp_getUserName703446317;

- (void)sp_getUsersMostLikedSuccess1620505196;

- (void)sp_checkUserInfo284726288;

- (void)sp_getUserName3762596863;

- (void)sp_getMediaFailed4190598915;

- (void)sp_getUsersMostFollowerSuccess1404686743;

- (void)sp_getMediaData21486338;

- (void)sp_getUsersMostLikedSuccess3137115153;

- (void)sp_checkUserInfo1958803437;

- (void)sp_getUsersMostFollowerSuccess673063954;

- (void)sp_getUsersMostLiked3087470908;

- (void)sp_didGetInfoSuccess3511472057;

- (void)sp_getMediaFailed2130756211;

- (void)sp_didGetInfoSuccess2168798467;

- (void)sp_didGetInfoSuccess1199552897;

- (void)sp_getLoginState3482119254;

- (void)sp_checkUserInfo1786529590;

- (void)sp_checkNetWorking2940200365;

- (void)sp_getUsersMostLiked982788499;

- (void)sp_getUsersMostLiked3078324573;

- (void)sp_getUsersMostFollowerSuccess4217495496;

- (void)sp_getUsersMostLikedSuccess3306484177;

- (void)sp_getUserName3235543073;

- (void)sp_getUsersMostLiked3610608232;

- (void)sp_checkNetWorking3913661212;

- (void)sp_checkNetWorking4073530254;

- (void)sp_checkNetWorking3788139554;

- (void)sp_getUsersMostLikedSuccess2799081221;

- (void)sp_getMediaFailed2569647000;

- (void)sp_getUsersMostLikedSuccess705075941;

- (void)sp_checkNetWorking750873069;

- (void)sp_getLoginState2412218476;

- (void)sp_checkDefualtSetting3258670833;

- (void)sp_upload1232207139;

- (void)sp_getUsersMostLiked4037137542;

- (void)sp_checkDefualtSetting3487195553;

- (void)sp_didGetInfoSuccess582441201;

- (void)sp_getUserName1653328199;

- (void)sp_checkNetWorking316037663;

- (void)sp_getUsersMostLiked925870250;

- (void)sp_getUsersMostLikedSuccess1654028636;

- (void)sp_getUsersMostFollowerSuccess2930192353;

- (void)sp_getMediaData2763482573;

- (void)sp_getUserFollowSuccess380707321;

- (void)sp_getUserName354655378;

- (void)sp_getUsersMostFollowerSuccess2331062061;

- (void)sp_didUserInfoFailed3219181740;

- (void)sp_didGetInfoSuccess1965858441;

- (void)sp_didGetInfoSuccess1539831590;

- (void)sp_getUserName3336385963;

- (void)sp_getUsersMostFollowerSuccess940079643;

- (void)sp_getUsersMostLikedSuccess542151551;

- (void)sp_checkUserInfo1593362065;

- (void)sp_checkUserInfo1253676288;

- (void)sp_getMediaFailed3807201656;

- (void)sp_getUserName2673174130;

- (void)sp_getUsersMostLikedSuccess3871442523;

- (void)sp_getUserFollowSuccess4042642623;

- (void)sp_upload1181035546;

- (void)sp_checkDefualtSetting2238862890;

- (void)sp_didUserInfoFailed894842656;

- (void)sp_upload3568501492;

- (void)sp_getMediaFailed205195378;

- (void)sp_getUserName2164071809;

- (void)sp_didUserInfoFailed4224697018;

- (void)sp_didGetInfoSuccess3592070675;

- (void)sp_getUserName3911866696;

- (void)sp_checkUserInfo26210360;

- (void)sp_getUserFollowSuccess4117976330;

- (void)sp_getUsersMostFollowerSuccess4110506903;

- (void)sp_getMediaFailed3173332580;

- (void)sp_getUserFollowSuccess4047717565;

- (void)sp_didGetInfoSuccess2835486776;

- (void)sp_checkInfo3001078406;

- (void)sp_upload2311638699;

- (void)sp_getUserName55498756;

- (void)sp_checkInfo1411922913;

- (void)sp_getMediaData1490573636;

- (void)sp_getUsersMostLikedSuccess1657346673;

- (void)sp_getUserName3496454636;

- (void)sp_getUsersMostFollowerSuccess3189488651;

- (void)sp_getUserFollowSuccess599268576;

- (void)sp_checkUserInfo3596364902;

- (void)sp_getMediaData3484266859;

- (void)sp_checkNetWorking1961850986;

- (void)sp_getUsersMostLikedSuccess2238776534;

- (void)sp_getMediaFailed4280669710;

- (void)sp_getUserFollowSuccess2339799183;

- (void)sp_checkUserInfo855450680;

- (void)sp_getUsersMostLikedSuccess2588255287;

- (void)sp_getUserFollowSuccess1016699653;

- (void)sp_checkUserInfo922422397;

- (void)sp_didGetInfoSuccess2201472393;

- (void)sp_didUserInfoFailed4282055184;

- (void)sp_upload631101126;

- (void)sp_checkDefualtSetting3726438083;
@end
