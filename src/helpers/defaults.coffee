defaults =
  targets:
    node: [
      glob: [
        "src/**/*.civet"
        "test/**/*.civet"
      ]
    ]
    browser: [
      {
        glob: [
          "src/**/*.civet"
          "test/client/**/*.civet"
        ]
      }
      {
        preset: "node"
        glob: [
          "test/**/*.civet"
          "!test/client/**/*.civet"
        ]
      }
    ]

export default defaults