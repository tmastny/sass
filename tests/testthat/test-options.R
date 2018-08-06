context("options")

test_that("indent width works", {
  scss <- "foo { margin: 122px * .3; }"
  css_default <- compile(scss)

  width <- 4
  css_width <- compile(scss, indent_width = width)
  expect_equal(
    nchar(css_default) + width - 2,
    nchar(css_width)
  )
})

test_that("indent as tabs works", {
  scss <- "foo { margin: 122px * .3; }"
  css <- compile(scss, indent_width = 1, indent_type = 'tab')
  expect_equal(
    strsplit(css, "")[[1]][7],
    '\t'
  )
})

test_that("linefeed works", {
  scss <- "foo { margin: 122px * .3; }"
  css_lf <- compile(scss)

  expect_equal(
    strsplit(css_lf, "")[[1]][6],
    '\n'
  )

  css_cr <- compile(scss, linefeed = 'cr')

  expect_equal(
    strsplit(css_cr, "")[[1]][6],
    '\r'
  )

  css_crlf <- compile(scss, linefeed = 'crlf')

  expect_equal(
    paste0(strsplit(css_crlf, "")[[1]][6:7], collapse = ''),
    '\r\n'
  )

  css_crlf <- compile(scss, linefeed = 'lfcr')

  expect_equal(
    paste0(strsplit(css_crlf, "")[[1]][6:7], collapse = ''),
    '\n\r'
  )
})

test_that("precision works", {
  scss <- "foo { margin: 1px * 0.1234567891; }"
  num_chars_no_precision <- 23
  css <- compile(scss)

  expect_equal(
    num_chars_no_precision + 6,
    nchar(css)
  )

  css <- compile(scss, precision = 0)
  expect_equal(
    num_chars_no_precision,
    nchar(css)
  )

  css <- compile(scss, precision = 10)
  expect_equal(
    num_chars_no_precision +  11,
    nchar(css)
  )
})

test_that("source_comments work", {
  expect_lt(
    nchar(compile("foo.scss")),
    nchar(compile("foo.scss", source_comments = TRUE))
  )
})