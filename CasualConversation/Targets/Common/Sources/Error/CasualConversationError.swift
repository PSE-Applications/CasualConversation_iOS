//
//  CasualConversationError.swift
//  CasualConversation
//
//  Created by coda on 2022/07/23.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Foundation

public enum CCError: Error {
	
    public enum SystemErrorReason {
        case escapingClosureIsLost
        case typeCastingNotWork
        case optionalBindingNotWork
    }
	
	case systemErrorOccured(reason: SystemErrorReason)
    
    // MARK: - Domain
    public enum ConversationManageFailureReason {
        
    }
    
    public enum NoteManageFailureReason {
        
    }
    
    case conversationManageFailed(reason: ConversationManageFailureReason)
    case noteManageFailed(reason: NoteManageFailureReason)
    
    // MARK: - Data
    public enum RepositoryFailureReason {
        case coreDataViewContextUnsaved(Error)
        case coreDataUnloaded(Error)
        case fileURLPathInvalidated
    }
    
    case persistenceFailed(reason: RepositoryFailureReason)
    
}
