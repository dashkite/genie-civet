import M from "@dashkite/masonry"
import civet from "@dashkite/masonry-civet"
import T from "@dashkite/masonry-targets"
import { sh, exists } from "./helpers"
import lint from "./helpers/lint"
import Options from "./helpers/options"

export default ( Genie ) ->

  { targets } = Options.get Genie
  
  Genie.define "civet:build", "civet:clean", M.start [
    T.glob targets
    M.read
    M.tr civet
    M.extension ".js"
    T.write "build/${ build.preset }"
  ]

  # alias
  Genie.define "civet", "civet:build"
  
  Genie.on "build", "civet:build"

  Genie.define "civet:clean", "clean"

  Genie.define "civet:lint", "civet:clean", M.start [
    T.glob targets
    M.read
    M.tr civet
    lint
    # we write out the code so that we can reference it
    # in case we want to see why lint is complaining
    M.extension ".js"
    T.write "build/${ build.preset }"
  ]
  

  # Genie.on "test", "civet:test"

  Genie.on "lint", "civet:lint"