module MGit.MonadGit where
import qualified MGit.StatusModels as S
import qualified MGit.BranchModels as B
import Data.List (isPrefixOf)
import Debug.Trace (trace)

class Monad m => MonadGit m where
  fetch :: m ()
  branches :: m (Maybe B.Branches)
  status :: m S.StatusInfo
  path :: m FilePath
  setHead :: B.RefName -> m ()

currentBranch :: MonadGit m => m (Maybe B.BranchName)
currentBranch = do
  branchesRes <- branches
  pure $ B.name . B.currentBranch <$>  branchesRes

setHeadMaster :: MonadGit m => m ()
setHeadMaster = setHead (B.RefName "refs/heads/master")

setHeadSafe :: MonadGit m => String -> m ()
setHeadSafe branchPrefix = do
  bs <- branches
  case bs of
    Nothing -> pure ()
    Just branchesInfo -> do
      let
        b = B.branches branchesInfo
        filtered = filter (isPrefixOf branchPrefix . (\(B.BranchName n) -> n) . B.name) b
      trace (show filtered) (pure ())
      if length filtered == 1
      then  setHead . B.ref . head $ filtered
      else pure ()