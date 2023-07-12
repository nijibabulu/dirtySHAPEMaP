# required packages: readr, ggplot2

df <-
  readr::read_tsv("work/04_flash/lib_y7oDUzWh-01.hist",
                col_names = c("Length", "Count"))

linear_plot <-
  ggplot2::ggplot(df, ggplot2::aes(Length, Count)) +
  ggplot2::geom_col() +
  ggplot2::labs(title = "lib_y7oDUzWh length histogram") +
  ggplot2::theme_minimal()

log_plot <- linear_plot +
  ggplot2::scale_y_log10() +
  ggplot2::labs(title = "lib_y7oDUzWh length histogram (log scale)")

ggplot2::ggsave("results/lib_y7oDUzWh-01/linear_histogram.png", linear_plot,
                width = 5, height = 5)
ggplot2::ggsave("results/lib_y7oDUzWh-01/log_histogram.png", log_plot,
                width = 5, height = 5)
