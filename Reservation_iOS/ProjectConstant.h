//
//  ProjectConstant.h
//  Reservation
//
//  Created by Wai Man Chan on 3/14/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#ifndef Reservation_ProjectConstant_h
#define Reservation_ProjectConstant_h

#define coreURL @"https://etchan.com/Reservation"
#define UUID @"0B8381BA-9A4A-4A88-86C4-7DE03A9CC0BC"

#define URLWithHost(host, path) host path

#define CreateAppoinmentAddr URLWithHost(coreURL, "/User/Appoinment.php?action=create&uid=_uid&cid=_cid&sid=%lld&time=%@")
#define CancelAppoinmentAddr URLWithHost(coreURL, "/User/Appoinment.php?action=delete&aid=%lld&uid=_uid&cid=_cid")
#define AppoinmentFetchAddr URLWithHost(coreURL, "/User/Appoinment.php?action=display&uid=_uid&cid=_cid")
#define UsernameFetchAddr URLWithHost(coreURL, "/User/username.php?uid=%@")
#define fetchAddress URLWithHost(coreURL, "/Company/fetchNear.php?type=1")
#define CompanyTypeAddress URLWithHost(coreURL, "/Company/CompanyType.php?type=1")
#define Login_Addr URLWithHost(coreURL, "/User/login.php?action=login&acName=%@&pw=%@")
#define Register_Addr URLWithHost(coreURL, "/User/register.php")
#define menuFetchURL URLWithHost(coreURL, "/Company/Info/%lld/Menu.php")
#define addOrderAddress URLWithHost(coreURL, "/Company/order.php?action=add&uid=_uid&cid=_cid&table=%d&store=%lld")
#define testQueryURL URLWithHost(coreURL, "/User/test.php")
#define reservationFinishURL URLWithHost(coreURL, "/User/Appoinment.php?action=create&uid=_uid&cid=_cid&sid=%lld")
#define restaurantInfo URLWithHost(coreURL, "/Company/Info.php?id=%lld")
#define CommentAddress URLWithHost(coreURL, "/Company/review.php?action=display&sid=%lld")
#define fetchAddressWithSubType URLWithHost(coreURL, "/Company/fetchNear.php?type=1&subType=%d")

#define subTypeImageAddress URLWithHost(coreURL, "/Company/SubTypeImage/1/%d.png")

#endif
