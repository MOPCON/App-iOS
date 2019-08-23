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
