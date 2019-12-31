{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module LibGit.Remote where

import Foreign
import Foreign.C.Types
import Foreign.C.String
import Foreign.CStorable
import LibGit.Models
import GHC.Generics (Generic)


data GitRemote = GitRemote
  deriving (Generic, CStorable)

data GitFetchOptions = GitFetchOptions
  deriving (Generic, CStorable)
  
  
-- int git_remote_list(git_strarray *out, git_repository *repo);
-- TODO ?

-- int git_remote_lookup(git_remote **out, git_repository *repo, const char *name);
foreign import ccall "git2/remote.h git_remote_lookup" c_git_remote_lookup :: Ptr (Ptr GitRemote) -> Ptr GitRepo -> CString -> IO CInt

-- void git_remote_free(git_remote *remote);
foreign import ccall "git2/remote.h git_remote_free" c_git_remote_free :: Ptr GitRemote -> IO ()

-- const char * git_remote_url(const git_remote *remote);
foreign import ccall "git2/remote.h git_remote_url" c_git_remote_url :: Ptr GitRemote -> IO CString

-- int git_remote_download(git_remote *remote, const git_strarray *refspecs, const git_fetch_options *opts);
foreign import ccall "git2/remote.h git_remote_download" c_git_remote_download :: Ptr GitRemote -> Ptr GitStrArr -> Ptr GitFetchOptions -> IO CInt

-- int git_remote_fetch(git_remote *remote, const git_strarray *refspecs, const git_fetch_options *opts, const char *reflog_message);
foreign import ccall "git2/remote.h git_remote_fetch" c_git_remote_fetch :: Ptr GitRemote -> Ptr GitStrArr -> Ptr GitFetchOptions -> CString -> IO CInt

-- int git_fetch_init_options_integr(git_fetch_options *opts);
foreign import ccall "git_integr.h git_fetch_init_options_integr" c_git_fetch_init_options_integr :: Ptr (Ptr GitFetchOptions) -> IO CInt
