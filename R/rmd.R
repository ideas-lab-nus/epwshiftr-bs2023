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

render_rmd <- function(rmd, ref = NULL, envir = parent.frame()) {
    if (fs::is_absolute_path(rmd)) {
        stop("'rmd' should be a relative path.")
    }

    # output file name
    nm <- tools::file_path_sans_ext(basename(rmd))

    if (is.null(ref)) {
        dir <- getwd()
    } else {
        if (!is.null(names(ref)) && names(ref) == "") nm <- names(ref)

        # copy all data and checkout ref in a temporary directory
        dir <- temp_store("rmd")
        br <- basename(tempfile("branch"))
        gert::git_branch_create(br, ref, checkout = FALSE, repo = dir)
        gert::git_branch_checkout(br, repo = dir, force = TRUE)

        # change working directory
        old <- getwd()
        on.exit(setwd(old), add = TRUE)
        setwd(dir)
        on.exit(unlink(dir, recursive = TRUE), add = TRUE)
    }

    if (!file.exists(rmd)) {
        stop("Failed to locate 'rmd' in current working directory.")
    }

    # read yaml header
    yaml <- rmarkdown::yaml_front_matter(rmd)

    # render file
    out <- rmarkdown::render(rmd, "all", nm, envir = envir, quiet = TRUE)

    if (unlist(lapply(yaml$output, .subset, "keep_tex"))) {
        out <- c(out, paste0(nm, ".tex"))
    }

    out <- path_rmd_root(gsub(paste0(dirname(normalizePath(rmd)), "/"), "", out, fixed = TRUE), rmd)

    # copy the file back
    if (!is.null(ref)) file_copy(out, old)

    out
}
