module MGit.Format (
  printBranchesInfo,
  printBranchAggregationInfo,
  printBranchesLookup
) where

import qualified MGit.BranchModels as B
import MGit.MonadMGit
import Data.Maybe (fromMaybe)
import System.FilePath.Posix (makeRelative)

formatBranchesInfo :: FilePath -> BranchesInfo -> [String]
formatBranchesInfo pwd (BranchesInfo branches) = fmap formatLine branches
  where
    formatLine (RepoBranchInfo path branch) =
      let relativePath = makeRelative pwd path
          len = length relativePath
          spaceLen = 40 - len
          space = " " <> (if spaceLen > 0 then replicate spaceLen ' ' else "") <> " "
       in relativePath <> space <> maybe "no branches" (\(B.BranchName n) -> n) branch

printBranchesInfo :: FilePath -> BranchesInfo -> IO ()
printBranchesInfo pwd info = do
  let lines = formatBranchesInfo pwd info
  mapM_ putStrLn lines
  
  
formatBranchAggregationInfo :: AggregatedBranchesInfo -> [String]
formatBranchAggregationInfo (AggregatedBranchesInfo infos) = fmap formatLine infos
  where 
    formatLine (B.BranchName name, count) = 
      let len = length name
          spaceLen = 40 - len
          space = " " <> (if spaceLen > 0 then replicate spaceLen ' ' else "") <> ""
       in name <> space <> show count 
       
printBranchAggregationInfo :: AggregatedBranchesInfo -> IO ()
printBranchAggregationInfo info = do
  let lines = formatBranchAggregationInfo info
  mapM_ putStrLn lines

formatBranchesLookup :: FilePath -> [(FilePath, B.Branches)] -> [String]
formatBranchesLookup _ [] = []
formatBranchesLookup pwd ((p, b):as) = (makeRelative pwd p) : prepareBranches b <> formatBranchesLookup pwd as
  where
    prepareBranches B.Branches{branches} = fmap prepareBranchInfo branches
    prepareBranchInfo (B.RepoBranchInfo branchType (B.BranchName name) isBranch ref) = let
      len = length name
      spaceLen = 60 - len
      space = " " <> (if spaceLen > 0 then replicate spaceLen ' ' else "") <> ""
      in "  " <> name <> space <> show ref

printBranchesLookup :: FilePath -> [(FilePath, B.Branches)] -> IO ()
printBranchesLookup pwd d = do
  let lines = formatBranchesLookup pwd d
  mapM_ putStrLn lines