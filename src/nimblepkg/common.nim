# Copyright (C) Dominik Picheta. All rights reserved.
# BSD License. Look at license.txt for more info.
#
# Various miscellaneous common types reside here, to avoid problems with
# recursive imports

when not defined(nimscript):
  import sets

  import version
  export version.NimbleError # TODO: Surely there is a better way?

  type
    BuildFailed* = object of NimbleError

    PackageInfo* = object
      mypath*: string ## The path of this .nimble file
      isNimScript*: bool ## Determines if this pkg info was read from a nims file
      isMinimal*: bool
      isInstalled*: bool ## Determines if the pkg this info belongs to is installed
      postHooks*: HashSet[string] ## Useful to know so that Nimble doesn't execHook unnecessarily
      preHooks*: HashSet[string]
      name*: string
      version*: string
      author*: string
      description*: string
      license*: string
      skipDirs*: seq[string]
      skipFiles*: seq[string]
      skipExt*: seq[string]
      installDirs*: seq[string]
      installFiles*: seq[string]
      installExt*: seq[string]
      requires*: seq[PkgTuple]
      bin*: seq[string]
      binDir*: string
      srcDir*: string
      backend*: string
      foreignDeps*: seq[string]

    ## Same as quit(QuitSuccess), but allows cleanup.
    NimbleQuit* = ref object of Exception

  proc raiseNimbleError*(msg: string, hint = "") =
    var exc = newException(NimbleError, msg)
    exc.hint = hint
    raise exc

const
  nimbleVersion* = "0.7.11"