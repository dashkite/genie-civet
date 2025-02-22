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
  
  # TODO migrate to a separate node test preset?
  # Genie.define "civet:test", "build", ->
  #   if await exists "build/node/test/index.js"
  #     sh "node
  #       --enable-source-maps
  #       --trace-warnings
  #       --unhandled-rejections=strict
  #       build/node/test/index.js"
  #   else
  #     console.warn "no tests defined"

  # Genie.on "test", "civet:test"

  Genie.on "lint", "civet:lint"