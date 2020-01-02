module LibGit.TestGitLib where

import System.Directory
import qualified LibGit.LibGitApp as A
import qualified LibGit.MGitApp as MA
import qualified MGit.MonadGit as A
import qualified MGit.MonadMGit as MA
--import LibGit.Models
--import qualified LibGit.Branch as B
--import qualified LibGit.Common as C
--import qualified LibGit.Remote as R
--import qualified LibGit.Status as S



--tstFetch = do
--  print "Test fetch"
--  pwd <- getCurrentDirectory
--  inir <- c_git_libgit2_init
--  ppRepo <- mallocBytes (sizeOf (undefined :: Ptr GitRepo))
--  withCString pwd $ \s -> do
--    r <- c_git_repository_open ppRepo s
--    print r
--  repoPtr <- peek ppRepo
--  cb <- wrapGitStatusCb statusFunc
--  ppRemote <- mallocBytes (sizeOf (undefined :: Ptr GitRemote))
--  withCString "origin" $ \s -> do
--    r <- c_git_remote_lookup ppRemote repoPtr s
--    print r
--  remotePtr <- peek ppRemote
--  
--  ppFetchOpts <- mallocBytes (sizeOf (undefined :: Ptr GitFetchOptions))
--  do 
--    r <- c_git_fetch_init_options_integr ppFetchOpts
--    print r
--  fetchOptsPtr <- peek ppFetchOpts
--  do 
--    refs <- makeStrArr ["master"]
--    r <- c_git_remote_download remotePtr refs fetchOptsPtr
--    print r
--  free ppFetchOpts
--  free ppRepo
--  free ppRemote


--tstStatus = C.withLibGit $ do
--  pwd <- getCurrentDirectory
--  C.withRepo pwd $ \repo -> do
--    statusInfo <- S.repoStatus repo
--    print statusInfo
--
--tstRemote = C.withLibGit $ do
--  pwd <- getCurrentDirectory
--  C.withRepo pwd $ \repo ->
--    R.lookupRemote repo "origin" $ \r -> do
--      uri <- R.remoteUri r
--      print uri
--
--tstRemoteFetch = C.withLibGit $ do
--  pwd <- getCurrentDirectory
--  C.withRepo pwd $ \repo ->
--    R.lookupRemote repo "origin" R.remoteFetch
--
--tstBranches = C.withLibGit $ do
--  pwd <- getCurrentDirectory
--  C.withRepo pwd $ \repo -> do
--    res <- B.getBranches repo
--    print $ "current branch: " <> show (B.currentBranch res)
--    mapM_ print $ fmap show (B.branches res)

tstCurrentBranch :: IO String
tstCurrentBranch = do
  pwd <- getCurrentDirectory
  branchName <- A.runLibGitApp pwd A.currentBranch
  print branchName
  pure branchName
  
tstCurrentBranches :: IO ()
tstCurrentBranches = do
  res <- MA.runMGitApp MA.getBranches
  print res
  pure ()
  