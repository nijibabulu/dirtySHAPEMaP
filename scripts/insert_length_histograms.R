# required packages: readr, ggplot2

generate_histograms <- function(file) {
  base <- fs::path_file(file) |> fs::path_ext_remove()
  df <- readr::read_tsv(file, col_names = c("Length", "Count"))
  return(base)

  linear_plot <-
    ggplot2::ggplot(df, ggplot2::aes(Length, Count)) +
    ggplot2::geom_col() +
    ggplot2::labs(title = glue::glue("{base} length histogram")) +
    ggplot2::theme_minimal()

  log_plot <- linear_plot +
    ggplot2::scale_y_log10() +
    ggplot2::labs(title = glue::glue("{base} length histogram (log scale)"))

  fs::dir_create(fs::path("results", base))
  ggplot2::ggsave(fs::path("results", base, "linear_histogram.png"), linear_plot,
                  width = 5, height = 5)
  ggplot2::ggsave(fs::path("results", base, "log_histogram.png"), log_plot,
                  width = 5, height = 5)
}


generate_histograms("work/05_pear/lib_y7oDUzWh-02.hist")
generate_histograms("work/04_flash/lib_y7oDUzWh-01.hist")
generate_histograms("work/04_flash/lib_y7oDUzWh-02.hist")
