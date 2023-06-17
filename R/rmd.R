path_rmd_root <- function(path, rmd) {
    if (!length(path)) return()
    fs::path_rel(file.path(dirname(rmd), path))
}

rmd_deps <- function(rmd) {
    c(rmd_deps_img(rmd), rmd_deps_tmpl(rmd), rmd_deps_bib(rmd))
}

rmd_deps_bib <- function(rmd) {
    # read yaml header
    yaml <- rmarkdown::yaml_front_matter(rmd)

    # extract bibliography file
    path_rmd_root(yaml$bibliography, rmd)
}

rmd_deps_tmpl <- function(rmd) {
    # read yaml header
    yaml <- rmarkdown::yaml_front_matter(rmd)

    # extract template
    tmpl <- path_rmd_root(unlist(lapply(yaml$output, .subset, "template")), rmd)

    # extract bst for LaTeX template
    l <- readLines(tmpl, warn = FALSE)
    re <- "^\\s*\\\\bibliographystyle\\s*{\\s*(.+)\\s*}"
    m <- regmatches(l, regexec(re, l, perl = TRUE))
    m <- m[lengths(m) == 2L]

    bst <- NULL
    if (length(m)) {
        f <- paste0(vapply(m[lengths(m) == 2L], .subset2, "", 2L), ".bst")
        bst <- path_rmd_root(f, rmd)
    }

    c(tmpl, bst)
}

rmd_deps_img <- function(rmd) {
    re <- "(?:knitr::)?include_graphics\\((['\"])(.+)\\g{-2}\\)"
    l <- readLines(rmd, warn = FALSE)
    m <- regmatches(l, regexec(re, l, perl = TRUE))
    f <- vapply(m[lengths(m) == 3L], .subset2, "", 3L)
    path_rmd_root(f[f != ""], rmd)
}

render_rmd <- function(rmd, envir = parent.frame()) {
    # read yaml header
    yaml <- rmarkdown::yaml_front_matter(rmd)

    out <- rmarkdown::render(rmd, "all", envir = envir, quiet = TRUE)

    if (unlist(lapply(yaml$output, .subset, "keep_tex"))) {
        out <- c(out, paste0(tools::file_path_sans_ext(out[1]), ".tex"))
    }

    path_rmd_root(gsub(paste0(dirname(normalizePath(rmd)), "/"), "", out, fixed = TRUE), rmd)
}
