module MGit.StatusModels where

data DeltaStatus =
    Unmodified
  | Added
  | Deleted
  | Modified
  | Renamed
  | Copied
  | Ignored
  | Untracked
  | Typechange
  | Unreadable
  | Conflicted
  deriving (Show)

data DeltaInfo = DeltaInfo {
  status :: DeltaStatus,
  oldPath :: FilePath,
  newPath :: FilePath
} deriving (Show)

data StatusEntryDeltaInfo = StatusEntryDeltaInfo {
  headToIndex :: Maybe DeltaInfo,
  indexToWorkDir :: Maybe DeltaInfo
} deriving (Show)

newtype StatusInfo = StatusInfo {
  delta :: [StatusEntryDeltaInfo]
} deriving (Show)