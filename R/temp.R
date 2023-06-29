temp_store <- function(prefix = "temp") {
    # create a temporary folder to store data
    dir <- tempfile(prefix)
    dir.create(dir)

    # copy whole working directory to the temporary folder
    file_copy(list.files(all.files = TRUE, no.. = TRUE), dir, recursive = TRUE)

    dir
}

file_copy <- function(from, to, recursive = FALSE) {
    res <- file.copy(from, to, overwrite = TRUE, copy.date = TRUE, recursive = recursive)

    if (any(!res)) {
        stop(sprintf(
            "Failed to copy file: [%s]",
            paste0("'", from[!res], "'", collapse = "\n")
        ))
    }

    normalizePath(to)
}
