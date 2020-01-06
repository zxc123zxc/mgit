module Cli.CliParser (
  CliCommand(..),
  parseCli
) where

import System.Environment
import Options.Applicative

data CliCommand =
    Branch
  | Branches
  | Fetch
  | LookupBranches String
  | Checkout String
  | Test
  deriving (Show)

cliParser :: Parser CliCommand
cliParser = subparser $
  command "branch"      (info branchParser (progDesc "Current branch for each repo"))     <>
  command "branches"    (info branchesParser (progDesc "Branches aggregated info"))       <>
  command "fetch"       (info fetchParser (progDesc "Fetch all repos"))                   <>
  command "lookup"      (info lookupParser (progDesc "Set head in all repos"))            <>
  command "checkout"    (info checkoutParser (progDesc "Set head in all repos"))          <>
  command "test"        (info testParser (progDesc "Test command"))

  where
    branchParser :: Parser CliCommand
    branchParser = pure Branch

    branchesParser :: Parser CliCommand
    branchesParser = pure Branches

    fetchParser :: Parser CliCommand
    fetchParser = pure Fetch

    lookupParser :: Parser CliCommand
    lookupParser = LookupBranches <$> argument str idm

    checkoutParser :: Parser CliCommand
    checkoutParser = Checkout <$> argument str idm

    testParser :: Parser CliCommand
    testParser = pure Test


desc :: InfoMod CliCommand
desc = fullDesc
       <> progDesc "Print a greeting for TARGET"
       <> header "hello - a test for optparse-applicative"

parseCli :: IO CliCommand
parseCli = execParser (info cliParser desc)