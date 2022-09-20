//
//  CasualConversationError.swift
//  CasualConversation
//
//  Created by coda on 2022/07/23.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation

public enum CCError: Error {
	
	public static var log: [Self] = []
	
    public enum SystemErrorReason {
        case escapingClosureIsLost
        case typeCastingNotWork
        case optionalBindingNotWork
    }
	
	case systemErrorOccured(reason: SystemErrorReason)
	case catchError(Error)
	case log(String)
    
    // MARK: - Domain
    public enum ConversationManageFailureReason {
		
    }
    
    public enum NoteManageFailureReason {
        
    }
	
	public enum AudioServiceManageFailureReason {
		case bindingFailure
		case fileURLPathInvalidated
		case fileURLPathSavedFailure
		case preparedFailure
		case fileBindingFailure
	}
    
    case conversationManageFailed(reason: ConversationManageFailureReason)
    case noteManageFailed(reason: NoteManageFailureReason)
	case audioServiceFailed(reason: AudioServiceManageFailureReason)
    
    // MARK: - Data
    public enum RepositoryFailureReason {
        case coreDataViewContextUnsaved(Error)
        case coreDataUnloaded(Error)
        case coreDataUnloadedEntity
		case fileNotExists
    }
    
    case persistenceFailed(reason: RepositoryFailureReason)
    
}
