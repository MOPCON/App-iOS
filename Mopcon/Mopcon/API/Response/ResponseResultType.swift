//
//  ResultType.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

typealias VoidResultType = (Result<Void, Error>) -> Void

typealias CommunityResultType = (Result<Group, Error>) -> Void

typealias OrganizerResultType = (Result<Organizer, Error>) -> Void

typealias VolunteerListResultType = (Result<VolunteerList, Error>) -> Void

typealias VolunteerResultType = (Result<Volunteer, Error>) -> Void

typealias SponsorListResultType = (Result<[SponsorList], Error>) -> Void

typealias SponsorResultType = (Result<[Sponsor], Error>) -> Void

typealias SessionListResultType = (Result<[SessionList], Error>) -> Void

typealias SessionInfoResultType = (Result<SessionInfo, Error>) -> Void

typealias FieldGameIntroResultType = (Result<FieldGameIntro, Error>) -> Void

typealias FieldGameStatusResultType = (Result<FieldGameMe, Error>) -> Void

typealias FieldGameTaskResultType = (Result<FieldGameTask, Error>) -> Void

typealias FieldGameTaskVerifiedResultType = (Result<String, Error>) -> Void

typealias FieldGameRewardResultType = (Result<FieldGameReward, Error>) -> Void
