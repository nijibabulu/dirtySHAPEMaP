generate_histograms <- function(base) {
  full_dists <-
    readr::read_tsv(glue::glue("results/{base}/{base}.95seqs.dists"),
                  col_names = c("distance", "count"))
  trim_dists <-
    readr::read_tsv(glue::glue("results/{base}/{base}.95seqs.insert.dists"),
                  col_names = c("distance", "count"))

  full_plot <-
    ggplot2::ggplot(full_dists, ggplot2::aes(distance, count)) +
    ggplot2::geom_col() +
    ggplot2::labs(x = "Number of Substitutions",
                  title = glue::glue("{base} Substitution Histogram (Full Sequence)")) +
    ggplot2::theme_minimal()

  trim_plot <-
    ggplot2::ggplot(trim_dists, ggplot2::aes(distance, count)) +
    ggplot2::geom_col() +
    ggplot2::scale_x_continuous(limits = c(0, 95)) +
    ggplot2::labs(x = "Number of Substitutions",
                  title = glue::glue("{base} Substitution Histogram (Insert Only)")) +
    ggplot2::theme_minimal()

  p <- patchwork::wrap_plots(full_plot, trim_plot, ncol = 1)
  ggplot2::ggsave(glue::glue("results/{base}/{base}.distplot.png"),
                  width = 6, height = 8)
}

generate_histograms("lib_y7oDUzWh-01")
generate_histograms("lib_y7oDUzWh-02")
