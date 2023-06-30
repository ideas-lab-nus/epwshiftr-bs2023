pack_tex <- function(tex, deps, name = tools::file_path_sans_ext(tex)) {
    if (fs::is_absolute_path(tex)) {
        stop("'tex' should be a relative path.")
    }

    if (any(fs::is_absolute_path(deps))) {
        stop("'deps' should be all relative paths.")
    }

    # make sure tex and deps are in the same root folder
    if ((root <- fs::path_common(c(tex, deps))) == "") {
        stop("Please make sure 'tex' and 'deps' share the same root folder.")
    }

    zipfile <- tempfile("packtex", fileext = ".zip")

    # create a temporary to store all files
    dir <- tempfile("packtex")
    dir.create(dir)

    # get folder structure relative to root
    dirs <- unique(dirname(c(tex, deps)))
    dirs <- fs::path_rel(dirs, root)
    # create folder structure
    for (d in file.path(dir, dirs)) {
        if (!dir.exists(d)) dir.create(d, FALSE, TRUE)
    }
    file_copy(c(tex, deps), file.path(dir, fs::path_rel(c(tex, deps), root)))

    old <- getwd()
    on.exit(setwd(old), add = TRUE)
    setwd(dir)
    zip(zipfile, ".")

    out <- paste0(name, ".zip")
    setwd(old)
    file_copy(zipfile, out)
    as.character(fs::path_rel(out))
}
